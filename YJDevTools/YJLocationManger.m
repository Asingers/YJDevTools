//
//  LocationManger.m
//  LocationManger
//
//  Created by zhangyuanjie on 2018/7/20.
//  Copyright © 2018年 zhangyuanjie. All rights reserved.
//

#import "YJLocationManger.h"
@interface YJLocationManger ()<CLLocationManagerDelegate>

@property (nonatomic,copy) UpdateLocatonEndBlock updateLocatonEndBlock;
@end
@implementation YJLocationManger{
    CLLocationManager *_locationManager;
    BOOL _isResponds;
}
+ (instancetype)sharedInstance{
    
    static YJLocationManger *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[YJLocationManger alloc] init];
        sharedInstance.loctionName = @"未知";
        
    });
    
    return sharedInstance;
}

- (void)startMonitoringLocation{
    
    if (!_locationManager){
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        // 最精确定位
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.activityType = CLActivityTypeFitness;
        _locationManager.pausesLocationUpdatesAutomatically = NO;
        _locationManager.distanceFilter = kCLDistanceFilterNone;
    }
    _isResponds = NO;
    //仅在前台定位
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    NSLog(@"%d",[CLLocationManager locationServicesEnabled]);
    if ([CLLocationManager locationServicesEnabled] && (status == kCLAuthorizationStatusNotDetermined || status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse)) {
        [_locationManager requestWhenInUseAuthorization];
        [_locationManager startUpdatingLocation];
        
    }
    
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    //停止定位
    [manager stopUpdatingLocation];
    
    if (_isResponds ) {
        return;
    }
    // 1.获取用户位置的对象
    CLLocation *location = [locations lastObject];
    
    // 2.对地理位置进行反编码
    CLGeocoder * geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        self.loctionName = @"未知";
        
        if (!error) {
            for (CLPlacemark * placemark in placemarks) {
                
                NSString *cityString =@"未知";
                
                if (placemark.locality) {
                    cityString =  placemark.locality;
                    self.loctionName = cityString;
                }
            }
        }
        
        if (self.updateLocatonEndBlock ) {
            self.updateLocatonEndBlock(self->_loctionName,placemarks.count > 0 ?placemarks[0] :nil,location);
        }
    }];
    _isResponds = YES;
}


- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    
    NSLog(@"定位失败发送通知code：%li %@ ",error.code,_loctionName);
    if (_isResponds) {
        return;
    }
    if (self.updateLocatonEndBlock && _isResponds == NO) {
        self.updateLocatonEndBlock(_loctionName,nil,nil);
    }
    
}
//开始定位获取定位城市名称
- (void)startMonitoringLocationWithUpdateLocatonEndBlock:(UpdateLocatonEndBlock) updateLocatonEndBlock{
    
    self.updateLocatonEndBlock = updateLocatonEndBlock;
    
    [self startMonitoringLocation];
    
}
@end
