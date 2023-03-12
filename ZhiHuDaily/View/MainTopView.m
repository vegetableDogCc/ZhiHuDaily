#import "MainTopView.h"

#import "UIView+Frame.h"

@interface MainTopView ()

@property(nonatomic, strong) UILabel *dateLab; //日期文本框
@property(nonatomic, strong) UILabel *monthLab; //月份文本
@property(nonatomic, strong) UIView *verticalLine; //竖直分割线
@property(nonatomic, strong) UILabel *welcomeLab; //欢迎文本框

@end

@implementation MainTopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.dateLab];
        [self addSubview:self.monthLab];
        [self addSubview:self.verticalLine];
        [self addSubview:self.welcomeLab];
        [self addSubview:self.userButton];
    }
    return self;
}

#pragma mark - Lazy

- (UILabel *)dateLab {
    if (_dateLab == nil) {
        //获取当前时间点
        NSDate *dateNow = [NSDate date];
        //把NSDate转成特定格式的NSString
        NSDateFormatter *formatterDate = [[NSDateFormatter alloc] init];
        formatterDate.dateFormat = @"d";
        NSString *dateStr = [formatterDate stringFromDate:dateNow];
        _dateLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, 63, 18)];
        _dateLab.font = [UIFont boldSystemFontOfSize:19];
        _dateLab.text = dateStr;
        _dateLab.textAlignment = NSTextAlignmentCenter;
    }
  return _dateLab;
}

- (UILabel *)monthLab {
    if (_monthLab == nil) {
        //获取当前时间点
        NSDate *dateNow = [NSDate date];
        //把NSDate转成特定格式的NSString
        NSDateFormatter *formatterMonth = [[NSDateFormatter alloc] init];
        formatterMonth.dateFormat = @"M月";
        NSString *monthStr = [formatterMonth stringFromDate:dateNow];
        _monthLab = [[UILabel alloc] initWithFrame:CGRectMake(_dateLab.left, _dateLab.bottom, _dateLab.width, _dateLab.height)];
        _monthLab.font = [UIFont systemFontOfSize:11];
        //将单数月的阿拉伯数字转为中文数字
        if (![monthStr isEqual: @"10月"] && ![monthStr isEqual: @"11月"] && ![monthStr isEqual: @"12月"]) {
            NSArray *arabicNum = @[@"1月",@"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月"];
            NSArray *chineseNum = @[@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月"];
            NSDictionary *dic = [NSDictionary dictionaryWithObjects:chineseNum forKeys:arabicNum];
            monthStr = [dic objectForKey:monthStr];
        }
        _monthLab.text = monthStr;
        _monthLab.textAlignment = NSTextAlignmentCenter;
    }
  return _monthLab;
}

- (UIView *)verticalLine {
    if (_verticalLine == nil) {
        _verticalLine = [[UIView alloc] initWithFrame:CGRectMake(_dateLab.right, _dateLab.top, 1, _dateLab.height + _monthLab.height)];
        _verticalLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _verticalLine;
}

- (UILabel *)welcomeLab {
    if (_welcomeLab == nil) {
        _welcomeLab = [[UILabel alloc] initWithFrame:CGRectMake(_verticalLine.right + 11, _verticalLine.top, 200, _verticalLine.height)];
        _welcomeLab.font = [UIFont boldSystemFontOfSize:23];
        //一天中的不同时段显示不同的欢迎文本
        NSDate *dateNow = [NSDate date];
        NSDateFormatter *formattetTime = [[NSDateFormatter alloc] init];
        formattetTime.dateFormat = @"H";
        NSString *strTime = [formattetTime stringFromDate:dateNow];
        int time = [strTime intValue];
        if (time >= 6 && time < 9) {
            _welcomeLab.text = @"早上好!";
        }
        else if (time >= 18 && time < 23) {
            _welcomeLab.text = @"晚上好!";
        }
        else if (time >= 23 || time <= 2) {
            _welcomeLab.text = @"早点休息";
        }
        else {
            _welcomeLab.text = @"知乎日报";
        }
    }
  return _welcomeLab;
}

- (UIButton *)userButton {
    if (_userButton == nil) {
        _userButton = [[UIButton alloc] initWithFrame:CGRectMake(self.welcomeLab.right + 70, 10, 30, 30)];
        [_userButton setBackgroundImage:[UIImage imageNamed:@"头像"] forState:UIControlStateNormal];
        _userButton.layer.cornerRadius = _userButton.width / 2;
        _userButton.layer.masksToBounds = YES;
        _userButton.adjustsImageWhenHighlighted = NO;
    }
    return _userButton;
}

@end
