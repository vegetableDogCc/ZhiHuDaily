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

@end
