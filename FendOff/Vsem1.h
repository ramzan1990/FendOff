#include <UIKit/UIKit.h>
#import "Rand1.h"
#import "Rand2.h"

@interface Vsem1 : NSObject {
  NSInteger stot;
}

- (NSInteger) getStot;
- (NSMutableData *) evsem_x:(NSMutableData *)bm seed:(NSInteger)seed;
- (NSMutableData *) dvsem_x:(NSMutableData *)bm seed:(NSInteger)seed;
- (NSMutableData *) evsem_t:(NSMutableData *)bm seed:(NSInteger)seed;
- (NSMutableData *) dvsem_t:(NSMutableData *)bm seed:(NSInteger)seed;
- (NSMutableData *) evsem_s:(NSMutableData *)bm seed:(NSInteger)seed;
- (NSMutableData *) dvsem_s:(NSMutableData *)bm seed:(NSInteger)seed;
- (NSMutableData *) evsem_ct:(NSMutableData *)bm seed:(NSInteger)seed;
- (NSMutableData *) dvsem_ct:(NSMutableData *)bm seed:(NSInteger)seed;
- (NSMutableArray *) pastosd:(NSInteger)num pas:(NSString *)pas;
+ (NSMutableArray *) pass16:(NSInteger)num pas:(NSString *)pas;
+(NSMutableData *) decryptData:(NSData *) data passw:(NSString *) passw highSecurity:(BOOL) highSecurity;
+(NSMutableData *) encryptData:(NSData *) data passw:(NSString *) passw highSecurity:(BOOL) highSecurity;

@end
