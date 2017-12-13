//
//  BottomView.m
//  PLMusic
//
//  Created by PengLiang on 2017/12/13.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "BottomView.h"

@implementation BottomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 上一曲按键设置
        _preSongButton = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width/5, frame.size.height/2.3, frame.size.width*0.2, frame.size.width*0.2)];
        [_preSongButton setImage:[UIImage imageNamed:@"cm2_fm_btn_pre"] forState:UIControlStateNormal];
        [_preSongButton setImage:[UIImage imageNamed:@"cm2_fm_btn_pre_prs"] forState:UIControlStateHighlighted];
        [self addSubview:_preSongButton];
        
        // 播放或暂停按键设置
        _playOrPauseButton = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width/2 - frame.size.width*0.1, frame.size.height/2.3, frame.size.width*0.2, frame.size.width*0.2)];
        [_playOrPauseButton setImage:[UIImage imageNamed:@"cm2_fm_btn_pause"] forState:UIControlStateNormal];
        [_playOrPauseButton setImage:[UIImage imageNamed:@"cm2_fm_btn_pause_prs"] forState:UIControlStateHighlighted];
        [self addSubview:_playOrPauseButton];
        
        // 下一曲按键设置
        _nextSongButton = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width/5*4 - frame.size.width*0.2, frame.size.height/2.3, frame.size.width*0.2, frame.size.width*0.2)];
        [_nextSongButton setImage:[UIImage imageNamed:@"cm2_fm_btn_next"] forState:UIControlStateNormal];
        [_nextSongButton setImage:[UIImage imageNamed:@"cm2_fm_btn_next_prs"] forState:UIControlStateHighlighted];
        [self addSubview:_nextSongButton];
        
        // 播放模式按键设置
        _playModeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, frame.size.height/2.3, frame.size.width*0.2, frame.size.width*0.2)];
        [_playModeButton setImage:[UIImage imageNamed:@"cm2_icn_loop"] forState:UIControlStateNormal];
        [_playModeButton setImage:[UIImage imageNamed:@"cm2_icn_loop_prs"] forState:UIControlStateHighlighted];
        [self addSubview:_playModeButton];
        
        // 歌曲列表按键设置
        _songListButton = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width*4/5, frame.size.height/2.3, frame.size.width*0.2, frame.size.width*0.2)];
        [_songListButton setImage:[UIImage imageNamed:@"cm2_icn_list"] forState:UIControlStateNormal];
        [_songListButton setImage:[UIImage imageNamed:@"cm2_icn_list_prs"] forState:UIControlStateHighlighted];
        [self addSubview:_songListButton];
        
        // 播放进度条
        _songSlider = [[UISlider alloc] initWithFrame:CGRectMake(frame.size.width/6, frame.size.height/4, frame.size.width*2/3, frame.size.height*0.2)];
        [_songSlider setThumbImage:[UIImage imageNamed:@"cm2_detail_knob_nomal"] forState:UIControlStateNormal];
        [_songSlider setThumbImage:[UIImage imageNamed:@"cm2_detail_knob_prs"] forState:UIControlStateHighlighted];
        _songSlider.tintColor = [UIColor whiteColor];
        [self addSubview:_songSlider];
        
        // 当前播放时间
        _currentTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, frame.size.height/4, frame.size.width/6 - 10, frame.size.height*0.2)];
        [_currentTimeLabel setTextColor:[UIColor whiteColor]];
        _currentTimeLabel.text = @"00:00";
        _currentTimeLabel.font = [UIFont systemFontOfSize:15];
        _currentTimeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_currentTimeLabel];
        
        // 整歌时间
        _durationTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width*5/6 + 5, frame.size.height/4, frame.size.width/6 - 10, frame.size.height*0.2)];
        _durationTimeLabel.textColor = [UIColor whiteColor];
        _durationTimeLabel.text = @"00:00";
        _durationTimeLabel.font = [UIFont systemFontOfSize:15];
        _durationTimeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_durationTimeLabel];
        
        
    }
    return self;
}

@end
