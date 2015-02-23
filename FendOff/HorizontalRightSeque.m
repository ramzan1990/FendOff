#import "HorizontalRightSeque.h"

@implementation HorizontalRightSeque

- (void)perform
{
  
        UIViewController *desViewController = (UIViewController *)self.destinationViewController;
        
        UIView *srcView = [(UIViewController *)self.sourceViewController view];
        UIView *desView = [desViewController view];
    
    UINavigationController* nav =[(UIViewController *)self.sourceViewController navigationController];
    double n = nav.navigationBar.frame.size.height;
    //[nav setNavigationBarHidden:YES animated:YES];
    
        desView.transform = srcView.transform;
        desView.bounds = srcView.bounds;
    desView.bounds = CGRectMake(desView.bounds.origin.x, desView.bounds.origin.y, desView.bounds.size.width, desView.bounds.size.height + n);
    
                desView.center = CGPointMake(srcView.center.x - srcView.frame.size.width, srcView.center.y-n);
    
        
        UIWindow *mainWindow = [[UIApplication sharedApplication].windows objectAtIndex:0];
        [mainWindow addSubview:desView];
        
        // slide newView over oldView, then remove oldView
        [UIView animateWithDuration:2.3
                         animations:^{
                             desView.center = CGPointMake(srcView.center.x, srcView.center.y-n);
                             
                            
                                     srcView.center = CGPointMake(srcView.center.x + srcView.frame.size.width, srcView.center.y-n);
                             
                             
                         }
                         completion:^(BOOL finished){
                             //[desView removeFromSuperview];
                             [self.sourceViewController presentModalViewController:desViewController animated:NO];
                         }];
    /*     UIViewController *src = (UIViewController *) self.sourceViewController;
    UIViewController *dst = (UIViewController *) self.destinationViewController;
    [UIView transitionWithView:src.navigationController.view duration:0.6
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        [src.navigationController pushViewController:dst animated:NO];
                    }
                    completion:NULL];
     */

}

@end
