//
//  BabySexVC.m
//  TestLanding
//
//  Created by loufq on 16/3/20.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "BabySexVC.h"
#import "ModifyMeInfoTool.h"
#import "HttpTool.h"

@implementation BabySexVC

- (void)contentData {
    
}

- (void)rightBtnAction {
    self.person = [PersonBase new];
    self.person.gender = (self.selectedRow == 0) ? GenderMan : GenderWoman;

    NSDictionary *dict = @{
                           @"data":@{
                                   @"xuid":@"37865002-b862-11e5-b130-00163e004e00",
                                   @"gender":@(self.person.gender),
                                   },
                           @"header":@{
                                   @"msgType":@"modifyBabyInfo",
                                   @"token":kToken
                                   }
                           };
    [self.manager POST:kModifyBabyInfo parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject-%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-%@",error);
    }];
}

- (void)modifyMamaInfo {
    NSDictionary *dict = @{
                           @"data":@{
                                   @"xuid":@"37865002-b862-11e5-b130-00163e004e00",
                                   @"gender":@(self.person.gender),
                                   },
                           @"header":@{
                                   @"msgType":@"mygrouplist",
                                   @"token":kToken
                                   }
                           };
    [self.manager POST:kModifyMamaInfo parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject-%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-%@",error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsZero;
    }
//    cell.textLabel.text = self.list[indexPath.row];
    [self setupCell:cell withRow:indexPath.row];
    return cell;
}

- (void)setupCell:(UITableViewCell *)cell withRow:(NSInteger)row{
    
    NSString *title = nil;
    if ([self.person isKindOfClass:[Baby class]]){ //小孩
        switch (row) {
            case 0:
                title = @"小王纸";
                break;
            case 1:
                title = @"小公举";
                break;
            default:
                title = @"未知";
                break;
        }
    } else{ //成人
        switch (row) {
            case 0:
                title = @"男";
                break;
            case 1:
                title = @"女";
                break;
            default:
                title = @"未知";
                break;
        }
    }
    
    cell.textLabel.text = title;
    
    cell.accessoryView = (self.selectedRow == row) ? self.checkView : nil;
}

- (UIImageView *)checkView{
    if (_checkView == nil) {
        
        _checkView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"checkBox_me"]];
        _checkView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width)-30, 2, 20, 20);
    }
    
    return _checkView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectedRow = indexPath.row;
    [tableView reloadData];
}

@end
