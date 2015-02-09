#import <UIKit/UIKit.h>
#import "VaultCategory.h"

@interface VaultController : UITableViewController <UIAlertViewDelegate>{
    NSString* password;
    NSString* vaultFile;
    VaultCategory* selectedCategory;
}

- (void) setPass:(NSString *)pass;
- (void) setVaultFile:(NSString *)vaultFileP;
- (void) setVaultList:(NSMutableArray *)vaultListP;

@end
