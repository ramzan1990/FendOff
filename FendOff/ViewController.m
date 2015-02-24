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
        NSMutableData *decData = [Vsem1 decryptData:data passw:password highSecurity:YES];
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
    NSMutableData* mData = [Vsem1 encryptData:data passw:password highSecurity:YES];
    [mData writeToFile:imagesFile atomically:YES];
}

+ (void) changePassword:(NSString *) newPass{
    password = newPass;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:imagesList];
    NSMutableData* mData = [Vsem1 encryptData:data passw:password highSecurity:YES];
    [mData writeToFile:imagesFile atomically:YES];
    
    data = [NSKeyedArchiver archivedDataWithRootObject:vaultList];
    mData = [Vsem1 encryptData:data passw:password highSecurity:YES];
    [mData writeToFile:vaultFile atomically:YES];
    
}

- (IBAction)encryptClicked:(id)sender
{
    [self touchedUp:sender];
    UIButton* s = (UIButton *) sender;
    ipc= [[UIImagePickerController alloc] init];
    ipc.delegate = self;
    ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    ipc.navigationController.navigationBar.translucent = NO;
    ipc.navigationBar.barTintColor =  [UIColor colorWithRed:1.0 green:128.0/255.0 blue:109.0/255.0 alpha:1];
    ipc.navigationBar.tintColor = [UIColor whiteColor];
    ipc.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        [self presentViewController:ipc animated:YES completion:nil];
    else
    {
        popover=[[UIPopoverController alloc]initWithContentViewController:ipc];
        [popover presentPopoverFromRect:s.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}
- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    if ([navigationController isKindOfClass:[UIImagePickerController class]])
    {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        viewController.navigationController.navigationBar.translucent = NO;
        viewController.edgesForExtendedLayout = UIRectEdgeNone;
    }
}


#pragma mark - ImagePickerController Delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        [picker dismissViewControllerAnimated:YES completion:^{
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
            [self performSegueWithIdentifier:@"Encrypt" sender:self];
        }];
    } else {
        [popover dismissPopoverAnimated:YES];
    }
    pickedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    }

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }];
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
