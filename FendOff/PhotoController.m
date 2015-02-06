//
//  PhotoController.m
//  FendOff
//
//  Created by Ramzan Umarov on 2/6/15.
//  Copyright (c) 2015 Softberry. All rights reserved.
//

#import "PhotoController.h"
#import "DecryptController.h"
#import "Vsem1.h"

@interface PhotoController ()

@end

@implementation PhotoController

- (void) setFile:(NSString *)pFile{
    file =pFile;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    filePath = [documentsDirectory stringByAppendingPathComponent: @"EncryptedPhotos"];
    filePath = [filePath stringByAppendingPathComponent: file];
    
}

- (IBAction)delete:(id)sender {
    NSFileManager* fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:filePath error:nil];
    DecryptController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DecryptView"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)save:(id)sender {
    NSString* passw = _pass.text;
    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
    NSMutableData *mData = [NSMutableData data];
    [mData appendData:data];
    
    Vsem1 * em = [[Vsem1 alloc] init];
    
    NSMutableArray* sa = [em pastosd:2 pas:passw];
    
    long stot = [em getStot];
    
    long s3 = -999;
    if (stot > 3) s3 = [sa[3] integerValue];
    mData = [em dvsem4:mData seed:s3];
    s3 = 999;
    if (stot > 2) s3 = [sa[2] integerValue];
    mData = [em dvsem3:mData seed:s3];
    mData = [em dvsem2:mData seed:[sa[1] integerValue]];
    mData = [em dvsem1:mData seed:[sa[0] integerValue]];
    UIImageWriteToSavedPhotosAlbum([UIImage imageWithData:mData],nil,nil,nil);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FendOff"
                                                    message:@"Image placed into saved photos album."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
