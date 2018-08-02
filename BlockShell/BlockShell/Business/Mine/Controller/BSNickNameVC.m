//
//  BSNickNameVC.m
//  BlockShell
//
//  Created by 李顺风 on 2018/7/2.
//  Copyright © 2018年 qiaofeng. All rights reserved.
//

#import "BSNickNameVC.h"

@interface BSNickNameVC ()

@end

@implementation BSNickNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Nickname";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithTitle:@"保存"
                                              style:UIBarButtonItemStylePlain
                                              target:self
                                              action:@selector(rightBarClick)];
}

- (void)rightBarClick
{
    //    NSLog(@"右边");
    //    [UCLoginManager enterLoginView];
//    LoginViewController * loginVC = [LoginViewController new];
//    [self presentViewController:loginVC animated:YES completion:nil];
    
    //保存 
    
    
}


@end
