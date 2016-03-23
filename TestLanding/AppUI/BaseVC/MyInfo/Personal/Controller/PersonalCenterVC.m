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
#import "PersonalInfoVC.h"
#import "MyOrderVC.h"
#import "PersonalCenterCell.h"
#import "PersonalInfoCell.h"

#import "PersonalCenter.h"
#import "HttpTool.h"
#import "MeInfoItem.h"

@interface PersonalCenterVC ()

@end

@implementation PersonalCenterVC

- (void)contentData {
    [self.tableView registerClass:[PersonalCenterCell class] forCellReuseIdentifier:@"PersonalCenterCell"];
    [self.tableView registerClass:[PersonalInfoCell class] forCellReuseIdentifier:@"PersonalInfoCell"];
    [self fetchUserInfo];
}

- (void)fetchUserInfo {
    
    NSDictionary *dict = @{
                           @"data":@{
                                   @"xuid":@"37865002-b862-11e5-b130-00163e004e00",
                                   @"headerImg":@"3"
                                   },
                           @"header":@{
                                   @"msgId":@"ea1b5095-3a23-4ae9-97af-06a4893b5ab9",
                                   @"msgType":@"getMamaInfo",
                                   @"token":kToken
                                   }
                           };
    
    [self.manager POST:kGetMamaInfo parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject-%@",responseObject);
        NSDictionary *mamaData = [responseObject valueForKeyPath:@"data.mama.mamaInfo"];
        NSDictionary *babyData = [[responseObject valueForKeyPath:@"data.mama.babies"] lastObject];
        MeInfoItem *infoItem = [MeInfoItem new];
        infoItem.avatar = mamaData[@"headerImg"];
        infoItem.levelName = mamaData[@"rankTitle"];
        infoItem.introduction = mamaData[@"userSig"];
        infoItem.babyName = babyData[@"babyName"];
        infoItem.age = babyData[@"babyAgeDesc"];
        [self setupData:infoItem];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-%@",error);
    }];
}

- (void)setupData:(MeInfoItem *)infoItem {
    infoItem.targetClass = [PersonalInfoVC class];
    NSArray *list1 = [NSArray new];
    list1 = @[infoItem];
    
    PersonalCenter *myWork = [PersonalCenter itemWithIcon:@"myWork" title:@"我的作品" targrtClass:nil];
    myWork.needToken = YES;
    PersonalCenter *myOrder = [PersonalCenter itemWithIcon:@"myOrder" title:@"我的订单" targrtClass:[MyOrderVC class]];
    myOrder.needToken = YES;
    PersonalCenter *myAddress = [PersonalCenter itemWithIcon:@"myAddress" title:@"我的地址" targrtClass:nil];
    myAddress.needToken = YES;
    PersonalCenter *myZone = [PersonalCenter itemWithIcon:@"myZone" title:@"我的空间" targrtClass:nil];
    myZone.needToken = YES;
    PersonalCenter *myLoveCoin = [PersonalCenter itemWithIcon:@"myLoveCoin" title:@"我的爱心币" targrtClass:nil];
    myLoveCoin.needToken = YES;
    PersonalCenter *help = [PersonalCenter itemWithIcon:@"help" title:@"帮助反馈" targrtClass:nil];
    PersonalCenter *settings = [PersonalCenter itemWithIcon:@"settings" title:@"设置" targrtClass:nil];
    NSArray *list2 = [NSArray new];
    list2 = @[myWork,myOrder,myAddress,myZone,myLoveCoin,help,settings];
    
    self.data = [NSMutableArray arrayWithObjects:list1,list2, nil];
    [self.tableView reloadData];
}

#pragma mark UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 90;
    }
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *list = self.data[section];
    return list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *list = self.data[indexPath.section];
    if (indexPath.section == 0) {
        PersonalInfoCell *infoCell = [tableView dequeueReusableCellWithIdentifier:@"PersonalInfoCell"];
        infoCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        infoCell.infoItem = list[indexPath.row];
        return infoCell;
    } else {
        PersonalCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonalCenterCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.personal = list[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *list = self.data[indexPath.section];
    id item = list[indexPath.row];
    
    UIViewController *vc = [[[item targetClass]alloc]init];
    vc.title = [item title];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
