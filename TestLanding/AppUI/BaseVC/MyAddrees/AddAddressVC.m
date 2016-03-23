//
//  AddAddressVC.m
//  TestLanding
//
//  Created by loufq on 16/3/22.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "AddAddressVC.h"
#import "AddAddressCell.h"


@interface AddAddressVC ()

@end

@implementation AddAddressVC

- (void)contentData {
    [self.tableView registerClass:[AddAddressCell class] forCellReuseIdentifier:@"AddAddressCell"];
    [self addressData];
    [self buttonLayout];
}

- (void)buttonLayout {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
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
    NSDictionary *dict = @{
                           @"data":@{
                                       @"xuid":@"37865002-b862-11e5-b130-00163e004e00",
//                                       @"userName":self.address.fullname,
//                                       @"mobliePhone":self.address.mobliePhone,
//                                       @"provCode":self.address.postCode
                                   },
                           @"header":@{
                                       @"msgId":@"ea1b5095-3a23-4ae9-97af-06a4893b5ab9",
                                       @"msgType":@"concentrate",
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

//失败就弹出框，提示错误信息
- (void)alertMessage:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
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
    self.data = [@[] mutableCopy];
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
    [self.tableView reloadData];
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
