//
//  SCIconView.m
//  PLMusic
//
//  Created by PengLiang on 2017/12/13.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "SCIconView.h"

@implementation SCIconView

// 开始旋转
- (void)startRotating {
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotateAnimation.fromValue = [NSNumber numberWithFloat:0];
    rotateAnimation.toValue = [NSNumber numberWithFloat:M_PI*2];// 旋转一周
    rotateAnimation.duration = 20;
    rotateAnimation.repeatCount = MAXFLOAT;
    [self.layer addAnimation:rotateAnimation forKey:nil];
}
// 停止旋转
- (void)stopRotating {
    CFTimeInterval pausedTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.layer.speed = 0;// 停止旋转
    self.layer.timeOffset = pausedTime;
    // 保存时间，恢复旋转需要用到
    
}
// 恢复旋转
- (void)resumeRotate {
    if (self.layer.timeOffset == 0) {
        [self startRotating];
        return;
    }
    
    CFTimeInterval pausedTime = self.layer.timeOffset;
    self.layer.speed = 1;
    self.layer.timeOffset = 0;
    self.layer.beginTime = 0;
    CFTimeInterval timeSincePause = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.layer.beginTime = timeSincePause;
}

@end