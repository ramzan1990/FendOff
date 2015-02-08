#import "OpenVaultController.h"
#import "VaultController.h"
#import "Vsem1.h"

@interface OpenVaultController ()

@end

@implementation OpenVaultController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dirName = [docDir stringByAppendingPathComponent:@"Vault"];
    BOOL isDir;
    NSFileManager *fm = [NSFileManager defaultManager];
    if(![fm fileExistsAtPath:dirName isDirectory:&isDir])
    {
        [fm createDirectoryAtPath:dirName withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    
    NSString * fileName = @"vault.ff";
    
    vaultFile = [dirName stringByAppendingPathComponent: fileName];
    
    fileExists = [fm fileExistsAtPath: vaultFile];
    if (fileExists){
        
    }else{
        UILabel *label = (UILabel *)[self.view viewWithTag:100];
        UIButton *button = (UIButton *)[self.view viewWithTag:101];
        [label setHidden:YES];
        [button setHidden:YES];
    }
}


- (IBAction)doneClicked:(id)sender {
    if(fileExists){
        NSData *data = [[NSData alloc] initWithContentsOfFile:vaultFile];
        NSMutableData *decData = [Vsem1 decryptData:data passw:_pass.text];
        @try{
            vaultList= [NSKeyedUnarchiver unarchiveObjectWithData:decData];
            [self performSegueWithIdentifier:@"OpenVault" sender:self];
        }
        @catch(NSException *){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FendOff"
                                                            message:@"Wrong password!"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            
        }
    }else{
        vaultList = [[NSMutableArray alloc] init];
        vaultList[0] = @"general";
        vaultList[1] = @"phones";
        vaultList[2] = @"emails";
        [self performSegueWithIdentifier:@"OpenVault" sender:self];
        
    }
}
- (IBAction)resetClicked:(id)sender {
     NSFileManager *fm = [NSFileManager defaultManager];
     [fm removeItemAtPath:vaultFile error:nil];
    vaultList = [[NSMutableArray alloc] init];
    vaultList[0] = @"general";
    vaultList[1] = @"phones";
    vaultList[2] = @"emails";
    [self performSegueWithIdentifier:@"OpenVault" sender:self];
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"OpenVault"]){
        UINavigationController* nav = (UINavigationController*)[segue destinationViewController];
        VaultController* vc = (VaultController* )[nav viewControllers][0];
        [vc setPass:_pass.text];
        [vc setVaultFile:vaultFile];
        [vc setVaultList:vaultList];
    }
}

@end
