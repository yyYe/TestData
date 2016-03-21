//
//  ModifyNameVC.m
//  TestLanding
//
//  Created by loufq on 16/3/20.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "ModifyNameVC.h"
#import "ModifyNameCell.h"

static NSString *const kModifyMamaInfo = @"http://app.yimama.com.cn/api/mama/modifyMamaInfo";

@implementation ModifyNameVC

- (void)contentData {
    [self.tableView registerClass:[ModifyNameCell class] forCellReuseIdentifier:@"ModifyNameCell"];

}

- (void)rightBtnAction{
    NSDictionary *dict = @{
                           @"data":@{
                                   @"xuid":@"37865002-b862-11e5-b130-00163e004e00",
                                   @"userNick":nameText
                                   },
                           @"header":@{
                                   @"msgType":@"mygrouplist",
                                   @"timestamp":@"2016-02-29 13:07:57.429",
                                   @"clientRes":@"iOS",
                                   @"token":@"2e66a5e1c29c43a3a36913a0b5daf48661874998366493504079781121225176"
                                   }
                           };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/javascript",@"application/json",@"text/json", @"text/html", nil];
    [manager POST:kModifyMamaInfo parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject-%@",responseObject);
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-%@",error);
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ModifyNameCell *nameCell = [tableView dequeueReusableCellWithIdentifier:@"ModifyNameCell"];
//    nameCell.tfName.text = self.labelItem.details;
    nameCell.tfContent = ^(NSString *tfText){
        nameText = tfText;
        [self.tableView reloadData];
    };
    return nameCell;
}

@end
