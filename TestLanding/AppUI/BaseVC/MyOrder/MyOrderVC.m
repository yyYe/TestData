//
//  MyOrderVC.m
//  TestLanding
//
//  Created by loufq on 16/3/22.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "MyOrderVC.h"
#import "MyOrderCell.h"
#import "MyOrder.h"

@interface MyOrderVC ()

@end

@implementation MyOrderVC

- (void)contentData {
    [self.tableView registerClass:[MyOrderCell class] forCellReuseIdentifier:@"MyOrderCell"];
    NSDictionary *dict = @{
                           @"data":@{
                                   @"xuid":@"37865002-b862-11e5-b130-00163e004e00",
                                   },
                           @"header":@{
                                   @"msgId":@"ea1b5095-3a23-4ae9-97af-06a4893b5ab9",
                                   @"msgType":@"list",
                                   @"token":kToken
                                   }
                           };
    [self.manager POST:kList parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject-%@",responseObject);
        NSArray *list = [responseObject valueForKeyPath:@"data.cfList.dataList"];
        for (NSDictionary *dict in list) {
            MyOrder *order = [MyOrder new];
            order.orderId = dict[@"orderId"];
            order.cfTitle = dict[@"cfTitle"];
            order.cfPicture = dict[@"cfPicture"];
            order.sizeName = dict[@"sizeName"];
            order.price = dict[@"price"];
            order.cfEndTime = dict[@"cfEndTime"];
            order.total = dict[@"total"];
            order.orderSta = [dict[@"orderSta"] integerValue];
            order.num = [dict[@"num"] integerValue];
            self.data = [NSMutableArray arrayWithObjects:order, nil];
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-%@",error);
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyOrderCell"];
    cell.myOrder = self.data[indexPath.row];
    return cell;
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
