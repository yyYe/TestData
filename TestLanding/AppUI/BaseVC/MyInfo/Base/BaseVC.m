//
//  BaseVC.m
//  TestLanding
//
//  Created by loufq on 16/3/19.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "BaseVC.h"

@implementation BaseVC

- (Mother *)mother {
    if (!_mother) {
        _mother = [Mother new];
    }
    return _mother;
}

- (NSMutableArray *)data {
    if (!_data) {
        _data = [@{} mutableCopy];
    }
    return _data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIEventSubtypeNone;
    self.view.backgroundColor = FGTableBgGrayColor;
    self.manager = [AFHTTPSessionManager manager];
    self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/javascript",@"application/json",@"text/json", @"text/html", nil];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];

    [self contentData];
}

- (void)contentData {
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UITableViewCell alloc];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    } else{
        return 20;
    }
}

@end
