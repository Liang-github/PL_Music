//
//  SongListTableViewCell.m
//  PLMusic
//
//  Created by PengLiang on 2017/12/12.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "SongListTableViewCell.h"

@implementation SongListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _songNumber = [[UILabel alloc] init];
        _songNumber.font = [UIFont systemFontOfSize:20];
        _songNumber.textColor = [UIColor blackColor];
        _songNumber.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_songNumber];
        [_songNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(5);
            make.left.equalTo(self).offset(5);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(60);
        }];
        
        // 创建歌名label添加到cell中
        _songName = [[UILabel alloc] init];
        _songName.font = [UIFont systemFontOfSize:18];
        _songName.textColor = [UIColor blackColor];
        [self addSubview:_songName];
        [_songName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(5);
            make.left.equalTo(_songNumber.mas_right).offset(5);
            make.width.mas_equalTo(150);
            make.height.mas_equalTo(35);
        }];
        // 创建歌手名label添加到cell中
        _singerName = [[UILabel alloc] init];
        _singerName.font = [UIFont systemFontOfSize:12];
        _singerName.textColor = [UIColor blackColor];
        [self addSubview:_singerName];
        [_singerName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_songName.mas_bottom).offset(5);
            make.left.equalTo(_songNumber.mas_right).offset(5);
            make.width.mas_equalTo(150);
            make.height.mas_equalTo(20);
        }];
    }
    return self;
}

@end
