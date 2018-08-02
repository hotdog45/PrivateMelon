//
//  BSVoucherCenterVC.m
//  BlockShell
//
//  Created by 李顺风 on 2018/6/22.
//  Copyright © 2018年 qiaofeng. All rights reserved.
//

#import "BSVoucherCenterVC.h"
#import "LLHomeTabCell.h"
#import "LLHomePageCell.h"
#import "HomeHeaderCell.h"
#import "BSVoucherOneCell.h"
#import "BSVoucherTwoCell.h"
#import "BSVoucherThreeCell.h"
#import "BSVoucherFlowCell.h"
#import "BSVoucherOtherCell.h"
#import "BSPaymentView.h"
#import <Contacts/Contacts.h>
/// iOS 9前的框架
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
/// iOS 9的新框架
#import <ContactsUI/ContactsUI.h>

#define Is_up_Ios_9        [[UIDevice currentDevice].systemVersion floatValue] >= 9.0


@interface BSVoucherCenterVC ()<ABPeoplePickerNavigationControllerDelegate,CNContactPickerDelegate>

@property(strong,nonatomic) BSPaymentView *paymentView;

@property(strong,nonatomic) NSString *phoneNum;
@property(strong,nonatomic) NSString *locationbyphone;
@property(nonatomic,strong) NSMutableArray *dataArr;



@end

@implementation BSVoucherCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithImage:[UIImage imageNamed:@"mine_icon_talk"]
                                              style:UIBarButtonItemStylePlain
                                              target:self
                                              action:@selector(rightBarClick)];
    self.title = @"Voucher Center";
    [self.view addSubview:self.tableView];
    _dataArr = [NSMutableArray arrayWithCapacity:0];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BSVoucherOneCell" bundle:nil] forCellReuseIdentifier:@"BSVoucherOneCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BSVoucherTwoCell" bundle:nil] forCellReuseIdentifier:@"BSVoucherTwoCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BSVoucherThreeCell" bundle:nil] forCellReuseIdentifier:@"BSVoucherThreeCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BSVoucherFlowCell"  bundle:nil] forCellReuseIdentifier:@"BSVoucherFlowCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BSVoucherOtherCell" bundle:nil] forCellReuseIdentifier:@"BSVoucherOtherCell"];
    
    _paymentView = [BSPaymentView paymentView];
    _paymentView.frame = CGRectMake(0, SCREENH_HEIGHT, SCREEN_WIDTH, SCREENH_HEIGHT);
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview: _paymentView];
    _paymentView.hidden = YES;
    [_paymentView.closeBtn add_BtnClickHandler:^(NSInteger tag) {
        [self setPaymentViewHidden:YES];
    }];
    [_paymentView.bgBtn add_BtnClickHandler:^(NSInteger tag) {
        [self setPaymentViewHidden:YES];
    }];
    
    [_paymentView.alipayBtn add_BtnClickHandler:^(NSInteger tag) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"shopId"] = @"1";
        dic[@"sellerId"] = @"1";
        dic[@"orderType"] = @"1";
        dic[@"payWay"] = @"3";
        dic[@"itemcount"] = @"1";
        dic[@"skuId"] = @"10091";
        dic[@"businessInfo"] = @{@"phone":@"13355786578"};
        
        [[BSHomeNet sharedInstance] postTradeOrderCreateImmediatelyOrderWithParameters:dic Complete:^(BSTradeOrderModel *model) {
            NSLog(@"%@",model);
        } failed:^(NSString *error) {
            [MBProgressHUD showError:error];
        }];
    }];
    [_paymentView.wxBtn add_BtnClickHandler:^(NSInteger tag) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"shopId"] = @"1";
        dic[@"sellerId"] = @"1";
        dic[@"orderType"] = @"1";
        dic[@"payWay"] = @"2";
        dic[@"itemcount"] = @"1";
        dic[@"skuId"] = @"10091";
        dic[@"businessInfo"] = @{@"phone":@"13355786578"};
        
        [[BSHomeNet sharedInstance] postTradeOrderCreateImmediatelyOrderWithParameters:dic Complete:^(BSTradeOrderModel *model) {
            NSLog(@"%@",model);
            
            NSError *err;
            BSTradeOrderwxModel *payInfo = [[BSTradeOrderwxModel alloc]
                                        initWithDictionary:model.payInfo
                                        error:&err];
            if (err) {
                NSLog(@"%@",payInfo);
            }
            
        } failed:^(NSString *error) {
            [MBProgressHUD showError:error];
        }];
    }];
    
    //话费
    [[LRNotificationCenter rac_addObserverForName:@"collectionViewSelectItem" object:nil] subscribeNext:^(NSNotification *notification) {
        LRWeakSelf(self) //weakself
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *index = notification.userInfo[@"index"];
            LRLog(@"%@", index);
            [self setPaymentViewHidden:NO];
        });
    }];
    
    //流量
    [[LRNotificationCenter rac_addObserverForName:@"collectionView2SelectItem" object:nil] subscribeNext:^(NSNotification *notification) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *index = notification.userInfo[@"index"];
            LRLog(@"%@", index);
            [self setPaymentViewHidden:NO];
        });
    }];

    
    [self getNetlist];
}

-(void)setPaymentViewHidden:(BOOL) isHidden{
    if (isHidden) {
        [UIView animateWithDuration:0.2 animations:^{
            _paymentView.y = SCREENH_HEIGHT;
        } completion:^(BOOL finished) {
            _paymentView.hidden = YES;
        }];
    } else {
        _paymentView.hidden = false;
        [UIView animateWithDuration:0.2 animations:^{
            _paymentView.y = 0;
        }];
    }
    
}

- (void)rightBarClick {
   
}
- (void)getNetlist {
    [self.dataArr removeAllObjects];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"virtualType"] = @"1";
    dic[@"prov"] = @"浙江";
    LRWeakSelf(self)
    [[BSHomeNet sharedInstance] postVirtualserviceQueryvirtualitemWithParameters:dic Complete:^(NSArray *array) {
        
        for (NSDictionary *dic in array) {
            NSError *err;
            BSQueryvirtualitemModel *model = [[BSQueryvirtualitemModel alloc]
                                        initWithDictionary:dic
                                        error:&err];
            if (!err) {
                [weakself.dataArr addObject:model];
            }
        }
        [weakself.tableView reloadData];
    } failed:^(NSString *error) {
        [MBProgressHUD showError:error];
    }];
    
    
}
#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 1;
    } else {
        if (_isFlowVoucher) {
            return 3;
        } else {
            return 1;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 99;
    } else if (indexPath.section == 1) {
        
        if (_isFlowVoucher) {
            return (SCREEN_WIDTH-60)/3*2 + 90;
        } else {
            return (SCREEN_WIDTH-60)/3*2 + 130;
        }
    } else {
        if (_isFlowVoucher) {
            return 80;
        } else {
            return (SCREEN_WIDTH-60)/3 + 90;
        }
        
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        BSVoucherOneCell*cell = [tableView dequeueReusableCellWithIdentifier:@"BSVoucherOneCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.phoneListBtn add_BtnClickHandler:^(NSInteger tag) {
//            [self requestContactAuthorAfterSystemVersion9];
            [self JudgeAddressBookPower];
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"RAC" message:@"RAC TEST" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"other", nil];
////            [[self rac_signalForSelector:@selector(alertView:clickedButtonAtIndex:) fromProtocol:@protocol(UIAlertViewDelegate)] subscribeNext:^(RACTuple *tuple) {
////                NSLog(@"tuple.first----%@",tuple.first);
////                NSLog(@"tuple.second----%@",tuple.second);
////                NSLog(@"tuple.third----%@",tuple.third);
////            }];
//            [[alertView rac_buttonClickedSignal] subscribeNext:^(id x) {
//                NSLog(@"%@",x);
//            }];
//
//            [alertView show];
            
        }];
//        [[cell.phoneNumTF rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(id x){
//            LRLog(@"change");
//        }];
        [[cell.phoneNumTF rac_textSignal] subscribeNext:^(id x) {
            NSLog(@"%@",x);
        }];
        cell.phoneNumTF.text = _phoneNum;
        cell.phoneType.text = _locationbyphone;
        return cell;
    } else if (indexPath.section == 1) {
        
        if (_isFlowVoucher) {
            BSVoucherFlowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BSVoucherFlowCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            [cell.btn1 add_BtnClickHandler:^(NSInteger tag) {
//                [self setPaymentViewHidden:NO];
//            }];
            cell.dataArr = self.dataArr;
            [cell.collectionView reloadData];
            return cell;
        } else {
            BSVoucherTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BSVoucherTwoCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.btn1 add_BtnClickHandler:^(NSInteger tag) {
                [self setPaymentViewHidden:NO];
            }];
            cell.dataArray = self.dataArr;
            [cell.collectionView reloadData];
            return cell;
        }
        
    } else {
        if (_isFlowVoucher) {
            BSVoucherOtherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BSVoucherOtherCell"];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"BSVoucherOtherCell" owner:self options:nil] lastObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        } else {
            BSVoucherThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BSVoucherThreeCell"];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"BSVoucherThreeCell" owner:self options:nil] lastObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
    }
    
    
    
}

//请求通讯录权限
#pragma mark 请求通讯录权限
- (void)requestContactAuthorAfterSystemVersion9{
    
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (status == CNAuthorizationStatusNotDetermined) {
        CNContactStore *store = [[CNContactStore alloc] init];
        [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError*  _Nullable error) {
            if (error) {
                NSLog(@"授权失败");
            }else {
                NSLog(@"成功授权");
            }
        }];
    }
    else if(status == CNAuthorizationStatusRestricted)
    {
        NSLog(@"用户拒绝");
        [self showAlertViewAboutNotAuthorAccessContact];
    }
    else if (status == CNAuthorizationStatusDenied)
    {
        NSLog(@"用户拒绝");
        [self showAlertViewAboutNotAuthorAccessContact];
    }
    else if (status == CNAuthorizationStatusAuthorized)//已经授权
    {
        //有通讯录权限-- 进行下一步操作
        [self openContact];
    }
    
}

//有通讯录权限-- 进行下一步操作
- (void)openContact{
    // 获取指定的字段,并不是要获取所有字段，需要指定具体的字段
    NSArray *keysToFetch = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey];
    CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:keysToFetch];
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    
    [contactStore enumerateContactsWithFetchRequest:fetchRequest error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        NSLog(@"-------------------------------------------------------");
        
        NSString *givenName = contact.givenName;
        NSString *familyName = contact.familyName;
        NSLog(@"givenName=%@, familyName=%@", givenName, familyName);
        //拼接姓名
        NSString *nameStr = [NSString stringWithFormat:@"%@%@",contact.familyName,contact.givenName];
        
        NSArray *phoneNumbers = contact.phoneNumbers;
        
        //        CNPhoneNumber  * cnphoneNumber = contact.phoneNumbers[0];
        
        //        NSString * phoneNumber = cnphoneNumber.stringValue;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
        for (CNLabeledValue *labelValue in phoneNumbers) {
            //遍历一个人名下的多个电话号码
//            NSString *label = labelValue.label;
//            NSString *    phoneNumber = labelValue.value;
            CNPhoneNumber *phoneNumber = labelValue.value;
            
            NSString * string = phoneNumber.stringValue ;
            
            //去掉电话中的特殊字符
            string = [string stringByReplacingOccurrencesOfString:@"+86" withString:@""];
            string = [string stringByReplacingOccurrencesOfString:@"-" withString:@""];
            string = [string stringByReplacingOccurrencesOfString:@"(" withString:@""];
            string = [string stringByReplacingOccurrencesOfString:@")" withString:@""];
            string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
            string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
            
            NSString *str = [NSString stringWithFormat:@"姓名=%@, 电话号码是=%@", nameStr, string];
            NSLog(@"姓名=%@, 电话号码是=%@", nameStr, string);
            [arr addObject:str];
        }
        
        //    *stop = YES; // 停止循环，相当于break；
        
    }];
    
}


//提示没有通讯录权限
- (void)showAlertViewAboutNotAuthorAccessContact{
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"请授权通讯录权限"
                                          message:@"请在iPhone的\"设置-隐私-通讯录\"选项中,允许花解解访问你的通讯录"
                                          preferredStyle: UIAlertControllerStyleAlert];
    
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:OKAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
///////////////////////////////////////////////////////////////
#pragma mark ---- 调用系统通讯录
- (void)JudgeAddressBookPower {
    ///获取通讯录权限，调用系统通讯录
    [self CheckAddressBookAuthorization:^(bool isAuthorized , bool isUp_ios_9) {
        if (isAuthorized) {
            [self callAddressBook:isUp_ios_9];
        }else {
            NSLog(@"请到设置>隐私>通讯录打开本应用的权限设置");
        }
    }];
}

- (void)CheckAddressBookAuthorization:(void (^)(bool isAuthorized , bool isUp_ios_9))block {
    if (Is_up_Ios_9) {
        CNContactStore * contactStore = [[CNContactStore alloc]init];
        if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusNotDetermined) {
            [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * __nullable error) {
                if (error)
                {
                    NSLog(@"Error: %@", error);
                }
                else if (!granted)
                {
                    
                    block(NO,YES);
                }
                else
                {
                    block(YES,YES);
                }
            }];
        }
        else if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusAuthorized){
            block(YES,YES);
        }
        else {
            NSLog(@"请到设置>隐私>通讯录打开本应用的权限设置");
        }
    }else {
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        ABAuthorizationStatus authStatus = ABAddressBookGetAuthorizationStatus();
        
        if (authStatus == kABAuthorizationStatusNotDetermined)
        {
            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (error)
                    {
                        NSLog(@"Error: %@", (__bridge NSError *)error);
                    }
                    else if (!granted)
                    {
                        
                        block(NO,NO);
                    }
                    else
                    {
                        block(YES,NO);
                    }
                });
            });
        }else if (authStatus == kABAuthorizationStatusAuthorized)
        {
            block(YES,NO);
        }else {
            NSLog(@"请到设置>隐私>通讯录打开本应用的权限设置");
        }
    }
}

- (void)callAddressBook:(BOOL)isUp_ios_9 {
    if (isUp_ios_9) {
        CNContactPickerViewController *contactPicker = [[CNContactPickerViewController alloc] init];
        contactPicker.delegate = self;
        contactPicker.displayedPropertyKeys = @[CNContactPhoneNumbersKey];
        [self presentViewController:contactPicker animated:YES completion:nil];
    }else {
        ABPeoplePickerNavigationController *peoplePicker = [[ABPeoplePickerNavigationController alloc] init];
        peoplePicker.peoplePickerDelegate = self;
        [self presentViewController:peoplePicker animated:YES completion:nil];
        
    }
}

#pragma mark -- CNContactPickerDelegate
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty {
    CNPhoneNumber *phoneNumber = (CNPhoneNumber *)contactProperty.value;
    [self dismissViewControllerAnimated:YES completion:^{
        /// 联系人
        NSString *text1 = [NSString stringWithFormat:@"%@%@",contactProperty.contact.familyName,contactProperty.contact.givenName];
        /// 电话
        NSString *text2 = phoneNumber.stringValue;
        //        text2 = [text2 stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSLog(@"联系人：%@, 电话：%@",text1,text2);
        _phoneNum = [self strPhone:text2];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"phonenumber"] = [NSString stringWithFormat:@"%@",_phoneNum];
        [[BSHomeNet sharedInstance] postVirtualserviceLocationbyphoneWithParameters:dic Complete:^(BSLocationbyphoneModel *model) {
            _locationbyphone = [NSString stringWithFormat:@"%@%@",model.province,model.phoneclass];
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
            [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        } failed:^(NSString *error) {
            [MBProgressHUD showError:error];
        }];
        
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        
        
    }];
}

#pragma mark -- ABPeoplePickerNavigationControllerDelegate
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    
    ABMultiValueRef valuesRef = ABRecordCopyValue(person, kABPersonPhoneProperty);
    CFIndex index = ABMultiValueGetIndexForIdentifier(valuesRef,identifier);
    CFStringRef value = ABMultiValueCopyValueAtIndex(valuesRef,index);
    CFStringRef anFullName = ABRecordCopyCompositeName(person);
    
    [self dismissViewControllerAnimated:YES completion:^{
        /// 联系人
        NSString *text1 = [NSString stringWithFormat:@"%@",anFullName];
        /// 电话
        NSString *text2 = (__bridge NSString*)value;
        //        text2 = [text2 stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSLog(@"联系人：%@, 电话：%@",text1,text2);
        
        _phoneNum = [self strPhone:text2];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"phonenumber"] = [NSString stringWithFormat:@"%@",_phoneNum];
        [[BSHomeNet sharedInstance] postVirtualserviceLocationbyphoneWithParameters:dic Complete:^(BSLocationbyphoneModel *model) {
            _locationbyphone = [NSString stringWithFormat:@"%@%@",model.province,model.phoneclass];
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
            [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        } failed:^(NSString *error) {
            [MBProgressHUD showError:error];
        }];
         
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];

        
    }];
}



-(NSString *)strPhone:(NSString *)str{
    NSString * string = str ;
    string = [string stringByReplacingOccurrencesOfString:@"+86" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"-" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"(" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@")" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    return string;
}


@end
