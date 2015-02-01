#include <UIKit/UIKit.h>
#import "Rand1.h"
#import "Rand2.h"

@interface Vsem1 : NSObject {
  NSInteger stot;
}

- (NSMutableArray *) evsem1:(NSMutableArray *)bm seed:(NSInteger)seed;
- (NSMutableArray *) dvsem1:(NSMutableArray *)bm seed:(NSInteger)seed;
- (NSMutableArray *) evsem2:(NSMutableArray *)bm seed:(NSInteger)seed;
- (NSMutableArray *) dvsem2:(NSMutableArray *)bm seed:(NSInteger)seed;
- (NSMutableArray *) evsem3:(NSMutableArray *)bm seed:(NSInteger)seed;
- (NSMutableArray *) dvsem3:(NSMutableArray *)bm seed:(NSInteger)seed;
- (NSMutableArray *) evsem4:(NSMutableArray *)bm seed:(NSInteger)seed;
- (NSMutableArray *) dvsem4:(NSMutableArray *)bm seed:(NSInteger)seed;
- (NSMutableArray *) pastosd:(NSInteger)num pas:(NSString *)pas;
+ (NSMutableArray *) pass16:(NSInteger)num pas:(NSString *)pas;
@end
