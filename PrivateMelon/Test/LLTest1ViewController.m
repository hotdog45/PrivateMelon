//
//  LLTest1ViewController.m
//  PrivateMelon
//
//  Created by 李顺风 on 2018/3/26.
//  Copyright © 2018年 李顺风. All rights reserved.
//

#import "LLTest1ViewController.h"
#import "LLtest3ViewController.h"
#import "LLTestNetWork.h"

@interface LLTest1ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *testText;

@end

@implementation LLTest1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)apitest1:(id)sender {
    NSDictionary *param;
    param = @{ @"page" : @0,
               @"perPage" : @50,
               };
    [[LLTestNetWork sharedInstance] getUniDataWithParameters:param Complete:^(LLSchoolListModel *list) {
        _testText.text = list.toJSONString;
    } failed:^(NSString *error) {
        _testText.text = error;
    }];
}

- (IBAction)test2:(id)sender {

   
    NSDictionary *param;
    param = @{ @"page" : @0,
               @"perPage" : @50,
               };
    [[LLTestNetWork sharedInstance] getLLUCWithParameters:param Complete:^(UCUCityBaseListMdoel *list) {
        _testText.text = list.toJSONString;
    } failed:^(NSString *error) {
        _testText.text = error;
    }];
    
}
- (IBAction)jump:(id)sender {
    LLtest3ViewController *VC=[[LLtest3ViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

@end
