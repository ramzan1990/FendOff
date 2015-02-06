//
//  PhotoController.h
//  FendOff
//
//  Created by Ramzan Umarov on 2/6/15.
//  Copyright (c) 2015 Softberry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoController : UIViewController{
    NSString* file;
    NSString* filePath;
}

- (void) setFile:(NSString *)pFile;

@property (weak, nonatomic) IBOutlet UITextField *pass;

@end
