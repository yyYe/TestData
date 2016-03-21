//
//  LoginSuccessVC.m
//  TestLanding
//
//  Created by loufq on 16/3/19.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <Masonry/Masonry.h>

#import "PersonalCenterVC.h"
#import "PersonalCenter.h"
#import "MeGroup.h"
#import "PersonalCenterCell.h"
#import "PersonalInfoVC.h"
#import "HttpTool.h"

static NSString *const kListFollows = @"http://app.yimama.com.cn/api/follow/listFollows";
static NSString *const kGetUserInfo = @"http://app.yimama.com.cn/api/follow/getUserInfo";

@interface PersonalCenterVC () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation PersonalCenterVC

- (NSMutableArray *)data{
    if (_data == nil) {
        _data = [@[] mutableCopy];
    }
    
    return _data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableViewLayout];
    [self setupData];
    [self fetchUserInfo];
}

- (void)tableViewLayout {
    UITableView *tableView = [UITableView new];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [tableView registerClass:[PersonalCenterCell class] forCellReuseIdentifier:@"PersonalCenterCell"];
}

- (void)fetchUserInfo {
    NSDictionary *dict = @{
                           @"data":@{
                                   @"pageNo":@1,
                                   @"pageSize":@10,
                                   @"tid":@53
                                   },
                           @"header":@{
                                   @"msgId":@"ea1b5095-3a23-4ae9-97af-06a4893b5ab9",
                                   @"msgType":@"listFollows",
                                   @"timestamp":@"2015-12-29 13:07:57.429",
                                   @"clientRes":@"iOS"
                                   }
                           };
    [HttpTool postWithURL:kListFollows params:dict success:^(id json) {
        NSLog(@"responseObject-%@",json);
    } failure:^(NSString *errorMsg, NSString *statusCode) {
        NSLog(@"error-%@",errorMsg);
    }];
    
}

- (void)setupData{
    
    PersonalCenter *myWork = [PersonalCenter itemWithIcon:@"myWork" title:@"我的作品" targrtClass:[PersonalInfoVC class]];
    myWork.needToken = YES;
    PersonalCenter *myOrder = [PersonalCenter itemWithIcon:@"myOrder" title:@"我的订单" targrtClass:nil];
    myOrder.needToken = YES;
    PersonalCenter *myAddress = [PersonalCenter itemWithIcon:@"myAddress" title:@"我的地址" targrtClass:nil];
    myAddress.needToken = YES;
    PersonalCenter *myZone = [PersonalCenter itemWithIcon:@"myZone" title:@"我的空间" targrtClass:nil];
    myZone.needToken = YES;
    PersonalCenter *myLoveCoin = [PersonalCenter itemWithIcon:@"myLoveCoin" title:@"我的爱心币" targrtClass:nil];
    myLoveCoin.needToken = YES;
    PersonalCenter *help = [PersonalCenter itemWithIcon:@"help" title:@"帮助反馈" targrtClass:nil];
    PersonalCenter *settings = [PersonalCenter itemWithIcon:@"settings" title:@"设置" targrtClass:nil];

    self.data = [NSMutableArray arrayWithObjects:myWork,myOrder,myAddress,myZone,myLoveCoin,help,settings, nil];
    
}

- (void)mamaInfo {
    
    NSDictionary *dict = @{
                           @"data":@{
                                   @"pageNo":@1,
                                   @"pageSize":@10,
                                   @"tid":self.userID
                                   },
                           @"header":@{
                                   @"msgId":@"ea1b5095-3a23-4ae9-97af-06a4893b5ab9",
                                   @"msgType":@"getUserInfo",
                                   @"timestamp":@"2016-02-29 13:07:57.429",
                                   @"clientRes":@"iOS",
                                   @"token":self.token
                                   }
                           };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/javascript",@"application/json",@"text/json", @"text/html", nil];
    [manager POST:kGetUserInfo parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject-%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-%@",error);
    }];
    //    [HttpTool postWithURL:kGetUserInfo params:dict success:^(id json) {
    //        NSLog(@"responseObject-%@",json);
    //    } failure:^(NSString *errorMsg, NSString *statusCode) {
    //        NSLog(@"error-%@",errorMsg);
    //    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonalCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonalCenterCell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.personalCenter = self.data[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    id item = self.data[indexPath.row];
    
    UIViewController *vc = [[[item targetClass]alloc]init];
    vc.title = [item title];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
