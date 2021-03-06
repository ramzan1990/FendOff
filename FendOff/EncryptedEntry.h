#include <UIKit/UIKit.h>

@interface  EncryptedEntry : NSObject <NSCoding>{
    NSString* name;
    NSString* password;
    UIImage* preview;
}

-  (id) init:(NSString *)nameP password:(NSString* ) passwordP preview:(UIImage*)priviewP;
- (NSString *) getName;
- (NSString *) getPassword;
- (UIImage *) getPreview;

@end
