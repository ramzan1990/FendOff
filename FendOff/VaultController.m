#import "VaultController.h"
#import "ViewController.h"
#import "Vsem1.h"

@interface VaultController (){
    NSMutableArray* vaultList;
}

@end

@implementation VaultController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    vaultList = [ViewController getVaultList];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}




- (IBAction)backClicked:(id)sender {
    if(selectedCategory != nil){
        selectedCategory = nil;
        [self.tableView reloadData];
    }else{
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:vaultList];
        NSMutableData* mData = [Vsem1 encryptData:data passw:[ViewController getPass]];
        [mData writeToFile:[ViewController getVaultFile] atomically:YES];
        
        ViewController *vc =[self.storyboard instantiateViewControllerWithIdentifier:@"MainView"];
        [vc setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self presentViewController:vc animated:YES completion:nil];
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(selectedCategory == nil){
        return [vaultList count] + 1;
    }else{
        return [[selectedCategory getEntries] count]+1;
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
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
        [[selectedCategory getEntries] addObject:detailString];
    }
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VaultCell" forIndexPath:indexPath];
    if(selectedCategory == nil){
        if(indexPath.row<[vaultList count]){
            cell.textLabel.text = [[vaultList objectAtIndex:indexPath.row] getName];
        }else{
            cell.textLabel.text =@"New Category...";
        }
    }else{
        if(indexPath.row<[[selectedCategory getEntries] count]){
            cell.textLabel.text = [[selectedCategory getEntries] objectAtIndex:indexPath.row];
        }else{
            cell.textLabel.text =@"New Entry...";
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(selectedCategory == nil){
        if(indexPath.row<[vaultList count]){
            selectedCategory = (VaultCategory* )[vaultList objectAtIndex:indexPath.row];
            [self.tableView reloadData];
        }
    }else{
       
    }
    
}



/*
 #pragma mark - Navigation
 
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
