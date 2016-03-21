//
//  TestVC.m
//  TestLanding
//
//  Created by loufq on 16/3/19.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "PersonalInfoVC.h"
#import <AFNetworking/AFNetworking.h>
#import "MamaInfoCell.h"
#import "MamaAvatarCell.h"
#import "MeBabyInfoItem.h"
#import "BabyAddInfoCell.h"
#import "BabyDetailsCell.h"
#import "ModifyNameVC.h"
#import "AddBabyVC.h"
#import "BabySexVC.h"

static NSString *const kGetUserInfo = @"http://app.yimama.com.cn/api/follow/getUserInfo";
static NSString *const kGetMamaInfo = @"http://app.yimama.com.cn/api/mama/getMamaInfo";

@implementation PersonalInfoVC

- (void)contentData {
    [self.tableView registerClass:[MamaInfoCell class] forCellReuseIdentifier:@"MamaInfoCell"];
    [self.tableView registerClass:[MamaAvatarCell class] forCellReuseIdentifier:@"MamaAvatarCell"];
    [self.tableView registerClass:[BabyAddInfoCell class] forCellReuseIdentifier:@"BabyAddInfoCell"];
    [self.tableView registerClass:[BabyDetailsCell class] forCellReuseIdentifier:@"BabyDetailsCell"];
    
    NSDictionary *dict = @{
                           @"data":@{
                                   @"xuid":@"37865002-b862-11e5-b130-00163e004e00"
                                   },
                           @"header":@{
                                   @"msgId":@"ea1b5095-3a23-4ae9-97af-06a4893b5ab9",
                                   @"msgType":@"getMamaInfo",
                                   @"timestamp":@"2016-02-29 13:07:57.429",
                                   @"clientRes":@"iOS",
                                   @"token":@"2e66a5e1c29c43a3a36913a0b5daf48661874998366493504079781121225176"
                                   }
                           };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/javascript",@"application/json",@"text/json", @"text/html", nil];
    [manager POST:kGetMamaInfo parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject-%@",responseObject);
        self.dict = responseObject;
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-%@",error);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setUpMamaData];
    });
    
}

- (void)setUpMamaData {
    NSDictionary *dictData = [self.dict valueForKeyPath:@"data.mama.mamaInfo"];
    //头像
    PersonalCenter *avatar = [PersonalCenter itemWithTitle:@"头像" avatar:dictData[@"headerImg"] targrtClass:nil];
    NSArray *list1 = [NSArray new];
    list1 = @[avatar];
    
    //父母的信息
    MeLableItem *nikeNameItem = [MeLableItem itemWithTitle:@"昵称" details:dictData[@"userNick"] targrtClass:[ModifyNameVC class]];
    MeLableItem *areaItem = [MeLableItem itemWithTitle:@"区域" details:dictData[@"area"] targrtClass:nil];
    NSString *sex = [NSString stringWithFormat:@"%@",[dictData[@"gender"] isEqual: @"1"]?@"女":@"男"];
    MeLableItem *sexItem = [MeLableItem itemWithTitle:@"性别" details:sex targrtClass:[BabySexVC class]];
    MeLableItem *birthDayItem = [MeLableItem itemWithTitle:@"生日" details:dictData[@"birthday"] targrtClass:nil];
    MeLableItem *phoneItem = [MeLableItem itemWithTitle:kPhone details:dictData[@"phone"] targrtClass:nil];
    MeLableItem *signatureItem = [MeLableItem itemWithTitle:@"签名" details:dictData[@"userSig"] targrtClass:nil];
    NSArray *list2 = [NSArray new];
    list2 = @[nikeNameItem,areaItem,sexItem,birthDayItem,phoneItem,signatureItem];
    
    //宝宝信息
    PersonalCenter *babyTitle = [PersonalCenter itemWithTitle:@"宝宝信息" avatar:@"addBabyInfo" targrtClass:[AddBabyVC class]];
    NSMutableArray *babyArray = [@[] mutableCopy];
    [babyArray addObject:babyTitle];
    NSArray *babyList = [self.dict valueForKeyPath:@"data.mama.babies"];
    for (NSDictionary *dicData in babyList) {
        MeBabyInfoItem *babyInfoItem = [[MeBabyInfoItem alloc]init];
        babyInfoItem.nickName = dicData[@"babyName"];
        NSString *babySex = [NSString stringWithFormat:@"%@",[dictData[@"gender"] isEqual: @"1"]?@"男":@"女"];
        babyInfoItem.sex = babySex;
        babyInfoItem.birthday = dicData[@"birthday"];
        babyInfoItem.avatar = dicData[@"headerImg"];
        [babyArray addObject:babyInfoItem];
    }
    NSArray *list3 = [NSArray new];
    list3 = babyArray;
    
    self.data = [NSMutableArray arrayWithObjects:list1,list2,list3, nil];
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 60;
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            return 30;
        }
        return 80;
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
        MamaAvatarCell *avatarCell = [tableView dequeueReusableCellWithIdentifier:@"MamaAvatarCell"];
        avatarCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        avatarCell.avatarData = list[indexPath.row];
        return avatarCell;
    } else if (indexPath.section == 1) {
        MamaInfoCell *mamaInfoCell = [tableView dequeueReusableCellWithIdentifier:@"MamaInfoCell"];
        mamaInfoCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        mamaInfoCell.labelItem = list[indexPath.row];
        return mamaInfoCell;
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            BabyAddInfoCell *addInfoCell = [tableView dequeueReusableCellWithIdentifier:@"BabyAddInfoCell"];
            addInfoCell.babyDetails = list[0];
            return addInfoCell;
        } else {
            BabyDetailsCell *detailsCell = [tableView dequeueReusableCellWithIdentifier:@"BabyDetailsCell"];
            detailsCell.babyItem = list[indexPath.row];
            return detailsCell;
        }
    }
    
    static NSString *reuseID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsZero;
    }
    cell.textLabel.text = @"test";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *list = self.data[indexPath.section];
    id item = list[indexPath.row];
    
    UIViewController *vc = [[[item targetClass]alloc]init];
    vc.title = [item title];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
