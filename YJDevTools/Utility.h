//
//  Utility.h
//  AFN3.0
//
//  Created by Asingers on 16/6/2.
//  Copyright © 2016年 Yuanjie Zhang. All rights reserved.
//

#define SF_COLOR(RED, GREEN, BLUE, ALPHA)	[UIColor colorWithRed:RED green:GREEN blue:BLUE alpha:ALPHA]
#define UTILITYCOLOR(a) [UtilityHelper colorWithHexString:(a)]

//有状态栏时的屏幕宽度
#define IISCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
//无状态栏时的屏幕高度
#define IISCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
#define ISIPHONE4 (ScreenH==(480)? (YES):(NO))
#define ISIPHONE5 (ScreenH==(568)? (YES):(NO))
#define ISIPHONE6 (ScreenH==(667)? (YES):(NO))
#define ISIPHONE6P (ScreenH==(736)? (YES):(NO))
#define ISIPHONEX (ScreenH==(812)? (YES):(NO))

//iphoneX的 安全区适配
#define NavHeight (ISIPHONEX? (88):(64))
#define BottomSafty (ISIPHONEX? (34):(0))
#define NavCenterY (ISIPHONEX? (66):(42))


#define WEAKSELF __weak typeof(self) weakSelf = self;

#define IOS8_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending )

#define IOS9_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"9.0"] != NSOrderedAscending )


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Reachability.h"
@interface Utility : NSObject

@end
@interface UtilityHelper : NSObject {
    
}
// 判断网络
+ (BOOL)isExistenceNetwork;
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;
@end

@interface UIView (UIViewUtils)

- (CGFloat)left;
- (void)setLeft:(CGFloat)x;
- (CGFloat)top;
- (void)setTop:(CGFloat)y;
- (CGFloat)right;
- (void)setRight:(CGFloat)right;
- (CGFloat)bottom;
- (void)setBottom:(CGFloat)bottom;
- (CGFloat)centerX;
- (void)setCenterX:(CGFloat)centerX;
- (CGFloat)centerY;
- (void)setCenterY:(CGFloat)centerY;
- (CGFloat)width;
- (void)setWidth:(CGFloat)width;
- (CGFloat)height;
- (void)setHeight:(CGFloat)height;
- (CGPoint)origin;
- (void)setOrigin:(CGPoint)origin;
- (CGSize)size;
- (void)setSize:(CGSize)size;
- (void)removeAllSubviews;

// 清除缓存:


@end
