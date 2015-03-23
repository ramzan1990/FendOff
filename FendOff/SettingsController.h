//
//  SettingsController.h
//  FendOff
//
//  Created by Ramzan Umarov on 2/19/15.
//  Copyright (c) 2015 Softberry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *oldPass;
@property (weak, nonatomic) IBOutlet UITextField *pass;
@property (weak, nonatomic) IBOutlet UITextField *exportName;
@property (weak, nonatomic) IBOutlet UIButton *exportButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIView *passView;
@property (weak, nonatomic) IBOutlet UIView *aboutView;
@property (weak, nonatomic) IBOutlet UIView *exportView;

@end
