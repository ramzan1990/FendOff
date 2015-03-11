#import <UIKit/UIKit.h>
#import "EncryptedEntry.h"

@interface PhotoController : UIViewController <UIScrollViewDelegate>{
    EncryptedEntry* selectedPhoto;
    UIImage * decryptedImage;
}

- (void) setEntry:(EncryptedEntry *)pEntry;

@property (weak, nonatomic) IBOutlet UIImageView *iv;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
