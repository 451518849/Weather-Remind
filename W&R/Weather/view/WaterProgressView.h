//
//  WaterProgressView.h
//  WaterProgress
//
//  Created by apple on 16/1/1.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SWING 1.5
#define CYCLE 0

#define SWING_ADD_NUMBER 0.01
#define SWING_MAX_NUMBER 1.5
#define SWING_MIN_NUMBER 1

#define SWING_ADD_CYCLE_NUMBER 0.1

#define SWING_WIDTH 1

#define WATER_COLOR [UIColor colorWithRed:209/255.0f green:124/255.0f blue:59/255.0f alpha:1]

@interface WaterProgressView : UIView

//波浪的颜色
@property(nonatomic,strong)UIColor *currentWaterColor;

//波浪的波峰,建议值 1～1.5
@property(nonatomic,assign) float swing;

//波浪的周期
@property(nonatomic,assign) float cycle;

//波浪的位置
@property(nonatomic,assign)float currentLinePointY;

@property(nonatomic,assign) BOOL swingFlag;

@end
