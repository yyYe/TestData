//
//  ViewController.m
//  TestLanding
//
//  Created by loufq on 16/3/18.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "LoginVC.h"
#import <AFNetworking/AFNetworking.h>
#import <Masonry/Masonry.h>
#import "PersonalCenterVC.h"
#import "HttpTool.h"
#import "PersonalInfoVC.h"

static NSString *const kCheckCode = @"http://app.yimama.com.cn/api/fastCheckCode";
static NSString *const kFastLogin = @"http://app.yimama.com.cn/api/fastLogin";
//static NSInteger const kPhoneTag = 100;
//static NSInteger const kCheckCodeTag = 200;

@interface LoginVC () <UITextFieldDelegate> {
    LimitTextField *tfPhone;
    LimitTextField *tfCheckCode;
}

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIEventSubtypeNone;
    
    tfPhone = [LimitTextField new];
    tfPhone.text = @"15757984264";
    tfPhone.delegate = self;
    tfPhone.borderStyle = UITextBorderStyleRoundedRect;
    tfPhone.keyboardType = UIKeyboardTypeNumberPad;
    tfPhone.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:tfPhone];
    
    tfCheckCode = [LimitTextField new];
    tfCheckCode.delegate = self;
    tfCheckCode.borderStyle = UITextBorderStyleRoundedRect;
    tfCheckCode.keyboardType = UIKeyboardTypeNumberPad;
    tfCheckCode.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:tfCheckCode];
    
    UIButton *checkCodeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [checkCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    checkCodeButton.backgroundColor = [UIColor grayColor];
    [checkCodeButton addTarget:self action:@selector(checkCodeButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkCodeButton];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    loginButton.backgroundColor = [UIColor grayColor];
    [loginButton addTarget:self action:@selector(loginButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    [tfPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).offset(30);
        make.right.equalTo(self.view).offset(-30);
        make.height.equalTo(@44);
    }];
    
    [tfCheckCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.equalTo(tfPhone);
        make.top.equalTo(tfPhone.mas_bottom).offset(30);
        make.right.equalTo(checkCodeButton.mas_left).offset(-10);
    }];
    
    [checkCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tfCheckCode.mas_right).offset(10);
        make.top.equalTo(tfCheckCode);
        make.right.height.equalTo(tfPhone);
    }];
    
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(tfPhone);
        make.top.equalTo(tfCheckCode.mas_bottom).offset(30);
    }];
    
}

- (void)checkCodeButtonTapped {
    NSDictionary *dict = @{
                           @"data":@{
                                   @"phone":tfPhone.text
                                   },
                           @"header":@{
                                   @"msgId":@"ea1b5095-3a23-4ae9-97af-06a4893b5ab9",
                                   @"msgType":@"fastCheckCode",
                                   @"timestamp":@"2015-12-29 13:07:56.436",
                                   @"clientRes":@"iOS"
                                   }
                           };
    [HttpTool postWithURL:kCheckCode params:dict success:^(id json) {
        NSLog(@"responseObject-%@",json);
    } failure:^(NSString *errorMsg, NSString *statusCode) {
        NSLog(@"error-%@",errorMsg);
    }];
    
}

- (void)loginButtonTapped {
    NSDictionary *dict = @{
                           @"data":@{
                                       @"phone":tfPhone.text,
                                       @"checkCode":tfCheckCode.text
                                   },
                           @"header":@{
                                       @"msgId":@"ea1b5095-3a23-4ae9-97af-06a4893b5ab9",
                                       @"msgType":@"fastLogin",
                                       @"timestamp":@"2015-12-29 13:07:57.429",
                                       @"clientRes":@"iOS"
                                   }
                           };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/javascript",@"application/json",@"text/json", @"text/html", nil];
    [manager POST:kFastLogin parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject-%@",responseObject);
        PersonalInfoVC *infoVC = [PersonalInfoVC new];
        infoVC.userID = [responseObject valueForKeyPath:@"data.sessionUser.id"];
        infoVC.token = [responseObject valueForKeyPath:@"data.sessionUser.token"];
        infoVC.xuid = [responseObject valueForKeyPath:@"data.sessionUser.xuid"];
        [self.navigationController pushViewController:infoVC animated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-%@",error);
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (range.location >= 11) {
        return NO; // return NO to not change text
    }
    
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


@implementation LimitTextField

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(paste:))
        return NO;
    if (action == @selector(select:))
        return NO;
    if (action == @selector(selectAll:))
        return NO;
    return [super canPerformAction:action withSender:sender];
}

@end
