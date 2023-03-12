//将网络请求封装为单例类
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HttpRequest : NSObject

+ (instancetype)sharedTool;

- (void)getWithURLString:(NSString *)urlString
              parameters:(id __nullable)parameters
                 success:(void (^)(id responseObject))success
                 failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
