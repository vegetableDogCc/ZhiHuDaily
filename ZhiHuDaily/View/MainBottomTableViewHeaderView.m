#import "MainBottomTableViewHeaderView.h"

#import <Masonry.h>

NSString *MainBottomTableViewHeaderViewReuseIdentifier = @"MainBottomTableViewHeaderView";

@interface MainBottomTableViewHeaderView ()

@property(nonatomic, strong) UILabel *dateLab; //日期文本框
@property(nonatomic, strong) UIView *horizontalLine; //水平分割线

@end

@implementation MainBottomTableViewHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.dateLab];
        [self.contentView addSubview:self.horizontalLine];
    }
    return self;
}

- (void)updateConfigurationUsingState:(UIViewConfigurationState *)state {
    self.dateLab.frame = CGRectMake(0, 0, 0, 0);
    [self.contentView addSubview:self.dateLab];
    [self.dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(2.5);
    }];
    
    self.horizontalLine.frame = CGRectMake(0, 0, 0, 0);
    [self.contentView addSubview:self.horizontalLine];
    [self.horizontalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.height.mas_equalTo(0.5);
        make.left.equalTo(self.dateLab.mas_right).offset(5);
        make.right.mas_equalTo([UIScreen mainScreen].bounds.origin.x + [UIScreen mainScreen].bounds.size.width);
    }];
}

#pragma mark - Lazy

- (UILabel *)dateLab {
    if (_dateLab == nil) {
        _dateLab = [[UILabel alloc] init];
        _dateLab.font = [UIFont systemFontOfSize:14];
        _dateLab.textColor = [UIColor grayColor];
    }
    return _dateLab;
}

- (UIView *)horizontalLine {
    if (_horizontalLine == nil) {
        _horizontalLine = [[UIView alloc] init];
        _horizontalLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _horizontalLine;
}

#pragma mark - Setter

- (void)setDate:(NSString *)date {
    self.dateLab.text = date.copy;
}

#pragma mark - Getter

- (NSString *)date {
    return self.dateLab.text.copy;
}

@end
