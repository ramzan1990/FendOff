#import "Vsem1.h"
#include "bytebuffer.h"

@implementation Vsem1

- (NSMutableArray *) evsem1:(NSMutableArray *)bm seed:(NSInteger)seed {
    NSInteger len = [bm count];
    char rb;
    Rand1 * rnd = [[Rand1 alloc] init];
    [rnd setSeed:seed];
    
    for (NSInteger i = 0; i < len; i++) {
        rb = (char)[rnd rand:-127 max:127];
        NSNumber *tmp1 =[bm objectAtIndex:i];
        char tmp2 =([tmp1 charValue]^ rb);
        bm[i] =[NSNumber numberWithInt:tmp2];
    }
    
    return bm;
}

- (NSMutableArray *) dvsem1:(NSMutableArray *)bm seed:(NSInteger)seed {
    NSInteger len = [bm count];
    char rb;
    Rand1 * rnd = [[Rand1 alloc] init];
    [rnd setSeed:seed];
    
    for (NSInteger i = 0; i < len; i++) {
        rb = (char)[rnd rand:-127 max:127];
        NSNumber *tmp1 =[bm objectAtIndex:i];
        char tmp2 =([tmp1 charValue]^ rb);
        bm[i] =[NSNumber numberWithInt:tmp2];
    }
    
    return bm;
}

- (NSMutableArray *) evsem2:(NSMutableArray *)bm seed:(NSInteger)seed {
    NSInteger len = [bm count];
    NSInteger ip;
    char bc = 0;
    Rand2 * rnd = [[Rand2 alloc] init];
    [rnd setSeed:seed];
    NSMutableArray * bb = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < len; i++)
        bb[i] = @(YES);
    
    
    for (NSInteger i = 0; i < len - 1; i++) {
        if ([bb[i] boolValue] == YES) {
            ip =[rnd rand:i + 1 max:len - 1];
            if ([bb[ip] boolValue] == YES) {
                bc = [bm[ip] charValue];
                bm[ip] = bm[i];
                bm[i] = [NSNumber numberWithInt:bc];
                bb[ip] = @(NO);
            }
            else if ((ip + 1) < len) {
                ip++;
                
                while (!bb[ip]) {
                    ip++;
                    if (ip >= len)
                        break;
                }
                
                if (ip < len) {
                    bc = [bm[ip] charValue];
                    bm[ip] = bm[i];
                    bm[i] = [NSNumber numberWithInt:bc];
                    bb[ip] = @(NO);
                }
            }
            else {
                ip--;
                
                while (!bb[ip] && (ip > i)) {
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

- (NSMutableArray *) dvsem2:(NSMutableArray *)bm seed:(NSInteger)seed {
    NSInteger len = [bm count];
    NSInteger ip;
    char bc = 0;
    Rand2 * rnd = [[Rand2 alloc] init];
    [rnd setSeed:seed];
    NSMutableArray * bb = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < len; i++)
        bb[i] = @(YES);
    
    
    for (NSInteger i = 0; i < len - 1; i++) {
        if ([bb[i] boolValue] == YES) {
            ip = [rnd rand:i + 1 max:len - 1];
            if ([bb[ip] boolValue] == YES) {
                bc = [bm[ip] charValue];
                bm[ip] = bm[i];
                bm[i] = [NSNumber numberWithInt:bc];
                bb[ip] = @(NO);
            }
            else if ((ip + 1) < len) {
                ip++;
                
                while (!bb[ip]) {
                    ip++;
                    if (ip >= len)
                        break;
                }
                
                if (ip < len) {
                    bc = [bm[ip] charValue];
                    bm[ip] = bm[i];
                    bm[i] = [NSNumber numberWithInt:bc];
                    bb[ip] = @(NO);
                }
            }
            else {
                ip--;
                
                while (!bb[ip] && (ip > i)) {
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

- (NSMutableArray *) evsem3:(NSMutableArray *)bm seed:(NSInteger)seed {
    NSInteger len = [bm count];
    char rb, tb;
    Rand1 * rnd = [[Rand1 alloc] init];
    [rnd setSeed:seed];
    for (NSInteger i = 0; i < len; i++) {
        NSInteger j = [rnd rand:0 max:2];
        rb = [bm[i] charValue];
        tb = (char)(((rb >> j) ^ (rb >> 5)) & ((1 << 3) - 1));
        bm[i] =  [NSNumber numberWithInt:(char)(rb ^ ((tb << j) | (tb << 5)))];;
    }
    
    return bm;
}

- (NSMutableArray *) dvsem3:(NSMutableArray *)bm seed:(NSInteger)seed {
    NSInteger len = [bm count];
    char rb, tb;
    Rand1 * rnd = [[Rand1 alloc] init];
    [rnd setSeed:seed];
    
    for (NSInteger i = 0; i < len; i++) {
        NSInteger j = [rnd rand:0 max:2];
        rb = [bm[i] charValue];
        tb = (char)(((rb >> j) ^ (rb >> 5)) & ((1 << 3) - 1));
        bm[i] = [NSNumber numberWithInt:(char)(rb ^ ((tb << j) | (tb << 5)))];
    }
    
    return bm;
}

- (NSMutableArray *) evsem4:(NSMutableArray *)bm seed:(NSInteger)seed {
    NSInteger len = [bm count];
    char rb;
    Rand2 * rnd = [[Rand2 alloc] init];
    [rnd setSeed:seed];
    
    for (NSInteger i = 0; i < len; i++) {
        char j = (char)[rnd rand:-127 max:127];
        rb = ~[bm[i] charValue];
        bm[i] = [NSNumber numberWithInt:(char)(rb ^ j)];
    }
    
    return bm;
}

- (NSMutableArray *) dvsem4:(NSMutableArray *)bm seed:(NSInteger)seed {
    NSInteger len = [bm count];
    char rb;
    Rand2 * rnd = [[Rand2 alloc] init];
    [rnd setSeed:seed];
    
    for (NSInteger i = 0; i < len; i++) {
        char j = (char)[rnd rand:-127 max:127];
        rb = (char)([bm[i] charValue] ^ j);
        bm[i] = [NSNumber numberWithInt:(char)~rb];
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
                ppas = [pas substringWithRange:NSMakeRange(16,32)];
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
        NSString * s =[NSString stringWithFormat:@"%@%@", pad, [pas substringWithRange:NSMakeRange(i * ls,(i + 1) * ls)]];
        spa[i] =  s;
        NSData *bytes = [s dataUsingEncoding:NSUTF8StringEncoding];
        uint8_t *rawBytes = [bytes bytes];
        byte_buffer bb = *bb_new_wrap(rawBytes, [bytes length]);
        // [bb order:ByteOrder.LITTLE_ENDIAN];
        if (ls <= 4)
            sa[i] =[NSNumber numberWithInt:bb_get_int(&bb)];
        else
            sa[i] = [NSNumber numberWithLong:bb_get_long(&bb)];
        if (numc < num)
            sa[num - 1] = sa[num - 2];
    }
    
    if (lsl > 0 && len > num) {
        pad = @"";
        if (lso == 1 || lso == 5)
            pad = @"123";
        else if (lso == 2 || lso == 6)
            pad = @"45";
        else if (lso == 3 || lso == 7)
            pad = @"6";
        NSString* s =[NSString stringWithFormat:@"%@%@", pad, [pas substringFromIndex:numc * ls]];
        spa[num - 1] = s;
        NSData *bytes = [s dataUsingEncoding:NSUTF8StringEncoding];
        uint8_t *rawBytes = [bytes bytes];
        byte_buffer bb = *bb_new_wrap(rawBytes, [bytes length]);
        
        //[bb order:ByteOrder.BIG_ENDIAN];
        if (ls <= 4)
            sa[num - 1] = [NSNumber numberWithInt:bb_get_int(&bb)];
        else
            sa[num - 1] = [NSNumber numberWithLong:bb_get_long(&bb)];
    }
    return sa;
}

@end
