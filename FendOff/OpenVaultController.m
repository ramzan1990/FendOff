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
        [_doneButton setTitle:@"Enter" forState:UIControlStateNormal];
    }else{
        
    }
    
    _pass.layer.cornerRadius=3.0f;
    _pass.layer.masksToBounds=YES;
    _pass.layer.borderColor=[[UIColor whiteColor]CGColor];
    _pass.layer.borderWidth= 1.0f;
    
    [_pass setDelegate:self];
    
    //[fm removeItemAtPath:vaultFile error:nil];
}


- (IBAction)doneClicked:(id)sender {
    password= _pass.text;
    if(fileExists){
        NSData *data = [[NSData alloc] initWithContentsOfFile:vaultFile];
        NSMutableData *decData = [Vsem1 decryptData:data passw:_pass.text];
        @try{
            vaultList= [NSKeyedUnarchiver unarchiveObjectWithData:decData];
            [self performSegueWithIdentifier:@"Enter" sender:self];
        }
        @catch(NSException * exception){
            //NSLog( @"Name: %@", exception.name);
            //NSLog( @"Reason: %@", exception.reason );
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
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:vaultList];
        NSMutableData* mData = [Vsem1 encryptData:data passw:password];
        [mData writeToFile:vaultFile atomically:YES];
        
        [self performSegueWithIdentifier:@"Enter" sender:self];
        
    }
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        ViewController* vc = (ViewController* )[segue destinationViewController];
        [vc setPass:password];
        [vc setVaultFile:vaultFile];
        [vc setVaultList:vaultList];
    
}

@end
