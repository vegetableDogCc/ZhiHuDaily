#import "StoriesContent.h"

@implementation StoriesContent

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.body = dic[@"body"];
        self.identifier = [dic[@"id"] longValue];
        self.js = dic[@"js"][0];
        self.gaPrefix = dic[@"ga_prefix"];
        self.url = dic[@"url"];
        self.title = dic[@"title"];
        self.imageHue = dic[@"image_hue"];
        self.imageUrl = dic[@"image"];
        self.shareUrl = dic[@"share_url"];
        self.imagesUrl = dic[@"images"][0];
        self.css = dic[@"css"][0];
        self.type = [dic[@"type"] longValue];
        self.publishTime = [dic[@"publish_time"] longValue];
        self.createTime = [dic[@"create_time"] longValue];
    }
    return self;
}

@end
