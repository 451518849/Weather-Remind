//
//  CardTextView.h
//  W&R
//
//  Created by LIU KAIYANG on 16/2/4.
//  Copyright © 2016年 vt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardTextView : UIView
@property (nonatomic,strong) UILabel *cardTitleLabel;
@property (nonatomic,strong) UITextView *cardTextView;
@property (nonatomic,strong) UILabel *cardTimeLabel;
@property (nonatomic,strong) UILabel *label;

-(void)finish;
-(void)unfinish;
-(instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title andNote:(NSString *)note andTime:(NSDate *)time;
@end
