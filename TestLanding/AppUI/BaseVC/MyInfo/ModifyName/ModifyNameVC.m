//
//  ModifyNameVC.m
//  TestLanding
//
//  Created by loufq on 16/3/20.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "ModifyNameVC.h"
#import "ModifyNameCell.h"

@implementation ModifyNameVC

- (void)contentData {
    [self.tableView registerClass:[ModifyNameCell class] forCellReuseIdentifier:@"ModifyNameCell"];

}

- (void)rightBtnAction{
    //修改名字
    //需要判断，进去的是妈妈的还是宝宝的，，进去谁就修改谁
    NSDictionary *dict = @{
                           @"data":@{
                                   @"xuid":@"37865002-b862-11e5-b130-00163e004e00",
                                   @"userNick":self.person.nickName
                                   },
                           @"header":@{
                                   @"msgType":@"mygrouplist",
                                   @"timestamp":@"2016-02-29 13:07:57.429",
                                   @"clientRes":@"iOS",
                                   @"token":kToken
                                   }
                           };
    
    [self.manager POST:kModifyMamaInfo parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject-%@",responseObject);
        self.refresh();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-%@",error);
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ModifyNameCell *nameCell = [tableView dequeueReusableCellWithIdentifier:@"ModifyNameCell"];
    nameCell.person = self.person;
    nameCell.tfContent = ^(NSString *tfText){
        if (tfText == nil) {
            [self.tableView reloadData];
        } else {
            self.person.nickName = tfText;
        }
    };
    return nameCell;
}

@end
