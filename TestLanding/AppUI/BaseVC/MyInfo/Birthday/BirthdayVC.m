//
//  BirthdayVC.m
//  TestLanding
//
//  Created by loufq on 16/3/21.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "BirthdayVC.h"
#import "BirthdayCell.h"

static NSInteger const kDatePickerHeight = 200;

@implementation BirthdayVC

- (void)contentData {
    [self.tableView registerClass:[BirthdayCell class] forCellReuseIdentifier:@"BirthdayCell"];
}

- (void)rightBtnAction {
    NSDictionary *dict = @{
                           @"data":@{
                                   @"xuid":@"37865002-b862-11e5-b130-00163e004e00",
                                   @"birthday":self.person.birthday
                                   },
                           @"header":@{
                                   @"msgType":@"modifyBabyInfo",
                                   @"token":kToken
                                   }
                           };
    [self.manager POST:kModifyMamaInfo parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject-%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-%@",error);
    }];
    self.refresh();
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BirthdayCell *birthdayCell = [tableView dequeueReusableCellWithIdentifier:@"BirthdayCell"];
    birthdayCell.person = self.person;
    return birthdayCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self datePickerMethod];
    self.selectedIndexPath = indexPath;
}

- (void)datePickerMethod {
    UIDatePicker *datePicker = [UIDatePicker new];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    datePicker.date = [formatter dateFromString:self.person.birthday];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    [datePicker setLocale:[[NSLocale alloc ]initWithLocaleIdentifier:@"zh_Hans_CN"]];//zh_CN
    [datePicker addTarget:self action:@selector(datePickerTapped:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:datePicker];
    [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.width.equalTo(@(screenWidth));
        make.height.equalTo(@(kDatePickerHeight));
    }];
}

- (void)datePickerTapped:(UIDatePicker *)datePicker {
    NSDate *pickerDate = datePicker.date;
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    self.person.birthday = [fmt stringFromDate:pickerDate];
    [self.tableView reloadRowsAtIndexPaths:@[self.selectedIndexPath] withRowAnimation:UITableViewRowAnimationNone];
}

@end
