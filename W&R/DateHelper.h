//
//  DateHelper.h
//  W&R
//
//  Created by apple on 16/3/31.
//  Copyright © 2016年 vt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Macro.h"

@interface DateHelper : NSObject

/*
 *  获取所在年
 */
+(NSString*)getTodayYear;

/*
 *  获取所在月
 */
+(NSString*)getTodayMonth;

/*
 *  获取所在日
 */
+(NSString*)getTodayDay;

/*---------------------------------------------------*/
/*---------------------------------------------------*/

/*
 *  获取明天的日期 yyyy年MM月dd日
 */
+(NSString*)getTomorrowDateByYMD;

/*---------------------------------------------------*/
/*---------------------------------------------------*/

/*
 *  设置事件根据天气推送的时间
 */
+(NSString*)setRecentEventNotificationTime;

/*
 *  设置明天的天气的推送（今天推送）
 */
+(NSString*)setTommorrowWeatherNotificationTime;


@end
