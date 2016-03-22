//
//  ConstMacro.h
//  YiMaMa
//
//  Created by LWF on 16/1/4.
//  Copyright © 2016年 YiMaMa. All rights reserved.
//

#ifndef ConstMacro_h
#define ConstMacro_h

//常用宏
#define SCREEN_WIDTH   CGRectGetWidth([UIScreen mainScreen].bounds)
#define SCREEN_HEIGHT  CGRectGetHeight([UIScreen mainScreen].bounds)
//#define WEAKSELF  __weak typeof (self)weakSelf = self;
#define NAVIGATION_BAR_HEIGHT  64
#define TAB_BAR_HEIGHT  49
#define TOOL_BAR_HEIGHT  40
#define SUCCESS_ANIMATION_DURATION  1.0
#define FAILE_ANIMATION_DURATION 1.2

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define SS(strongSelf)  __strong typeof(weakSelf) strongSelf = weakSelf;

//通知处理
#define addN(_selector,_name)\
([[NSNotificationCenter defaultCenter] addObserver:self selector:_selector name:_name object:nil])

#define removeNObserverWithName(_name)\
([[NSNotificationCenter defaultCenter] removeObserver:self name:_name object:nil])

#define removeNObserver() ([[NSNotificationCenter defaultCenter] removeObserver:self])

#define postN(_name)\
([[NSNotificationCenter defaultCenter] postNotificationName:_name object:nil userInfo:nil])

#define postNWithObj(_name,_obj)\
([[NSNotificationCenter defaultCenter] postNotificationName:_name object:_obj userInfo:nil])

#define postNWithInfos(_name,_obj,_infos)\
([[NSNotificationCenter defaultCenter] postNotificationName:_name object:_obj userInfo:_infos])


/* push */
#define pushVCChangeNavBar(_vc) ([self.navigationController pushViewControllerWithNavigationControllerTransition:_vc])
#define pushVC(_vc) ([self.navigationController pushViewController:_vc animated:YES])
#define pushVCClass(_class) ([self.navigationController pushViewController:[[_class class] create] animated:YES])
#define pushVCNoAnimated(_vc) ([self.navigationController pushViewController:_vc animated:NO])
#define popVC() ([self.navigationController popViewControllerAnimated:YES])
/* present  */
#define presentVC(_vc) ([self presentViewController:_vc animated:YES completion:nil])
#define presentNavVC(_vc) ([self presentViewController:[[UINavigationController alloc] initWithRootViewController:_vc] animated:YES completion:nil])


//输出日志
#ifdef DEBUG
#define FGLog(...) NSLog(__VA_ARGS__)
#define FGLogDetails(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#else
#define FGLog(...)
#define FGLogDetails(fmt, ...)
#endif

//默认头像
#define YMMDefaultHeadIcon @"headerDefault"

//头像尺寸
#define YMMIconSize CGSizeMake(70, 70)
#define YMMHighIconSize CGSizeMake(200, 200)

//颜色
#define FGColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define FGAlphaColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define FGRandomColor FGColor(arc4random()%256, arc4random()%256, arc4random()%256)
//disableColor
#define FGDisableColor [UIColor lightGrayColor]

//表格相关色
#define FGSeparatorColor FGAlphaColor(200, 199, 204, 1) //分割线x = 8 height = 1/3.0
#define FGTableBgGrayColor FGColor(246, 246, 246)

//导航栏相关颜色
#define YMMNavBarColor FGColor(242, 117, 164)
#define YMMNavItemNormalColor [UIColor whiteColor]
#define YMMNavItemHighColor [UIColor greenColor]
#define YMMNavItemGrayColor FGColor(238, 238, 238)

#define YMMNavItemTitleColor FGColor(101, 101, 101)
#define YMMNavItemSubTitleColor FGColor(191, 191, 191)
#define YMMNavItemPriceColor FGColor(248, 132, 174)
#define YMMNavItemInfoColor FGColor(189, 189, 189)

//是否为4英寸
#define is4Inch ([UIScreen mainScreen].bounds.size.height == 568.0)

//导航栏title字体大小
#define YMMTitleFont [UIFont boldSystemFontOfSize:19]
#define YMMNavItemTitleFont [UIFont systemFontOfSize:14]

//untitliy

#define PriceFormat(_price) [NSString stringWithFormat:@"%1.2f", (_price.intValue*1.0 / 100 )]

#endif /* ConstMacro_h */
