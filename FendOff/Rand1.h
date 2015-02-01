#include <UIKit/UIKit.h>

@interface Rand1 : NSObject {
  unsigned long seed;
}

- (id) init;
- (id) initWithSeed:(unsigned long)seedP;
- (unsigned long) rand;
- (unsigned long) randNonNegative;
- (unsigned long) rand:(NSInteger)bits;
- (NSInteger) rand:(NSInteger)min max:(NSInteger)max;
- (void) setSeed:(unsigned long)seed;
@end
