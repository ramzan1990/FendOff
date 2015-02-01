#include <UIKit/UIKit.h>

@interface Rand1 : NSObject {
  NSUInteger seed;
}

- (id) init;
- (id) initWithSeed:(NSInteger)seedP;
- (NSInteger) rand;
- (NSInteger) randNonNegative;
- (NSInteger) rand:(NSInteger)bits;
- (NSInteger) rand:(NSInteger)min max:(NSInteger)max;
- (void) setSeed:(NSInteger)seed;
@end
