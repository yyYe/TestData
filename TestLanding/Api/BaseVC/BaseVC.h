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

@interface BaseVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *data;
- (void)contentData;
@end
