//
//  AlertSheetView.h
//  TestLanding
//
//  Created by loufq on 16/3/23.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^pushAlertSteet)(UIAlertController *alertController);
typedef void(^openLibary)(UIImagePickerController *picker);
typedef void(^returnBeformPage)();

@interface AlertSheetView : UIView <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) pushAlertSteet push;
@property (nonatomic, strong) openLibary picker;
@property (nonatomic, strong) returnBeformPage returnPage;
- (void)showSheetView;
@end
