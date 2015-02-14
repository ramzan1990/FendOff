//
//  DecryptController.h
//  FendOff
//
//  Created by Ramzan Umarov on 2/6/15.
//  Copyright (c) 2015 Softberry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EncryptedEntry.h"

@interface DecryptController : UITableViewController{
    EncryptedEntry* selectedEntry;
}

@end
