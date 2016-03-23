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

#import "ConstMacro.h"
#import "HttpTool.h"
#import "PersonalCenter.h"
#import "MeLableItem.h"
#import "HttpTool.h"
#import "PersonBase.h"
#import "Mother.h"
#import "Baby.h"
#import "Gender.h"


static NSString *const kToken = @"55cef3b35ae945e2bce16e1ba0544b1428911520457339080863123031971765";
static NSString *const kXuid = @"37865002-b862-11e5-b130-00163e004e00";
static NSString *const kMsgID = @"ea1b5095-3a23-4ae9-97af-06a4893b5ab9";

static NSString *const kModifyMamaHeaderImg = @"http://app.yimama.com.cn/api/mama/modifyMamaHeaderImg";
static NSString *const kModifyMamaInfo = @"http://app.yimama.com.cn/api/mama/modifyMamaInfo"; //妈妈修改信息接口
static NSString *const kModifyBabyInfo = @"http://app.yimama.com.cn/api/mama/modifyBabyInfo"; //宝宝修改信息接口
static NSString *const kGetMamaInfo = @"http://app.yimama.com.cn/api/mama/getMamaInfo";
static NSString *const kAddBabyInfo = @"http://app.yimama.com.cn/api/mama/addBabyInfo";
static NSString *const kRemoveBabyInfo = @"http://app.yimama.com.cn/api/mama/removeBabyInfo";
static NSString *const kGetUserInfo = @"http://app.yimama.com.cn/api/follow/getUserInfo";
static NSString *const kListFollows = @"http://app.yimama.com.cn/api/follow/listFollows";
static NSString *const kList = @"http://app.yimama.com.cn/api/cforder/list"; //用户订单列表
static NSString *const kPost_upload_batch = @"http:/app.yimama.com.cn/im/post_upload_batch";
static NSString *const kUserAddressList = @"http://app.yimama.com.cn/api/adr/userAddressList";
static NSString *const kAddUserAddress = @"http://app.yimama.com.cn/api/adr/addUserAddress";
static NSString *const kUpdateUserAddress = @"http://app.yimama.com.cn/api/adr/updateUserAddress";

#define screenHeight [UIScreen mainScreen].bounds.size.height
#define screenWidth [UIScreen mainScreen].bounds.size.width

@interface BaseVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) Mother *mother;

- (void)contentData;
@end
