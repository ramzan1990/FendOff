#include <UIKit/UIKit.h>

@interface Rand2 : NSObject {
  NSUInteger seed;
}

- (id) init;
- (NSInteger) rand;
- (NSInteger) rand:(NSInteger)min max:(NSInteger)max;
- (void) setSeed:(NSInteger)seed;
@end
