//
//  SectionModel.m
//  ZhiHuDaily
//
//  Created by coin on 2022/12/24.
//

#import "SectionModel.h"
#import "HttpRequest.h"

@implementation SectionModel

+ (void)requestLatest {
    [[HttpRequest sharedTool] getWithURLString:@"news/latest" success:^(id _Nonnull responseObject) {
        //将id型的responseObject强转为字典
        NSDictionary *obj = (NSDictionary *)responseObject;
        //创建可变数组
        NSMutableArray *ary = [NSMutableArray array];
        for (NSDictionary *dic in obj[@"stories"]) {
            Stories *story = [[Stories alloc] initWithDictionary:dic];
            [ary addObject:story];
        }
        //创建model
        SectionModel *model = [[SectionModel alloc] init];
        model.date = obj[@"date"];
        model.storyAry = ary;
        responseObject = model;
        NSLog(@"%@",model);
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

@end
