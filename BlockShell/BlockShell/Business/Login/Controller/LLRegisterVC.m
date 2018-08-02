//
//  LLRegisterVC.m
//  BlockShell
//
//  Created by 李顺风 on 2018/3/28.
//  Copyright © 2018年 李顺风. All rights reserved.
//

#import "LLRegisterVC.h"


@interface LLRegisterVC ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *pwdLab;
@property (weak, nonatomic) IBOutlet UIButton *getNumBtn;
@property (weak, nonatomic) IBOutlet UITextField *codeNum;


@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@property (weak, nonatomic) IBOutlet UIButton *agreementtn;


@property (weak, nonatomic) IBOutlet UIButton *goLoginBtn;

@property (weak, nonatomic) IBOutlet UIButton *wxBtn;

@property (weak, nonatomic) IBOutlet UIButton *qqBtn;

@property (weak, nonatomic) IBOutlet UIButton *wbBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toplc;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftlc;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginbtnToplc;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *wxWlc;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phoneHlc;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomlc;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *qqBottomlc;

@property (weak, nonatomic) IBOutlet UIView *bg1;

@property (weak, nonatomic) IBOutlet UIView *bg2;

@property (weak, nonatomic) IBOutlet UIView *bg3;


@property (weak, nonatomic) IBOutlet UILabel *otherloginlab;

@property (assign, nonatomic)  int count;
@property (strong, nonatomic)  NSTimer *timer;

@end

@implementation LLRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];

    _count = 60;
    _toplc.constant = 95*Scale_X;
    _leftlc.constant = 50*Scale_X;
    _loginbtnToplc.constant = 38*Scale_X;
    _wxWlc.constant = 45*Scale_X;
    _phoneHlc.constant = 35*Scale_X;
    _qqBottomlc.constant = 33*Scale_X;
    _bottomlc.constant = 45*Scale_X;
    _agreementtn.titleLabel.font = [UIFont systemFontOfSize:12*Scale_X];
    _otherloginlab.font = [UIFont systemFontOfSize:12*Scale_X];
    
    float radius = 35*Scale_X/2;
    _bg1.layer.cornerRadius = radius;
    _bg2.layer.cornerRadius = radius;
    _bg3.layer.cornerRadius = radius;
    _getNumBtn.layer.cornerRadius =  radius;
    _registerBtn.layer.cornerRadius =  radius;
    _goLoginBtn.layer.cornerRadius = radius;
    _bg1.layer.masksToBounds = YES;
    _bg2.layer.masksToBounds = YES;
    _bg3.layer.masksToBounds = YES;
    _getNumBtn.layer.masksToBounds = YES;
    _registerBtn.layer.masksToBounds = YES;
    _goLoginBtn.layer.masksToBounds = YES;
    
    _pwdLab.secureTextEntry = true;

}

- (IBAction)btnClick:(id)sender {
    switch ([sender tag]) {
        case 1://获取验证码
           
        {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            if (_phoneNum.text.length == 11 ) {
                dic[@"mobile"] = _phoneNum.text;
            } else {
                [MBProgressHUD showError:@"请输入正确的手机号"];
                return;
            }
            _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(startCountingAnimation) userInfo:nil repeats:YES];
            [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
            

//            [self startCountingAnimation];
            [[LLLoginNet sharedInstance] postUsersSmiWithParameters:dic Complete:^{
                [MBProgressHUD showSuccess:@"获取成功,请在手机上查看"];
            } failed:^(NSString *error) {
                [MBProgressHUD showError:error];
            }];
        }
            break;
        case 2://注册
        {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            if (_phoneNum.text.length == 11 ) {
                dic[@"mobile"] = _phoneNum.text;
            } else {
                [MBProgressHUD showError:@"请输入正确的手机号"];
                return;
            }
            if (_codeNum.text.length > 3 ) {
                dic[@"smscode"] = _codeNum.text;
            } else {
                [MBProgressHUD showError:@"请输入验证码"];
                return;
            }
            if (_pwdLab.text.length > 5 ) {
                dic[@"password"] = _pwdLab.text;
            } else {
                [MBProgressHUD showError:@"请输入六位以上密码"];
                return;
            }
//            [[LLLoginNet sharedInstance] postUsersRegisterWithParameters:dic Complete:^(LLUserModel *model) {
//                [self login];
//            } failed:^(NSString *error) {
//                [MBProgressHUD showError:error];
//
//            }];
            
            
        }
            break;
        case 3://协议
            [MBProgressHUD showSuccess:@"协议"];

            break;
        case 4://去登陆
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
            break;
        case 5://微信
//            [MBProgressHUD showSuccess:@"微信"];
        {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            dic[@"user_id"] = @"0";
            dic[@"category"] = @"basic";
//            [[LLLoginNet sharedInstance] getUsersIDWithParameters:dic Complete:^(LLUserModel *model) {
//                [MBProgressHUD showSuccess:@"获取成功!"];
//            } failed:^(NSString *error) {
//                [MBProgressHUD showError:error];
//            }];
        }

            break;
        case 6://QQ
            [MBProgressHUD showSuccess:@"QQ"];

            break;
        case 7://微博
            [MBProgressHUD showSuccess:@"微博"];

            break;
            
        default:
            break;
    }
    
    
    
}


-(void)login{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (_phoneNum.text.length == 11 ) {
        dic[@"username"] = _phoneNum.text;
    } else {
        [MBProgressHUD showError:@"请输入正确的手机号"];
        return;
    }
    if (_pwdLab.text.length > 1 ) {
        dic[@"password"] = _pwdLab.text;
    } else {
        [MBProgressHUD showError:@"请输入密码"];
        return;
    }
    dic[@"type"] = @"1";
//    [[LLLoginNet sharedInstance] postUsersLoginWithParameters:dic Complete:^(LLUserModel *model) {
//        [LLLoginManager setUserModel:model];
//        NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
//        dic2[@"user_id"] = model.userId.stringValue;
//        dic2[@"category"] = @"basic";
//        [[LLLoginNet sharedInstance] getUsersIDWithParameters:dic2 Complete:^(LLUserModel *model) {
//            [MBProgressHUD showSuccess:@"注册成功!"];
//            [LLLoginManager setUserModel:model];
//            if ([LLLoginManager isSettingTags]) {
//                [LRNotificationCenter postNotificationName:@"loginAfter" object:nil];
//            } else {
////                LLSelectInterestVC *vc = [LLSelectInterestVC new];
////                [self presentViewController:vc animated:YES completion:nil];
//            }
//        } failed:^(NSString *error) {
//            [MBProgressHUD showError:error];
//        }];
//    } failed:^(NSString *error) {
//        [MBProgressHUD showError:error];
//        
//    }];
}

-(void)startCountingAnimation {
    self.getNumBtn.enabled = false;
    if (_count == 1) {
        self.getNumBtn.enabled = true;
        [self.getNumBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        [_timer invalidate];
        _timer = nil;
//        return;
    } else {
        _count -=1;
        [UIView animateWithDuration:1.0 animations:^{
            [self.getNumBtn setTitle:[NSString stringWithFormat:@"%d s",_count] forState:UIControlStateNormal];
        }];
    }
    
}


@end
