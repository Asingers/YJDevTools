//
//  LocationManger.h
//  LocationManger
//
//  Created by zhangyuanjie on 2018/7/20.
//  Copyright © 2018年 zhangyuanjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^UpdateLocatonEndBlock)(NSString *loctionName,CLPlacemark * placemark,CLLocation *userLocation);

@interface YJLocationManger : NSObject
@property (nonatomic,copy) NSString *loctionName; //实际定位的城市名
+ (instancetype)sharedInstance;
- (void)startMonitoringLocationWithUpdateLocatonEndBlock:(UpdateLocatonEndBlock) updateLocatonEndBlock;
@end
