#include <UIKit/UIKit.h>

@interface Rand2 : NSObject {
  unsigned long seed;
}

- (id) init;
- (unsigned long) rand;
- (NSInteger) rand:(NSInteger)min max:(NSInteger)max;
- (void) setSeed:(unsigned long)seed;
@end
