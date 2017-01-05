//
//  ViewController.h
//  Weather&Remind
//
//  Created by apple on 16/1/1.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol setScrollDelegate <NSObject>

-(void)enableScroll;
-(void)disableScroll;

@end
//
//@protocol helpDelegate <NSObject>
//
//-(void)makeHelpCards;
//
//@end

@interface WeatherController : UIViewController<UIScrollViewDelegate>

@property (nonatomic) id<setScrollDelegate> setScrollDelegate;
//@property (nonatomic) id<helpDelegate> helpDelegate;

@end

