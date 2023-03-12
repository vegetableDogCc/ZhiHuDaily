//主页新闻列表视图
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

///复用标志
UIKIT_EXTERN NSString *MainBottomTableViewCellReuseIdentifier;

@interface MainBottomTableViewCell : UITableViewCell

@property(nonatomic, copy) NSData *imgData; //图片data
@property(nonatomic, copy) NSString *title; //文章标题字符串
@property(nonatomic, copy) NSString *author; //作者字符串

@end

NS_ASSUME_NONNULL_END
