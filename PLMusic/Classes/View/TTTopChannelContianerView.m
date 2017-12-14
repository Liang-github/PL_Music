//
//  TTTopChannelContianerView.m
//  PLMusic
//
//  Created by PengLiang on 2017/12/13.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import "TTTopChannelContianerView.h"

@interface TTTopChannelContianerView ()

@property (nonatomic, weak) UIButton *lastSelectedButton;

@property (nonatomic, weak) UIView *indicatorView;

@end

static CGFloat kTitleLabelNorimalFont = 13;
static CGFloat kTitleLabelSelectedFont = 16;
static CGFloat kAddChannelWidth = 30;
static CGFloat kSliderViewWidth = 20;
static CGFloat buttonWidth = 70;

@implementation TTTopChannelContianerView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialization];
    }
    return self;
}

- (void)setChannelNameArray:(NSArray *)channelNameArray {
    _channelNameArray = channelNameArray;
    self.scrollView.contentSize = CGSizeMake(buttonWidth*channelNameArray.count, 0);
    for (NSInteger i = 0; i < channelNameArray.count; i ++) {
        UIButton *button = [self createChannelButton];
        button.frame = CGRectMake(i*buttonWidth, 0, buttonWidth, self.frame.size.height);
        [button setTitle:channelNameArray[i] forState:UIControlStateNormal];
        [self.scrollView addSubview:button];
    }
    // 默认选中第一个channelButton
    [self clickChannelButton:self.scrollView.subviews[1]];
}
#pragma mark - 初始化子控件
- (void)initialization {
    self.alpha = 0.9;
    
    UIScrollView *scrollView = [self createScrollView];
    self.scrollView = scrollView;
    [self addSubview:self.scrollView];
    
    // 初始化被选中的channelButton的红线，也就是indicatorView
    UIView *indicatorView = [self createIndicatorView];
    self.indicatorView = indicatorView;
    [self.scrollView addSubview:self.indicatorView];
}
#pragma mark - 创建容纳channelButton的scrollview
- (UIScrollView *)createScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    self.scrollView = scrollView;
    scrollView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    return scrollView;
}

- (UIView *)createSliderView {
    UIImageView *sliderView = [[UIImageView alloc] init];
    sliderView.frame = CGRectMake(self.frame.size.width - kSliderViewWidth - kAddChannelWidth, 0, kSliderViewWidth, self.frame.size.height);
    sliderView.alpha = 0.9;
    sliderView.image = [UIImage imageNamed:@"slidetab_mask"];
    return sliderView;
}
- (UIView *)createIndicatorView {
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor colorWithRed:243/255.0 green:75/255.0 blue:80/255.0 alpha:1];
    [self addSubview:indicatorView];
    return indicatorView;
}
- (UIButton *)createChannelButton {
    UIButton *button = [[UIButton alloc] init];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitleColor:[UIColor colorWithRed:243/255.0 green:75/255.0 blue:80/255.0 alpha:1] forState:UIControlStateDisabled];
    button.titleLabel.font = [UIFont systemFontOfSize:kTitleLabelNorimalFont];
    [button addTarget:self action:@selector(clickChannelButton:) forControlEvents:UIControlEventTouchUpInside];
    [button layoutIfNeeded];
    return button;
}
- (void)clickChannelButton:(UIButton *)sender {
    self.lastSelectedButton.titleLabel.font = [UIFont systemFontOfSize:kTitleLabelNorimalFont];
    self.lastSelectedButton.enabled = YES;
    self.lastSelectedButton = sender;
    self.lastSelectedButton.enabled = NO;
    CGFloat newOffsetX = sender.center.x - [UIScreen mainScreen].bounds.size.width*0.5;
    if (newOffsetX < 0) {
        newOffsetX = 0;
    }
    if (newOffsetX > self.scrollView.contentSize.width - self.scrollView.frame.size.width) {
        newOffsetX = self.scrollView.contentSize.width - self.scrollView.frame.size.width;
    }
    [UIView animateWithDuration:0.25 animations:^{
        [sender.titleLabel setFont:[UIFont systemFontOfSize:kTitleLabelNorimalFont]];
        [sender layoutIfNeeded];
        [self.scrollView setContentOffset:CGPointMake(newOffsetX, 0) animated:YES];
        self.indicatorView.frame = CGRectMake(sender.frame.origin.x + sender.titleLabel.frame.origin.x - 10, self.frame.size.height - 2, sender.titleLabel.frame.size.width + 20, 2);
    }];
    
    NSInteger index = [self.scrollView.subviews indexOfObject:sender] - 1;
    if ([self.delegate respondsToSelector:@selector(chooseChannelWithIndex:)]) {
        [self.delegate chooseChannelWithIndex:index];
    }
}
- (void)selectChannelButtonWithIndex:(NSInteger)index {
    self.indicatorView.hidden = NO;
    [self clickChannelButton:self.scrollView.subviews[index + 1]];
}
- (void)deleteChannelButtonWithIndex:(NSInteger)index {
    NSInteger realIndex = index + 1;
    [self.scrollView.subviews[realIndex] removeFromSuperview];
    for (NSInteger i = realIndex; i < self.scrollView.subviews.count; i ++) {
        UIButton *button = self.scrollView.subviews[i];
        CGRect buttonFrame = button.frame;
        button.frame = CGRectMake(buttonFrame.origin.x - button.frame.size.width, buttonFrame.origin.y, buttonFrame.size.width, buttonFrame.size.height);
    }
    self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width - self.scrollView.frame.size.width/5, 0);
}
- (void)addChannelButtonWithChannelName:(NSString *)channelName {
    UIButton *button = [self createChannelButton];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width + buttonWidth, 0);
    button.frame = CGRectMake(self.scrollView.contentSize.width - buttonWidth, 0, buttonWidth, self.frame.size.height);
    [button setTitle:channelName forState:UIControlStateNormal];
    [self.scrollView addSubview:button];
}
@end
