#import "VaultCategory.h"

@implementation VaultCategory

- (id) initWithName:(NSString *)name{
    catName = name;
    catEntries = [[NSMutableArray alloc] init];
    return self;
}

- (NSString *) getName{
    return catName;
}

- (NSMutableArray *) getEntries{
    return catEntries;
}

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:catName   forKey:@"catName"];
    [aCoder encodeObject:catEntries  forKey:@"catEntries"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super init]))
    {
        catName = [aDecoder decodeObjectForKey:@"catName"];
        catEntries = [aDecoder decodeObjectForKey:@"catEntries"];
    }
    return self;
}

@end
