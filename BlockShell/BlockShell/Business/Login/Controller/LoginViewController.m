//
//  LoginViewController.m
//  BlockShell
//
//  Created by 李顺风 on 2018/3/27.
//  Copyright © 2018年 李顺风. All rights reserved.
//

#import "LoginViewController.h"
#import "LLRegisterVC.h"



@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *pwdLab;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


@property (weak, nonatomic) IBOutlet UIButton *wxBtn;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftlc;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phoneHlc;


@property (weak, nonatomic) IBOutlet UIView *bg1;
@property (weak, nonatomic) IBOutlet UIView *bg2;
@property (weak, nonatomic) IBOutlet UIView *bg3;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phoneHc;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginBtnHC;
@property (weak, nonatomic) IBOutlet UIButton *labCode;

@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UIButton *codeBtn;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UIView *wxBindView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *wxBindHC;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logoTopC;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *wxBtnTopC;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginBtnTopC;

@property (assign, nonatomic)  int count;
@property (strong, nonatomic)  NSTimer *timer;
@property (strong, nonatomic)  NSString *weiXinCode;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _count = 60;
    _leftlc.constant = 32*Scale_X;
    _phoneHlc.constant = 44*Scale_X;
    _phoneHc.constant = 44*Scale_X;
    _loginBtnHC.constant = 44*Scale_X;
    
    _logoTopC.constant = 35*Scale_X;
    _wxBtnTopC.constant = 35*Scale_X;
    _loginBtnTopC.constant = 55*Scale_X;

    
    
    _titleLab.font = [UIFont systemFontOfSize:22*Scale_X];
    
    _bg1.layer.borderWidth = OnePxLinne;
    _bg2.layer.borderWidth = OnePxLinne;
    _bg3.layer.borderWidth = OnePxLinne;
    _bg1.layer.borderColor = [LRRGBHex(0xDFDFDF) CGColor];
    _bg2.layer.borderColor = [LRRGBHex(0xDFDFDF) CGColor];
    _bg3.layer.borderColor = [LRRGBHex(0xDFDFDF) CGColor];
    _bg1.layer.cornerRadius = 2;
    _bg2.layer.cornerRadius = 2;
    _bg3.layer.cornerRadius = 2;
    
//
//    _isBindView = YES;
//    _isBindView = NO;
    
    [self setUiView];
    
    [[LRNotificationCenter rac_addObserverForName:@"loginAfter" object:nil] subscribeNext:^(id x) {
//        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dismissVC];
        });
    }];
    
    [[LRNotificationCenter rac_addObserverForName:@"kNotBindPhoneError" object:nil] subscribeNext:^(id x) {
        //        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            _isBindView = YES;
            [self setUiView];
        });
    }];
    
}

-(void) setUiView{
    if (_isBindView) {
        _wxBindView.hidden = NO;
        _wxBindHC.constant = 170*Scale_X;
        _wxBtn.hidden = YES;
        [_loginBtn setTitle:@"绑定并登录" forState:UIControlStateNormal];
        _titleLab.text = @"绑定手机号码";
    } else {
        _wxBindView.hidden = YES;
        _wxBindHC.constant = 120*Scale_X;
        _wxBtn.hidden = NO;
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        _titleLab.text = @"登录";
    }
}

- (IBAction)btnClick:(id)sender {
    switch ([sender tag]) {
        case 1://登录
        {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            if (_phoneNum.text.length == 11) {
                dic[@"phone"] = _phoneNum.text;
            } else {
                [MBProgressHUD showError:@"请输入正确的手机号"];
                return;
            }
            if (_pwdLab.text.length > 1 ) {
                dic[@"verifyCode"] = _pwdLab.text;
            } else {
                [MBProgressHUD showError:@"请输入验证码"];
                return;
            }
            if (_isBindView) {
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                dic[@"weiXinCode"] = _weiXinCode;//微信临时授权码
                dic[@"phone"] = @"15829554591";
                dic[@"bindType"] = @1;
                dic[@"verifyCode"] = @"000000";
                //            dic[@"deviceId"] = uuid;
                dic[@"source"] = @1;//登录来源:1-客户端,2-web,3-小程序
                [[LLLoginNet sharedInstance] postUserAuthbindphoneWithParameters: dic Complete:^{
                    [MBProgressHUD showSuccess:@"绑定成功"];
                } failed:^(NSString *error) {
                    [MBProgressHUD showError:error];
                }];
            } else {
                dic[@"type"] = _isBindView ? @3:@1;
                dic[@"way"] = @1;
                //            dic[@"verifyCode"] = @"000000";
                //            dic[@"phone"] = @"15829554591";
                [[LLLoginNet sharedInstance] postUsermanagerUsersLoginWithParameters:dic Complete:^{
                    [MBProgressHUD showSuccess:@"登陆成功!"];
                    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
                    dic2[@"queryType"] = @3;
                    [self dismissVC];
                    [[LLLoginNet sharedInstance] postUsermanagerUserQueryuserWithParameters:dic2 Complete:^(LLUserModel *model) {
                        [LLLoginManager setUserModel:model];
                    } failed:^(NSString *error) {
                        [MBProgressHUD showError:error];
                    }];
                } failed:^(NSString *error) {
                    [MBProgressHUD showError:error];
                }];
            }
           
            
        }
            break;
        case 100://国籍
        {
            [MBProgressHUD showSuccess:@"选择国籍"];
        }
            break;
        case 101://验证码
        {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            dic[@"type"] = _isBindView ? @3:@1;
            if (_phoneNum.text.length == 11) {
                dic[@"phone"] = _phoneNum.text;
            } else {
//                [MBProgressHUD showError:@"请输入正确的手机号"];
//                return;
                dic[@"phone"] = @15829554591;
            }
            _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(startCountingAnimation) userInfo:nil repeats:YES];
            [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
            
            [[LLLoginNet sharedInstance] postUsersSmiWithParameters:dic Complete:^{
                [MBProgressHUD showSuccess:@"获取成功,请在手机上查看"];
            } failed:^(NSString *error) {
                [MBProgressHUD showError:error];
            }];
        }
            break;
        case 4://微信
        {
            [OpenShare WeixinAuth:@"snsapi_userinfo" Success:^(NSDictionary *message) {
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                dic[@"weiXinCode"] = message[@"code"];//微信临时授权码
                _weiXinCode = message[@"code"];//微信临时授权码
                dic[@"authType"] = @1;//1-微信
                dic[@"source"] = @1;//登录来源:1-客户端,2-web,3-小程序
                [[LLLoginNet sharedInstance] postUsermanagerUserAuthloginWithParameters:dic Complete:^{
                    [MBProgressHUD showSuccess:@"登录成功"];
                    [self dismissVC];
                } failed:^(NSString *error) {
                    [MBProgressHUD showError:error];
                }];
                NSLog(@"微信登录成功:\n%@",message);
            } Fail:^(NSDictionary *message, NSError *error) {
                NSLog(@"微信登录失败:\n%@\n%@",message,error);
            }];
        }
            break;
        case 102:
        {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            dic[@"weiXinCode"] = _weiXinCode;//微信临时授权码
            dic[@"phone"] = @"15829554591";
            dic[@"bindType"] = @1;
            dic[@"verifyCode"] = @"000000";
            dic[@"source"] = @1;//登录来源:1-客户端,2-web,3-小程序
            [[LLLoginNet sharedInstance] postUserAuthbindphoneWithParameters: dic Complete:^{
                [MBProgressHUD showSuccess:@"绑定成功"];
            } failed:^(NSString *error) {
                [MBProgressHUD showError:error];
            }];
        }
            break;
        case 104://用户协议
            [MBProgressHUD showSuccess:@"用户协议"];
            break;
        case 7:
            [self dismissVC];
            break;
            
        default:
            break;
    }
    
    
    
}

-(void)dismissVC{
    if (self.loginCancelBlock) {
        self.loginCancelBlock();
    }
    [self dismissViewControllerAnimated:YES completion:nil];

}



-(void)startCountingAnimation {
    self.codeBtn.enabled = false;
    if (_count == 1 || _count < 1) {
        self.codeBtn.enabled = true;
        _count =60;
        [self.codeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        [_timer invalidate];
        _timer = nil;
        //        return;
    } else {
        _count -=1;
        [UIView animateWithDuration:1.0 animations:^{
            [self.codeBtn setTitle:[NSString stringWithFormat:@"%d s",_count] forState:UIControlStateNormal];
        }];
    }
    
}

@end
