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
#import "SVProgressHUD.h"

@interface EncryptController ()

@end

@implementation EncryptController

- (void)viewDidLoad {
    [super viewDidLoad];
    _ivPickedImage.image = image;
    
    
}


- (IBAction)doneClicked:(id)sender {
    if(_name.text.length==0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FendOff"
                                                        message:@"Enter name first."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }else{
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSString* path = [ViewController getPath:_name.text];
            NSData* data = UIImagePNGRepresentation(_ivPickedImage.image);
            NSString * p = [self randomStringWithLength:12];
            NSMutableData* encData = [Vsem1 encryptData:data passw:p highSecurity:NO];
            [encData writeToFile:path atomically:YES];
            
            UIImage *originalImage = _ivPickedImage.image;
            CGSize destinationSize = CGSizeMake(80, 80);
            UIGraphicsBeginImageContext(destinationSize);
            [originalImage drawInRect:CGRectMake(0,0,destinationSize.width,destinationSize.height)];
            UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            EncryptedEntry* ee = [[EncryptedEntry alloc] init:_name.text password:p preview:newImage];
            [ViewController addEncryptedEntry:ee];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FendOff"
                                                                message:@"File was successfully encrypted."
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            });
            
            
            
            
        });
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self performSegueWithIdentifier:@"Back" sender:self];
}

-(NSString *) randomStringWithLength: (int) len {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    
    return randomString;
}


- (void) setImage:(UIImage *) pickedImage{
    image = pickedImage;
}


@end

