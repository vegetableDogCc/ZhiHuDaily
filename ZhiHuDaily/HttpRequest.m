//
//  HttpRequest.m
//  ZhiHuDaily
//
//  Created by coin on 2022/12/26.
//

#import "HttpRequest.h"
#import <AFNetworking/AFNetworking.h>

@interface HttpRequest ()

@property(nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation HttpRequest

static id _manager;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[super allocWithZone:zone] init];
    });
    return _manager;
}

+ (instancetype)sharedTool {
    return [self alloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://news-at.zhihu.com/api/3"]];
        //self.manager.requestSerializer
        //AFJSONRequestSerializer
        //AFHTTPRequestSerializer
    }
    return self;
}

@end
