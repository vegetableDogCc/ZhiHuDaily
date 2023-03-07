//
//  SectionModel.h
//  ZhiHuDaily
//
//  Created by coin on 2022/12/24.
//

//进行网络请求
#import <Foundation/Foundation.h>

#import "BannerStories.h"
#import "Stories.h"
#import "StoriesContent.h"
#import "InteractionNumber.h"

NS_ASSUME_NONNULL_BEGIN

typedef NSString *SectionModelStoryPlace NS_STRING_ENUM;

///新闻在banner内展示
FOUNDATION_EXPORT SectionModelStoryPlace const SectionModelStoryPlaceBanner;
///新闻的位置在banner以下
FOUNDATION_EXPORT SectionModelStoryPlace const SectionModelStoryPlaceBottom;

@interface SectionModel : NSObject

//请求到的banner新闻的数据
@property(nonatomic, strong) NSArray <BannerStories *> *bannerAry;
//新闻日期
@property(nonatomic, copy) NSString *date;
//列表新闻除日期以外的其他数据
@property(nonatomic, strong) NSArray <Stories *> *storyAry;
//请求到的新闻内容的数据
@property(nonatomic, strong) NSArray <StoriesContent *> *storyContentAry;
//请求到的文章互动情况的数据
@property(nonatomic, strong) NSArray <InteractionNumber *> *interactionAry;

+ (void)requestLatestSuccess:(void (^)(SectionModel *model, SectionModelStoryPlace storyPlace))success
                     failure:(void (^)(NSError *error))failure;

+ (void)requestWithDate:(NSString *)str
                success:(void (^)(SectionModel *model))success
                failure:(void (^)(NSError *error))failure;

+ (void)requeatWithId:(long)identifier
              success:(void (^)(SectionModel *model))success
              failure:(void (^)(NSError *error))failure;

+ (void)requestInteractionWithId:(long)identifier
                       success:(void (^)(SectionModel *model))success
                       failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
