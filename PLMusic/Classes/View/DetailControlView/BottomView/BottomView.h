//
//  BottomView.h
//  PLMusic
//
//  Created by PengLiang on 2017/12/13.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomView : UIView

@property (nonatomic, strong) UIButton *preSongButton;
@property (nonatomic, strong) UIButton *nextSongButton;
@property (nonatomic, strong) UIButton *playOrPauseButton;
@property (nonatomic, strong) UIButton *playModeButton;
@property (nonatomic, strong) UIButton *songListButton;
@property (nonatomic, strong) UISlider *songSlider;
@property (nonatomic, strong) UILabel *currentTimeLabel;
@property (nonatomic, strong) UILabel *durationTimeLabel;

@end
