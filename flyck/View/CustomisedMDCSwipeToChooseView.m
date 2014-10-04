//
//  CustomisedMDCSwipeToChooseView.m
//  flyck
//
//  Created by EndoTsuyoshi on 2014/10/04.
//  Copyright (c) 2014年 in.thebase. All rights reserved.
//

#import "CustomisedMDCSwipeToChooseView.h"

@implementation CustomisedMDCSwipeToChooseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame options:(MDCSwipeToChooseViewOptions *)options{
    
    self = [self initWithFrame:frame options:options strProperty:nil];
    return self;
}
-(id)initWithFrame:(CGRect)rect
           options:options
       strProperty:(NSString *)strProperty{
    self = [super initWithFrame:rect options:options];
    
    if(self){
        if(strProperty == nil || [strProperty isEqual:[NSNull null]]){
            //そのまま
        }else{
            
        }
        
//        
//        //viewにラベルを貼付ける
//        // レイヤーの作成
//        CAGradientLayer *gradient = [CAGradientLayer layer];
//        
////        CGFloat heightOfGrad = 0.7f;
////        // レイヤーサイズをビューのサイズをそろえる
////        gradient.frame = CGRectMake(0, self.bounds.size.height*(1.f-heightOfGrad),
////                                    self.bounds.size.width,
////                                    self.bounds.size.height*heightOfGrad);
//        gradient.frame = self.bounds;
//        // 開始色と終了色を設定
//        gradient.colors = @[
//                            // 開始色
//                            (id)[UIColor colorWithRed:0 green:0 blue:0 alpha:1.f].CGColor,
//                            // 終了色
//                            (id)[UIColor colorWithRed:1 green:0 blue:0 alpha:1.f].CGColor
//                            ];
//        
//        // レイヤーを追加
//        [self.layer insertSublayer:gradient atIndex:0];
        
        NSLog(@"gradation");
    }
    
    return self;
}


- (void)drawRect:(CGRect)rect
{
    
    
    
    NSLog(@"drawRect");
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSArray *gradientColors = [NSArray arrayWithObjects:(id) [UIColor redColor].CGColor, [UIColor yellowColor].CGColor, nil];
    
    CGFloat gradientLocations[] = {0, 0.50, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) gradientColors, gradientLocations);
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

@end
