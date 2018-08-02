//
//  LLMineVC.m
//  BlockShell
//
//  Created by 李顺风 on 2018/3/27.
//  Copyright © 2018年 李顺风. All rights reserved.
//

#import "LLMineVC.h"
#import "BSTableViewCell.h"
#import "BSMineHeaderView.h"
#import "BSSetUpVC.h"

#define LRHeaderHeight  280

@interface LLMineVC ()

@end

@implementation LLMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LRRGBHex(0xF5F5F5);
    self.tableView.backgroundColor = LRRGBHex(0xF5F5F5);
    
    
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"BSTableViewCell" bundle:nil] forCellReuseIdentifier:@"BSTableViewCell"];

    self.tableView.contentInset = UIEdgeInsetsMake(LRHeaderHeight, 0, 0, 0);
    BSMineHeaderView *view = [BSMineHeaderView mineHeaderView];
    view.frame = CGRectMake(0, -LRHeaderHeight, [UIScreen mainScreen].bounds.size.width, LRHeaderHeight);
    view.tag = 101;
    //头像
    [view.iconImage add_BtnClickHandler:^(NSInteger tag) {
        [MBProgressHUD showSuccess:@"头像"];
    }];
    //贝壳
    [view.shellBtn add_BtnClickHandler:^(NSInteger tag) {
        [MBProgressHUD showSuccess:@"贝壳"];
    }];
    //算力
    [view.calculationBtn add_BtnClickHandler:^(NSInteger tag) {
        [MBProgressHUD showSuccess:@"算力"];
    }];
    
    [self.tableView addSubview:view];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 76, iPhoneX ? 45 : 20, 90, 50)];
    [btn add_BtnClickHandler:^(NSInteger tag) {
        [MBProgressHUD showSuccess:@"咨询"];
    }];
    [btn setImage:[UIImage imageNamed:@"mine_icon_talk"] forState:UIControlStateNormal];
    [self.view addSubview:btn];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

//-(void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//
//}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = NO;
}




- (void)rightBarClick
{
    //    NSLog(@"右边");
    [LLLoginManager enterLoginVC];
//    LoginViewController * loginVC = [LoginViewController new];
//    [self presentViewController:loginVC animated:YES completion:nil];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 480;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    BSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BSTableViewCell"];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BSTableViewCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //我的订单
    [cell.myOrderBtn add_BtnClickHandler:^(NSInteger tag) {
        [MBProgressHUD showSuccess:@"我的订单"];
    }];
    //全部订单
    [cell.allOrderBtn add_BtnClickHandler:^(NSInteger tag) {
        [MBProgressHUD showSuccess:@"全部订单"];
    }];
    //代付款
    [cell.paymentBtn add_BtnClickHandler:^(NSInteger tag) {
        [MBProgressHUD showSuccess:@"代付款"];
    }];
    //待发货
    [cell.DeliverBtn add_BtnClickHandler:^(NSInteger tag) {
        [MBProgressHUD showSuccess:@"待发货"];
    }];
    //待收货
    [cell.collectedBtn add_BtnClickHandler:^(NSInteger tag) {
        [MBProgressHUD showSuccess:@"待收货"];
    }];
    //待评价
    [cell.evaluatesBtn add_BtnClickHandler:^(NSInteger tag) {
        [MBProgressHUD showSuccess:@"待评价"];
    }];
    //售后
    [cell.afterSaleBtn add_BtnClickHandler:^(NSInteger tag) {
        [MBProgressHUD showSuccess:@"售后"];
    }];
    //店铺管理
    [cell.shopWorkBenchBtn add_BtnClickHandler:^(NSInteger tag) {
        [MBProgressHUD showSuccess:@"店铺管理"];
    }];
    //邀请朋友
    [cell.invitingFriendsBtn add_BtnClickHandler:^(NSInteger tag) {
        [MBProgressHUD showSuccess:@"邀请朋友"];
    }];
    //加入
    [cell.joinBlockShellBtn add_BtnClickHandler:^(NSInteger tag) {
        [MBProgressHUD showSuccess:@"加入"];
    }];
    //客服
    [cell.customerServiceBtn add_BtnClickHandler:^(NSInteger tag) {
        [MBProgressHUD showSuccess:@"客服"];
    }];
    //设置
    [cell.settingBtn add_BtnClickHandler:^(NSInteger tag) {
//        [MBProgressHUD showSuccess:@"设置"];
        BSSetUpVC *vc = [BSSetUpVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    return cell;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    if (point.y < -LRHeaderHeight) {
        CGRect rect = [self.tableView viewWithTag:101].frame;
        rect.origin.y = point.y;
        rect.size.height = -point.y;
        [self.tableView viewWithTag:101].frame = rect;
    }
}


@end
