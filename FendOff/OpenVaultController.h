#import <UIKit/UIKit.h>

@interface OpenVaultController : UIViewController{
    NSString* vaultFile;
    NSMutableArray* vaultList;
    BOOL fileExists;
    NSString* password;
}
@property (weak, nonatomic) IBOutlet UITextField *pass;
@property (weak, nonatomic) IBOutlet UITextField *pass2;
@property (weak, nonatomic) IBOutlet UIView *passview;

@end
