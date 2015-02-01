#import "Rand1.h"

@implementation Rand1


- (id) init {
    if (self = [super init]) {
        unsigned long s = CFAbsoluteTimeGetCurrent();
        [self setSeed:s != 0 ? s : 1];
    }
    return self;
}

- (id) initWithSeed:(unsigned long)seedP {
    if (self = [super init]) {
        [self setSeed:seedP];
    }
    return self;
}

- (unsigned long) rand {
    seed ^= (seed << 13);
    seed ^= (seed >> 7);
    seed ^= (seed << 17);
    return seed;
}

- (unsigned long) randNonNegative {
    return [self rand] >> 1;
}

- (unsigned long) rand:(NSInteger)bits {
    return [self rand] >> (64 - bits);
}

- (NSInteger) rand:(NSInteger)min max:(NSInteger)max {
    if (min > max) {
        NSInteger m = max;
        max = min;
        min = m;
    }
    if (min == max) {
        return min;
    }
    return (([self rand] >> 1) % (max + 1 - min)) + min;
}



- (void) setSeed:(unsigned long)seedP {
    unsigned long t= 0xCAFEBCDE;
    seedP = seedP + t;
    if (seedP == 0)
        seedP = t;
    seed = seedP;
}

@end
