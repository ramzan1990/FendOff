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

- (IBAction)tryToFail:(id)sender {
    @try{
        NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
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
            file =  [@"rrrrjgkgdjfgkl;jd dfk j;glkdfg ;ldfkgjdflk;" dataUsingEncoding:NSUTF8StringEncoding];
            if (![filemgr createFileAtPath:filePath contents:file attributes:nil]){
                NSLog(@"Create file returned NO");
            }
        }
        const char *cString = [filePath cStringUsingEncoding:NSUTF8StringEncoding];
        byte_buffer bb = *bb_new_from_file(cString, "rb");
        [self tryToSave:bb];
        
    }
    @catch(NSException * ex){
         NSLog(@"%@", [ex callStackSymbols]);
    }
}

- (void) tryToSave:(byte_buffer) bb{
    NSString* passw = @"1234";
    NSString* allt = @"";
    NSString* outs;
     NSMutableArray * bouts = [[NSMutableArray alloc] init];
     NSMutableArray * boutss = [[NSMutableArray alloc] init];
    
    byte_buffer allf = bb;
    DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
    Date date = new Date();
    outs = String.format("FendoffP " + dateFormat.format(date) + "\n");
    allt = allt.concat(outs);
    allt = allt.concat(passw);
    allt = allt.concat("\n");
    int lensh = allt.length();
    lensh = lensh + 3;
    outs = "" + lensh + "\n";
    allt = allt.concat(outs);
    boutss = allt.getBytes();
    ByteArrayOutputStream outst = new ByteArrayOutputStream();
    outst.write(boutss);
    outst.write(allf);
    bouts = outst.toByteArray();
    Vsem1 em = new Vsem1();
    long[] sa = em.pastosd(2, passw);
    int stot = em.stot;
    bouts = em.evsem1(bouts, sa[0]);
    bouts = em.evsem2(bouts, sa[1]);
    long s3 = 999;
    if (stot > 2) s3 = sa[2];
    bouts = em.evsem3(bouts, s3);
    s3 = -999;
    if (stot > 3) s3 = sa[3];
    bouts = em.evsem4(bouts, s3);
    oS.write(bouts);
    oS.close();
}


@end
