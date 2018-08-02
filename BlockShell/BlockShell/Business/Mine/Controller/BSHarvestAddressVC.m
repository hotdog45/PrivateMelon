//
//  BSHarvestAddressVC.m
//  BlockShell
//
//  Created by 李顺风 on 2018/7/2.
//  Copyright © 2018年 qiaofeng. All rights reserved.
//

#import "BSHarvestAddressVC.h"
#import "BSAddressCell.h"

@interface BSHarvestAddressVC ()

@end

@implementation BSHarvestAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = LRRGBHex(0xF7F8FB);
    self.title = @"Harvest Address";
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"BSAddressCell" bundle:nil] forCellReuseIdentifier:@"BSAddressCell"];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BSAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BSAddressCell"];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BSAddressCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //    //我的订单
    //    [cell.myOrderBtn add_BtnClickHandler:^(NSInteger tag) {
    //        [MBProgressHUD showSuccess:@"我的订单"];
    //    }];
    //
    return cell;
    
}

@end
