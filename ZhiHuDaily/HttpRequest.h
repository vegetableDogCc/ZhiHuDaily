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

//声明一个名为requestLatest的方法，有两个分别叫success和error的block参数
- (void)requestLatest:(void (^)(id responseObject))success
              failure:(void (^)(NSError *error))failure;


@end

NS_ASSUME_NONNULL_END
