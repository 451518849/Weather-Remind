//
//  WeatherNotification.m
//  Weather&Remind
//
//  Created by apple on 16/1/10.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "WeatherNotification.h"
#import "Macro.h"
#import "DateHelper.h"

extern NSMutableArray *eventTitle;
extern NSMutableArray *eventNotes;
extern NSMutableArray *eventTime;
extern NSMutableArray *eventStatus;
extern NSMutableArray *colors;
extern NSMutableArray *eventDate;
extern NSMutableArray *eventString;


@implementation WeatherNotification

+(void)locationNotificationOfTodayWeather
{
    UILocalNotification *todayWeatherNotification = [[UILocalNotification alloc]init];
    NSUserDefaults *userDefualts = [NSUserDefaults standardUserDefaults];
  //  NSString *todayNofifcation = [userDefualts objectForKey:TODAY_NOTIFICATION];
        //获取已经保存的今日天天气状况
    NSString *todayAirQuilty = [userDefualts objectForKey:@"todayAirQuilty"];
    NSString *airRemark = [userDefualts objectForKey:@"airRemark"];
        
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
   // [formatter setDateFormat:TIME_FORMATTER];
    NSDate *notificationTime = [formatter dateFromString:TODAY_WEATHER_NOTIFICATION_TIME];//触发通知的时间
        
    todayWeatherNotification.fireDate = notificationTime;
    todayWeatherNotification.repeatInterval = NSCalendarUnitDay;
    todayWeatherNotification.timeZone = [NSTimeZone defaultTimeZone];
    todayWeatherNotification.alertTitle = @"健康提示";
    todayWeatherNotification.alertBody = [NSString stringWithFormat:@"今日%@,温馨提示：%@",todayAirQuilty,airRemark];
    todayWeatherNotification.soundName = UILocalNotificationDefaultSoundName;
    [todayWeatherNotification setApplicationIconBadgeNumber:0]; //右上角红色数字
    NSDictionary *userIfo = [NSDictionary dictionaryWithObject:@"今日天气推送" forKey:TODAY_WEATHER_NOTIFICATION_KEY];
    todayWeatherNotification.userInfo = userIfo;
    [[UIApplication sharedApplication]scheduleLocalNotification:todayWeatherNotification]; //推送注册
}

+(void)locationNotificationOfFutureWeather
{
    
        UILocalNotification *futureWeatherNotification = [[UILocalNotification alloc]init];
        if (futureWeatherNotification != nil)
        {
            NSUserDefaults *userDefualts = [NSUserDefaults standardUserDefaults];
            NSString *tomorrowWeather = [userDefualts objectForKey:@"tomorrowWeather"];
            NSString *tomorrowTemperature = [userDefualts objectForKey:@"tomorrowTemperature"];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:DATE_FORMATTER];
            NSDate *notificationTime = [formatter dateFromString:[DateHelper setTommorrowWeatherNotificationTime]];//触发通知的时间
            NSLog(@"明天天气推送时间%@",[DateHelper setTommorrowWeatherNotificationTime]);
            futureWeatherNotification.fireDate = notificationTime;
            futureWeatherNotification.timeZone = [NSTimeZone defaultTimeZone];
            
            //明天天气情况的预报，如果下雨则进行提示
            futureWeatherNotification.alertTitle = @"明日天气预报";
            futureWeatherNotification.alertBody = [NSString stringWithFormat:@"明天%@,温度%@",tomorrowWeather,tomorrowTemperature];
            futureWeatherNotification.soundName = UILocalNotificationDefaultSoundName;
            [futureWeatherNotification setApplicationIconBadgeNumber:1];
            NSDictionary *userIfo = [NSDictionary dictionaryWithObject:@"明日天气推送" forKey:TOMORROW_WEATHER_NOTIFICATION_KEY];
            futureWeatherNotification.userInfo = userIfo;
            [[UIApplication sharedApplication]scheduleLocalNotification:futureWeatherNotification];
        }
}

+(void)locationNotificationToArragementEvent
{
    
    //时间判断
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:DATE_FORMATTER_YDM];
    NSString *tommorrowDate = [DateHelper getTomorrowDateByYMD];
    
    UILocalNotification *tomorrowEventNotification = [[UILocalNotification alloc]init];
    
    
    for (int i = 0; i < eventDate.count; i++) {
        
        NSString *arrageDateString = [formatter stringFromDate: [eventDate objectAtIndex:i]];
        
        if ([tommorrowDate isEqualToString:arrageDateString]) {
            NSUserDefaults *userDefualts = [NSUserDefaults standardUserDefaults];
            NSString *tomorrowWeather = [userDefualts objectForKey:TOMORROW_WEATHER_NOTIFICATION_KEY];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:DATE_FORMATTER];
            NSDate *notificationTime = [formatter dateFromString:[DateHelper setRecentEventNotificationTime]];//触发通知的时间
            NSLog(@"事件推送：%@",[DateHelper setRecentEventNotificationTime]);
            tomorrowEventNotification.fireDate = notificationTime;
            tomorrowEventNotification.timeZone = [NSTimeZone defaultTimeZone];
            //明天天气情况的预报，如果下雨则进行提示
            tomorrowEventNotification.alertTitle = @"事件提示";
            tomorrowEventNotification.alertBody = [NSString stringWithFormat:@"明天%@,您安排了%@,是否会受影响",tomorrowWeather,eventTitle[i]];
            tomorrowEventNotification.soundName = UILocalNotificationDefaultSoundName;
            [tomorrowEventNotification setApplicationIconBadgeNumber:1];
            NSDictionary *userIfo = [NSDictionary dictionaryWithObject:@"明日事件推送" forKey:TOMORROW_EVENT_NOTIFICATION_KEY];
            tomorrowEventNotification.userInfo = userIfo;
            [[UIApplication sharedApplication]scheduleLocalNotification:tomorrowEventNotification];
        }
    }
    
}

+(void)locationNotificationOfNotesTitle:(NSString*)notesTitle notesDate:(NSDate*)notesDate
{
    UILocalNotification *notesNotification = [[UILocalNotification alloc]init];
    if (notesNotification != nil)
    {
        notesNotification.fireDate = notesDate;
        notesNotification.alertTitle = @"事件提醒";
        notesNotification.alertBody = [NSString stringWithFormat:@"今日安排了 %@",notesTitle];
        notesNotification.soundName = UILocalNotificationDefaultSoundName;
        [notesNotification setApplicationIconBadgeNumber:1];
        NSDictionary *userIfo = [NSDictionary dictionaryWithObject:@"事件推送" forKey:@"todayEvent"];
        notesNotification.userInfo = userIfo;
        [[UIApplication sharedApplication]scheduleLocalNotification:notesNotification];
    }
}

+(void)setNotesNotificationWithTitle:(NSString*)notesTitle  Withkey:(NSDate*)notesDate
{
    UILocalNotification *notesNotification = [[UILocalNotification alloc]init];
    if (notesNotification != nil)
    {
        //将事件的提醒时间转换成字符串设置为key
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:DATE_FORMATTER];
        NSString *key = [formatter stringFromDate:notesDate];
        
        notesNotification.fireDate = notesDate;
        notesNotification.repeatInterval = kCFCalendarUnitDay;
        notesNotification.alertTitle = @"事件提醒";
        notesNotification.alertBody = [NSString stringWithFormat:@"今日安排了 %@",notesTitle];
        notesNotification.soundName = UILocalNotificationDefaultSoundName;
        [notesNotification setApplicationIconBadgeNumber:1];
        NSDictionary *userIfo = [NSDictionary dictionaryWithObject: notesDate forKey:key];
        notesNotification.userInfo = userIfo;
        [[UIApplication sharedApplication]scheduleLocalNotification:notesNotification];
    }
    
}

+(void)cancelNotesNotificationWithkey:(NSDate*)notesDate
{
    //将事件的提醒时间转换成字符串设置为key
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:DATE_FORMATTER];
    NSString *key = [formatter stringFromDate:notesDate];
    
    NSArray *locationNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    for (UILocalNotification *notification in locationNotifications)
    {
        NSDictionary *userInfo = notification.userInfo;
        if (userInfo)
        {
            NSString *info = userInfo[key];
            if (info != nil)
            {
                [[UIApplication sharedApplication] cancelLocalNotification:notification];
             //   break;
            }
        }
    }
    
}

+(void)cancelLocalNotificationWithkey:(NSString*)key
{
    NSArray *locationNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    for (UILocalNotification *notification in locationNotifications)
    {
        NSDictionary *userInfo = notification.userInfo;
        if (userInfo)
        {
            NSString *info = userInfo[key];
            if (info != nil)
            {
                [[UIApplication sharedApplication] cancelLocalNotification:notification];
              //  break;
            }
        }
    }
}


@end
