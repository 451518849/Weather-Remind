//
//  WaterProgressView.m
//  WaterProgress
//
//  Created by apple on 16/1/1.
//  Copyright © 2016年 wangxiaofa. All rights reserved.
//

#import "WaterProgressView.h"

@implementation WaterProgressView


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        [self setBackgroundColor:[UIColor clearColor]];
        _swing = SWING;
        _cycle = CYCLE;
        _swingFlag = NO;
        
        _currentWaterColor = WATER_COLOR;;
        _currentLinePointY = 20;
        self.layer.masksToBounds = YES;

        [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(anmiateWave) userInfo:nil repeats:YES];
        
    }
    
    return  self;
}

-(id)initWithFrame:(CGRect)frame currentWaterColor:(UIColor*)waterColor currentLinePOintY:(float)wavePointY waveCornerRaduis:(float)raduis cycleTime:(float)time
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self setBackgroundColor:[UIColor clearColor]];
        _swing = SWING;
        _cycle = CYCLE;
        _swingFlag = NO;

        _currentWaterColor = waterColor;
        _currentLinePointY = wavePointY;
        self.layer.cornerRadius = raduis;
        self.layer.masksToBounds = YES;
        
        [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(anmiateWave) userInfo:nil repeats:YES];
    }
    
    return self;
}

-(void)anmiateWave
{
    //这里是波峰值的大小范围判断
    if (_swingFlag)
    {
        _swing += SWING_ADD_NUMBER;
    }
    else
    {
        _swing -= SWING_ADD_NUMBER;
    }
    
    //当小于最小值是进行增加
    if (_swing <= SWING_MIN_NUMBER)
    {
        _swingFlag = YES;
    }
    
    //当大于最大值时进行递减
    if (_swing >= SWING_MAX_NUMBER)
    {
        _swingFlag = NO;
    }
    
    //周期频率的改变，当然也可以固定这个值
    _cycle += SWING_ADD_CYCLE_NUMBER;
    
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    //获取画布上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //创建划线路径
    CGMutablePathRef path = CGPathCreateMutable();
    
    //画波浪
    CGContextSetLineWidth(context, SWING_WIDTH);
    
    //填充颜色
    CGContextSetFillColorWithColor(context, [_currentWaterColor CGColor]);
    
    float y=_currentLinePointY;
    
    //起点
    CGPathMoveToPoint(path, NULL, rect.origin.x, y);
    
    for(float x = rect.origin.x;x <= rect.size.width;x ++){
        //利用sin(wx + C )填充直线
        y= _swing * sin( x/180*M_PI + 2*_cycle/M_PI ) + _currentLinePointY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    //其余封闭矩形的顶点
    CGPathAddLineToPoint(path, nil, rect.size.width, rect.size.height);
    CGPathAddLineToPoint(path, nil, rect.origin.x, rect.size.height);
    CGPathAddLineToPoint(path, nil, rect.origin.x, _currentLinePointY);
    
    
    CGContextAddPath(context, path);
    //填充路径
    CGContextFillPath(context);
    //渲染
    CGContextDrawPath(context, kCGPathStroke);
    //释放画笔，只一步是必须的
    CGPathRelease(path);
    
}

@end
