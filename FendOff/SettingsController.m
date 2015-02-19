//
//  SettingsController.m
//  FendOff
//
//  Created by Ramzan Umarov on 2/19/15.
//  Copyright (c) 2015 Softberry. All rights reserved.
//

#import "SettingsController.h"
#import "ViewController.h"

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
}

- (IBAction)segmentSwitch:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        //toggle the correct view to be visible
        [_passView setHidden:NO];
        [_aboutView setHidden:YES];
    }
    else{
        //toggle the correct view to be visible
        [_passView setHidden:YES];
        [_aboutView setHidden:NO];
    }
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
