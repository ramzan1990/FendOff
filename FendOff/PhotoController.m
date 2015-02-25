#import "PhotoController.h"
#import "DecryptController.h"
#import "Vsem1.h"
#import "SVProgressHUD.h"
#import "ViewController.h"

@interface PhotoController ()<UIScrollViewDelegate>
@end

@implementation PhotoController

- (void) setEntry:(EncryptedEntry *)pEntry{
    selectedPhoto =pEntry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [[NSData alloc] initWithContentsOfFile:[ViewController getPath:[selectedPhoto getName]]];
        NSMutableData *mData = [Vsem1 decryptData:data passw:[selectedPhoto getPassword] highSecurity:NO];
        UIImage * img = [UIImage imageWithData:mData];
        

        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            _iv.image = img;
            
            
            CGRect screenRect = [[UIScreen mainScreen] bounds];
            CGFloat screenWidth = screenRect.size.width;
            //CGFloat screenHeight = screenRect.size.height;
            
            self.scrollView.minimumZoomScale=screenWidth/img.size.width;
            self.scrollView.maximumZoomScale=6.0;
            self.scrollView.contentSize= self.iv.image.size;
            self.scrollView.delegate=self;
            self.scrollView.zoomScale =screenWidth/img.size.width;
        });
        
        
    });
    self.navigationItem.title = [selectedPhoto getName];


}
- (IBAction)backClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}




- (IBAction)save:(id)sender {
    @try{
        UIImageWriteToSavedPhotosAlbum(_iv.image,nil,nil,nil);
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

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.iv;
}




@end
