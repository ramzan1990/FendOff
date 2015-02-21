#import "PhotoController.h"
#import "DecryptController.h"
#import "Vsem1.h"

@interface PhotoController ()

@end

@implementation PhotoController

- (void) setEntry:(EncryptedEntry *)pEntry{
    selectedPhoto =pEntry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @try{
        NSData *data = [[NSData alloc] initWithContentsOfFile:[self getPath:[selectedPhoto getName]]];
        NSMutableData *mData = [Vsem1 decryptData:data passw:[selectedPhoto getPassword]];
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
    
    self.navigationItem.title = [selectedPhoto getName];
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





@end
