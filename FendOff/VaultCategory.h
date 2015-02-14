#include <UIKit/UIKit.h>

@interface VaultCategory : NSObject <NSCoding>{
    NSString* catName;
    int catType;
    NSMutableArray* catEntries;
}

-  (id) initWithName:(NSString *)name;
- (NSString *) getName;
- (NSMutableArray *) getEntries;

@end
