//
//  WeatherNotification.h
//  Weather&Remind
//
//  Created by apple on 16/1/10.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherNotification : NSObject

//今日天气推送体
+(void)locationNotificationOfTodayWeather;

//明日天气推送
+(void)locationNotificationOfFutureWeather;

/*
 *  根据天气情提醒事件
 *  @prama arrageDate 为明天的日期
 */
+(void)locationNotificationToArragementEvent;

/*
 *  事件推送
 *  @prama notesTitle 为事件的名称
 *  @prama notesDate 事件的执行时间
 */
+(void)locationNotificationOfNotesTitle:(NSString*)notesTitle notesDate:(NSDate*)notesDate;

//设置中关闭推送
+(void)cancelLocalNotificationWithkey:(NSString*)key;

/*
 *  给新增的notes设置闹钟
 *  @prama notesTitle 为事件的名称
 *  @prama key 根据key关闭推送
 *
 */
+(void)setNotesNotificationWithTitle:(NSString*)notesTitle Withkey:(NSString*)key;

//当删除notes时，关闭闹钟
+(void)cancelNotesNotificationWithkey:(NSString*)key;


@end
