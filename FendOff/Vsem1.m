#import "Vsem1.h"

@implementation Vsem1


-(NSInteger)getStot{
    return stot;
}

- (NSMutableData *) evsem_x:(NSMutableData *)bm seed:(NSInteger)seed {
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

- (NSMutableData *) dvsem_x:(NSMutableData *)bm seed:(NSInteger)seed {
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



- (NSMutableData *) evsem_t:(NSMutableData *)bm seed:(NSInteger)seed {
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

- (NSMutableData *) dvsem_t:(NSMutableData *)bm seed:(NSInteger)seed {
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

- (NSMutableData *) evsem_s:(NSMutableData *)bm seed:(NSInteger)seed {
    NSInteger len = [bm length];
    char rb, tb;
    Rand1 * rnd = [[Rand1 alloc] init];
    [rnd setSeed:seed];
    char* fileBytes = (char*)[bm mutableBytes];
    for (NSInteger i = 0; i < len; i++) {
        char jj = (char) [rnd rand:0 max:255];
        char j = (char) [rnd rand:0 max:7];
        rb = fileBytes[i];
        tb = (char) ((((unsigned char)(0xFF & rb) >> j) | (rb << (8 - j))));
        fileBytes[i] = (char) (tb ^ jj);
    }
    return bm;
}

- (NSMutableData *) dvsem_s:(NSMutableData *)bm seed:(NSInteger)seed {
    NSInteger len = [bm length];
    char rb;
    Rand1 * rnd = [[Rand1 alloc] init];
    [rnd setSeed:seed];
    char* fileBytes = (char*)[bm mutableBytes];
    for (NSInteger i = 0; i < len; i++) {
        char jj = (char) [rnd rand:0 max:255];
        char j = (char) [rnd rand:0 max:7];
        rb = (char) (fileBytes[i] ^ jj);
        fileBytes[i] = (char) ((unsigned char)(0xFF & rb) >> (8 - j) | (rb << j));
    }
    
    return bm;
}



- (NSMutableData *) evsem_ct:(NSMutableData *)bm seed:(NSInteger)seed {
    NSInteger len = [bm length];
    char rb;
    Rand1 * rnd = [[Rand1 alloc] init];
    [rnd setSeed:seed];
    char* fileBytes = (char*)[bm mutableBytes];
    NSMutableArray * bms = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < len; i++) {
        char j = (char)[rnd rand:-127 max:127];
        rb = ~fileBytes[i];
        fileBytes[i] = (rb ^ j);
    }
    
    return bm;
}

byte[] evsem_ct(byte[] bm, long seed) {
    int len = bm.length;
    byte rb;
    byte bms[] = new byte[len];
    Rand1 rnd = new Rand1();
    rnd.setSeed(seed);
    int jl = (int) rnd.rand(0, len - 1);
    for (int i = 0; i < len; i++) {
        if (i + jl < len)
            bms[i + jl] = bm[i];
        else
            bms[i + jl - len] = bm[i];
    }
    for (int i = 0; i < len; i++) {
        byte j = (byte) rnd.rand(-128, 127);
        rb = (byte) bms[i];
        bm[i] = (byte) (rb ^ j);
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
    //NSInteger lso = ls + lsl;
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

+(NSMutableData *) decryptData:(NSData *) data passw:(NSString *) passw highSecurity:(BOOL) highSecurity{
    NSMutableData *mData = [NSMutableData data];
    [mData appendData:data];
    Vsem1 * em = [[Vsem1 alloc] init];
    NSMutableArray* sa = [em pastosd:2 pas:passw];
    long stot = [em getStot];
    long s3 = -999;
    if (stot > 3) s3 = [sa[3] integerValue];
     if(highSecurity){
    mData = [em dvsem4:mData seed:s3];
     }
    s3 = 999;
    if (stot > 2) s3 = [sa[2] integerValue];
    mData = [em dvsem_s:mData seed:s3];
    if(highSecurity){
        mData = [em dvsem_t:mData seed:[sa[1] integerValue]];
    }
    mData = [em dvsem_x:mData seed:[sa[0] integerValue]];
    return mData;
}

+(NSMutableData *) encryptData:(NSData *) data passw:(NSString *) passw highSecurity:(BOOL) highSecurity{
    NSMutableData *bouts = [NSMutableData data];
    [bouts appendData:data];
    Vsem1 * em = [[Vsem1 alloc] init];
    NSMutableArray* sa = [em pastosd:2 pas:passw];
    long stot = [em getStot];
    bouts = [em evsem_x:bouts seed:[sa[0] integerValue]];
    if(highSecurity){
        bouts = [em evsem_t:bouts seed:[sa[1] integerValue]];
    }
    long s3 = 999;
    if (stot > 2) s3 = [sa[2] integerValue];
    bouts = [em evsem_s:bouts seed:s3];
    if(highSecurity){
    s3 = -999;
    if (stot > 3) s3 = [sa[3] integerValue];
    bouts = [em evsem_ct:bouts seed:s3];
    }
    return bouts;
}

@end
