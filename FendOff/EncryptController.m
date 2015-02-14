//
//  EncryptController.m
//  FendOff
//
//  Created by Ramzan Umarov on 2/5/15.
//  Copyright (c) 2015 Softberry. All rights reserved.
//

#import "EncryptController.h"
#import "Vsem1.h"
#import "ViewController.h"
#import "EncryptedEntry.h"

@interface EncryptController ()

@end

@implementation EncryptController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)doneClicked:(id)sender {
    if(_ivPickedImage.image == nil || _name.text.length==0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FendOff"
                                                        message:@"Choose image and enter name."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    NSString* path = [self getPath:_name.text];
    NSData* data = UIImagePNGRepresentation(_ivPickedImage.image);
    NSString * p = [self randomStringWithLength:10];
    NSMutableData* encData = [Vsem1 encryptData:data passw:p];
    [encData writeToFile:path atomically:YES];
    EncryptedEntry* ee = [[EncryptedEntry alloc] init:_name.text file:path password:p preview:[self resizeImage:_ivPickedImage.image newSize:CGSizeMake(40, 40)]];
    [ViewController addEncryptedEntry:ee];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FendOff"
                                                    message:@"File was successfully encrypted."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (UIImage *)resizeImage:(UIImage*)image newSize:(CGSize)newSize {
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    CGImageRef imageRef = image.CGImage;
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Set the quality level to use when rescaling
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, newSize.height);
    
    CGContextConcatCTM(context, flipVertical);
    // Draw into the context; this scales the image
    CGContextDrawImage(context, newRect, imageRef);
    
    // Get the resized image from the context and a UIImage
    CGImageRef newImageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    CGImageRelease(newImageRef);
    UIGraphicsEndImageContext();
    
    return newImage;
}

-(NSString *) randomStringWithLength: (int) len {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    
    return randomString;
}

-(NSString *) getPath:(NSString *) name {
    NSFileManager *fm  = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *dirName = [documentsDirectory stringByAppendingPathComponent:@"EncryptedPhotos"];
    
    BOOL isDir;
    if(![fm fileExistsAtPath:dirName isDirectory:&isDir])
    {
        [fm createDirectoryAtPath:dirName withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent: @"EncryptedPhotos"];
    filePath = [filePath stringByAppendingPathComponent: name];
    return filePath;
}


- (IBAction)btnGalleryClicked:(id)sender
{
    ipc= [[UIImagePickerController alloc] init];
    ipc.delegate = self;
    ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    [self presentViewController:ipc animated:YES completion:nil];
    else
    {
        popover=[[UIPopoverController alloc]initWithContentViewController:ipc];
        [popover presentPopoverFromRect:_btnGallery.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}

#pragma mark - ImagePickerController Delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    } else {
        [popover dismissPopoverAnimated:YES];
    }
    _ivPickedImage.image = [info objectForKey:UIImagePickerControllerOriginalImage];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end

