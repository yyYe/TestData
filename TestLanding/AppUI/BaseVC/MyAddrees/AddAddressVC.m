//
//  AddAddressVC.m
//  TestLanding
//
//  Created by loufq on 16/3/22.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "AddAddressVC.h"
#import "AddAddressCell.h"
#import "MyAddress.h"

@interface AddAddressVC ()
@property (nonatomic, strong) MyAddress *address;
@end

@implementation AddAddressVC

- (MyAddress *)address {
    if (!_address) {
        _address = [MyAddress new];
    }
    return _address;
}

- (void)contentData {
    [self.tableView registerClass:[AddAddressCell class] forCellReuseIdentifier:@"AddAddressCell"];
    [self addressData];
}

- (void)buttonLayout {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.backgroundColor = [UIColor greenColor];
    [button setTitle:@"登陆" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addressItem) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.bottom.equalTo(self.view.mas_bottom).offset(-150);
        make.right.equalTo(self.view).offset(-10);
    }];
}

- (void)addressItem {
    NSDictionary *dict = @{
                           @"data":@{
                                       @"xuid":@"37865002-b862-11e5-b130-00163e004e00",
                                       @"userName":@""
                                   },
                           @"header":@{
                                       @"msgId":@"ea1b5095-3a23-4ae9-97af-06a4893b5ab9",
                                       @"msgType":@"concentrate",
                                       @"token":kToken
                                   }
                           };
    
    [self.manager POST:kAddUserAddress parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject-%@",responseObject);
        //        NSArray *list = [responseObject valueForKeyPath:@"data.cfList.dataList"];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-%@",error);
    }];
}

- (void)addressData {
    //判断，转进去的如果是空的就显示占位符的
    //不是空的，就是修改的，占位符要换成传进来的值
    PersonalCenter *name = [PersonalCenter itemWithTitle:@"姓名" placeholder:@"请输入姓名"];
    PersonalCenter *phone = [PersonalCenter itemWithTitle:@"手机" placeholder:@"请输入手机"];
    PersonalCenter *postCode = [PersonalCenter itemWithTitle:@"邮票" placeholder:@"请输入邮票"];
    PersonalCenter *city = [PersonalCenter itemWithTitle:@"省市区" placeholder:@"请选择"];
    PersonalCenter *address = [PersonalCenter itemWithTitle:@"详细地址" placeholder:@"请输入详细地址"];
    self.data = [NSMutableArray arrayWithObjects:name,phone,postCode,city,address, nil];
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
//    switch (row) {
//        case 0:
//            self.address = textField.text;
//            break;
//        case 1:
//            self.item.mobilePhone = textField.text;
//            break;
//        case 2:
//            self.item.postCode = textField.text;
//            break;
//        case 3:
//            //            self.item.area = textField.text;
//            break;
//        case 4:
//            self.item.street = textField.text;
//            break;
//            
//        default:
//            break;
//    }
    NSString *text = value;
    NSLog(@"text-%@,\n row-%d",text,row);
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
