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

static id _instance = nil; //nil自加

//重写allocWithZone:方法
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    //使用dispatch_once方法能保证某段代码在程序运行过程中只被执行1次，并且即使在多线程的环境下，dispatch_once也可以保证线程安全。用在这里就是只创建一次manager，不会创建不用的manager
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //调用父类allocWithZone:方法来创建对象
        _instance = [[super allocWithZone:zone] init];
    });
    return _instance;
}

//通过sharedTool类方法来返回单例对象
+ (instancetype)sharedTool {
    return [self alloc];
}

//重写init
- (instancetype)init {
    //调用父类的init方法
    self = [super init];
    //如果父类初始化成功
    if (self) {
        //为AFHTTPSessionManager *manager赋值
        self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://news-at.zhihu.com/api/3"]];
        //self.manager.requestSerializer
        //AFJSONRequestSerializer
        //AFHTTPRequestSerializer
    }
    return self;
}

#pragma mark - GET请求

//最新新闻
- (void)requestLatest:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    [self.manager GET:@"news/latest" parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
