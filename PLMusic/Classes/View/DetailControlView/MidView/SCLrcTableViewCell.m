//
//  SCLrcTableViewCell.m
//  PLMusic
//
//  Created by PengLiang on 2017/12/13.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "SCLrcTableViewCell.h"

@implementation SCLrcTableViewCell

AnimationType *animationType = translation;

+ (SCLrcTableViewCell *)SC_CellForRowWithTableView:(UITableView *)tableView {
    NSString *cellID = @"lrccellID";
    SCLrcTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[SCLrcTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
}
- (void)addAnimation:(AnimationType)animationType {
    switch (animationType) {
        case translation:
        {
            [self.layer removeAnimationForKey:@"translation"];
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
            animation.values = [NSArray arrayWithObjects:[NSNumber numberWithDouble:50], [NSNumber numberWithDouble:0], [NSNumber numberWithDouble:50], [NSNumber numberWithDouble:0], nil];
            animation.duration = 0.7;
            animation.repeatCount = 1;
            [self.layer addAnimation:animation forKey:@"translation"];
        }
            break;
        case scale:
        {
            [self.layer removeAnimationForKey:@"scale"];
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
            animation.values = [NSArray arrayWithObjects:[NSNumber numberWithDouble:0.5], [NSNumber numberWithDouble:1.0], nil];
            animation.duration = 0.7;
            animation.repeatCount = 1;
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            
            [self.layer addAnimation:animation forKey:@"scale"];
        }
            break;
        case rotation:
        {
            [self.layer removeAnimationForKey:@"rotation"];
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
            animation.values = [NSArray arrayWithObjects:[NSNumber numberWithDouble:(-1 / 6 * M_PI)], [NSNumber numberWithDouble:0], [NSNumber numberWithDouble:(1 / 6 * M_PI)], [NSNumber numberWithDouble:0], nil];
            animation.duration = 0.7;
            animation.repeatCount = 1;
            [self.layer addAnimation:animation forKey:@"rotation"];
        }
            break;
        case scaleAlways:
        {
            CABasicAnimation *animatio1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            
            animatio1.repeatCount = 1;
            animatio1.duration = 0.6;
            animatio1.autoreverses = YES; // 动画结束时执行逆动画
            
            // 缩放倍数
            animatio1.fromValue = [NSNumber numberWithFloat:1.0]; // 开始时的倍率
            animatio1.toValue = [NSNumber numberWithFloat:1.2]; // 结束时的倍率
            [self.layer addAnimation:animatio1 forKey:@"scale-layer"];
        }
            break;
        case scaleNormal:
        {
            
        }
            break;
        default:
            break;
    }
}
@end
