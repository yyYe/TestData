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


@interface MyAddressVC ()
@property (nonatomic, strong) MyAddress *address;

@end

@implementation MyAddressVC

- (void)contentData {
    self.tableView.layer.borderColor = [UIColor grayColor].CGColor;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.bottom.equalTo(self.view).offset(-50);
    }];
    [self.tableView registerClass:[MyAddressCell class] forCellReuseIdentifier:@"MyAddressCell"];
    [self buttonLayout];
    [self addAddressInfo];
}

- (void)addAddressInfo {
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
            self.address.deliveryid = data[@"deliveryid"];
            self.address.defaultAddress = [data[@"defaultdeliveraddress"] isEqual: @"1"] ? YES : NO ;
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

- (void)defaultAddress:(NSInteger)row {
    self.address = [MyAddress new];
    self.address = self.data[row];
    NSDictionary *dict = @{
                           @"data":@{
                                   @"deliveryId":self.address.deliveryid,
                                   @"xuid":self.address.xuid
                                   },
                           @"header":@{
                                   @"clientRes":@"iOS",
                                   @"msgId":@"9667B374-7534-4479-8394-C4C9A7EECB3B",
                                   @"timestamp":@"2016-03-23 15:42:56",
                                   @"msgType":@"setDefaultAddress",
                                   @"token":kToken
                                   }
                           };
    
    [self.manager POST:kDefaultUserAddress parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject-%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-%@",error);
    }];
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
        addVC.isModify = isYES;
        addVC.address = self.data[row];
    } else {
        addVC.isModify = isNO;
    }
    addVC.refresh = ^(){
        [self addAddressInfo];
    };
    [self.navigationController pushViewController:addVC animated:YES];
}

#pragma mark UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSArray *list = self.data[indexPath.section];
    MyAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyAddressCell"];
    cell.address = self.data[indexPath.section];
    cell.defaultTapped = ^(){
        [self defaultAddress:indexPath.section];
    };
    cell.edit = ^(){
        [self buttonTapped:YES row:indexPath.section];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self buttonTapped:YES row:indexPath.section];
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
