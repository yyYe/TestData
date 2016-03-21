//
//  ModifyMeInfoTool.m
//  YiMaMa
//
//  Created by LWF on 16/2/2.
//  Copyright © 2016年 YiMaMa. All rights reserved.
//

#import "ModifyMeInfoTool.h"
#import <AFNetworking/AFNetworking.h>
#import "HttpTool.h"

static NSString *const kModifyMamaInfo = @"http://app.yimama.com.cn/api/mama/modifyMamaInfo";
static NSString *const kModifyBabyInfo = @"http://app.yimama.com.cn/api/mama/modifyBabyInfo";

@implementation ModifyMeInfoTool

+ (void)modifyMotherInfo:(Mother *)mother currentVC:(UIViewController *)modalVC  success:(void (^)(id json))success{
    Params *params = [Params paramsWithMsgType:@"modifyMotherInfo"];
    params.data[@"area"] = mother.address;
    params.data[@"birthday"] = mother.birthday;
    params.data[@"userNick"] = mother.nickName;
    params.data[@"userSig"] = mother.signature;
    params.data[@"gender"] = @(mother.gender);
//    params.data[@"xuid"] = [FGUser currentUser].xuid;
    //    params.data[@"intro"] = @"";
//    NSDictionary *dict = @{
//                           @"data":@{
//                                   @"xuid":mother.xuid,
//                                   @"gender":@(mother.gender),
//                                   @"area":mother.address,
//                                   @"birthday":mother.birthday,
//                                   @"userNick":mother.nickName,
//                                   },
//                           @"header":@{
//                                   @"msgId":mother.userId,
//                                   @"msgType":@"mygrouplist",
//                                   @"token":kToken
//                                   }
//                           };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/javascript",@"application/json",@"text/json", @"text/html", nil];
    [manager POST:kModifyMamaInfo parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject-%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-%@",error);
    }];

}
+ (void)modifyBabyInfo:(Baby *)baby currentVC:(UIViewController *)modalVC success:(void (^)(id json))success{
    Params *params = [Params paramsWithMsgType:@"modifyBabyInfo"];
    params.data[@"babyName"] = baby.nickName;
    params.data[@"birthday"] = baby.birthday;
    params.data[@"gender"] = @(baby.gender);
    params.data[@"xuid"] = baby.xuid;
    
    
}

@end
