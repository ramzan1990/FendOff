#import "Rand1.h"

@implementation Rand1


- (id) init {
  if (self = [super init]) {
    NSInteger s = CFAbsoluteTimeGetCurrent();
    [self setSeed:s != 0 ? s : 1];
  }
  return self;
}

- (id) initWithSeed:(NSInteger)seedP {
  if (self = [super init]) {
    [self setSeed:seedP];
  }
  return self;
}

- (NSInteger) rand {
  seed ^= (seed << 13);
  seed ^= (seed >> 7);
  seed ^= (seed << 17);
  return seed;
}

- (NSInteger) randNonNegative {
  return [self rand] >> 1;
}

- (NSInteger) rand:(NSInteger)bits {
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



- (void) setSeed:(NSInteger)seedP {
  seedP = seedP + 0xCAFEBCDE;
  if (seedP == 0)
    seedP = 0xCADEBCDE;
  seed = seedP;
}

@end
