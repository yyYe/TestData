//
//  SetUpVC.m
//  TestLanding
//
//  Created by loufq on 16/3/27.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "SetUpVC.h"

@interface SetUpVC ()

@end

@implementation SetUpVC

- (void)contentData {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    PersonalCenter *praise = [PersonalCenter itemWithTitle:@"给好评" targrtClass:nil];
    PersonalCenter *recommendToFriend = [PersonalCenter itemWithTitle:@"推荐给好友" targrtClass:nil];
    PersonalCenter *clearCache = [PersonalCenter itemWithTitle:@"清除缓存" targrtClass:nil];
    PersonalCenter *aboutUs = [PersonalCenter itemWithTitle:@"关于我们" targrtClass:nil];
    PersonalCenter *statement = [PersonalCenter itemWithTitle:@"声明" targrtClass:nil];
    self.data = [NSMutableArray arrayWithObjects:praise,recommendToFriend,clearCache,aboutUs,statement, nil];
}

- (void)logoutButtonLayout {
    UIView *footView = [UIView new];
    footView.backgroundColor = [UIColor clearColor];
    
    UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(8, 0, SCREEN_WIDTH - 8, 1/3.0)];
    topLine.backgroundColor = FGSeparatorColor;
    [footView addSubview:topLine];
    
    UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [logoutBtn addTarget:self action:@selector(LogoutTapped) forControlEvents:UIControlEventTouchUpInside];
    [logoutBtn setBackgroundImage:[UIImage imageWithColor:YMMNavBarColor] forState:UIControlStateNormal];
    logoutBtn.layer.cornerRadius = 5;
    logoutBtn.layer.masksToBounds = YES;
    CGFloat btnX = 15;
    CGFloat btnY = 25;
    CGFloat btnW = SCREEN_WIDTH - 2*btnX;
    CGFloat btnH = 40;
    logoutBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    [footView addSubview:logoutBtn];
    footView.frame = CGRectMake(0, 0, screenWidth, 2*btnY + btnH);
    
    self.tableView.tableFooterView = footView;
}

- (void)LogoutTapped {
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    PersonalCenter *personal = self.data[indexPath.row];
    cell.textLabel.text = personal.title;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 150;
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
