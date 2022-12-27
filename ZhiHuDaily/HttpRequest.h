//
//  HttpRequest.h
//  ZhiHuDaily
//
//  Created by coin on 2022/12/26.
//

//将网络请求封装为单例类
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HttpRequest : NSObject

+ (instancetype)sharedTool;

@end

NS_ASSUME_NONNULL_END
