#include <UIKit/UIKit.h>

@interface CategoryEntry : NSObject <NSCoding>{
    NSString* name;
    NSString* note;
}

- (id) initWithName:(NSString *)nameP;
-(NSString *) getName;
-(NSString *) getNote;
-(void) setNote: (NSString *)newNote;

@end
