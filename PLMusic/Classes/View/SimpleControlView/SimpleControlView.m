//
//  SimpleControlView.m
//  PLMusic
//
//  Created by PengLiang on 2017/12/13.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "SimpleControlView.h"
#import <Masonry.h>
#import "Const.h"

@implementation SimpleControlView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(0xff0000);
        
        _albumImage = [[UIImageView alloc] init];
        [self addSubview:_albumImage];
        [_albumImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(5);
            make.left.equalTo(self).offset(5);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(60);
        }];
        
        _songName = [[UILabel alloc] init];
        _songName.font = [UIFont systemFontOfSize:18];
        [_songName setTextColor:UIColorFromRGB(0x000000)];
        [self addSubview:_songName];
        [_songName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(5);
            make.left.equalTo(_albumImage.mas_right).offset(5);
            make.width.mas_equalTo(150);
            make.height.mas_equalTo(35);
            
        }];
        
        _singerName = [[UILabel alloc] init];
        _singerName.font = [UIFont systemFontOfSize:12];
        _singerName.textColor = UIColorFromRGB(0x000000);
        [self addSubview:_singerName];
        [_singerName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_songName.mas_bottom).offset(5);
            make.left.equalTo(_albumImage.mas_right).offset(5);
            make.width.mas_equalTo(150);
            make.height.mas_equalTo(20);
        }];
        
        _nextBtn = [[UIButton alloc] init];
        [_nextBtn setImage:[UIImage imageNamed:@"cm2_fm_btn_next"] forState:UIControlStateNormal];
        [_nextBtn setImage:[UIImage imageNamed:@"cm2_fm_btn_next_prs"] forState:UIControlStateHighlighted];
        [self addSubview:_nextBtn];
        [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(10);
            make.right.equalTo(self).offset(20);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(50);
        }];
        
        _playOrPauseBtn = [[UIButton alloc] init];
        [_playOrPauseBtn setImage:[UIImage imageNamed:@"cm2_fm_btn_pause"] forState:UIControlStateNormal];
        [_playOrPauseBtn setImage:[UIImage imageNamed:@"cm2_fm_btn_pause_prs"] forState:UIControlStateHighlighted];
        [self addSubview:_playOrPauseBtn];
        [_playOrPauseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(10);
            make.right.equalTo(_nextBtn.mas_right).offset(10);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(50);
        }];
    }
    return self;
}

@end
