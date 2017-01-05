//
//  AppDelegate.h
//  Weather&Remind
//
//  Created by apple on 16/1/1.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol restartAnimationsDelegate;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) id<restartAnimationsDelegate> delegate;


@end

@protocol restartAnimationsDelegate

-(void)restartAnimations;

@end
