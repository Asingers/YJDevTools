//
//  HTTPClient.m
//  AFN3.0
//
//  Created by Asingers on 16/6/2.
//  Copyright © 2016年 Yuanjie Zhang. All rights reserved.
//
#import "Utility.h"
#import "HTTPClient.h"
#import "MJExtension.h"
@implementation HTTPClient
/**
 *  初始化请求参数
 *
 *  @param base url
 *  @param dic  参数
 *
 *  @return 请求地址
 */
- (id)initWithBaseURL:(NSString *)base Dic:(NSMutableDictionary *)dic{
    self = [super init];
    if (self){
        NSMutableString * str = [NSMutableString stringWithString:base];
        for (int i = 0; i<dic.allKeys.count; i++) {
            NSString * key = [dic.allKeys objectAtIndex:i];
            NSString * value = [dic objectForKey:key];
            [str appendFormat:@"%@=%@",key,value];
            if (i!=(dic.allKeys.count-1)) {
                [str appendString:@"&"];
            }
        }
        // 参数种可能会有空格,需要编码处理
        self.baseUrl = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        self.requestDic = dic;
        NSLog(@"url = %@",str);
    }
    return self;
}
/**
 *  通用请求方法
 *
 *  @param callback       返回数据
 *  @param errorBlock     错误
 *  @param nonetWorkBlock 无网
 */
-(void)requestDataAndCallBack:(void(^)(id data, NSString *errorMessage))callback
                   errorBlock:(void(^)(id data, NSError *error))errorBlock
               nonetWorkBlock:(void(^)(BOOL nonetWork))nonetWorkBlock{
    
    BOOL net = [UtilityHelper isExistenceNetwork];
    if (!net&&nonetWorkBlock) {
        nonetWorkBlock(net);
        return;
    }
    self.session = [AFHTTPSessionManager manager];
    self.session.requestSerializer.timeoutInterval = 30;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self.session GET:self.baseUrl parameters:self.requestDic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callback(responseObject,@"");
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(nil,error);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];

}
-(void)requestDataPOSTAndCallBack:(void(^)(id data, NSString *errorMessage))callback
                       errorBlock:(void(^)(id data,NSError *error))errorBlock
                   nonetWorkBlock:(void(^)(BOOL nonetWork))nonetWorkBlock{
    BOOL net = [UtilityHelper isExistenceNetwork];
    if (!net&&nonetWorkBlock) {
        nonetWorkBlock(net);
        return;
    }
    self.session = [AFHTTPSessionManager manager];
    self.session.requestSerializer.timeoutInterval = 30;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self.session POST:self.baseUrl parameters:self.requestDic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callback(responseObject,@"");
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(nil,error);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
}
-(void)requestDataDELETEAndCallBack:(void(^)(id data, NSString *errorMessage))callback
                         errorBlock:(void(^)(id data,NSError *error))errorBlock
                     nonetWorkBlock:(void(^)(BOOL nonetWork))nonetWorkBlock{
    BOOL net = [UtilityHelper isExistenceNetwork];
    if (!net&&nonetWorkBlock) {
        nonetWorkBlock(net);
        return;
    }
    self.session = [AFHTTPSessionManager manager];
    self.session.requestSerializer.timeoutInterval = 30;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [self.session DELETE:self.baseUrl parameters:self.requestDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callback(responseObject,@"");
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(nil,error);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

    }];
}
-(void)requestDownLoadAndCallBack:(void(^)(id data, NSString *errorMessage))callback
                       errorBlock:(void(^)(id data,NSError *error))errorBlock
                   nonetWorkBlock:(void(^)(BOOL nonetWork))nonetWorkBlock{
    BOOL net = [UtilityHelper isExistenceNetwork];
    if (!net&&nonetWorkBlock) {
        nonetWorkBlock(net);
        return;
    }
    self.session = [AFHTTPSessionManager manager];
    self.session.requestSerializer.timeoutInterval = 30;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    [self.session GET:self.baseUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callback(responseObject,@"");
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(nil,error);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

    }];
}
@end
