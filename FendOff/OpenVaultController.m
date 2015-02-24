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
    
  
    
    UIFont *customFont = [UIFont fontWithName:@"Circe-Bold" size:48];
    _mainLabel.font = customFont;
    
    [_scrollView setContentSize:CGSizeMake(600, 321)];
    
    [self registerForKeyboardNotifications];
    
    _pass.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    
    //[fm removeItemAtPath:vaultFile error:nil];
    //[fm removeItemAtPath:[dirName stringByAppendingPathComponent: @"images.ff"] error:nil];
    //[fm removeItemAtPath:[dirName stringByAppendingPathComponent: @"EncryptedPhotos"] error:nil];
}


- (IBAction)doneClicked:(id)sender {
    password= _pass.text;
    if(fileExists){
        NSData *data = [[NSData alloc] initWithContentsOfFile:vaultFile];
        NSMutableData *decData = [Vsem1 decryptData:data passw:_pass.text highSecurity:YES];
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
        if(_pass.text.length >=4){
        vaultList = [[NSMutableArray alloc] init];
        vaultList[0] = [[VaultCategory alloc] initWithName:@"General"];
        vaultList[1] = [[VaultCategory alloc] initWithName:@"Phones"];
        vaultList[2] = [[VaultCategory alloc] initWithName:@"Emails"];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:vaultList];
        NSMutableData* mData = [Vsem1 encryptData:data passw:password highSecurity:YES];
        [mData writeToFile:vaultFile atomically:YES];
        
        [self performSegueWithIdentifier:@"Enter" sender:self];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FendOff"
                                                            message:@"Password should be at least 4 characters."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGRect keyPadFrame=[[UIApplication sharedApplication].keyWindow convertRect:[[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue] fromView:self.view];
    CGSize kbSize =keyPadFrame.size;
    CGRect activeRect=[self.view convertRect:_doneButton.frame fromView:_doneButton.superview];
    CGRect aRect = self.view.bounds;
    aRect.size.height -= (kbSize.height);
    
    
    //_doneButton.frame.origin.y + self.activeField.frame.size.height
    
    CGPoint origin =  activeRect.origin;
    origin.y -= _scrollView.contentOffset.y;
    origin.y += _doneButton.frame.size.height;
    
    if (!CGRectContainsPoint(aRect, origin)) {
        CGPoint scrollPoint = CGPointMake(0.0,CGRectGetMaxY(activeRect)-(aRect.size.height) + _doneButton.frame.size.height);
        [_scrollView setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    //UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    _scrollView.contentOffset = CGPointZero;
    //_scrollView.scrollIndicatorInsets = contentInsets;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        ViewController* vc = (ViewController* )[segue destinationViewController];
        [vc setPass:password];
        [vc setVaultFile:vaultFile];
        [vc setVaultList:vaultList];
    
}

@end
