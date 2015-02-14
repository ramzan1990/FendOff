#import <UIKit/UIKit.h>
#import "EncryptedEntry.h"

@interface PhotoController : UIViewController{
    EncryptedEntry* selectedEntry;
}

- (void) setEntry:(EncryptedEntry *)pEntry;

@property (weak, nonatomic) IBOutlet UIImageView *iv;

@end
