//
//  BSSetUpVC.m
//  BlockShell
//
//  Created by 李顺风 on 2018/6/28.
//  Copyright © 2018年 qiaofeng. All rights reserved.
//

#import "BSSetUpVC.h"
#import "BSSetUpCell.h"
#import "BSNickNameVC.h"
#import "BSHarvestAddressVC.h"

@interface BSSetUpVC ()

@end

@implementation BSSetUpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = ;
    self.tableView.backgroundColor = LRRGBHex(0xF7F8FB);
    self.title = @"Set up";
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"BSSetUpCell" bundle:nil] forCellReuseIdentifier:@"BSSetUpCell"];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 510;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BSSetUpCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BSSetUpCell"];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BSSetUpCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //我的地址
    [cell.addressBtn add_BtnClickHandler:^(NSInteger tag) {
        BSHarvestAddressVC *vc = [BSHarvestAddressVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    //我的昵称
    [cell.nickNameBtn add_BtnClickHandler:^(NSInteger tag) {
        BSNickNameVC *vc = [BSNickNameVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }];

    return cell;
    
}


@end
