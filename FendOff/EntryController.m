#import "EntryController.h"
#import "VaultController.h"

@interface EntryController ()

@end

@implementation EntryController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [entry getName];
    if(_entryNote.text.length >0){
        _entryNote.text =[entry getNote];
    }
    [_entryNote becomeFirstResponder];
}

- (void) setEntry:(CategoryEntry *) selectedEntry{
    entry = selectedEntry;
}

- (IBAction)backClicked:(id)sender {
    [entry setNote:_entryNote.text];
    VaultController* vc = (VaultController* )[self.navigationController.viewControllers objectAtIndex:0];
    [vc saveData];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Navigation




@end
