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
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, assign) BOOL needToken;
@property (nonatomic, assign) Class targetClass;
@property (nonatomic, copy) void(^doneBlock)();

+ (instancetype)itemWithTitle:(NSString *)title targrtClass:(Class)targetClass;
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title targrtClass:(Class)targetClass;
+ (instancetype)itemWithTitle:(NSString *)title avatar:(NSString *)avatar targrtClass:(Class)targetClass;
@end