//
//  ViewController.m
//  FendOff
//
//  Created by Ramzan Umarov on 1/31/15.
//  Copyright (c) 2015 Softberry. All rights reserved.
//

#import "ViewController.h"
#import "Vsem1.h"
#import "EncryptController.h"

@interface ViewController ()

@end

@implementation ViewController

static NSString* password;
static NSString* vaultFile;
static NSString* imagesFile;
static NSMutableArray* vaultList;
static NSMutableArray* imagesList;

- (void)viewDidLoad {
    [super viewDidLoad];
    if(imagesList == nil){
    imagesList = [[NSMutableArray alloc] init];
    NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dirName = [docDir stringByAppendingPathComponent:@"Vault"];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString * fileName = @"images.ff";
    imagesFile = [dirName stringByAppendingPathComponent: fileName];
    
    fileExists = [fm fileExistsAtPath: imagesFile];
    if (fileExists){
        NSData *data = [[NSData alloc] initWithContentsOfFile:imagesFile];
        NSMutableData *decData = [Vsem1 decryptData:data passw:password];
        @try{
            imagesList= [NSKeyedUnarchiver unarchiveObjectWithData:decData];
        }
        @catch(NSException *){
            
            
        }
    }
    }
    
}
- (IBAction)touched:(id)sender {
    UIButton* b = (UIButton*) sender;
    b.alpha = 0.7;
}
- (IBAction)touchedUp:(id)sender {
    UIButton* b = (UIButton*) sender;
    b.alpha =1.0;
}

- (void) setPass:(NSString *)pass{
    password= pass;
}

+(NSString *) getPass{
    return password;
}

- (void) setVaultFile:(NSString *)vaultFileP{
    vaultFile = vaultFileP;
}

- (void) setVaultList:(NSMutableArray *)vaultListP{
    vaultList = vaultListP;
}

+ (NSString *) getVaultFile{
    return vaultFile;
}

+ (NSMutableArray *) getVaultList{
    return vaultList;
}

+ (NSMutableArray *) getImagesList{
    return imagesList;
}

+ (void) addEncryptedEntry:(EncryptedEntry*) ee{
    [imagesList addObject:ee];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:imagesList];
    NSMutableData* mData = [Vsem1 encryptData:data passw:password];
    [mData writeToFile:imagesFile atomically:YES];
}

+ (void) changePassword:(NSString *) newPass{
    password = newPass;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:imagesList];
    NSMutableData* mData = [Vsem1 encryptData:data passw:password];
    [mData writeToFile:imagesFile atomically:YES];
    
    data = [NSKeyedArchiver archivedDataWithRootObject:vaultList];
    mData = [Vsem1 encryptData:data passw:password];
    [mData writeToFile:vaultFile atomically:YES];
    
}

- (IBAction)encryptClicked:(id)sender
{
    [self touchedUp:sender];
    UIButton* s = (UIButton *) sender;
    ipc= [[UIImagePickerController alloc] init];
    ipc.delegate = self;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else
    {
        ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        [self presentViewController:ipc animated:YES completion:nil];
    else
    {
        popover=[[UIPopoverController alloc]initWithContentViewController:ipc];
        [popover presentPopoverFromRect:s.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
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
    pickedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self performSegueWithIdentifier:@"Encrypt" sender:self];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"Encrypt"]){
    UINavigationController* nav = (UINavigationController*)[segue destinationViewController];
    EncryptController* ec = (EncryptController* )[nav viewControllers][0];
    [ec setImage:pickedImage];
    }
}

@end
