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

#import "HttpTool.h"
#import "PersonalCenter.h"
#import "MeLableItem.h"
#import "HttpTool.h"
#import "PersonBase.h"
#import "Mother.h"
#import "Baby.h"

static NSString *const kToken = @"0861329c495e40c49ff973745214cb8154546556665290210768289694033397";
static NSString *const kModifyMamaHeaderImg = @"http://app.yimama.com.cn/api/mama/modifyMamaHeaderImg";
static NSString *const kModifyMamaInfo = @"http://app.yimama.com.cn/api/mama/modifyMamaInfo"; //妈妈修改信息接口
static NSString *const kModifyBabyInfo = @"http://app.yimama.com.cn/api/mama/modifyBabyInfo"; //宝宝修改信息接口
static NSString *const kGetUserInfo = @"http://app.yimama.com.cn/api/follow/getUserInfo";
static NSString *const kGetMamaInfo = @"http://app.yimama.com.cn/api/mama/getMamaInfo";
static NSString *const kRemoveBabyInfo = @"http://app.yimama.com.cn/api/mama/removeBabyInfo";
static NSString *const kPost_upload_batch = @"http:/app.yimama.com.cn/im/post_upload_batch";
static NSString *const kAddBabyInfo = @"http://app.yimama.com.cn/api/mama/addBabyInfo";
static NSString *const kListFollows = @"http://app.yimama.com.cn/api/follow/listFollows";
static NSString *const kList = @"http://app.yimama.com.cn/api/cforder/list"; //用户订单列表
static NSString *const kAddUserAddress = @"http://app.yimama.com.cn/api/adr/addUserAddress"; 

#define screenHeight [UIScreen mainScreen].bounds.size.height
#define screenWidth [UIScreen mainScreen].bounds.size.width

@interface BaseVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) Mother *mother;

- (void)contentData;
@end
