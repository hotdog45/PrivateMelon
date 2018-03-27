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





@end
