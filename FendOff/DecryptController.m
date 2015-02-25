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
#import "SVProgressHUD.h"

@interface DecryptController ()

@end

@implementation DecryptController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
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


- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    EncryptedEntry* e = [[ViewController getImagesList] objectAtIndex:indexPath.row];
    NSFileManager *fm = [NSFileManager defaultManager];
    [fm removeItemAtPath:[ViewController getPath:[e getName]] error:nil];
    [ViewController removeEncryptedEntry:indexPath.row];
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedEntry = [[ViewController getImagesList] objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"ShowPhoto" sender:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"ShowPhoto"]){
        PhotoController* pc = (PhotoController* )[segue destinationViewController];
        [pc setEntry:selectedEntry];
    }
}


@end
