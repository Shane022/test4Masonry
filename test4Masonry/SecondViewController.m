//
//  SecondViewController.m
//  test4Masonry
//
//  Created by new on 15-10-29.
//  Copyright (c) 2015年 new. All rights reserved.
//
//参照：http://www.wugaojun.com/blog/2015/05/24/autolayoutshi-zhan-cellgao-du-bu-gu-ding-de-uitableview/


#import "SecondViewController.h"
#import "CustomTableViewCell.h"
#import "Masonry.h"

static NSString * const tableViewCellIdentifier = @"identifier";

@interface SecondViewController ()

@end

@implementation SecondViewController
{
    NSArray *datas;
    UITableView *tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self setupTableView];
}

- (void)setupData {
    NSDictionary *dic1 = @{@"title":@"djiwoa",@"subtitle":@"how to use masonry"};
    NSDictionary *dic2 = @{@"title":@"dj",@"subtitle":@""};
    NSDictionary *dic3 = @{@"title":@"djiwoadwaaa",@"subtitle":@"how to use masonrydwaaaawdawdaadadahiiiiiiiiiiiiiiiiiiiiiiiiiiiiuyuggyugyugyuguggbhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh"};
    datas = @[dic1,dic2,dic3];
}

- (void)setupTableView {
    UITableView *testTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView = testTableView;
    testTableView.delegate = self;
    testTableView.dataSource = self;
    [testTableView registerClass:[CustomTableViewCell class] forCellReuseIdentifier:tableViewCellIdentifier];
    [self.view addSubview:testTableView];
    
    [testTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UIView *footerView = [[UIView alloc] init];
    testTableView.tableFooterView = footerView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellIdentifier];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(CustomTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row % 3;
    NSDictionary *data = datas[row];
    
    [cell.titleLabel setText:data[@"title"]];
    [cell.subtitleLabel setText:data[@"subtitle"]];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self heightForCellAtIndexPath:indexPath];
}
/*
 heightForCellAtIndexPath:拿出一个cell用于计算，使用dispatch_once保证只执行一次，方法configureCell:atIndexPath:在数据源那块已经实现了，直接调用即可。
 */
- (CGFloat)heightForCellAtIndexPath:(NSIndexPath *)indexPath {
    static CustomTableViewCell *cell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellIdentifier];
    });
    [self configureCell:cell atIndexPath:indexPath];
    return [self calculateHeightForCell:cell];
}
/*
 调用calculateHeightForCell:计算cell的高度，先调用setNeedsLayout和layoutIfNeeded让cell去布局子视图，然后调用systemLayoutSizeFittingSize:让AutoLayout系统去计算大小, 参数UILayoutFittingCompressedSize的意思是告诉AutoLayout系统使用尽可能小的尺寸以满足约束，返回的结果里+1.0f是分割线的高度。
 */
- (CGFloat)calculateHeightForCell:(CustomTableViewCell *)cell {
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1.0f;
}
/*
实现该方法后，tableview就不会一次性调用完所有cell的高度，有些不在可见范围的cell是不需要一开始就知道高度的。当然，estimatedHeightForRowAtIndexPath方法调用频率就会非常高，所以我们尽量返回一个比较接近实际结果的固定值以提高性能.
*/
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 112.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
