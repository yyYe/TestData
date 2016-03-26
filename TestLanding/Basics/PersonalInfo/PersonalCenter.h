//
//  FGMeBaseItem.h
//  YiMaMa
//
//  Created by LWF on 16/1/15.
//  Copyright © 2016年 YiMaMa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonalCenter : NSObject

/**  注意:这个不是头像, 头像是avatar   */
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *avatar; //头像
@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSData *avatarData;
@property (nonatomic, assign) BOOL isModify;
@property (nonatomic, assign) BOOL needToken;
@property (nonatomic, assign) Class targetClass;
@property (nonatomic, strong) void(^doneBlock)();

+ (instancetype)itemWithTitle:(NSString *)title targrtClass:(Class)targetClass;
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title targrtClass:(Class)targetClass;
+ (instancetype)itemWithTitle:(NSString *)title avatar:(NSString *)avatar targrtClass:(Class)targetClass;
+ (instancetype)itemWithTitle:(NSString *)title text:(NSString *)text placeholder:(NSString *)placeholder;
@end
