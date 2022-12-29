//
//  ViewController.m
//  ZhiHuDaily
//
//  Created by coin on 2022/12/24.
//

#import "MainViewController.h"
#import <Masonry.h>
#import "UIView+Frame.h"
#import "HttpRequest.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT UIScreen mainScreen].bounds.size.height

@interface ViewController ()

//日期文本框
@property(nonatomic, strong) UILabel *dateLab;

//月份文本框
@property(nonatomic, strong) UILabel *monthLab;

//竖直分割线
@property(nonatomic, strong) UIView *verticalLine;

//欢迎文本框
@property(nonatomic, strong) UILabel *welcomeLab;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.dateLab];
    [self.view addSubview:self.monthLab];
    [self.view addSubview:self.verticalLine];
    [self.view addSubview:self.welcomeLab];
    
    [self testdata];
}

#pragma mark - Getter

//设置日期文本框
- (UILabel *)dateLab {
    if (_dateLab == nil) {
        //获取当前时间点
        NSDate *dateNow = [NSDate date];
        //把NSDate按formatter格式转成NSString
        NSDateFormatter *formatterDate = [[NSDateFormatter alloc] init];
        formatterDate.dateFormat = @"d";
        
        // d or dd? 单数日时看一看
        
        NSString *strDate = [formatterDate stringFromDate:dateNow];
        _dateLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 45, 45, 20)];
        _dateLab.font = [UIFont boldSystemFontOfSize:18];
        _dateLab.text = strDate;
       
        //_dateLab.backgroundColor = [UIColor yellowColor];
    }
  return _dateLab;
}

//设置月份文本框
- (UILabel *)monthLab {
    if (_monthLab == nil) {
        //获取当前时间点
        NSDate *dateNow = [NSDate date];
        //把NSDate按formatter格式转成NSString
        NSDateFormatter *formatterMonth = [[NSDateFormatter alloc] init];
        formatterMonth.dateFormat = @"M月";
        NSString *strMonth = [formatterMonth stringFromDate:dateNow];
        _monthLab = [[UILabel alloc] initWithFrame:CGRectMake(_dateLab.left, _dateLab.bottom, _dateLab.width, _dateLab.height)];
        _monthLab.font = [UIFont boldSystemFontOfSize:11];
        _monthLab.text = strMonth;
        
        //_monthLab.backgroundColor = [UIColor greenColor];
    }
  return _monthLab;
}

//设置竖直分割线
- (UIView *)verticalLine {
    if (_verticalLine == nil) {
        _verticalLine = [[UIView alloc] initWithFrame:CGRectMake(_dateLab.right, _dateLab.top, 1, _dateLab.height + _monthLab.height)];
        _verticalLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _verticalLine;
}

//设置欢迎文本框
- (UILabel *)welcomeLab {
    if (_welcomeLab == nil) {
        _welcomeLab = [[UILabel alloc] initWithFrame:CGRectMake(_verticalLine.right + 15, _verticalLine.top, 200, _verticalLine.height)];
        _welcomeLab.font = [UIFont boldSystemFontOfSize:25];
        //一天中的不同时段显示不同的欢迎文本
        NSDate *dateNow = [NSDate date];
        NSDateFormatter *formattetTime = [[NSDateFormatter alloc] init];
        formattetTime.dateFormat = @"H";
        NSString *strTime = [formattetTime stringFromDate:dateNow];
        int time = [strTime intValue];
        
        // 具体时间点尚不确定

        if (time >= 6 && time < 9) {
            _welcomeLab.text = @"早上好!";
        }
        else if (time >= 18 && time < 23) {
            _welcomeLab.text = @"晚上好!";
        }
        else if (time >= 23 || time <= 6) {
            _welcomeLab.text = @"早点休息";
        }
        else {
            _welcomeLab.text = @"知乎日报";
        }
        
        //_welcomeLab.backgroundColor = [UIColor systemPinkColor];
    }
  return _welcomeLab;
}

- (void)testdata {
    [[HttpRequest sharedTool] requestLatest:^(id  _Nonnull responseObject) {
        NSLog(@"请求成功");
        } failure:^(NSError * _Nonnull error) {
            NSLog(@"请求失败");
        }];
}

@end
