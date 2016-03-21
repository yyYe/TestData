//
//  HttpTool.h
//  TestLanding
//
//  Created by loufq on 16/3/19.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FGParams : NSObject

@property (strong, nonatomic) NSMutableDictionary *data;
@property (strong, nonatomic) NSMutableDictionary *header;
+ (instancetype)paramsWithMsgType:(NSString*)msgType;
+ (instancetype)createWithMsgType:(NSString*)msgType;

@end


@interface HttpTool : NSObject
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSString *errorMsg, NSString *statusCode))failure;

+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSString *errorMsg, NSString *statusCode))failure;
@end
