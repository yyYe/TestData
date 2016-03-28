//
//  AppDelegate.m
//  TestLanding
//
//  Created by loufq on 16/3/18.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "AppDelegate.h"
#import <AFNetworking/AFNetworking.h>

static NSString *const kToken = @"16f42d445a3341d7bbe2fb7d5d7af1cc87797030419345647975199807067420";
static NSString *const kHeartbeat = @"http://app.yimama.com.cn/api/heartbeat";

@interface AppDelegate ()
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSDictionary *dict = @{
                           @"data":@{
                                   @"token":kToken
                                   },
                           @"header":@{
                                   @"clientRes":@"iOS",
                                   @"msgId":@"9667B374-7534-4479-8394-C4C9A7EECB3B",
                                   @"timestamp":@"2016-03-25 23:21:09.000",
                                   @"msgType":@"heartbeat",
                                   }
                           };
    self.manager = [AFHTTPSessionManager manager];
    self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/javascript",@"application/json",@"text/json", @"text/html", nil];
    [self.manager POST:kHeartbeat parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *resultCode = responseObject[@"resultCode"];
        if ([[resultCode substringFromIndex:resultCode.length-1] isEqual:@"0"]) {
            NSLog(@"心跳成功");
        } else {
            NSLog(@"心跳失败");
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-%@",error);
    }];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
