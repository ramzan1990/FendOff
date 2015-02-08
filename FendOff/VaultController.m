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
    
   
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) setPass:(NSString *)pass{
    password= pass;
}
- (void) setVaultFile:(NSString *)vaultFileP{
    vaultFile = vaultFileP;
}

- (void) setVaultList:(NSMutableArray *)vaultListP{
    vaultList = vaultListP;
}

- (IBAction)backClicked:(id)sender {
    if(selectedCategory != nil){
        selectedCategory = nil;
    }else{
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:vaultList];
        NSMutableData* mData = [Vsem1 encryptData:data passw:password];
        [mData writeToFile:vaultFile atomically:YES];
        
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
        return [[selectedCategory getEntries] count];
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.row == [vaultList count]){
        return UITableViewCellEditingStyleInsert;
    } else {
        return UITableViewCellEditingStyleDelete;
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
           [vaultList addObject:@"new_cat"];
        }else{
            [[selectedCategory getEntries] addObject:@"new_entry"];
        }
        [self.tableView reloadData];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VaultCell" forIndexPath:indexPath];
     if(selectedCategory == nil){
    if(indexPath.row<[vaultList count]){
    cell.textLabel.text = [vaultList objectAtIndex:indexPath.row];
    }else{
        cell.textLabel.text =@"New Category...";
    }
     }else{
         if(indexPath.row<[vaultList count]){
             cell.textLabel.text = [[selectedCategory getEntries] objectAtIndex:indexPath.row];
         }else{
             cell.textLabel.text =@"New Entry...";
         }
     }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedCategory = (VaultCategory* )[vaultList objectAtIndex:indexPath.row];
    [self.tableView reloadData];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
