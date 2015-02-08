#import <UIKit/UIKit.h>

@interface PhotoController : UIViewController{
    NSString* file;
    NSString* filePath;
}

- (void) setFile:(NSString *)pFile;

@property (weak, nonatomic) IBOutlet UITextField *pass;
@property (weak, nonatomic) IBOutlet UIImageView *iv;

@end
