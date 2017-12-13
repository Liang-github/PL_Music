//
//  SimpleControlView.h
//  PLMusic
//
//  Created by PengLiang on 2017/12/13.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleControlView : UIView

@property (nonatomic, strong) UIImageView *albumImage;
@property (nonatomic, strong) UILabel *songName;
@property (nonatomic, strong) UILabel *singerName;
@property (nonatomic, strong) UIButton *playOrPauseBtn;
@property (nonatomic, strong) UIButton *nextBtn;

@end
