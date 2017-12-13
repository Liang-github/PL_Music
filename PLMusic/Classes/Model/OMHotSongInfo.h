//
//  OMHotSongInfo.h
//  PLMusic
//
//  Created by PengLiang on 2017/12/12.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OMHotSongInfo : NSObject

@property (nonatomic, strong) UIImage *albumImage_big;
@property (nonatomic, strong) UIImage *albumImage_small;
@property (nonatomic, copy) NSString *pic_big;
@property (nonatomic, copy) NSString *lrclink;
@property (nonatomic, copy) NSString *pic_small;
@property (nonatomic, copy) NSString *song_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *album_title;
@property (nonatomic, copy) NSString *file_duration;

@end
