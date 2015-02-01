#import "Rand2.h"

@implementation Rand2

- (id) init {
  if (self = [super init]) {
    seed = 0xCAFEBCDE;
  }
  return self;
}

- (unsigned long) rand {
  seed ^= (seed << 21);
  seed ^= (seed >> 35);
  seed ^= (seed << 4);
  return seed;
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
  NSInteger out = (NSInteger)[self rand] % max;
  out = (out < 0) ? -out : out;
  out = (out % (max + 1 - min)) + min;
  return out;
}

- (void) setSeed:(unsigned long)seedP {
  unsigned long t= 0xCAFEBCDE;
  seedP = seedP + t;
  if (seedP == 0)
    seedP =t;
  seed = seedP;
}

@end
