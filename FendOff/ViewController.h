//
//  ViewController.h
//  FendOff
//
//  Created by Ramzan Umarov on 1/31/15.
//  Copyright (c) 2015 Softberry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EncryptedEntry.h"

@interface ViewController : UIViewController{
    BOOL fileExists;
}

- (void) setPass:(NSString *)pass;
- (void) setVaultFile:(NSString *)vaultFileP;
- (void) setVaultList:(NSMutableArray *)vaultListP;
+(NSString *) getPass;
+(NSString *) getVaultFile;
+(NSMutableArray *) getVaultList;
+ (NSMutableArray *) getImagesList;
+ (void) addEncryptedEntry:(EncryptedEntry*) ee;
+ (void) changePassword:(NSString *) newPass;
@end

