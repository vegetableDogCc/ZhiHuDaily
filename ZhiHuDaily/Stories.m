//
//  Story.m
//  ZhiHuDaily
//
//  Created by coin on 2022/12/28.
//

#import "Stories.h"

@implementation Story

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.gaPrefix = dic[@"ga_prefix"];
        self.hint = dic[@"hint"];
        self.identifier = [dic[@"id"] longValue];
        self.imageHue = dic[@"image_hue"];
        self.imageUrl = dic[@"images"];
        self.title = dic[@"title"];
        self.type = [dic[@"type"] longValue];
        self.url = dic[@"url"];
    }
    return self;
}

@end
