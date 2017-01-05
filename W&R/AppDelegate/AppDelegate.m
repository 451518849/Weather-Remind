//
//  AppDelegate.m
//  Weather&Remind
//
//  Created by apple on 16/1/1.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "AppDelegate.h"
#import "Macro.h"
#import "AVFoundation/AVFoundation.h"
@interface AppDelegate ()
extern BOOL animationFlag;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //icon清零
    application.applicationIconBadgeNumber = 0;
    
    //第一次打开app记录下来
//    NSUserDefaults *userDefualts = [NSUserDefaults standardUserDefaults];
//    NSString *isFirstOpen = [userDefualts objectForKey:@"firstOpen"];
//    
//    if (![isFirstOpen isEqualToString:@"1"])
//    {
//        [userDefualts setObject:@"1" forKey:@"firstOpen"];
//        [userDefualts setObject:@"YES" forKey:@"todayNotification"];
//        [userDefualts setObject:@"YES" forKey:@"tomorrowNotification"];
//        [userDefualts setObject:@"YES" forKey:@"notesNotification"];
//        [userDefualts setObject:@"YES" forKey:@"backgroundImageUpdate"];
//        
//    }
    
    //ios8后的注册通知
    float sysVersion=[[UIDevice currentDevice]systemVersion].floatValue;
    if (sysVersion>=8.0) {
        UIUserNotificationType type=UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound;
        UIUserNotificationSettings *setting=[UIUserNotificationSettings settingsForTypes:type categories:nil];
        [[UIApplication sharedApplication]registerUserNotificationSettings:setting];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    //animationFlag = NO;
    //icon清零
 //   application.applicationIconBadgeNumber = 0;
    
    //开启后台运行
//    UIApplication*   app = [UIApplication sharedApplication];
//    __block    UIBackgroundTaskIdentifier bgTask;
//    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (bgTask != UIBackgroundTaskInvalid)
//            {
//                bgTask = UIBackgroundTaskInvalid;
//            }
//        });
//    }];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (bgTask != UIBackgroundTaskInvalid)
//            {
//                bgTask = UIBackgroundTaskInvalid;
//            }
//        });
//    });
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [self.delegate restartAnimations];
    application.applicationIconBadgeNumber = 0;

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//ios8以后需要注册本地推送
-(void) registerLocalNotification:(UIApplication*)application
{
    
}

//本地推送监测
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification*)notification{
    
    application.applicationIconBadgeNumber -= 1;
    
}


@end
