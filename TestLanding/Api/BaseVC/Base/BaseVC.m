//
//  BaseVC.m
//  TestLanding
//
//  Created by loufq on 16/3/19.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "CustomNavgationButtonVC.h"
#import "BaseVC.h"

@implementation BaseVC

- (Mother *)mother {
    if (!_mother) {
        _mother = [Mother new];
    }
    return _mother;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.manager = [AFHTTPSessionManager manager];
    self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/javascript",@"application/json",@"text/json", @"text/html", nil];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }];
    [self contentData];
//    [self refreshTableView];
}


- (void)refreshTableView {
    CustomNavgationButtonVC *navgationButtonVC = [CustomNavgationButtonVC new];
    navgationButtonVC.refresh = ^(){
        [self.tableView reloadData];
    };
}

- (void)contentData {
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UITableViewCell alloc];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

@end
