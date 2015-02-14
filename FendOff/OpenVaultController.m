#import "OpenVaultController.h"
#import "Vsem1.h"
#import "ViewController.h"
#import "VaultCategory.h"

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
        
    }
}


- (IBAction)doneClicked:(id)sender {
    if(fileExists){
        NSData *data = [[NSData alloc] initWithContentsOfFile:vaultFile];
        NSMutableData *decData = [Vsem1 decryptData:data passw:_pass.text];
        @try{
            vaultList= [NSKeyedUnarchiver unarchiveObjectWithData:decData];
            password= _pass.text;
            [self performSegueWithIdentifier:@"Enter" sender:self];
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
        vaultList[0] = [[VaultCategory alloc] initWithName:@"General"];
        vaultList[1] = [[VaultCategory alloc] initWithName:@"Phones"];
        vaultList[2] = [[VaultCategory alloc] initWithName:@"Emails"];
        [self performSegueWithIdentifier:@"Enter" sender:self];
        
    }
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        ViewController* vc = (ViewController* )[segue destinationViewController];
        [vc setPass:password];
        [vc setVaultFile:vaultFile];
        [vc setVaultList:vaultList];
    
}

@end
