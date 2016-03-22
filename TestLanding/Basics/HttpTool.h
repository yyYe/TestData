//
//  HttpTool.h
//  TestLanding
//
//  Created by loufq on 16/3/19.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>


@interface Params : NSObject

@property (strong, nonatomic) NSMutableDictionary *data;
@property (strong, nonatomic) NSMutableDictionary *header;
+ (instancetype)paramsWithMsgType:(NSString*)msgType;
+ (instancetype)createWithMsgType:(NSString*)msgType;

@end

//文件对象基类
@interface FGBaseFile : NSObject

@property (nonatomic, strong) NSData *data;
@property (nonatomic, copy) NSString *name; //参数名
@property (nonatomic, copy) NSString *filename; //文件名
@property (nonatomic, copy) NSString *mimeType; //文件类型

+ (instancetype)fileWithData:(NSData *)data;

@end

/**  默认jpg格式   */
@interface FGPictureFile : FGBaseFile


@end

@interface HttpTool : NSObject

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSString *errorMsg, NSString *statusCode))failure;

@end
