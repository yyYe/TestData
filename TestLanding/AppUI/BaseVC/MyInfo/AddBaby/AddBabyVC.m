//
//  AddBabyVC.m
//  TestLanding
//
//  Created by loufq on 16/3/20.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "AddBabyVC.h"
#import "MamaAvatarCell.h"
#import "ModifyNameVC.h"
#import "MamaInfoCell.h"
#import "BabySexVC.h"


@implementation AddBabyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[MamaAvatarCell class] forCellReuseIdentifier:@"MamaAvatarCell"];
    [self.tableView registerClass:[MamaInfoCell class] forCellReuseIdentifier:@"MamaInfoCell"];
    if (self.isModify == YES) {
        [self setupNavRightBtnWithTitle:nil];
        self.title = self.babyInfo.nickName;
    }else {
        self.title = @"新增宝宝信息";
    }
    
}

- (void)contentData {
    PersonalCenter *avatar = [PersonalCenter itemWithTitle:@"头像" avatar:self.babyInfo.avatar targrtClass:nil];
    NSArray *list1 = [NSArray new];
    list1 = @[avatar];
    
    MeLableItem *nikeNameItem = [MeLableItem itemWithTitle:@"昵称" details:self.isModify == NO ? @"" : self.babyInfo.nickName targrtClass:[ModifyNameVC class]];
    NSString *sex = (self.babyInfo.sex == GenderMan) ? @"小王纸" : @"小公举";
    MeLableItem *sexItem = [MeLableItem itemWithTitle:@"性别" details:self.isModify == NO ? @"小公举" : sex targrtClass:[BabySexVC class]];
    MeLableItem *birthDayItem = [MeLableItem itemWithTitle:@"生日" details:self.isModify == NO ? @"" : self.babyInfo.birthday targrtClass:nil];
    NSArray *list2 = [NSArray new];
    list2 = @[nikeNameItem,sexItem,birthDayItem];
    self.data = [NSMutableArray arrayWithObjects:list1,list2, nil];
}

- (void)rightBtnAction {
    NSDictionary *dict = @{
                           @"data":@{
                                   @"xuid":@"37865002-b862-11e5-b130-00163e004e00",
                                   @"babyName":@"test",
//                                   @"headerImg":self.babyInfo.avatar,
//                                   @"babyName":self.babyInfo.nickName
//                                   @"birthday":self.babyInfo.birthday,
//                                   @"gender":@(self.babyInfo.sex),
                                   },
                           @"header":@{
                                   @"msgType":@"addBabyInfo",
                                   @"timestamp":@"2016-02-29 13:07:57.429",
                                   @"clientRes":@"iOS",
                                   @"token":kToken
                                   }
                           };

    [self.manager POST:kAddBabyInfo parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject-%@",responseObject);
        self.refresh();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-%@",error);
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 60;
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
        avatarCell.personalCenter = list[indexPath.row];
        return avatarCell;
    } else if (indexPath.section == 1) {
        MamaInfoCell *mamaInfoCell = [tableView dequeueReusableCellWithIdentifier:@"MamaInfoCell"];
        mamaInfoCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        mamaInfoCell.labelItem = list[indexPath.row];
        return mamaInfoCell;
    }
    
    static NSString *reuseID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    cell.textLabel.text = @"test";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [self showSheetView];
    }
    else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        NSArray *list = self.data[indexPath.section];
        id item = list[indexPath.row];
        
        UIViewController *vc = [[[item targetClass]alloc]init];
        vc.title = [item title];
        
        if (indexPath.section == 1) {
            BabySexVC *sexVC = (BabySexVC *)vc;
            sexVC.person = self.baby;
            sexVC.refresh = ^(){
                [self contentData];
            };
        }
        [self.navigationController pushViewController:vc animated:YES];
    }
    
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
    UIImage *iconImage = [image generateThumbnail:YMMIconSize];
    NSData *data = UIImageJPEGRepresentation(iconImage, 1.0f);
    PersonalCenter *personal = [PersonalCenter new];
    personal.avatarData = data;
    FGPictureFile *picture = [FGPictureFile fileWithData:data];
    NSDictionary *dict = @{
                           @"data":@{
                                   @"xuid":kXuid,
                                   @"fileName":picture.name,
                                   @"filePath":picture.filename
                                   },
                           @"header":@{
                                   @"msgId":kMsgID,
                                   @"msgType":@"fileList",
                                   @"token":kToken
                                   }
                           };
    NSString *filePath = [NSString stringWithFormat:@"%@?token=%@",kPost_upload_batch,kToken];
    [self.manager POST:filePath parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:picture.data name:picture.name fileName:picture.filename mimeType:picture.mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *list = responseObject[@"fileList"];
        if (list.count == 0) { //上传失败
        } else{ //上传成功
            for (NSDictionary *dict in list) {
                NSString *item = dict[@"filePath"];
                [self babyHeader:item];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)babyHeader:(NSString *)item {
    NSDictionary *dict = @{
                           @"data":@{
                                   @"xuid":kXuid,
                                   @"headerImg":item
                                   },
                           @"header":@{
//                                   @"msgId":kMsgID,
                                   @"msgType":@"modifyBabyHeaderImg",
                                   @"token":kToken
                                   }
                           };
    [self.manager POST:kModifyBabyHeaderImg parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"response-%@",responseObject);
        [self contentData];
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-%@",error);
    }];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
