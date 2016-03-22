//
//  ModifyMeInfoTool.h
//  YiMaMa
//
//  Created by LWF on 16/2/2.
//  Copyright © 2016年 YiMaMa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Mother.h"
#import "Baby.h"

@interface ModifyMeInfoTool : NSObject

+ (void)modifyMotherInfo:(Mother *)mother currentVC:(UIViewController *)modalVC  success:(void (^)(id json))success;
+ (void)modifyBabyInfo:(Baby *)baby currentVC:(UIViewController *)modalVC success:(void (^)(id json))success;

@end
