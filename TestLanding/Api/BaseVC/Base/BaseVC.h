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
#import "MeGroup.h"
#import "PersonBase.h"
#import "Mother.h"
#import "Baby.h"

static NSString *const kToken = @"a68e58ae97ef410d9d730d8618b4af8d95789903638697255885331133727644";
static NSString *const kModifyMamaInfo = @"http://app.yimama.com.cn/api/mama/modifyMamaInfo"; //妈妈修改信息接口
static NSString *const kModifyBabyInfo = @"http://app.yimama.com.cn/api/mama/modifyBabyInfo"; //宝宝修改信息接口

#define screenHeight [UIScreen mainScreen].bounds.size.height
#define screenWidth [UIScreen mainScreen].bounds.size.width

@interface BaseVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) Mother *mother;

- (void)contentData;
@end
