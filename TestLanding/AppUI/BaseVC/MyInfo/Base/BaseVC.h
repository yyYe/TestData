//
//  BaseVC.h
//  TestLanding
//
//  Created by loufq on 16/3/19.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import <Masonry/Masonry.h>
#import "UIImage+Extension.h"

#import "ConstMacro.h"
#import "HttpTool.h"
#import "PersonalCenter.h"
#import "MeLableItem.h"
#import "HttpTool.h"
#import "PersonBase.h"
#import "Mother.h"
#import "Baby.h"
#import "Gender.h"


static NSString *const kToken = @"16f42d445a3341d7bbe2fb7d5d7af1cc87797030419345647975199807067420";
static NSString *const kXuid = @"BDCB5B4E-361E-4875-87C0-470A9FEBAA4E";
static NSString *const kMsgID = @"ea1b5095-3a23-4ae9-97af-06a4893b5ab9";
//妈妈信息接口
static NSString *const kModifyMamaHeaderImg = @"http://app.yimama.com.cn/api/mama/modifyMamaHeaderImg";
static NSString *const kGetMamaInfo = @"http://app.yimama.com.cn/api/mama/getMamaInfo";
static NSString *const kModifyMamaInfo = @"http://app.yimama.com.cn/api/mama/modifyMamaInfo";
//宝宝信息接口
static NSString *const kModifyBabyHeaderImg = @"http://app.yimama.com.cn/api/mama/modifyBabyHeaderImg";
static NSString *const kModifyBabyInfo = @"http://app.yimama.com.cn/api/mama/modifyBabyInfo";
static NSString *const kRemoveBabyInfo = @"http://app.yimama.com.cn/api/mama/removeBabyInfo";
static NSString *const kAddBabyInfo = @"http://app.yimama.com.cn/api/mama/addBabyInfo";
static NSString *const kGetBabyInfo = @"http://app.yimama.com.cn/api/mama/getBabyInfo";

static NSString *const kGetUserInfo = @"http://app.yimama.com.cn/api/follow/getUserInfo";
static NSString *const kListFollows = @"http://app.yimama.com.cn/api/follow/listFollows";
static NSString *const kList = @"http://app.yimama.com.cn/api/cforder/list"; //用户订单列表
static NSString *const kPost_upload_batch = @"http:/app.yimama.com.cn/im/post_upload_batch";
//地址
static NSString *const kUserAddressList = @"http://app.yimama.com.cn/api/adr/userAddressList";
static NSString *const kAddUserAddress = @"http://app.yimama.com.cn/api/adr/addUserAddress";
static NSString *const kUpdateUserAddress = @"http://app.yimama.com.cn/api/adr/updateUserAddress";
static NSString *const kDefaultUserAddress = @"http://app.yimama.com.cn/api/adr/defaultUserAddress";
static NSString *const kDeleteUserAddress = @"http://app.yimama.com.cn/api/adr/deleteUserAddress";

#define screenHeight [UIScreen mainScreen].bounds.size.height
#define screenWidth [UIScreen mainScreen].bounds.size.width


@interface BaseVC : UIViewController <UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) Mother *mother;
@property (nonatomic, assign) BOOL isModify;

- (void)contentData;
@end
