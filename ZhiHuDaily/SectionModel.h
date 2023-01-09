//
//  SectionModel.h
//  ZhiHuDaily
//
//  Created by coin on 2022/12/24.
//

//将网络请求的结果转为模型
#import <Foundation/Foundation.h>
#import "Stories.h"

NS_ASSUME_NONNULL_BEGIN

typedef NSString *SectionModelStoryPlace NS_STRING_ENUM;

///新闻在banner内展示
FOUNDATION_EXPORT SectionModelStoryPlace const SectionModelStoryPlaceBanner;
///新闻的位置在banner以下
FOUNDATION_EXPORT SectionModelStoryPlace const SectionModelStoryPlaceBottom;

@interface SectionModel : NSObject

@property(nonatomic, copy) NSString *date;

//创建返回Stories对象的属性
@property(nonatomic, strong) NSArray <Stories *> *storyAry;

+ (void)requestLatestSuccess:(void (^)(SectionModel *model, SectionModelStoryPlace storyPlace))success
                     failure:(void (^)(NSError *error))failure;

+ (void)requestWithDate:(NSString *)str
                success:(void (^)(SectionModel *model))success
                failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
