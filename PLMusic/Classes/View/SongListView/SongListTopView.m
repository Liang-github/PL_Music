//
//  SongListTopView.m
//  PLMusic
//
//  Created by PengLiang on 2017/12/12.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "SongListTopView.h"

@implementation SongListTopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 播放模式按键初始化
        _playMode = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width/2.5, self.frame.size.height)];
        [self addSubview:_playMode];
    }
    return self;
}

@end
