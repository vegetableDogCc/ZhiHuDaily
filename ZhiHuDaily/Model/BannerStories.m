//
//  BannerStories.m
//  ZhiHuDaily
//
//  Created by coin on 2023/3/7.
//

#import "BannerStories.h"

@implementation BannerStories

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.gaPrefix = dic[@"ga_prefix"];
        self.hint = dic[@"hint"];
        self.identifier = [dic[@"id"] longValue];
        self.imageHue = dic[@"image_hue"];
        self.title = dic[@"title"];
        self.type = [dic[@"type"] longValue];
        self.url = dic[@"url"];
        if (dic[@"images"]) {
            self.imageUrl = dic[@"images"][0];
        }
        else if (dic[@"image"]) {
            self.imageUrl = dic[@"image"];
        }
        else {
            self.imageUrl = @"";
        }
    }
    return self;
}

@end
