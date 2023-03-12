#import "InteractionNumber.h"

@implementation InteractionNumber

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.longComments = [dic[@"long_comments"] longValue];;
        self.popularity = [dic[@"popularity"] longValue];
        self.shortComments = [dic[@"short_comments"] longValue];
        self.comments = [dic[@"comments"] longValue];
    }
    return self;
}

@end
