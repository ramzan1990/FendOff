#import "CategoryEntry.h"

@implementation CategoryEntry

- (id) initWithName:(NSString *)nameP {
    name = nameP;
    note = @"";
    return self;
}

- (NSString *) getName{
    return name;
}

- (NSString *) getNote{
    return note;
}

-(void) setNote: (NSString *)newNote{
    note =newNote;
}

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:name   forKey:@"name"];
    [aCoder encodeObject:note  forKey:@"note"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super init]))
    {
        name = [aDecoder decodeObjectForKey:@"name"];
        note = [aDecoder decodeObjectForKey:@"note"];
    }
    return self;
}

@end
