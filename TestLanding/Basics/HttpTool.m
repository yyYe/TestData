//
//  HttpTool.m
//  TestLanding
//
//  Created by loufq on 16/3/19.
//  Copyright © 2016年 yeyy. All rights reserved.
//

#import "HttpTool.h"

@implementation HttpTool

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSString *errorMsg, NSString *statusCode))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/javascript",@"application/json",@"text/json", @"text/html", nil];
    
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"responseObject-%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-%@",error);
    }];
}

+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSString *errorMsg, NSString *statusCode))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/javascript",@"application/json",@"text/json", @"text/html", nil];
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject-%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-%@",error);
    }];
}

@end


@implementation FGBaseFile

+ (instancetype)fileWithData:(NSData *)data{
    FGBaseFile *file = [[self alloc]init];
    file.data = data;
    return file;
}

@end

@implementation FGPictureFile

- (instancetype)init{
    if (self = [super init]) {
        NSString *name = [NSString stringWithFormat:@"%@.jpg",[self generateMsgId]];
        self.name = name;
        self.filename = name;
        self.mimeType = @"image/jpeg";
    }
    
    return self;
}

- (NSString *)generateMsgId{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];
    CFRelease(uuid_string_ref);
    return uuid;
}


@end

@implementation Params

- (instancetype)init{
    if (self = [super init]) {
        self.data = [@{} mutableCopy];
        
        self.header = [@{} mutableCopy];
        self.header[@"clientRes"] = @"iOS";
//        self.header[@"msgId"] = [UIDevice generateMsgId];
        self.header[@"timestamp"] = [self fetchTimestamp]; //"2015-11-09 16:50:44.091"
    }
    return self;
}

+ (instancetype)paramsWithMsgType:(NSString*)msgType{
    Params *params = [[self alloc]init];
    params.header[@"msgType"] = msgType ? msgType : @"";
    return params;
}

+ (instancetype)createWithMsgType:(NSString*)msgType{
    Params* params =[[self alloc]init];
    params.header[@"msgType"] = msgType ? msgType : @"";
    
    return params;
}

- (NSString *)fetchTimestamp{
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *str = [fmt stringFromDate:now];
    NSString *timestamp = [NSString stringWithFormat:@"%@.000", str];
    return timestamp;
}

@end
