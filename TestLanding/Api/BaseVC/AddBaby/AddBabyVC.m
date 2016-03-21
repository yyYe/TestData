//
//  AddBabyVC.m
//  TestLanding
//
//  Created by loufq on 16/3/20.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "AddBabyVC.h"
#import "MamaAvatarCell.h"
#import "ModifyNameVC.h"
#import "MamaInfoCell.h"
#import "BabySexVC.h"

static NSString *const kAddBabyInfo = @"http://app.yimama.com.cn/api/mama/addBabyInfo";

@implementation AddBabyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavLeftBtnWithTitle:@"个人信息"];
}

- (void)contentData {
    [self.tableView registerClass:[MamaAvatarCell class] forCellReuseIdentifier:@"MamaAvatarCell"];
    [self.tableView registerClass:[MamaInfoCell class] forCellReuseIdentifier:@"MamaInfoCell"];
    
    self.title = @"新增宝宝信息";
    
    PersonalCenter *avatar = [PersonalCenter itemWithTitle:@"头像" avatar:@"default-avatar" targrtClass:nil];
    NSArray *list1 = [NSArray new];
    list1 = @[avatar];
    
    MeLableItem *nikeNameItem = [MeLableItem itemWithTitle:@"昵称" details:@"" targrtClass:[ModifyNameVC class]];
//    NSString *sex = [NSString stringWithFormat:@"%@",[dictData[@"gender"] isEqual: @"1"]?@"女":@"男"];
    MeLableItem *sexItem = [MeLableItem itemWithTitle:@"性别" details:@"小公举" targrtClass:[BabySexVC class]];
    MeLableItem *birthDayItem = [MeLableItem itemWithTitle:@"生日" details:@"" targrtClass:nil];
    NSArray *list2 = [NSArray new];
    list2 = @[nikeNameItem,sexItem,birthDayItem];
    self.data = [NSMutableArray arrayWithObjects:list1,list2, nil];
}

- (void)rightBtnAction {
    NSDictionary *dict = @{
                           @"data":@{
                                   @"xuid":@"37865002-b862-11e5-b130-00163e004e00",
                                   @"babyName":@"test"
                                   },
                           @"header":@{
                                   @"msgType":@"addBabyInfo",
                                   @"timestamp":@"2016-02-29 13:07:57.429",
                                   @"clientRes":@"iOS",
                                   @"token":@"2e66a5e1c29c43a3a36913a0b5daf48661874998366493504079781121225176"
                                   }
                           };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/javascript",@"application/json",@"text/json", @"text/html", nil];
    [manager POST:kAddBabyInfo parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject-%@",responseObject);
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-%@",error);
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 60;
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
    }
    
    static NSString *reuseID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
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