#import <UIKit/UIKit.h>

@interface OpenVaultController : UIViewController  <UITextFieldDelegate>{
    NSString* vaultFile;
    NSMutableArray* vaultList;
    BOOL fileExists;
    NSString* password;
}
@property (weak, nonatomic) IBOutlet UITextField *pass;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
