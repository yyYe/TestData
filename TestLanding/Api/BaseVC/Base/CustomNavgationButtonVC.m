//
//  CustomNavgationButtonVC.m
//  TestLanding
//
//  Created by loufq on 16/3/20.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "CustomNavgationButtonVC.h"

@implementation CustomNavgationButtonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavLeftBtnWithTitle:@"取消"];
    [self setupNavRightBtnWithTitle:@"保存"];
}

- (void)setupNavLeftBtnWithTitle:(NSString *)title {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnAction)];
}

- (void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
    [self.tableView reloadData];
}

- (void)setupNavRightBtnWithTitle:(NSString *)title {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnAction)];
}

- (void)rightBtnAction {
    self.refresh();
}

@end
