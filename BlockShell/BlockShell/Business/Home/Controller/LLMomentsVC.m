//
//  LLMomentsVC.m
//  BlockShell
//
//  Created by 李顺风 on 2018/3/27.
//  Copyright © 2018年 李顺风. All rights reserved.
//

#import "LLMomentsVC.h"
#import <Social/Social.h>

#import "LLHomeTabCell.h"
#import "LLHomePageCell.h"
#import "HomeHeaderCell.h"
#import "BSVoucherCenterVC.h"
#import "BSPaymentSuccessVC.h"
@interface LLMomentsVC ()

@end

@implementation LLMomentsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LRRandomColor;
    self.navigationItem.leftBarButtonItem = nil;
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
//                                             initWithImage:[UIImage imageNamed:@"微信"]
//                                             style:UIBarButtonItemStylePlain
//                                             target:self
//                                             action:@selector(leftBarClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithImage:[UIImage imageNamed:@"mine_icon_talk"]
                                             style:UIBarButtonItemStylePlain
                                             target:self
                                             action:@selector(rightBarClick)];
    
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"LLHomeTabCell" bundle:nil] forCellReuseIdentifier:@"LLHomeTabCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LLHomePageCell" bundle:nil] forCellReuseIdentifier:@"LLHomePageCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeHeaderCell" bundle:nil] forCellReuseIdentifier:@"HomeHeaderCell"];


}


- (void)rightBarClick
{
//    NSLog(@"右边");
//    [UCLoginManager enterLoginView];
    LoginViewController * loginVC = [LoginViewController new];
    [self presentViewController:loginVC animated:YES completion:nil];
    
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 1;
    } else {
        return 7;
    }
    

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return SCREEN_WIDTH /3;
    } else if (indexPath.section == 1) {
        return 100 *Scale_X;
    } else {
        return 160;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        HomeHeaderCell*cell = [tableView dequeueReusableCellWithIdentifier:@"HomeHeaderCell"];
        if (cell == nil) {
            //通过xib的名称加载自定义的cell
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeHeaderCell" owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    } else if (indexPath.section == 1) {
        LLHomeTabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLHomeTabCell"];
        if (cell == nil) {
            //通过xib的名称加载自定义的cell
            cell = [[[NSBundle mainBundle] loadNibNamed:@"LLHomeTabCell" owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.btn1 add_BtnClickHandler:^(NSInteger tag) {
            BSVoucherCenterVC* vc = [BSVoucherCenterVC new];
            vc.isFlowVoucher = NO;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        [cell.btn2 add_BtnClickHandler:^(NSInteger tag) {
            BSVoucherCenterVC* vc = [BSVoucherCenterVC new];
            vc.isFlowVoucher = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }];
        [cell.btn3 add_BtnClickHandler:^(NSInteger tag) {
            BSPaymentSuccessVC* vc = [BSPaymentSuccessVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        [cell.btn4 add_BtnClickHandler:^(NSInteger tag) {
            [LLLoginManager enterLoginVC];
        }];
        return cell;
    } else {
        LLHomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LLHomePageCell"];
        if (cell == nil) {
            //通过xib的名称加载自定义的cell
            cell = [[[NSBundle mainBundle] loadNibNamed:@"LLHomePageCell" owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
   
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"右边%@",indexPath);
    if (indexPath.section > 1) {
        
    }

    
}





@end
