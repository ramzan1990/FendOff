//
//  ViewController.m
//  FendOff
//
//  Created by Ramzan Umarov on 1/31/15.
//  Copyright (c) 2015 Softberry. All rights reserved.
//

#import "ViewController.h"
#include "bytebuffer.h"
#import "Vsem1.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tryToFail:(id)sender {        NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *dirName = [docDir stringByAppendingPathComponent:@"MyDir"];
        
        BOOL isDir;
        NSFileManager *fm = [NSFileManager defaultManager];
        if(![fm fileExistsAtPath:dirName isDirectory:&isDir])
        {
            if([fm createDirectoryAtPath:dirName withIntermediateDirectories:YES attributes:nil error:nil])
                NSLog(@"Directory Created");
            else
                NSLog(@"Directory Creation Failed");
        }
        else
            NSLog(@"Directory Already Exist");
        
        NSFileManager *filemgr;
        filemgr = [NSFileManager defaultManager];
        NSString * fileName = @"newfile.txt";
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains
        (NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent: @"MyDir"];
        filePath = [filePath stringByAppendingPathComponent: @"newfile.txt"];
        NSLog(@"full path name: %@", filePath);
        
        // check if file exists
        if ([filemgr fileExistsAtPath: filePath] == YES){
            NSLog(@"File exists");
            
        }else {
            NSLog (@"File not found, file will be created");
            NSData *file;
            file =  [@"I am a text file with important information, for example password 4515. Thats it." dataUsingEncoding:NSUTF8StringEncoding];
            if (![filemgr createFileAtPath:filePath contents:file attributes:nil]){
                NSLog(@"Create file returned NO");
            }
        }
       NSString* newFile =  [self tryToSave:filePath];
        
    [self tryToSaveAgain:newFile];
    
}

- (NSString *) tryToSave:(NSString *) path{
    NSString* passw = @"1234";
    NSString* allt = @"";
    NSString* outs;
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    outs = [NSString stringWithFormat:@"%@%@%@", @"FendoffP ", [DateFormatter stringFromDate:[NSDate date]], @"\n"];
    allt = [NSString stringWithFormat:@"%@%@%@", outs, passw, @"\n"];
    int lensh = [allt length];
    lensh = lensh + 3;
    outs = [NSString stringWithFormat:@"%d%@", lensh, @"\n"];
    allt = [NSString stringWithFormat:@"%@%@", allt, outs];
    NSData *temp = [allt dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableData *bouts = [NSMutableData data];
    [bouts appendData:temp];
    [bouts appendData:data];
    
    Vsem1 * em = [[Vsem1 alloc] init];
    NSMutableArray* sa = [em pastosd:2 pas:passw];
    long stot = [em getStot];
    bouts = [em evsem1:bouts seed:[sa[0] integerValue]];
    bouts = [em evsem2:bouts seed:[sa[1] integerValue]];
    long s3 = 999;
    if (stot > 2) s3 = [sa[2] integerValue];
    bouts = [em evsem3:bouts seed:s3];
    s3 = -999;
    if (stot > 3) s3 = [sa[3] integerValue];
    bouts = [em evsem4:bouts seed:s3];
    NSString* newFile =[NSString stringWithFormat:@"%@.ff", path];
    [bouts writeToFile:newFile atomically:YES];
    return newFile;
}

-(void) printData:(NSMutableData *) data{
    char* bytes = (char *) [data bytes];
    for(int i = 0; i<[data length]; i++){
        int t = bytes[i];
        NSLog([NSString stringWithFormat:@" %d ", t]);
    }
}

- (void) tryToSaveAgain:(NSString *) path
{
    NSString* passw = @"1234";
     NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSMutableData *mData = [NSMutableData data];
    [mData appendData:data];
    
    Vsem1 * em = [[Vsem1 alloc] init];
    
    NSMutableArray* sa = [em pastosd:2 pas:passw];
    
    long stot = [em getStot];
    
    long s3 = -999;
    if (stot > 3) s3 = [sa[3] integerValue];
    mData = [em dvsem4:mData seed:s3];
    s3 = 999;
    if (stot > 2) s3 = [sa[2] integerValue];
    mData = [em dvsem3:mData seed:s3];
    mData = [em dvsem2:mData seed:[sa[1] integerValue]];
    mData = [em dvsem1:mData seed:[sa[0] integerValue]];
    NSString* newFile =[NSString stringWithFormat:@"%@ff.txt", path];
    [mData writeToFile:newFile atomically:YES];
}

@end
