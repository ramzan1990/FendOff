#include <UIKit/UIKit.h>
#import "Rand1.h"
#import "Rand2.h"

@interface Vsem1 : NSObject {
  NSInteger stot;
}

- (NSInteger) getStot;
- (NSMutableData *) evsem1:(NSMutableData *)bm seed:(NSInteger)seed;
- (NSMutableData *) dvsem1:(NSMutableData *)bm seed:(NSInteger)seed;
- (NSMutableData *) evsem2:(NSMutableData *)bm seed:(NSInteger)seed;
- (NSMutableData *) dvsem2:(NSMutableData *)bm seed:(NSInteger)seed;
- (NSMutableData *) evsem3:(NSMutableData *)bm seed:(NSInteger)seed;
- (NSMutableData *) dvsem3:(NSMutableData *)bm seed:(NSInteger)seed;
- (NSMutableData *) evsem4:(NSMutableData *)bm seed:(NSInteger)seed;
- (NSMutableData *) dvsem4:(NSMutableData *)bm seed:(NSInteger)seed;
- (NSMutableArray *) pastosd:(NSInteger)num pas:(NSString *)pas;
+ (NSMutableArray *) pass16:(NSInteger)num pas:(NSString *)pas;
@end
