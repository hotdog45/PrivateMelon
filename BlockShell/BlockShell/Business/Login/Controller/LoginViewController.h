//
//  LoginViewController.h
//  BlockShell
//
//  Created by 李顺风 on 2018/3/27.
//  Copyright © 2018年 李顺风. All rights reserved.
//

#import "BSBaseVC.h"

@interface LoginViewController : BSBaseVC
@property(copy,nonatomic) void (^loginCancelBlock)(void);

@property (assign, nonatomic)  BOOL isBindView;
@end
