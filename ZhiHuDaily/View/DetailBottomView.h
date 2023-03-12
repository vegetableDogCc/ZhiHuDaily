//新闻详情页底部视图
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailBottomView : UIView

@property(nonatomic) long CommentCount; //评论数
@property(nonatomic) long likesCount; //点赞数
@property(nonatomic, strong) UIButton *returnButton; //返回主页按钮

@end

NS_ASSUME_NONNULL_END
