//
//  LLRegisterVC.m
//  PrivateMelon
//
//  Created by 李顺风 on 2018/3/28.
//  Copyright © 2018年 李顺风. All rights reserved.
//

#import "LLRegisterVC.h"

@interface LLRegisterVC ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *pwdLab;


@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

//@property (weak, nonatomic) IBOutlet UIButton *registerBtn;


@property (weak, nonatomic) IBOutlet UIButton *goLoginBtn;

@property (weak, nonatomic) IBOutlet UIButton *wxBtn;

@property (weak, nonatomic) IBOutlet UIButton *qqBtn;

@property (weak, nonatomic) IBOutlet UIButton *wbBtn;


@end

@implementation LLRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
