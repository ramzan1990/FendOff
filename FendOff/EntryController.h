#import <UIKit/UIKit.h>
#import "CategoryEntry.h"

@interface EntryController : UIViewController{
    CategoryEntry* entry;
}

- (void) setEntry:(CategoryEntry *) selectedEntry;
@property (weak, nonatomic) IBOutlet UITextView *entryNote;

@end
