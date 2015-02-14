#include <UIKit/UIKit.h>

@interface  EncryptedEntry : NSObject <NSCoding>{
    NSString* name;
    NSString* file;
    NSString* password;
    UIImage* preview;
}

-  (id) init:(NSString *)nameP file:(NSString*) fileP password:(NSString* ) passwordP preview:(UIImage*)priviewP;
- (NSString *) getName;
- (NSString *) getFile;
- (NSString *) getPassword;
- (UIImage *) getPreview;

@end
