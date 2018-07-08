//
//  HTTPClient.h
//  AFN3.0
//
//  Created by Asingers on 16/6/2.
//  Copyright © 2016年 Yuanjie Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface HTTPClient : NSObject
@property (nonatomic,strong) AFHTTPSessionManager *session;
@property (nonatomic,strong) NSMutableDictionary *requestDic;
@property (nonatomic,strong) NSString *baseUrl;
-(void)requestDataAndCallBack:(void(^)(id data, NSString *errorMessage))callback
                   errorBlock:(void(^)(id data,NSError *error))errorBlock
               nonetWorkBlock:(void(^)(BOOL nonetWork))nonetWorkBlock;
-(void)requestDataPOSTAndCallBack:(void(^)(id data, NSString *errorMessage))callback
                   errorBlock:(void(^)(id data,NSError *error))errorBlock
               nonetWorkBlock:(void(^)(BOOL nonetWork))nonetWorkBlock;
-(void)requestDataDELETEAndCallBack:(void(^)(id data, NSString *errorMessage))callback
                       errorBlock:(void(^)(id data,NSError *error))errorBlock
                   nonetWorkBlock:(void(^)(BOOL nonetWork))nonetWorkBlock;
-(void)requestDownLoadAndCallBack:(void(^)(id data, NSString *errorMessage))callback
                       errorBlock:(void(^)(id data,NSError *error))errorBlock
                   nonetWorkBlock:(void(^)(BOOL nonetWork))nonetWorkBlock;
- (id)initWithBaseURL:(NSString *)base Dic:(NSDictionary *)dic;
@end
