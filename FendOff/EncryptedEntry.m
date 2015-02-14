#import "EncryptedEntry.h"

@implementation EncryptedEntry

-  (id) init:(NSString *)nameP file:(NSString*) fileP password:(NSString* ) passwordP preview:(UIImage *)priviewP{
    name = nameP;
    file = fileP;
    password = passwordP;
    preview = priviewP;
    return self;
}

- (NSString *) getName{
    return name;
}
- (NSString *) getFile{
    return file;
}

- (NSString *) getPassword{
    return password;
}

- (UIImage *) getPreview{
    return preview;
}

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:name   forKey:@"name"];
    [aCoder encodeObject:file  forKey:@"file"];
    [aCoder encodeObject:password   forKey:@"password"];
    [aCoder encodeObject:preview  forKey:@"preview"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super init]))
    {
        name = [aDecoder decodeObjectForKey:@"name"];
        file = [aDecoder decodeObjectForKey:@"file"];
        password = [aDecoder decodeObjectForKey:@"password"];
        preview = [aDecoder decodeObjectForKey:@"preview"];
    }
    return self;
}

@end
