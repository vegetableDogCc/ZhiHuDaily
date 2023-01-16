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

+ (SectionModel *)place:(SectionModelStoryPlace)place obj:(NSDictionary *)responseObject {
    NSMutableArray *ary = [NSMutableArray array];
    //遍历字典中所有键为place的元素,并将各个元素赋值给story对象相对应的属性,后将对象添加到可变数组中
    for (NSDictionary *dic in responseObject[place]) {
        Stories *story = [[Stories alloc] initWithDictionary:dic];
        [ary addObject:story];
    }

    SectionModel *model = [[SectionModel alloc] init];
    //把字典中所有键为date的元素赋值给model的date
    model.date = responseObject[@"date"];
    //把创建的可变数组赋值给model的storyAry
    model.storyAry = ary;
    return model;
}

//最新新闻
+ (void)requestLatestSuccess:(void (^)(SectionModel * _Nonnull, SectionModelStoryPlace _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    
    [[HttpRequest sharedTool] getWithURLString:@"news/latest" parameters:nil success:^(id  _Nonnull responseObject) {
        
        SectionModel *bannerModel = [self place:SectionModelStoryPlaceBanner obj:responseObject];
        SectionModel *bottomModel = [self place:SectionModelStoryPlaceBottom obj:responseObject];
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
        
        SectionModel *bottomModel = [self place:SectionModelStoryPlaceBottom obj:responseObject];
        if (success) {
            success(bottomModel);
        }
        
    } failure:^(NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
