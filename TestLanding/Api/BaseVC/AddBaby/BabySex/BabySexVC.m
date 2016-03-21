//
//  BabySexVC.m
//  TestLanding
//
//  Created by loufq on 16/3/20.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "BabySexVC.h"

@implementation BabySexVC

- (void)contentData {
    
    self.list = @[@"小王纸",@"小公举"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseID = @"Cell";
    self.cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (self.cell == nil) {
        self.cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.cell.separatorInset = UIEdgeInsetsZero;
    }
    self.cell.textLabel.text = self.list[indexPath.row];
    return self.cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        self.cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        self.cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
}

@end
