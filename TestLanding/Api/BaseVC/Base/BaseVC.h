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

#import "PersonalCenter.h"
#import "MeLableItem.h"
#import "HttpTool.h"
#import "MeGroup.h"
#import "PersonBase.h"
#import "Mother.h"
#import "Baby.h"

static NSString *const kToken = @"d9aea78e210249c08c928d12e1bcc7ec96078720425870911543459616944626";
static NSString *const kModifyMamaInfo = @"http://app.yimama.com.cn/api/mama/modifyMamaInfo";

@interface BaseVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *data;
- (void)contentData;
@end
