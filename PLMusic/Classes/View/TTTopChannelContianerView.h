//
//  TTTopChannelContianerView.h
//  PLMusic
//
//  Created by PengLiang on 2017/12/13.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TTTopchannelContianerViewDelegate<NSObject>

@optional
- (void)showOrHiddenAddChannelsCollectionView:(UIButton *)button;
- (void)chooseChannelWithIndex:(NSInteger)index;

@end

@interface TTTopChannelContianerView : UIView

- (void)addChannelButtonWithChannelName:(NSString *)channelName;
- (void)selectChannelButtonWithIndex:(NSInteger)index;
- (void)deleteChannelButtonWithIndex:(NSInteger)index;

@property (nonatomic, strong) NSArray *channelNameArray;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) id<TTTopchannelContianerViewDelegate> delegate;
@end
