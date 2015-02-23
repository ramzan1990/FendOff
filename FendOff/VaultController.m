#import "VaultController.h"
#import "ViewController.h"
#import "EntryController.h"
#import "Vsem1.h"

@interface VaultController (){
    NSMutableArray* vaultList;
}

@end

@implementation VaultController

    static CategoryEntry* selectedEntry;
    static VaultCategory* selectedCategory;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    vaultList = [ViewController getVaultList];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.title = @"Categories";
}




- (IBAction)backClicked:(id)sender {
    if(selectedCategory != nil){
        selectedCategory = nil;
        self.navigationItem.title = @"Categories";
        [self.tableView reloadData];
    }else{
        [self saveData];
        
        ViewController *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"MainView"];
        [vc setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self presentViewController:vc animated:YES completion:nil];
    }
}

- (void) saveData{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:vaultList];
    NSMutableData* mData = [Vsem1 encryptData:data passw:[ViewController getPass]];
    [mData writeToFile:[ViewController getVaultFile] atomically:YES];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(selectedCategory == nil){
        if([self.tableView isEditing]){
            return [vaultList count]+1;
        }else{
            return [vaultList count];
        }
    }else{
        if([self.tableView isEditing]){
            return [[selectedCategory getEntries] count]+1;
        }else{
            return [[selectedCategory getEntries] count];
        }
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    NSInteger n = 0;
    if(selectedCategory == nil){
        n = [vaultList count];
    }else{
        n = [[selectedCategory getEntries] count];
    }
    NSArray *indexPaths = [NSArray arrayWithObjects:
                           [NSIndexPath indexPathForRow:n inSection:0],
                           nil];
    UITableView *tv = (UITableView *)self.view;
    if(editing){
        [tv insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationBottom];
    }else{
        [tv deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationBottom];
    }
    [self.tableView setEditing:editing animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(selectedCategory == nil){
        if(indexPath.row == [vaultList count]){
            return UITableViewCellEditingStyleInsert;
        } else {
            return UITableViewCellEditingStyleDelete;
        }
    }else{
        if(indexPath.row == [[selectedCategory getEntries] count]){
            return UITableViewCellEditingStyleInsert;
        } else {
            return UITableViewCellEditingStyleDelete;
        }
    }
}

- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if(selectedCategory == nil){
            [vaultList removeObjectAtIndex:indexPath.row];
        }else{
            [[selectedCategory getEntries] removeObjectAtIndex:indexPath.row];
        }
        [self.tableView reloadData];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        if(selectedCategory == nil){
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"FendOff" message:@"Enter the category name:" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            alert.alertViewStyle = UIAlertViewStylePlainTextInput;
            alert.tag = 100;
            [alert show];
            
        }else{
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"FendOff" message:@"Enter the entry name:" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            alert.alertViewStyle = UIAlertViewStylePlainTextInput;
            alert.tag = 101;
            [alert show];
        }
        [self.tableView reloadData];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString* detailString =[[alertView textFieldAtIndex:0] text];
    if(alertView.tag == 100){
        [vaultList addObject:[[VaultCategory alloc] initWithName:detailString]];
    }else{
        [[selectedCategory getEntries] addObject:[[CategoryEntry alloc] initWithName:detailString]];
    }
    [self saveData];
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VaultCell" forIndexPath:indexPath];
    if(selectedCategory == nil){
        if(indexPath.row<[vaultList count]){
            cell.textLabel.text = [[vaultList objectAtIndex:indexPath.row] getName];
        }else{
            if([self.tableView isEditing]){
                cell.textLabel.text =@"New category";
            }
        }
    }else{
        if(indexPath.row<[[selectedCategory getEntries] count]){
            cell.textLabel.text = [[[selectedCategory getEntries] objectAtIndex:indexPath.row] getName];
        }else{
            if([self.tableView isEditing]){
                cell.textLabel.text =@"New entry";
            }
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(selectedCategory == nil){
        if(indexPath.row<[vaultList count]){
            selectedCategory = (VaultCategory* )[vaultList objectAtIndex:indexPath.row];
            self.navigationItem.title = [selectedCategory getName];
            [self.tableView reloadData];
        }
    }else{
        selectedEntry = [[selectedCategory getEntries] objectAtIndex:indexPath.row];
         [self performSegueWithIdentifier:@"ShowEntry" sender:self];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


 #pragma mark - Navigation
 
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     UINavigationController* nav = (UINavigationController*)[segue destinationViewController];
     EntryController* ec = (EntryController* )[nav viewControllers][0];
     [ec setEntry:selectedEntry];
 }


@end
