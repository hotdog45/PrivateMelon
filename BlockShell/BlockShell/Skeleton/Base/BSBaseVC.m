//
//  LLBaseViewController.m
//  PrivateMelon
//
//  Created by 李顺风 on 2018/3/26.
//  Copyright © 2018年 李顺风. All rights reserved.
//

#import "BSBaseVC.h"

@interface BSBaseVC ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation BSBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
//
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blackColor],NSFontAttributeName : [UIFont systemFontOfSize:22]};
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back_black"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackAction)];
    
    // tableview 遮挡问题
    if (([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//    if (self.childViewControllers.count < 1) {
//        self.navigationItem.leftBarButtonItem = nil;
//    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
}


- (void)goBackAction{
    // 在这里增加返回按钮的自定义动作
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark ----,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UITableViewCell new];
}
#pragma makr ------UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(UITableView*)tableView
{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
//        _tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.view.mj_h- (iPhoneX ? 83: 50));
        _tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT );
//        if (self.childViewControllers.count > 0) {
//            _tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT - (iPhoneX ? 83: 50) - (iPhoneX ? 84: 64));
//        }
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1];
        //ios11
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.sectionHeaderHeight = 0;
        _tableView.sectionFooterHeight = 0;
    }
    return _tableView;
}

@end
