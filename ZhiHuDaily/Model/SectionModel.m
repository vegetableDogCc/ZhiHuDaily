//
//  SectionModel.m
//  ZhiHuDaily
//
//  Created by coin on 2022/12/24.
//

#import "SectionModel.h"

#import "HttpRequest.h"

SectionModelStoryPlace const SectionModelStoryPlaceBanner = @"top_stories";
SectionModelStoryPlace const SectionModelStoryPlaceBottom = @"stories";

@implementation SectionModel

//最新新闻
+ (void)requestLatestSuccess:(void (^)(SectionModel * _Nonnull, SectionModelStoryPlace _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    
    [[HttpRequest sharedTool] getWithURLString:@"news/latest" parameters:nil success:^(id  _Nonnull responseObject) {
        
        NSMutableArray *ary1 = [NSMutableArray array];
        for (NSDictionary *dic in responseObject[SectionModelStoryPlaceBanner]) {
            BannerStories *bannerStory = [[BannerStories alloc] initWithDictionary:dic];
            [ary1 addObject:bannerStory];
        }
        
        NSMutableArray *ary2 = [NSMutableArray array];
        for (NSDictionary *dic in responseObject[SectionModelStoryPlaceBottom]) {
            Stories *story = [[Stories alloc] initWithDictionary:dic];
            [ary2 addObject:story];
        }
        
        SectionModel *bannerModel = [[SectionModel alloc] init];
        SectionModel *bottomModel = [[SectionModel alloc] init];

        bannerModel.date = responseObject[@"date"];
        bannerModel.bannerAry = ary1;
        bottomModel.storyAry = ary2;
        
        if (success) {
            success(bannerModel, SectionModelStoryPlaceBanner);
            success(bottomModel, SectionModelStoryPlaceBottom);
        }
        
    } failure:^(NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

//过往新闻
+ (void)requestWithDate:(NSString *)str success:(void (^)(SectionModel * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    
    NSString *string = [NSString stringWithFormat:@"stories/before/%@", str];
    [[HttpRequest sharedTool] getWithURLString:string parameters:nil success:^(id  _Nonnull responseObject) {
        
        NSMutableArray *ary = [NSMutableArray array];
        for (NSDictionary *dic in responseObject[SectionModelStoryPlaceBottom]) {
            Stories *story = [[Stories alloc] initWithDictionary:dic];
            [ary addObject:story];
        }
        
        SectionModel *bottomModel = [[SectionModel alloc] init];
        bottomModel.date = responseObject[@"date"];
        bottomModel.storyAry = ary;

        if (success) {
            success(bottomModel);
        }
        
    } failure:^(NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

//新闻内容
+ (void)requeatWithId:(long)identifier success:(void (^)(SectionModel * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    
    NSString *string = [NSString stringWithFormat:@"news/%ld", identifier];
    [[HttpRequest sharedTool] getWithURLString:string parameters:nil success:^(id  _Nonnull responseObject) {
        
        NSMutableArray *ary = [NSMutableArray array];
        StoriesContent *storyContent = [[StoriesContent alloc] initWithDictionary:responseObject];
        [ary addObject:storyContent];

        SectionModel *ContentModel = [[SectionModel alloc] init];
        ContentModel.storyContentAry = ary;
        
        if (success) {
            success(ContentModel);
        }
        
    } failure:^(NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

//互动情况
+ (void)requestInteractionWithId:(long)identifier success:(void (^)(SectionModel * _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    
    NSString *string = [NSString stringWithFormat:@"story-extra/%ld", identifier];
    [[HttpRequest sharedTool] getWithURLString:string parameters:nil success:^(id  _Nonnull responseObject) {
        
        NSMutableArray *ary = [NSMutableArray array];
        InteractionNumber *interactionNumber = [[InteractionNumber alloc] initWithDictionary:responseObject];
        [ary addObject:interactionNumber];
        
        SectionModel *interactionModel = [[SectionModel alloc] init];
        interactionModel.interactionAry = ary;
        
        if (success) {
            success(interactionModel);
        }
        
    } failure:^(NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
