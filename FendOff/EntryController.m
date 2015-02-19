#import "EntryController.h"

@interface EntryController ()

@end

@implementation EntryController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [entry getName];
    if(_entryNote.text.length >0){
        _entryNote.text =[entry getNote];
    }
}

- (void) setEntry:(CategoryEntry *) selectedEntry{
    entry = selectedEntry;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [entry setNote:_entryNote.text];
}


@end
