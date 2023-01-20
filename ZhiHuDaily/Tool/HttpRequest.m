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

static id _instance = nil;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    //使用dispatch_once方法能保证某段代码在程序运行过程中只被执行1次，并且即使在多线程的环境下，dispatch_once也可以保证线程安全。用在这里就是只创建一次manager，不会创建不用的manager
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:zone] init];
    });
    return _instance;
}

//通过此类方法来返回单例对象
+ (instancetype)sharedTool {
    return [self alloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        //为AFHTTPSessionManager *manager赋值
        self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://news-at.zhihu.com/api/3"]];
        //self.manager.requestSerializer
        //AFJSONRequestSerializer
        //AFHTTPRequestSerializer
    }
    return self;
}

//GET请求
- (void)getWithURLString:(NSString *)urlString parameters:(id)parameters success:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    [self.manager GET:urlString parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
