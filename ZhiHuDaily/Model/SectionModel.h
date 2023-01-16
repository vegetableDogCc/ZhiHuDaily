//
//  SectionModel.h
//  ZhiHuDaily
//
//  Created by coin on 2022/12/24.
//

//进行网络请求
#import <Foundation/Foundation.h>
#import "Stories.h"

NS_ASSUME_NONNULL_BEGIN

typedef NSString *SectionModelStoryPlace NS_STRING_ENUM;

///新闻在banner内展示
FOUNDATION_EXPORT SectionModelStoryPlace const SectionModelStoryPlaceBanner;
///新闻的位置在banner以下
FOUNDATION_EXPORT SectionModelStoryPlace const SectionModelStoryPlaceBottom;

@interface SectionModel : NSObject

//请求到的日期数据
@property(nonatomic, copy) NSString *date;
//除日期以外的其他数据
@property(nonatomic, strong) NSArray <Stories *> *storyAry;

+ (void)requestLatestSuccess:(void (^)(SectionModel *model, SectionModelStoryPlace storyPlace))success
                     failure:(void (^)(NSError *error))failure;

+ (void)requestWithDate:(NSString *)str
                success:(void (^)(SectionModel *model))success
                failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
