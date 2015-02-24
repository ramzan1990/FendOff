#import "PhotoController.h"
#import "DecryptController.h"
#import "Vsem1.h"
#import "SVProgressHUD.h"

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
        
        NSData *data = [[NSData alloc] initWithContentsOfFile:[self getPath:[selectedPhoto getName]]];
        NSMutableData *mData = [Vsem1 decryptData:data passw:[selectedPhoto getPassword] highSecurity:NO];
        UIImage * img = [UIImage imageWithData:mData];
        

        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            _iv.image = img;
            
            
            self.scrollView.minimumZoomScale=0.25;
            self.scrollView.maximumZoomScale=6.0;
            self.scrollView.contentSize= self.iv.image.size;
            self.scrollView.delegate=self;
            
        });
        
        
    });
    self.navigationItem.title = [selectedPhoto getName];


}
- (IBAction)backClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


-(NSString *) getPath:(NSString *) name {
    NSFileManager *fm  = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *dirName = [documentsDirectory stringByAppendingPathComponent:@"EncryptedPhotos"];
    
    BOOL isDir;
    if(![fm fileExistsAtPath:dirName isDirectory:&isDir])
    {
        [fm createDirectoryAtPath:dirName withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent: @"EncryptedPhotos"];
    filePath = [filePath stringByAppendingPathComponent: name];
    return filePath;
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
