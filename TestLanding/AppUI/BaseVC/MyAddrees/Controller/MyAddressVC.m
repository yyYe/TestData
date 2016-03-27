//
//  MyAddressVC.m
//  TestLanding
//
//  Created by loufq on 16/3/22.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "MyAddressVC.h"
#import "AddAddressVC.h"
#import "MyAddressCell.h"
#import "MyAddress.h"
#import "MyAddressFrame.h"

@interface MyAddressVC ()
@property (nonatomic, strong) MyAddress *address;

@end

@implementation MyAddressVC

- (void)contentData {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-50);
    }];
    [self.tableView registerClass:[MyAddressCell class] forCellReuseIdentifier:@"MyAddressCell"];
    [self buttonLayout];
    [self getAddressInfo];
}

- (void)getAddressInfo {
    NSDictionary *dict = @{
                           @"data":@{
                                       @"xuid":kXuid,
                                   },
                           @"header":@{
                                       @"msgId":kMsgID,
                                       @"msgType":@"userAddressList",
                                       @"token":kToken
                                   }
                           };
    
    [self.manager POST:kUserAddressList parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject-%@",responseObject);
        NSArray *list = [responseObject valueForKeyPath:@"data.addressList"];
        self.data = [@[] mutableCopy];
        for (NSDictionary *data in list) {
            self.address = [MyAddress new];
            self.address.fullname = data[@"fullname"];
            self.address.mobliePhone = data[@"mobilephone"];
//            long num = [[data valueForKey:@"deliveryid"] longValue];
//            NSNumber *number = [NSNumber numberWithLong:num];
            self.address.deliveryid = [(NSNumber*)data[@"deliveryid"] stringValue];
            self.address.defaultAddress = [data[@"defaultdeliveraddress"] isEqual: @"0"] ? YES : NO;
            self.address.prov = data[@"prov"];
            self.address.city = data[@"city"];
            self.address.areaname = data[@"areaname"];
            self.address.street = data[@"address"];
            self.address.postCode = data[@"postCode"];
            self.address.provCode = data[@"provCode"];
            self.address.cityCode = data[@"cityCode"];
            self.address.areaCode = data[@"areaCode"];
            self.address.xuid = data[@"xuid"];
//            self.address.msgID = data[@"msgId"];
            [self.data addObject:self.address];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-%@",error);
    }];
}

- (void)setDefaultAddress:(NSInteger)row {
    self.address = self.data[row];
    NSDictionary *dict = @{
                           @"data":@{
                                   @"deliveryId":self.address.deliveryid,
                                   },
                           @"header":@{
                                   @"clientRes":@"iOS",
                                   @"msgId":@"9667B374-7534-4479-8394-C4C9A7EECB3B",
                                   @"timestamp":@"2016-03-25 23:21:09.000",
                                   @"msgType":@"setDefaultAddress",
                                   @"token":kToken
                                   }
                           };
    
    [self.manager POST:kDefaultUserAddress parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //返回成功了，就给他刷新，失败就提示失败信息
        NSString *resultCode = responseObject[@"resultCode"];
        //如果resultCode的最后一位是0，表示返回请求成功
        if ([[resultCode substringFromIndex:resultCode.length-1] isEqual:@"0"]) {
//            [self getAddressInfo];
            [self.tableView reloadData];
        } else {
            [self alertMessage:responseObject[@"resultMsg"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-%@",error);
    }];
}

- (void)alertMessage:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)buttonLayout {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 22;
    button.backgroundColor = YMMNavBarColor;
    [button setTitle:@"添加新地址" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonTapped:row:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-5);
        make.width.equalTo(@150);
        make.height.equalTo(@44);
    }];
}

- (void)buttonTapped:(BOOL)yes row:(NSInteger)row {
    AddAddressVC *addVC = [AddAddressVC new];
    if (yes == isYES) {
        addVC.isModify = YES;
        addVC.address = self.data[row];
    } else {
        addVC.isModify = NO;
    }
    addVC.refresh = ^(){
        [self getAddressInfo];
    };
    [self.navigationController pushViewController:addVC animated:YES];
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyAddressFrame *frame = [MyAddressFrame new];
    frame.item = self.data[indexPath.row];
    return frame.cellHeight;
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSArray *list = self.data[indexPath.section];
    MyAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyAddressCell"];
    cell.address = self.data[indexPath.row];
    cell.defaultTapped = ^(){
        [self setDefaultAddress:indexPath.row];
    };
    cell.edit = ^(){
        [self buttonTapped:YES row:indexPath.row];
    };
    cell.deleteTapped = ^(){
        [self alertDeleteAddress:indexPath.row];
    };
    return cell;
}

- (void)alertDeleteAddress:(NSInteger)row {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"你确定要删除?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *cameraActon = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self deleteAddressData:row];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:cameraActon];
    [self presentViewController:alertController animated:YES completion:nil];

}

- (void)deleteAddressData:(NSInteger)index{
//    self.address = [MyAddress new];
    self.address = self.data[index];
    NSDictionary *dict = @{
                           @"data":@{
                                   @"deliveryId":self.address.deliveryid
                                   },
                           @"header":@{
//                                   @"msgId":kMsgID,
                                   @"msgType":@"deleteUserAddress",
                                   @"timestamp":@"2016-03-24 23:24:41.000",
                                   @"token":kToken
                                   }
                           };
    
    [self.manager POST:kDeleteUserAddress parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject-%@",responseObject);
        [self getAddressInfo];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
