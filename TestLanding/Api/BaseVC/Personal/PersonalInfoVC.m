//
//  TestVC.m
//  TestLanding
//
//  Created by loufq on 16/3/19.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "PersonalInfoVC.h"
#import "ModifyNameVC.h"
#import "AddBabyVC.h"
#import "BabySexVC.h"
#import "BirthdayVC.h"

#import "MamaInfoCell.h"
#import "MamaAvatarCell.h"
#import "BabyAddInfoCell.h"
#import "BabyDetailsCell.h"

#import "MeBabyInfoItem.h"

static NSString *const kGetUserInfo = @"http://app.yimama.com.cn/api/follow/getUserInfo";
static NSString *const kGetMamaInfo = @"http://app.yimama.com.cn/api/mama/getMamaInfo";
static NSString *const kModifyMamaHeaderImg = @"http://app.yimama.com.cn/api/mama/modifyMamaHeaderImg";


@implementation PersonalInfoVC

- (void)contentData {
    [self.tableView registerClass:[MamaInfoCell class] forCellReuseIdentifier:@"MamaInfoCell"];
    [self.tableView registerClass:[MamaAvatarCell class] forCellReuseIdentifier:@"MamaAvatarCell"];
    [self.tableView registerClass:[BabyAddInfoCell class] forCellReuseIdentifier:@"BabyAddInfoCell"];
    [self.tableView registerClass:[BabyDetailsCell class] forCellReuseIdentifier:@"BabyDetailsCell"];
    
    NSDictionary *dict = @{
                           @"data":@{
                                   @"xuid":@"37865002-b862-11e5-b130-00163e004e00",
                                   @"headerImg":@"3"
                                   },
                           @"header":@{
                                   @"msgId":@"ea1b5095-3a23-4ae9-97af-06a4893b5ab9",
                                   @"msgType":@"getMamaInfo",
                                   @"token":kToken
                                   }
                           };

    [self.manager POST:kGetMamaInfo parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject-%@",responseObject);
        NSDictionary *dictData = [responseObject valueForKeyPath:@"data.mama"];
        Mother *mother = [Mother motherWithDict:dictData[@"mamaInfo"]];
        mother.babies = [Baby babyWithArray:dictData[@"babies"]];
        self.mother = mother;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-%@",error);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setUpMamaData];
    });
    
}


- (void)setUpMamaData {
    //头像
    PersonalCenter *avatar = [PersonalCenter itemWithTitle:@"头像" avatar:self.mother.avatarString targrtClass:nil];
    NSArray *list1 = [NSArray new];
    list1 = @[avatar];
    
    //父母的信息
    MeLableItem *nikeNameItem = [MeLableItem itemWithTitle:@"昵称" details:self.mother.nickName targrtClass:[ModifyNameVC class]];
    MeLableItem *areaItem = [MeLableItem itemWithTitle:@"区域" details:self.mother.address targrtClass:nil];
    NSString *sex = self.mother.gender == 1 ? @"女" : @"男";
    MeLableItem *sexItem = [MeLableItem itemWithTitle:@"性别" details:sex targrtClass:[BabySexVC class]];
    MeLableItem *birthDayItem = [MeLableItem itemWithTitle:@"生日" details:self.mother.birthday targrtClass:[BirthdayVC class]];
    MeLableItem *phoneItem = [MeLableItem itemWithTitle:kPhone details:self.mother.phoneNumber targrtClass:nil];
    MeLableItem *signatureItem = [MeLableItem itemWithTitle:@"签名" details:self.mother.signature targrtClass:nil];
    NSArray *list2 = [NSArray new];
    list2 = @[nikeNameItem,areaItem,sexItem,birthDayItem,phoneItem,signatureItem];
    
    //宝宝信息
    PersonalCenter *babyTitle = [PersonalCenter itemWithTitle:@"宝宝信息" avatar:@"addBabyInfo" targrtClass:[AddBabyVC class]];
    NSMutableArray *babyArray = [@[] mutableCopy];
    [babyArray addObject:babyTitle];
    for (Baby *baby in self.mother.babies) {
        MeBabyInfoItem *babyInfoItem = [[MeBabyInfoItem alloc]init];
        babyInfoItem.sex = baby.gender;
        babyInfoItem.avatar = baby.avatarString;
        babyInfoItem.nickName = baby.nickName;
        babyInfoItem.birthday = baby.birthday;
        [babyArray addObject:babyInfoItem];
    }
    NSArray *list3 = [NSArray new];
    list3 = babyArray;
    
    self.data = [NSMutableArray arrayWithObjects:list1,list2,list3, nil];
    [self.tableView reloadData];
}

#pragma mark UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 60;
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            return 30;
        }
        return 80;
    }
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *list = self.data[section];
    return list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *list = self.data[indexPath.section];
    if (indexPath.section == 0) {
        MamaAvatarCell *avatarCell = [tableView dequeueReusableCellWithIdentifier:@"MamaAvatarCell"];
        avatarCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        avatarCell.avatarData = list[indexPath.row];
        return avatarCell;
    } else if (indexPath.section == 1) {
        MamaInfoCell *mamaInfoCell = [tableView dequeueReusableCellWithIdentifier:@"MamaInfoCell"];
        mamaInfoCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        mamaInfoCell.labelItem = list[indexPath.row];
        return mamaInfoCell;
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            BabyAddInfoCell *addInfoCell = [tableView dequeueReusableCellWithIdentifier:@"BabyAddInfoCell"];
            addInfoCell.babyDetails = list[0];
            return addInfoCell;
        } else {
            BabyDetailsCell *detailsCell = [tableView dequeueReusableCellWithIdentifier:@"BabyDetailsCell"];
            detailsCell.babyItem = list[indexPath.row];
            return detailsCell;
        }
    }
    
    static NSString *reuseID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsZero;
    }
    cell.textLabel.text = @"test";
    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        [self showSheetView];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *list = self.data[indexPath.section];
    id item = list[indexPath.row];
    
    UIViewController *vc = [[[item targetClass]alloc]init];
    vc.title = [item title];
    
    if (indexPath.section == 1) {
        ModifyNameVC *commonVC = (ModifyNameVC *)vc; //运行时
        commonVC.person = self.mother;
        commonVC.refresh = ^(){
            //刷新了就是没有改变值
            [self.tableView reloadData];
        };
    }
    
    if (indexPath.section == 2) {
        AddBabyVC *babyVC = [AddBabyVC new];
        babyVC.babyInfo = item;
        babyVC.refresh = ^(){
            [self.tableView reloadData];
        };
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark UIAlertController
- (void)showSheetView {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openGallery];
    }];
    UIAlertAction *cameraActon = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:photoAction];
    [alertController addAction:cameraActon];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark UIImagePickerController
- (void)openGallery {
    UIImagePickerController *pickerController = [UIImagePickerController new];
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSDictionary *dict = @{
                           @"data":@{
                                   @"xuid":@"37865002-b862-11e5-b130-00163e004e00",
                                   @"headerImg":@"3"
                                   },
                           @"header":@{
                                   @"msgId":@"ea1b5095-3a23-4ae9-97af-06a4893b5ab9",
                                   @"msgType":@"modifyMamaHeaderImg",
                                   @"token":kToken
                                   }
                           };
    
    [self.manager POST:kModifyMamaHeaderImg parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"response-%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-%@",error);
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
