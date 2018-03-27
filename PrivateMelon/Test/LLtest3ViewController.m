//
//  LLtest3ViewController.m
//  PrivateMelon
//
//  Created by 李顺风 on 2018/3/26.
//  Copyright © 2018年 李顺风. All rights reserved.
//

#import "LLtest3ViewController.h"

@interface LLtest3ViewController ()

@end

@implementation LLtest3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"测试号";
    
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 12;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    //    if (cell == nil) {
    //        //通过xib的名称加载自定义的cell
    //        cell = [[[NSBundle mainBundle] loadNibNamed:@"UITableViewCell" owner:self options:nil] lastObject];
    //    }
    cell.textLabel.text = @"测试";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"右边%@",indexPath);
    
}

@end
