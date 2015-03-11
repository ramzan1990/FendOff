//
//  EncryptController.h
//  FendOff
//
//  Created by Ramzan Umarov on 2/5/15.
//  Copyright (c) 2015 Softberry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EncryptController : UIViewController <UIAlertViewDelegate,  UITextFieldDelegate>{
    UIImage* image;
}


@property (weak, nonatomic) IBOutlet UIImageView *ivPickedImage;
@property (weak, nonatomic) IBOutlet UITextField *name;
- (void) setImage:(UIImage *) pickedImage;

@end
