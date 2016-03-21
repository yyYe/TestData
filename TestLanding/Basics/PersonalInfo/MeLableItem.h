//
//  MeLableItem.h
//  TestLanding
//
//  Created by loufq on 16/3/19.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "PersonalCenter.h"

@interface MeLableItem : PersonalCenter

@property (nonatomic, copy) NSString *details;

+ (instancetype)itemWithTitle:(NSString *)title details:(NSString *)details targrtClass:(Class)targetClass;
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title details:(NSString *)details  targrtClass:(Class)targetClass;

@end
