//
//  AddAddressVC.m
//  TestLanding
//
//  Created by loufq on 16/3/22.
//  Copyright © 2016年 yeyy. All rights reserved.
//
#import <MJExtension/MJExtension.h>
#import "AddAddressVC.h"
#import "AddAddressCell.h"
#import "CityAddress.h"

static NSString *const kPro = @"http://app.yimama.com.cn/api/adr/pro";
static NSString *const kCities = @"http://app.yimama.com.cn/api/adr/cities";
static NSString *const kAreas = @"http://app.yimama.com.cn/api/adr/areas";

@interface AddAddressVC () <UIPickerViewDelegate, UIPickerViewDataSource> {
    UIView *pickerContainerView;
    UIPickerView *addressPickerView;
    NSArray *proList;
    NSMutableArray *citiesList;
    NSMutableArray *areaList;
}

@end

@implementation AddAddressVC

- (void)contentData {
    [self.tableView registerClass:[AddAddressCell class] forCellReuseIdentifier:@"AddAddressCell"];
    [self addressData];
    [self buttonLayout];
}

- (void)buttonLayout {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 5;
    button.backgroundColor = YMMNavBarColor;
    [button setTitle:@"登陆" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addressItem) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.bottom.equalTo(self.view.mas_bottom).offset(-150);
        make.right.equalTo(self.view).offset(-10);
        make.height.equalTo(@44);
    }];
}

- (void)addressItem {
    if (self.isModify == YES) {
        //这里是修改的
        [self modifyAddressItem];
    } else {
        //这里是添加的
        [self addAddressItem];
    }
}

- (void)addAddressItem {
    NSDictionary *dict = @{
                           @"data":@{
                                   @"xuid":kXuid
                                   },
                           @"header":@{
                                   @"msgId":kMsgID,
                                   @"msgType":@"addUserAddress",
                                   @"token":kToken
                                   }
                           };
    [self.manager POST:kAddUserAddress parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject-%@",responseObject);
        NSString *resultCode = responseObject[@"resultCode"];
        //如果resultCode的最后一位是0，表示返回请求成功
        if ([[resultCode substringFromIndex:resultCode.length-1] isEqual:@"0"]) {
            self.refresh();
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [self alertMessage:responseObject[@"resultMsg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-%@",error);
    }];
}

- (void)modifyAddressItem {
    NSDictionary *dict = @{
                           @"data":@{
                                       @"deliveryId":self.address.deliveryid,
                                       @"userName":self.address.fullname,
                                       @"mobliePhone":self.address.mobliePhone,
                                       @"postCode":self.address.postCode,
                                       @"addressDetail":self.address.street,
                                       @"deliveryId":self.address.deliveryid,
                                       @"provCode":self.address.provCode,
                                       @"cityCode":self.address.cityCode,
                                       @"areaCode":self.address.areaCode
                                   },
                           @"header":@{
                                       @"msgId":self.address.xuid,
                                       @"msgType":@"modifyUserAddress",
                                       @"token":kToken
                                   }
                           };
    [self.manager POST:kUpdateUserAddress parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject-%@",responseObject);
        NSString *resultCode = responseObject[@"resultCode"];
        //如果resultCode的最后一位是0，表示返回请求成功
        if ([[resultCode substringFromIndex:resultCode.length-1] isEqual:@"0"]) {
            self.refresh();
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [self alertMessage:responseObject[@"resultMsg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-%@",error);
    }];
}

- (void)addressData {
    //判断，转进去的如果是空的就显示占位符的
    //不是空的，就是修改的，占位符要换成传进来的值
    PersonalCenter *name = [PersonalCenter itemWithTitle:@"姓名" placeholder:self.isModify == isYES ? self.address.fullname : @"请输入姓名"];
    name.isModify = self.isModify;
    PersonalCenter *phone = [PersonalCenter itemWithTitle:@"手机" placeholder:self.isModify == isYES ? self.address.mobliePhone : @"请输入手机"];
    phone.isModify = self.isModify;
    PersonalCenter *postCode = [PersonalCenter itemWithTitle:@"邮票" placeholder:self.isModify == isYES ? self.address.postCode : @"请输入邮票"];
    postCode.isModify = self.isModify;
    NSString *cityString = [NSString stringWithFormat:@"%@ %@ %@",self.address.prov,self.address.city,self.address.areaname];
    PersonalCenter *city = [PersonalCenter itemWithTitle:@"省市区" placeholder:self.isModify == isYES ? cityString : @"请选择"];
    city.isModify = self.isModify;
    PersonalCenter *address = [PersonalCenter itemWithTitle:@"详细地址" placeholder:self.isModify == isYES ? self.address.street : @"请输入详细地址"];
    address.isModify = self.isModify;
    self.data = [NSMutableArray arrayWithObjects:name,phone,postCode,city,address, nil];
}

- (void)title:(NSString *)title text:(NSString *)text {
    PersonalCenter *name = [PersonalCenter itemWithTitle:title placeholder:text];
    name.isModify = self.isModify;
    [self.data addObject:name];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddAddressCell"];
    cell.personalCenter = self.data[indexPath.row];
    cell.value = ^(NSString *value){
        [self row:indexPath.row value:value];
    };
    return cell;
}

- (void)row:(NSInteger)row value:(NSString *)value {
    switch (row) {
        case 0:
            self.address.fullname = value;
            break;
        case 1:
            self.address.mobliePhone = value;
            break;
        case 2:
            self.address.postCode = value;
            break;
        case 3:
//            self.item.area = textField.text;
            break;
        case 4:
            self.address.street = value;
            break;
            
        default:
            break;
    }
    [self.data addObject:self.address];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3) {
        [self pickerMyAddress];
        [self.view endEditing:YES];
    }
}

- (void)pickerMyAddress{
    
    if (addressPickerView == nil) {
        [self drawPickerView];
        proList = [NSArray new];
        citiesList = @[].mutableCopy;
        areaList = @[].mutableCopy;
        [self loadProvinceInfoFromServer];
        [self loadCitiesInfoFromServer];
        [self loadAreaInfoFromServer];
    }
    if (pickerContainerView.hidden == YES) {
        pickerContainerView.hidden = NO;
    } else {
        pickerContainerView.hidden = YES;
    }
}

- (void)drawPickerView{
    pickerContainerView = [UIView new];
    pickerContainerView.hidden = YES;
    pickerContainerView.backgroundColor = FGTableBgGrayColor;
    pickerContainerView.layer.borderWidth = 1;
    if ([self isKindOfClass:[UITableViewController class]] && self.navigationController) {
        [self.navigationController.view addSubview:pickerContainerView];
    } else{
        [self.view addSubview:pickerContainerView];
    }
    [pickerContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@250);
    }];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    targerTapped(cancelBtn, cancelBtnTapped);
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelBtn.frame = CGRectMake(10, 5, 60, 40);
    [pickerContainerView addSubview:cancelBtn];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    sureBtn.frame = CGRectMake(SCREEN_WIDTH-60-10, 5, 60, 40);
    [pickerContainerView addSubview:sureBtn];
    
    addressPickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 200)];
    addressPickerView.layer.borderWidth = 1;
    addressPickerView.dataSource = self;
    addressPickerView.delegate = self;
    [pickerContainerView addSubview:addressPickerView];
    [addressPickerView reloadAllComponents];
    
}

- (void)cancelBtnTapped {
    pickerContainerView.hidden = YES;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return proList.count;
    } else if (component == 1) {
        return citiesList.count;
    } else {
        return areaList.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    CityAddress *city;
    if (component == 0) {
        city = proList[row];
    } else if (component == 1) {
        city = citiesList[row];
    } else if (component == 2) {
        city = areaList[row];
    }
    return city.name;
}

- (void)loadProvinceInfoFromServer {
    NSDictionary *dict = @{
                           @"data":@{
                                   },
                           @"header":@{
                                   @"msgId":kMsgID,
                                   @"msgType":@"fetchProvince",
                                   @"token":kToken
                                   }
                           };
//    [self url:kPro path:@"data.proList" dict:dict array:proList];
    [self.manager POST:kPro parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *resultCode = responseObject[@"resultCode"];
        //如果resultCode的最后一位是0，表示返回请求成功
        if ([[resultCode substringFromIndex:resultCode.length-1] isEqual:@"0"]) {
            proList = [responseObject valueForKeyPath:@"data.proList"];
            proList = [CityAddress mj_objectArrayWithKeyValuesArray:proList];
        } else {
            [self alertMessage:responseObject[@"resultMsg"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-%@",error);
    }];
}

- (void)loadCitiesInfoFromServer {
    NSDictionary *dict = @{
                           @"data":@{
                                   @"addressCode":self.address.provCode,
                                   },
                           @"header":@{
                                   @"msgId":kMsgID,
                                   @"msgType":@"fetchCity",
                                   @"token":kToken
                                   }
                           };
    [self.manager POST:kCities parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *resultCode = responseObject[@"resultCode"];
        //如果resultCode的最后一位是0，表示返回请求成功
        if ([[resultCode substringFromIndex:resultCode.length-1] isEqual:@"0"]) {
            citiesList = [[CityAddress mj_objectArrayWithKeyValuesArray:[responseObject valueForKeyPath:@"data.citiesList"]] mutableCopy];
        } else {
            [self alertMessage:responseObject[@"resultMsg"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-%@",error);
    }];
}

- (void)loadAreaInfoFromServer {
    NSDictionary *dict = @{
                           @"data":@{
                                   @"addressCode":self.address.provCode,
                                   @"provCode":self.address.provCode,
                                   @"cityCode":self.address.cityCode
                                   },
                           @"header":@{
                                   @"msgId":kMsgID,
                                   @"msgType":@"fetchDistrict",
                                   @"token":kToken
                                   }
                           };
    [self.manager POST:kAreas parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *resultCode = responseObject[@"resultCode"];
        //如果resultCode的最后一位是0，表示返回请求成功
        if ([[resultCode substringFromIndex:resultCode.length-1] isEqual:@"0"]) {
            areaList = [[CityAddress mj_objectArrayWithKeyValuesArray:[responseObject valueForKeyPath:@"data.areasList"]] mutableCopy];
        } else {
            [self alertMessage:responseObject[@"resultMsg"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-%@",error);
    }];
}

- (void)url:(NSString *)url path:(NSString *)path dict:(NSDictionary *)dict array:(NSArray *)array {
    __block NSArray *arrayData = array;
    [self.manager POST:url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject-%@",responseObject);
        NSString *resultCode = responseObject[@"resultCode"];
        //如果resultCode的最后一位是0，表示返回请求成功
        if ([[resultCode substringFromIndex:resultCode.length-1] isEqual:@"0"]) {
            arrayData = [responseObject valueForKeyPath:path];
        } else {
            [self alertMessage:responseObject[@"resultMsg"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-%@",error);
    }];
}

//失败就弹出框，提示错误信息
- (void)alertMessage:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
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
