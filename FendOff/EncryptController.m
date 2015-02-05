//
//  EncryptController.m
//  FendOff
//
//  Created by Ramzan Umarov on 2/5/15.
//  Copyright (c) 2015 Softberry. All rights reserved.
//

#import "EncryptController.h"

@interface EncryptController ()

@end

@implementation EncryptController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnGalleryClicked:(id)sender
{
    ipc= [[UIImagePickerController alloc] init];
    ipc.delegate = self;
    ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
    [self presentViewController:ipc animated:YES completion:nil];
    else
    {
        popover=[[UIPopoverController alloc]initWithContentViewController:ipc];
        [popover presentPopoverFromRect:_btnGallery.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}

#pragma mark - ImagePickerController Delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    } else {
        [popover dismissPopoverAnimated:YES];
    }
    _ivPickedImage.image = [info objectForKey:UIImagePickerControllerOriginalImage];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end

