//
//  AlertSheetView.m
//  TestLanding
//
//  Created by loufq on 16/3/23.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "AlertSheetView.h"
#import "UIImage+Extension.h"
#import "PersonalCenter.h"
#import "HttpTool.h"

static NSString *const kToken = @"55cef3b35ae945e2bce16e1ba0544b1428911520457339080863123031971765";
static NSString *const kPost_upload_batch = @"http:/app.yimama.com.cn/im/post_upload_batch";
static NSString *const kModifyMamaHeaderImg = @"http://app.yimama.com.cn/api/mama/modifyMamaHeaderImg";


@implementation AlertSheetView

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self showSheetView];
    }
    return self;
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
//    [self presentViewController:alertController animated:YES completion:nil];
    self.push(alertController);
}

#pragma mark UIImagePickerController
- (void)openGallery {
    UIImagePickerController *pickerController = [UIImagePickerController new];
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerController.delegate = self;
//    [self presentViewController:pickerController animated:YES completion:nil];
    self.picker(pickerController);
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    UIImage *iconImage = [image generateThumbnail:CGSizeMake(70, 70)];
    NSData *data = UIImageJPEGRepresentation(iconImage, 1.0f);
    PersonalCenter *personal = [PersonalCenter new];
    personal.avatarData = data;
    FGPictureFile *picture = [FGPictureFile fileWithData:data];
    NSDictionary *dict = @{
                           @"data":@{
                                   @"xuid":@"37865002-b862-11e5-b130-00163e004e00",
                                   @"fileName":picture.name,
                                   @"filePath":picture.filename
                                   },
                           @"header":@{
                                   @"msgId":@"ea1b5095-3a23-4ae9-97af-06a4893b5ab9",
                                   //                                   @"msgType":@"fileList",
                                   @"token":kToken
                                   }
                           };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/javascript",@"application/json",@"text/json", @"text/html", nil];
    NSString *filePath = [NSString stringWithFormat:@"%@?token=%@",kPost_upload_batch,kToken];
    [manager POST:filePath parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:picture.data name:picture.name fileName:picture.filename mimeType:picture.mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *list = responseObject[@"fileList"];
        if (list.count == 0) { //上传失败
        } else{ //上传成功
            for (NSDictionary *dict in list) {
                NSString *item = dict[@"filePath"];
                [self motherHeader:item];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)motherHeader:(NSString *)item {
    NSDictionary *dict = @{
                           @"data":@{
                                   @"xuid":@"37865002-b862-11e5-b130-00163e004e00",
                                   @"headerImg":item
                                   },
                           @"header":@{
                                   @"msgId":@"ea1b5095-3a23-4ae9-97af-06a4893b5ab9",
                                   @"msgType":@"modifyMamaHeaderImg",
                                   @"token":kToken
                                   }
                           };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/javascript",@"application/json",@"text/json", @"text/html", nil];
    [manager POST:kModifyMamaHeaderImg parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"response-%@",responseObject);
//        [self dismissViewControllerAnimated:YES completion:nil];
        self.returnPage();
        //        [self contentData];
        //        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-%@",error);
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
//    [self dismissViewControllerAnimated:YES completion:nil];
    self.returnPage();
}

@end
