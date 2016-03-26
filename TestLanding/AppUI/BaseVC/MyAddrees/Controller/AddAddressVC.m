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

typedef enum {
    VCTypeAddAddress,
    VCTypeModifyAddress
}AddressVCType;

static NSString *const kPro = @"http://app.yimama.com.cn/api/adr/pro";
static NSString *const kCities = @"http://app.yimama.com.cn/api/adr/cities";
static NSString *const kAreas = @"http://app.yimama.com.cn/api/adr/areas";

@interface AddAddressVC () <UIPickerViewDelegate, UIPickerViewDataSource> {
    UIView *pickerContainerView;
    UIPickerView *addressPickerView;
    NSArray *proList;
    NSMutableArray *citiesList;
    NSMutableArray *areaList;
    NSString *proCode;
    NSString *cityCode;
    NSString *areaCode;
}

@property (nonatomic, strong) MyAddress *oldItem;
@property (nonatomic, assign) AddressVCType type;

@end

@implementation AddAddressVC

- (void)contentData {
    [self.tableView registerClass:[AddAddressCell class] forCellReuseIdentifier:@"AddAddressCell"];
    
    [self addressData];
    [self buttonLayout];
}

- (void)setupOldItem{ //保存地址更改前信息
    self.oldItem = [MyAddress new];
    self.oldItem.fullname = self.address.fullname;
    self.oldItem.mobliePhone = self.address.mobliePhone;
    self.oldItem.postCode = self.address.postCode;
    self.oldItem.prov = self.address.prov;
    self.oldItem.city = self.address.city;
    self.oldItem.areaname = self.address.areaname;
    self.oldItem.street = self.address.street;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    if (self.type == VCTypeModifyAddress && !self.isModify) {
        //取消修改，数据还原
        self.address.fullname = self.oldItem.fullname;
        self.address.mobliePhone = self.oldItem.mobliePhone;
        self.address.postCode = self.oldItem.postCode;
        self.address.prov = self.oldItem.prov;
        self.address.city = self.oldItem.city;
        self.address.areaname = self.oldItem.areaname;
        self.address.street = self.oldItem.street;
    }
}

- (void)buttonLayout {
    UIView *footView = [UIView new];
    footView.backgroundColor = [UIColor clearColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 5;
    button.backgroundColor = YMMNavBarColor;
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addressItem) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:button];
    NSInteger btnL = 20;
    NSInteger btnR = -20;
    NSInteger btnT = 20;
    NSInteger btnH = 44;
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footView).offset(btnL);
        make.centerY.equalTo(footView);
        make.right.equalTo(footView).offset(btnR);
        make.height.equalTo(@(btnH));
    }];
    
    footView.frame = CGRectMake(0, 0, 0, btnT*2+btnH);
    self.tableView.tableFooterView = footView;
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
                                   @"userName":self.address.fullname,
                                   @"mobliePhone":self.address.mobliePhone,
                                   @"postCode":self.address.postCode,
                                   @"addressDetail":self.address.street,
                                   @"provCode":proCode,
                                   @"cityCode":cityCode,
                                   @"areaCode":areaCode
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

- (void)rightBtnAction{
    self.address = [MyAddress new];
    
    for (PersonalCenter *item in self.data) {
        item.text = nil;
    }
    [self.tableView reloadData];
    addressPickerView.hidden = YES;
}

- (void)modifyAddressItem {
    NSDictionary *dict = @{
                           @"data":@{
                                       @"deliveryId":self.address.deliveryid,
                                       @"userName":self.address.fullname,
                                       @"mobliePhone":self.address.mobliePhone,
                                       @"postCode":self.address.postCode,
                                       @"addressDetail":self.address.street,
                                       @"provCode":proCode,
                                       @"cityCode":cityCode,
                                       @"areaCode":areaCode
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
    if (self.address) {
        self.title = @"修改地址";
        self.type = VCTypeModifyAddress;
        proCode = self.address.provCode;
        cityCode = self.address.cityCode;
        areaCode = self.address.areaCode;
        [self setupNavRightBtnWithTitle:nil];
        [self setupOldItem];
    } else{
        self.title = @"新增地址";
        self.type = VCTypeAddAddress;
        self.address = [MyAddress new];
        [self setupNavRightBtnWithTitle:@"清空"];
    }
    //判断，转进去的如果是空的就显示占位符的
    //不是空的，就是修改的，占位符要换成传进来的值
    PersonalCenter *name = [PersonalCenter itemWithTitle:kNameTitle text:self.address.fullname placeholder:@"请输入姓名"];
    name.isModify = self.isModify;
    PersonalCenter *phone = [PersonalCenter itemWithTitle:kPhoneTitle text:self.address.mobliePhone placeholder:@"请输入手机"];
    phone.isModify = self.isModify;
    PersonalCenter *postCode = [PersonalCenter itemWithTitle:kZipCodeTitle text:self.address.postCode placeholder:@"请输入邮票"];
    postCode.isModify = self.isModify;
    NSString *cityString = [NSString stringWithFormat:@"%@ %@ %@",self.address.prov,self.address.city,self.address.areaname];
    if ([cityString isEqualToString:@"(null) (null) (null)"]) {
        cityString = nil;
    }
    PersonalCenter *city = [PersonalCenter itemWithTitle:kAreaTitle text:cityString placeholder:@"请选择"];
    city.isModify = self.isModify;
    PersonalCenter *address = [PersonalCenter itemWithTitle:@"详细地址" text:self.address.street placeholder:@"请输入详细地址"];
    address.isModify = self.isModify;
    self.data = [NSMutableArray arrayWithObjects:name,phone,postCode,city,address, nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddAddressCell"];
    cell.personal = self.data[indexPath.row];
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
//            self.address.areaname = value;
            break;
        case 4:
            self.address.street = value;
            break;
            
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3) {
        [self pickerMyAddress];
        self.addressIndexPath = indexPath;
        [self.view endEditing:YES];
    }
}

- (void)pickerMyAddress{
    
    if (addressPickerView == nil) {
        [self drawPickerView];
        proList = [NSArray new];
        citiesList = @[].mutableCopy;
        areaList = @[].mutableCopy;
        proCode = @"110000"; //北京编码
        cityCode = @"110100"; //北京市
        areaCode = @"110101"; //东城区
        [self loadProvinceInfoFromServer];
        [self loadCitiesInfoFromServer:nil];
        [self loadAreaInfoFromServer:nil];
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
    targerTapped(sureBtn, sureBtnTapped);
    [pickerContainerView addSubview:sureBtn];
    
    addressPickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 200)];
    addressPickerView.layer.borderWidth = 1;
    addressPickerView.dataSource = self;
    addressPickerView.delegate = self;
    [pickerContainerView addSubview:addressPickerView];
    
}

- (void)cancelBtnTapped {
    pickerContainerView.hidden = YES;
}

- (void)sureBtnTapped {
    pickerContainerView.hidden = YES;
}

#pragma mark UIPickerViewDataSource

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

#pragma mark UIPickerViewDelegate
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

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        CityAddress *prov = proList[row];
        proCode = prov.code;
        [self loadCitiesInfoFromServer:^{
            
            [pickerView reloadComponent:1];
            [pickerView selectRow:0 inComponent:1 animated:YES];
            
            CityAddress *city = citiesList[0];
            cityCode = city.code;
            
            [self loadAreaInfoFromServer:^{
                [pickerView reloadComponent:2];
                [pickerView selectRow:0 inComponent:2 animated:YES];
                
                CityAddress *area = areaList[0];
                areaCode = area.code;
            }];
        }];
        [self selectedAddressAtPickerView:pickerView];
    }
    else if (component == 1) {
        CityAddress *city = citiesList[row];
        cityCode = city.code;
        [self loadAreaInfoFromServer:^{
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:YES];
            CityAddress *area = areaList[0];
            areaCode = area.code;
        }];
        [self selectedAddressAtPickerView:pickerView];
    }
    else {
        CityAddress *area = areaList[row];
        areaCode = area.code;
        [self selectedAddressAtPickerView:pickerView];
    }
}

/**  获取选中的地址   */
- (void)selectedAddressAtPickerView:(UIPickerView *)pickerView{
    NSInteger provinceRow = [pickerView selectedRowInComponent:0];
    NSInteger cityRow = [pickerView selectedRowInComponent:1];
    NSInteger districtRow = [pickerView selectedRowInComponent:2];
    
    CityAddress *province = nil;
    if (proList.count > provinceRow) {
        province = proList[provinceRow];
    }
    
    CityAddress *city = nil;
    if (citiesList.count > cityRow) {
        city = citiesList[cityRow];
    }
    
    CityAddress *district = nil;
    if (areaList.count > districtRow) {
        district = areaList[districtRow];
    }
    NSString *selectedAddress = [NSString stringWithFormat:@"%@ %@", province.name, city.name];
    if (district.name) {
        selectedAddress = [NSString stringWithFormat:@"%@ %@", selectedAddress,district.name];
    }
    
    //赋值
    PersonalCenter *item = self.data[self.addressIndexPath.row];
    self.address.prov = province.name;
    self.address.city = city.name;
    self.address.areaname = district.name;
    item.placeholder = selectedAddress;
    [self.tableView reloadRowsAtIndexPaths:@[self.addressIndexPath] withRowAnimation:UITableViewRowAnimationNone];
}

//省
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
            if (citiesList.count > 0 && areaList.count > 0) {
                [addressPickerView reloadAllComponents];
            }
        } else {
            [self alertMessage:responseObject[@"resultMsg"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-%@",error);
    }];
}

//市
- (void)loadCitiesInfoFromServer:(void (^)())success {
    NSDictionary *dict = @{
                           @"data":@{
                                   @"addressCode":proCode,
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
            if (success) {
                success();
            }
            if (proList.count > 0 && areaList.count > 0) {
                [addressPickerView reloadAllComponents];
            }
        } else {
            [self alertMessage:responseObject[@"resultMsg"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-%@",error);
    }];
}

//区
- (void)loadAreaInfoFromServer:(void (^)())success {
    NSDictionary *dict = @{
                           @"data":@{
//                                   @"addressCode":self.address.provCode,
                                   @"provCode":proCode,
                                   @"cityCode":cityCode
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
            if (success) {
                success();
            }
            if (proList.count > 0 && citiesList.count > 0) {
                [addressPickerView reloadAllComponents];
            }
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
