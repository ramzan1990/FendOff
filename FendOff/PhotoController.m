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
    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
    NSMutableData *mData = [Vsem1 decryptData:data passw:_pass.text];
    @try{
    UIImage * img = [UIImage imageWithData:mData];
    _iv.image = img;
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





@end
