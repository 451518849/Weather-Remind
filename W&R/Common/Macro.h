//
//  Header.h
//  Weather&Remind
//
//  Created by apple on 16/1/2.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "Macro.h"

#ifndef Macro_h
#define Macro_h

/*
 *  时间日期格式
 *  日期：yyyy年MM月dd日
 *  时间：HH:mm:ss
 */
#define DATE_FORMATTER @"yyyy年MM月dd日 HH:mm:ss"
#define DATE_FORMATTER_YDM @"yyyy年MM月dd日"

/*---------------------------------------------------*/
/*---------------------------------------------------*/

/*
 *  TODAY_WEATHER_NOTIFICATION_KEY 今日推送的key
 *  TOMORROW_WEATHER_NOTIFICATION_KEY 明日推送的key
 *  TOMORROW_EVENT_NOTIFICATION_KEY 天气结合事件推送的key
 */
#define TODAY_WEATHER_NOTIFICATION_KEY @"todayWeather"
#define TOMORROW_WEATHER_NOTIFICATION_KEY @"tomorrowWeather"
#define TOMORROW_EVENT_NOTIFICATION_KEY @"tomorrowEvent"


/*
 *  TODAY_NOTIFICATION 用来记录今日推送开关的
 *  TOMORROW_NOTIFICATION 用来记录明日天气推送开关的
 *  NOTESNOTIFICATION 用来记录事件结合天气推送的开关的
 *  LOCATION 用来记录定位开关的
 *
 *  OPEN 开关打开
 *  CLOSE 开关关闭
 */

#define TODAY_NOTIFICATION @"todayNotification"
#define TOMORROW_NOTIFICATION @"tomorrowNotification"
#define NOTESNOTIFICATION @"notesNotification"
#define LOCATION @"location_orientation"

#define OPEN @"Yes"
#define CLOSE  @"NO"

/*
 *  当日天气推送时间为：07:00:00   暂时不推送
 *  明日天气推送时间为：今日19:30:00
 *  当天气下雨,并且明天有安排时会推送：今日 12:00:00
 */
#define TODAY_WEATHER_NOTIFICATION_TIME @"7:00:00"
#define TOMORROW_WEATHER_NOTIFICATION_TIME @"19:30:00"
#define RECENT_EVENT_NOTIFICATION_TIME @"12:00:00"

/*---------------------------------------------------*/
/*---------------------------------------------------*/


/*  获取天气的key、value设置以及请求uri
 *  APPKEY 为密钥
 *  SIGN 为签名
 *
 */

#define CITY @"city"
#define WEATHER_BASIC_URL @"http://api.k780.com:88"
#define TODAY @"today"
#define PM25 @"pm25"
#define FUTURE @"future"
#define APPKEY @"17053"
#define SIGN @"157825e19f9b8d7f932ade3d7c4a6458"
#define WEATHER_URL @"%@/?app=weather.%@&weaid=%@&appkey=%@&sign=%@&format=json"
#define FUTURE_WEATHER_URL @""

/*---------------------------------------------------*/
/*---------------------------------------------------*/

/*
 *  背景的uri，暂时不用
 */

#define BACKGROUND_IMAGE_URL @"http://www.chm123.com.cn/backgroundImage/background.jpeg"

#endif /* Header_h */
