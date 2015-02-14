//
//  DecryptController.m
//  FendOff
//
//  Created by Ramzan Umarov on 2/6/15.
//  Copyright (c) 2015 Softberry. All rights reserved.
//

#import "DecryptController.h"
#import "PhotoController.h"
#import "ViewController.h"

@interface DecryptController ()

@end

@implementation DecryptController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    }



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[ViewController getImagesList] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FileCell" forIndexPath:indexPath];
    EncryptedEntry* ee = [[ViewController getImagesList] objectAtIndex:indexPath.row];
    UILabel* name = (UILabel *)[cell viewWithTag:100];
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:101];
    name.text = [ee getName];
    imageView.image = [ee getPreview];
    return cell;
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedEntry = [[ViewController getImagesList] objectAtIndex:indexPath.row];
     [self performSegueWithIdentifier:@"ShowPhoto" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"ShowPhoto"]){
    UINavigationController* nav = (UINavigationController*)[segue destinationViewController];
    PhotoController* pc = (PhotoController* )[nav viewControllers][0];
    [pc setEntry:selectedEntry];
    }
}


@end
