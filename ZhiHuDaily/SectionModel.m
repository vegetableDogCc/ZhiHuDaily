//
//  SectionModel.m
//  ZhiHuDaily
//
//  Created by coin on 2022/12/24.
//

#import "SectionModel.h"
#import "HttpRequest.h"

@implementation SectionModel

//请求得到最新新闻并转换为模型
+ (void)requestLatest {
    [[HttpRequest sharedTool] getWithURLString:@"news/latest" parameters:nil success:^(id  _Nonnull responseObject) {
            //将id型的responseObject强转为字典
            NSDictionary *responseObj = (NSDictionary *)responseObject;
            //创建可变数组
            NSMutableArray *ary = [NSMutableArray array];
            //遍历字典中所有键为stories的元素,并将各个元素赋值给story对象相对应的属性,后将对象添加到可变数组中
            for (NSDictionary *dic in responseObj[@"stories"]) {
                Stories *story = [[Stories alloc] initWithDictionary:dic];
                [ary addObject:story];
            }
            //创建model
            SectionModel *model = [[SectionModel alloc] init];
            //把字典responseObj中所有键为date的元素赋值给model的date
            model.date = responseObj[@"date"];
            //把创建的可变数组赋值给model的storyAry
            model.storyAry = ary;
            //让responseObject等于model
            responseObject = model;
            NSLog(@"%@",model);
        } failure:^(NSError * _Nonnull error) {
        }];
}

@end
