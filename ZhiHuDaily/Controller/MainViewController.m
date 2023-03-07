//
//  ViewController.m
//  ZhiHuDaily
//
//  Created by coin on 2022/12/24.
//

#import "MainViewController.h"

#import "DetailViewController.h"
#import "UserViewController.h"

#import <Masonry.h>

#import "SectionModel.h"

#import "MainTopView.h"
#import "MainBannerCollectionViewCell.h"
#import "MainBottomTableViewCell.h"
#import "MainBottomTableViewHeaderView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface MainViewController () <
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UITableViewDataSource,
    UITableViewDelegate
>

@property(nonatomic, strong) MainTopView *topView;
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) UIPageControl *pageControl;
@property(nonatomic, strong) UITableView *tableView;


//请求到的model中的date
@property(nonatomic, copy) NSString *latestDate;
//存放每个latestDate
@property(nonatomic, strong) NSMutableArray <NSString *> *timeArray;
//存放banner视图数据
@property(nonatomic, strong) NSArray <BannerStories *> *topDataArray;
//存放tableView视图数据
@property(nonatomic, strong) NSMutableArray <Stories *> *dataArray;

@end

@implementation MainViewController

#pragma mark - Life Cycle

//视图加载后
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.topView];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.pageControl];
    
    [self request];
}

#pragma mark - <UICollectionViewDataSource>

//item数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}
//设置cell
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MainBannerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MainBannerCollectionViewCellReuseIdentifier forIndexPath:indexPath];
    //赋值
    cell.title = self.topDataArray[indexPath.item].title;
    cell.author = self.topDataArray[indexPath.item].hint;
    NSURL *url = [NSURL URLWithString:self.topDataArray[indexPath.item].imageUrl];
    cell.imgData = [NSData dataWithContentsOfURL:url];
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

//点击item进入详情页
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    detailVC.url = self.topDataArray[indexPath.item].url;
    detailVC.identifier = self.topDataArray[indexPath.item].identifier;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.frame.size;
}

#pragma mark - <UITableViewDataSource>

//section数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count / 6;
}
//row数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}
//设置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainBottomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MainBottomTableViewCellReuseIdentifier forIndexPath:indexPath];
    //赋值
    cell.title = self.dataArray[indexPath.row + indexPath.section * 6].title;
    cell.author = self.dataArray[indexPath.row + indexPath.section * 6].hint;
    NSURL *url = [NSURL URLWithString:self.dataArray[indexPath.row + indexPath.section * 6].imageUrl];
    cell.imgData = [NSData dataWithContentsOfURL:url];

    return cell;
}

#pragma mark - <UITableViewDelegate>

//header高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    else {
        return 24;
    }
}
//row高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
//footer高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
//设置header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MainBottomTableViewHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:MainBottomTableViewCellReuseIdentifier];
    if (headerView == nil) {
        headerView = [[MainBottomTableViewHeaderView alloc] initWithReuseIdentifier:MainBottomTableViewCellReuseIdentifier];
    }
    headerView.date = self.timeArray[section - 1];
    
    return headerView;
}
//将要展示cell时
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    //判断是否为最后一个cell
    if((indexPath.row + 1) * (indexPath.section + 1) == self.dataArray.count) {
        [SectionModel requestWithDate:self.latestDate success:^(SectionModel * _Nonnull model) {
            //更新latestDate
            self.latestDate = model.date;
            //添加数据并刷新
            [self.dataArray addObjectsFromArray:model.storyAry];
            [self.tableView reloadData];
            
            //转换日期格式为x月x日，以准备赋值给section间的dateLab
            //把NSString转化为NSDate
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMdd";
            NSDate *Mdate = [formatter dateFromString:self.latestDate];
            //把NSDate转化为要求格式的NSString
            formatter.dateFormat = @"M月d日";
            NSString *str = [formatter stringFromDate:Mdate];
            //将得到的NSString添加到数组中
            if (self.timeArray == nil) {
                self.timeArray = [NSMutableArray array];
            }
            [self.timeArray addObject:str];
            
        } failure:^(NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
    }
}
//点击row进入详情页
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    detailVC.url = self.dataArray[indexPath.row + indexPath.section * 6].url;
    detailVC.identifier = self.dataArray[indexPath.row + indexPath.section * 6].identifier;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //计算collectionView当前页数
    int pageNum = (int)(self.collectionView.contentOffset.x / SCREEN_WIDTH + 0.5);
    self.pageControl.currentPage = pageNum;
}

#pragma mark - Method

//进入用户页
- (void)clickUserButton {
    UserViewController *userVC = [[UserViewController alloc] init];
    [self.navigationController pushViewController:userVC animated:YES];
}
//网络请求最新新闻
- (void)request {
    [SectionModel requestLatestSuccess:^(SectionModel * _Nonnull model, SectionModelStoryPlace  _Nonnull storyPlace) {
        //判断请求到的是否是顶部视图数据
        if (storyPlace == SectionModelStoryPlaceBanner) {
            self.topDataArray = [[NSArray alloc] initWithArray:model.bannerAry];
            [self.collectionView reloadData];
            //得到最新的日期
            self.latestDate = model.date;
        }
        //判断请求到的是否是tableView视图数据
        else if (storyPlace == SectionModelStoryPlaceBottom) {
            self.dataArray = [[NSMutableArray alloc] initWithArray:model.storyAry];
            [self.tableView reloadData];
        }
        
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - Lazy

- (MainTopView *)topView {
    if (_topView == nil) {
        _topView = [[MainTopView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [self.view addSubview:_topView];
        [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.height.mas_equalTo(52);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
        }];
        //点击头像
        [_topView.userButton addTarget:self action:@selector(clickUserButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _topView;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH) collectionViewLayout:layout];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [_collectionView registerClass:MainBannerCollectionViewCell.class forCellWithReuseIdentifier:MainBannerCollectionViewCellReuseIdentifier];
    }
    return _collectionView;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
        
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_topView.mas_bottom);
            make.height.mas_equalTo(SCREEN_HEIGHT-70);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
        }];
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableHeaderView = self.collectionView;
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;

        [_tableView registerClass:MainBottomTableViewCell.class forCellReuseIdentifier:MainBottomTableViewCellReuseIdentifier];
        [_tableView registerClass:MainBottomTableViewHeaderView.class forHeaderFooterViewReuseIdentifier:MainBottomTableViewHeaderViewReuseIdentifier];
    }
    return _tableView;
}

- (UIPageControl *)pageControl {
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];

        [self.view addSubview:_pageControl];
        [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.collectionView.mas_bottom).offset(-5);
            make.right.equalTo(self.collectionView.mas_right).offset(20);
        }];

        _pageControl.numberOfPages = 5;
        _pageControl.backgroundColor = [UIColor clearColor];
    }
    return _pageControl;
}

@end
