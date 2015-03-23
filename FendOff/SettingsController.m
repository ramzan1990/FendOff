//
//  SettingsController.m
//  FendOff
//
//  Created by Ramzan Umarov on 2/19/15.
//  Copyright (c) 2015 Softberry. All rights reserved.
//

#import "SettingsController.h"
#import "ViewController.h"
#import "VaultCategory.h"
#import "CategoryEntry.h"

@interface SettingsController ()

@end

@implementation SettingsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_oldPass setDelegate:self];
    [_pass setDelegate:self];
    
    //_saveButton.layer.borderColor = [UIColor blackColor].CGColor;
    //_saveButton.layer.borderWidth = 1.0;
    _saveButton.layer.cornerRadius = 3;
    _saveButton.layer.backgroundColor= [UIColor colorWithRed:(59/255.0) green:(180/255.0) blue:(217/255.0) alpha:1].CGColor;
    
    _exportButton.layer.cornerRadius = 3;
    _exportButton.layer.backgroundColor= [UIColor colorWithRed:(59/255.0) green:(180/255.0) blue:(217/255.0) alpha:1].CGColor;
}

- (IBAction)segmentSwitch:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        [_passView setHidden:NO];
        [_aboutView setHidden:YES];
        [_exportView setHidden:YES];
        
    }
    else if (selectedSegment == 1){
        [_exportView setHidden:NO];
        [_passView setHidden:YES];
        [_aboutView setHidden:YES];
    }
    else if (selectedSegment == 2){
        [_aboutView setHidden:NO];
        [_passView setHidden:YES];
        [_exportView setHidden:YES];
    }
}

- (IBAction)export:(id)sender {
    NSMutableArray* vaultList = [ViewController getVaultList];
    NSString* exportText = @"";
    for(int i =0; i<[vaultList count]; i++){
        VaultCategory* c = (VaultCategory*) [vaultList objectAtIndex:i];
        exportText =[NSString stringWithFormat:@"%@%@\n", exportText, [c getName]];
        for(int j = 0; j< [[c getEntries] count]; j++){
            CategoryEntry* e = (CategoryEntry*)[[c getEntries] objectAtIndex:j];
            exportText =[NSString stringWithFormat:@"%@    %@\n", exportText, [e getName]];
            exportText =[NSString stringWithFormat:@"%@        %@\n", exportText, [[e getNote] stringByReplacingOccurrencesOfString:@"\n" withString:@"\n        "]];
        }
    }
    UIImage* img = [self imageFromString:exportText];
    @try{
        UIImageWriteToSavedPhotosAlbum(img,nil,nil,nil);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FendOff"
                                                        message:@"Image placed into saved photos album."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    @catch(NSException *){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FendOff"
                                                        message:@"Error."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
}

- (UIImage *)imageFromString:(NSString *)string
{
    NSDictionary *attributes = @{NSFontAttributeName            : [UIFont systemFontOfSize:20],
                                 NSForegroundColorAttributeName : [UIColor blackColor],
                                 NSBackgroundColorAttributeName : [UIColor clearColor]};
    CGSize size = [string sizeWithAttributes:attributes];
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [string drawInRect:CGRectMake(0, 0, size.width, size.height) withAttributes:attributes];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)saveClicked:(id)sender {
    NSString* msg;
    if([_oldPass.text isEqualToString:[ViewController getPass]] ){
        if(_pass.text.length >= 4){
            [ViewController changePassword:_pass.text];
            _pass.text=@"";
            _oldPass.text=@"";
            msg = @"Password changed.";
        }else{
            msg = @"Password should be at least 4 symbols!";
        }
    }else{
        msg = @"Wrong password!";
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FendOff"
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
