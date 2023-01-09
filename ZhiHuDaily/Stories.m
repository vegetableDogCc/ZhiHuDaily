//
//  Story.m
//  ZhiHuDaily
//
//  Created by coin on 2022/12/28.
//

#import "Stories.h"

@implementation Stories

//自定义初始化方法
//调用initWithDictionary:方法的对象,其gaPrefix等属性等于传进来的字典参数的相对应的值
- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.gaPrefix = dic[@"ga_prefix"];
        self.hint = dic[@"hint"];
        self.identifier = [dic[@"id"] longValue];
        self.imageHue = dic[@"image_hue"];
        //self.imageUrl = dic[@"images"] ? dic[@"images"][0] : @"";
        if (dic[@"images"]) {
            self.imageUrl = dic[@"images"][0];
        }
        else if (dic[@"image"]) {
            self.imageUrl = dic[@"image"];
        }
        else {
            self.imageUrl = @"";
        }
        self.title = dic[@"title"];
        self.type = [dic[@"type"] longValue];
        self.url = dic[@"url"];
    }
    return self;
}

@end
