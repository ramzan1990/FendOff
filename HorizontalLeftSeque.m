//
//  CustomSeque.m
//  FendOff
//
//  Created by Ramzan Umarov on 2/23/15.
//  Copyright (c) 2015 Softberry. All rights reserved.
//

#import "HorizontalLeftSeque.h"

@implementation HorizontalLeftSeque

- (void)perform
{
   
        UIViewController *desViewController = (UIViewController *)self.destinationViewController;
        
        UIView *srcView = [(UIViewController *)self.sourceViewController view];
        UIView *desView = [desViewController view];
        
        desView.transform = srcView.transform;
        desView.bounds = srcView.bounds;
        
    
                desView.center = CGPointMake(srcView.center.x + srcView.frame.size.width, srcView.center.y);
    
        
        UIWindow *mainWindow = [[UIApplication sharedApplication].windows objectAtIndex:0];
        [mainWindow addSubview:desView];
        
        // slide newView over oldView, then remove oldView
        [UIView animateWithDuration:0.3
                         animations:^{
                             desView.center = CGPointMake(srcView.center.x, srcView.center.y);
                             
                            
                                     srcView.center = CGPointMake(srcView.center.x - srcView.frame.size.width, srcView.center.y);
                             
                             
                         }
                         completion:^(BOOL finished){
                             //[desView removeFromSuperview];
                             [self.sourceViewController presentModalViewController:desViewController animated:NO];
                         }];
    

}

@end
