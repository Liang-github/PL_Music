//
//  TopView.m
//  PLMusic
//
//  Created by PengLiang on 2017/12/13.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "TopView.h"

@implementation TopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 40, 40)];
        [_backBtn setImage:[UIImage imageNamed:@"cm2_live_btn_back"] forState:UIControlStateNormal];
        [_backBtn setImage:[UIImage imageNamed:@"cm2_live_btn_back_prs"] forState:UIControlStateHighlighted];
        [self addSubview:_backBtn];
        
        _songTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, frame.size.width - 20, frame.size.height/2)];
        [_songTitleLabel setFont:[UIFont systemFontOfSize:20]];
        [_songTitleLabel setTextColor:[UIColor whiteColor]];
        _songTitleLabel.text = @"";
        _songTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_songTitleLabel];
        
        _singerNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, frame.size.height/2 - 20, frame.size.width - 20, frame.size.height/2 - 30)];
        [_singerNameLabel setFont:[UIFont systemFontOfSize:17]];
        _singerNameLabel.textColor = [UIColor whiteColor];
        _singerNameLabel.text = @"";
        _singerNameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_singerNameLabel];
    }
    return self;
}

@end
