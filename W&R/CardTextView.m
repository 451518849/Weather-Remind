//
//  CardTextView.m
//  W&R
//
//  Created by LIU KAIYANG on 16/2/4.
//  Copyright © 2016年 vt. All rights reserved.
//

#import "CardTextView.h"

@implementation CardTextView
-(instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title andNote:(NSString *)note andTime:(NSDate *)time
{
    self = [super init];
    if (self) {
        self.frame = frame;
        [self setup];
        NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
        [dateformatter setDateFormat: @"yyyy年MM月dd日 HH:mm"];
        NSString *date = [dateformatter stringFromDate:time];
        self.cardTitleLabel.text = title;
        self.cardTextView.text = note;
        self.cardTimeLabel.text = [NSString stringWithFormat:@"%@",date];
        
        self.cardTitleLabel.textColor = [UIColor whiteColor];
        self.cardTitleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:37];
        
        self.cardTextView.font = [UIFont systemFontOfSize:24];
        
    }
    return self;
}
#define HEIGHT 568.0
#define WIDTH 320.0
-(void)setup
{
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    self.cardTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20/WIDTH * width, 20/HEIGHT * height, 300/WIDTH * width, 31/HEIGHT * height)];
    self.cardTitleLabel.adjustsFontSizeToFitWidth = YES;   //*******
    self.cardTextView = [[UITextView alloc]initWithFrame:CGRectMake(20/WIDTH * width, 117/HEIGHT * height, 280/WIDTH * width, 236/HEIGHT * height)];
    self.cardTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(114/WIDTH * width, 88/HEIGHT * height, 186/WIDTH * width, 21/HEIGHT * height)];
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(20/WIDTH * width, 88/HEIGHT * height, 86/WIDTH * width, 21/HEIGHT * height)];
    self.label.text = @"计划时间：";
    self.cardTextView.backgroundColor = [UIColor clearColor];
    self.cardTextView.editable = NO;
    
    [self addSubview:self.label];
    [self addSubview:self.cardTimeLabel];
    [self addSubview:self.cardTextView];
    [self addSubview:self.cardTitleLabel];
}
-(void)finish
{
    NSString *oldPrice = self.cardTitleLabel.text;
    NSUInteger length = [oldPrice length];
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, length)];
    [self.cardTitleLabel setAttributedText:attri];

}
-(void)unfinish
{
    NSString *oldPrice = self.cardTitleLabel.text;
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    [self.cardTitleLabel setAttributedText:attri];
}
@end
