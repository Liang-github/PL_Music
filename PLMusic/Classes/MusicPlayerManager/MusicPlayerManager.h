//
//  MusicPlayerManager.h
//  PLMusic
//
//  Created by PengLiang on 2017/12/12.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

typedef enum : NSUInteger {
    RepeatPlayMode,
    RepeatOnlyOnePlayMode,
    ShufflePlayMode,
} ShuffleAndRepeatState;


@interface MusicPlayerManager : NSObject

@property (nonatomic, strong) AVPlayer *play;
@property (nonatomic, strong) AVPlayerItem *playItem;
@property (nonatomic, assign) ShuffleAndRepeatState shuffleAndRepeatState;
@property (nonatomic, assign) NSInteger playingIndex;

+ (MusicPlayerManager *)sharedManager;
- (void)setPlayItem:(NSString *)songURL;
- (void)setPlay;
- (void)startPlay;
- (void)stopPlay;
- (void)play:(NSString *)songURL;

@end
