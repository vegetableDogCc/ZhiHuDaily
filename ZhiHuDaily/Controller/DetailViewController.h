//
//  DetailViewController.h
//  ZhiHuDaily
//
//  Created by coin on 2023/1/17.
//

//新闻详情页Controller
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController

@property(nonatomic) long identifier; //文章id
@property(nonatomic, copy) NSString *url; //文章URL

@end

NS_ASSUME_NONNULL_END
