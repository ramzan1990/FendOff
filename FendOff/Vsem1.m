#import "Vsem1.h"
#include "bytebuffer.h"

@implementation Vsem1


-(NSInteger)getStot{
    return stot;
}

- (NSMutableData *) evsem1:(NSMutableData *)bm seed:(NSInteger)seed {
    NSInteger len = [bm length];
    char rb;
    Rand1 * rnd = [[Rand1 alloc] init];
    [rnd setSeed:seed];
    char* fileBytes = (char*)[bm mutableBytes];
    for (NSInteger i = 0; i < len; i++) {
        rb = (char)[rnd rand:-127 max:127];
        fileBytes[i] =fileBytes[i] ^ rb;
    }
    
    return bm;
}

- (NSMutableData *) dvsem1:(NSMutableData *)bm seed:(NSInteger)seed {
    NSInteger len = [bm length];
    char rb;
    Rand1 * rnd = [[Rand1 alloc] init];
    [rnd setSeed:seed];
    char* fileBytes = (char*)[bm mutableBytes];
    for (NSInteger i = 0; i < len; i++) {
        rb = (char)[rnd rand:-127 max:127];
        fileBytes[i] =fileBytes[i] ^ rb;
    }
    return bm;
}

- (NSMutableData *) evsem2:(NSMutableData *)bm seed:(NSInteger)seed {
    NSInteger len = [bm length];
    NSInteger ip;
    char bc = 0;
    Rand2 * rnd = [[Rand2 alloc] init];
    [rnd setSeed:seed];
    NSMutableArray * bb = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < len; i++)
        bb[i] = @(YES);
    
    char* fileBytes = (char*)[bm mutableBytes];
    for (int i = 0; i < len - 1; i++) {
        if ([bb[i] boolValue] == YES) {
            ip =[rnd rand:i + 1 max:len - 1];
            if ([bb[ip] boolValue] == YES) {
                bc = fileBytes[ip];
                fileBytes[ip] = fileBytes[i];
                fileBytes[i] = bc;
                bb[ip] = @(NO);
            }
            else if ((ip + 1) < len) {
                ip++;
                
                while (!([bb[ip] boolValue] == YES)) {
                    ip++;
                    if (ip >= len)
                        break;
                }
                
                if (ip < len) {
                    bc = fileBytes[ip];
                    fileBytes[ip] = fileBytes[i];
                    fileBytes[i] = bc;
                    bb[ip] = @(NO);
                }
            }
            else {
                ip--;
                
                while (!([bb[ip] boolValue] == YES) && (ip > i)) {
                    if (ip >= len)
                        break;
                    ip--;
                }
                
                if (ip <= i)
                    break;
            }
        }
    }
    
    return bm;
}

- (NSMutableData *) dvsem2:(NSMutableData *)bm seed:(NSInteger)seed {
    NSInteger len = [bm length];
    NSInteger ip;
    char bc = 0;
    Rand2 * rnd = [[Rand2 alloc] init];
    [rnd setSeed:seed];
    NSMutableArray * bb = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < len; i++)
        bb[i] = @(YES);
    
    char* fileBytes = (char*)[bm mutableBytes];
    for (NSInteger i = 0; i < len - 1; i++) {
        if ([bb[i] boolValue] == YES) {
            ip = [rnd rand:i + 1 max:len - 1];
            if ([bb[ip] boolValue] == YES) {
                bc = fileBytes[ip] ;
                fileBytes[ip] = fileBytes[i];
                fileBytes[i] = bc;
                bb[ip] = @(NO);
            }
            else if ((ip + 1) < len) {
                ip++;
                
                while (!([bb[ip] boolValue] == YES)) {
                    ip++;
                    if (ip >= len)
                        break;
                }
                
                if (ip < len) {
                    bc = fileBytes[ip] ;
                    fileBytes[ip] = fileBytes[i];
                    fileBytes[i] = bc;
                    bb[ip] = @(NO);
                }
            }
            else {
                ip--;
                
                while (!([bb[ip] boolValue] == YES) && (ip > i)) {
                    if (ip >= len)
                        break;
                    ip--;
                }
                
                if (ip <= i)
                    break;
            }
        }
    }
    
    return bm;
}

- (NSMutableData *) evsem3:(NSMutableData *)bm seed:(NSInteger)seed {
    NSInteger len = [bm length];
    char rb, tb;
    Rand1 * rnd = [[Rand1 alloc] init];
    [rnd setSeed:seed];
    char* fileBytes = (char*)[bm mutableBytes];
    for (NSInteger i = 0; i < len; i++) {
        NSInteger j = [rnd rand:0 max:2];
        rb = fileBytes[i] ;
        tb = (((rb >> j) ^ (rb >> 5)) & ((1 << 3) - 1));
        fileBytes[i] =  (char)(rb ^ ((tb << j) | (tb << 5)));
    }
    
    return bm;
}

- (NSMutableData *) dvsem3:(NSMutableData *)bm seed:(NSInteger)seed {
    NSInteger len = [bm length];
    char rb, tb;
    Rand1 * rnd = [[Rand1 alloc] init];
    [rnd setSeed:seed];
    char* fileBytes = (char*)[bm mutableBytes];
    for (NSInteger i = 0; i < len; i++) {
        NSInteger j = [rnd rand:0 max:2];
        rb = fileBytes[i];
        tb = (char)(((rb >> j) ^ (rb >> 5)) & ((1 << 3) - 1));
        fileBytes[i] = (char)(rb ^ ((tb << j) | (tb << 5)));
    }
    
    return bm;
}

- (NSMutableData *) evsem4:(NSMutableData *)bm seed:(NSInteger)seed {
    NSInteger len = [bm length];
    char rb;
    Rand2 * rnd = [[Rand2 alloc] init];
    [rnd setSeed:seed];
    char* fileBytes = (char*)[bm mutableBytes];
    for (NSInteger i = 0; i < len; i++) {
        char j = (char)[rnd rand:-127 max:127];
        rb = ~fileBytes[i];
        fileBytes[i] = (rb ^ j);
    }
    
    return bm;
}

- (NSMutableData *) dvsem4:(NSMutableData *)bm seed:(NSInteger)seed {
    NSInteger len = [bm length];
    char rb;
    Rand2 * rnd = [[Rand2 alloc] init];
    [rnd setSeed:seed];
    char* fileBytes = (char*)[bm mutableBytes];
    for (NSInteger i = 0; i < len; i++) {
        char j = (char)[rnd rand:-127 max:127];
        rb = (char)(fileBytes[i]  ^ j);
        fileBytes[i] = ~rb;
    }
    
    return bm;
}

- (NSMutableArray *) pastosd:(NSInteger)num pas:(NSString *)pas {
    NSInteger i;
    NSInteger len = [pas length];
    NSInteger numb = num;
    if (len > 16)
        numb = 2 * num;
    if (len > 32) {
        numb = 3 * num;
    }
    NSMutableArray * sab = [[NSMutableArray alloc] init];
    stot = 0;
    NSString * ppas = nil;
    NSMutableArray * sa = [[NSMutableArray alloc] init];
    NSInteger lc, lp;
    if (len != 0) {
        if (len <= 16)
            ppas = pas;
        else
            ppas = [pas substringToIndex:16];
        sa = [Vsem1 pass16:num pas:ppas];
        lc = num;
        lp = [ppas length];
        if (lp < num)
            lc = lp;
        
        for (i = 0; i < lc; i++) {
            sab[stot] = sa[i];
            stot++;
        }
        
        if (len > 16) {
            if (len <= 32)
                ppas = [pas substringFromIndex:16];
            else
                ppas = [pas substringWithRange:NSMakeRange(16,16)];
            sa = [Vsem1 pass16:num pas:ppas];
            lc = num;
            lp = [ppas length];
            if (lp < num)
                lc = lp;
            
            for (i = 0; i < lc; i++) {
                sab[stot] = sa[i];
                stot++;
            }
            
        }
        if (len > 32) {
            if (len <= 48)
                ppas = [pas substringFromIndex:32];
            sa = [Vsem1 pass16:num pas:ppas];
            lc = num;
            lp = [ppas length];
            if (lp < num)
                lc = lp;
            
            for (i = 0; i < lc; i++) {
                sab[stot] = sa[i];
                stot++;
            }
            
        }
    }
    if (stot == 0) {
        
        for (i = 0; i < num; i++) {
            sab[stot] = [NSNumber numberWithInt:3000];
            stot++;
        }
        
    }
    return sab;
}

+ (NSMutableArray *) pass16:(NSInteger)num pas:(NSString *)pas {
    NSMutableArray * sa = [[NSMutableArray alloc] init];
    NSInteger i;
    NSInteger len = [pas length];
    NSInteger lsl = len % num;
    NSInteger ls = (len / num);
    if (len < num) {
        ls = len;
        lsl = 0;
    }
    NSInteger lso = ls + lsl;
    NSMutableArray * spa = [[NSMutableArray alloc] init];
    NSInteger numc = num - 1;
    if (lsl == 0)
        numc = num;
    NSString * pad = @"";
    
    for (i = 0; i < numc; i++) {
        pad = @"";
        if (ls == 1 || ls == 5)
            pad = @"%#$";
        else if (ls == 2 || ls == 6)
            pad = @"&^";
        else if (ls == 3 || ls == 7)
            pad = @"$";
        long r1 =i * ls;
        long r2 =(i + 1) * ls;
        NSString * s =[NSString stringWithFormat:@"%@%@", pad, [pas substringWithRange:NSMakeRange(r1,r2-r1)]];
        spa[i] =  s;
        NSData *bytes = [s dataUsingEncoding:NSUTF8StringEncoding];
        char *rawBytes = (char *)[bytes bytes];
        sa[i] =[NSNumber numberWithInt:OSReadLittleInt32(rawBytes, 0)];
        
        if (numc < num)
            sa[num - 1] = sa[num - 2];
    }
    
   
    return sa;
}

@end
