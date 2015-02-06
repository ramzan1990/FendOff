//
//  EncryptController.m
//  FendOff
//
//  Created by Ramzan Umarov on 2/5/15.
//  Copyright (c) 2015 Softberry. All rights reserved.
//

#import "EncryptController.h"
#import "Vsem1.h"

@interface EncryptController ()

@end

@implementation EncryptController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)doneClicked:(id)sender {
    if(_ivPickedImage.image == nil || _pass.text.length==0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FendOff"
                                                        message:@"Enter password and choose image first."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    NSString* path = [self getPath:imageName];
    CGDataProviderRef provider = CGImageGetDataProvider(_ivPickedImage.image.CGImage);
    NSData* data = (id)CFBridgingRelease(CGDataProviderCopyData(provider));
    [self tryToSave:path image:data pass:_pass.text];
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

- (NSString *) tryToSave:(NSString *) path image: (NSData*)data pass: (NSString *) passw {
    NSString* allt = @"";
    NSString* outs;
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    outs = [NSString stringWithFormat:@"%@%@%@", @"FendoffP ", [DateFormatter stringFromDate:[NSDate date]], @"\n"];
    allt = [NSString stringWithFormat:@"%@%@%@", outs, passw, @"\n"];
    int length = (int) [allt length];
    length +=  3;
    outs = [NSString stringWithFormat:@"%d%@", length, @"\n"];
    allt = [NSString stringWithFormat:@"%@%@", allt, outs];
    NSData *temp = [allt dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableData *bouts = [NSMutableData data];
    [bouts appendData:temp];
    [bouts appendData:data];
    
    Vsem1 * em = [[Vsem1 alloc] init];
    NSMutableArray* sa = [em pastosd:2 pas:passw];
    long stot = [em getStot];
    bouts = [em evsem1:bouts seed:[sa[0] integerValue]];
    bouts = [em evsem2:bouts seed:[sa[1] integerValue]];
    long s3 = 999;
    if (stot > 2) s3 = [sa[2] integerValue];
    bouts = [em evsem3:bouts seed:s3];
    s3 = -999;
    if (stot > 3) s3 = [sa[3] integerValue];
    bouts = [em evsem4:bouts seed:s3];
    NSString* newFile =[NSString stringWithFormat:@"%@.ff", path];
    [bouts writeToFile:newFile atomically:YES];
    return newFile;
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
    
    NSURL *imagePath = [info objectForKey:UIImagePickerControllerReferenceURL];
    imageName = [imagePath lastPathComponent];}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end

