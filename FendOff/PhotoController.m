#import "PhotoController.h"
#import "DecryptController.h"
#import "Vsem1.h"

@interface PhotoController ()

@end

@implementation PhotoController

- (void) setEntry:(EncryptedEntry *)pEntry{
    selectedEntry =pEntry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @try{
        NSData *data = [[NSData alloc] initWithContentsOfFile:[selectedEntry getFile]];
        NSMutableData *mData = [Vsem1 decryptData:data passw:[selectedEntry getPassword]];
        UIImage * img = [UIImage imageWithData:mData];
        _iv.image = img;
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





@end
