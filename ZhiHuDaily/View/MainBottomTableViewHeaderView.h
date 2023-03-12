//主页新闻列表间的每天日期视图
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

///复用标志
UIKIT_EXTERN NSString *MainBottomTableViewHeaderViewReuseIdentifier;

@interface MainBottomTableViewHeaderView : UITableViewHeaderFooterView

@property(nonatomic, copy) NSString *date; //每天日期字符串

@end

NS_ASSUME_NONNULL_END
