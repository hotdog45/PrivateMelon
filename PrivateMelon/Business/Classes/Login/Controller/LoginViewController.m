//
//  LoginViewController.m
//  PrivateMelon
//
//  Created by 李顺风 on 2018/3/27.
//  Copyright © 2018年 李顺风. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *pwdLab;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@property (weak, nonatomic) IBOutlet UIButton *forgotBtn;

@property (weak, nonatomic) IBOutlet UIButton *wxBtn;

@property (weak, nonatomic) IBOutlet UIButton *qqBtn;

@property (weak, nonatomic) IBOutlet UIButton *wbBtn;



@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}



- (IBAction)btnClick:(id)sender {
    switch ([sender tag]) {
        case 1://登录
            
            break;
        case 2://注册
            
            break;
        case 3://忘记
            
            break;
        case 4://微信
            
            break;
        case 5://QQ
            
            break;
        case 6://微博
            
            break;
        case 7:
            
            break;
            
        default:
            break;
    }
    
    
    
}











@end
