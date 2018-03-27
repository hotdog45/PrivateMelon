//
//  LLMomentsVC.m
//  PrivateMelon
//
//  Created by 李顺风 on 2018/3/27.
//  Copyright © 2018年 李顺风. All rights reserved.
//

#import "LLMomentsVC.h"
#import "LLtest1ViewController.h"


@interface LLMomentsVC ()

@end

@implementation LLMomentsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LRRandomColor;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithImage:[UIImage imageNamed:@"message_highlight"]
                                             style:UIBarButtonItemStylePlain
                                             target:self
                                             action:@selector(leftBarClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithImage:[UIImage imageNamed:@"home_highlight"]
                                             style:UIBarButtonItemStylePlain
                                             target:self
                                             action:@selector(rightBarClick)];
    
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
}

- (void)leftBarClick
{
    LLTest1ViewController *VC=[[LLTest1ViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}
- (void)rightBarClick
{
    NSLog(@"右边");
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
