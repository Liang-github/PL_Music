//
//  SCLrcTableView.h
//  PLMusic
//
//  Created by PengLiang on 2017/12/13.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCLrcTableViewCell.h"
#import "OMSongInfo.h"

@interface SCLrcTableView : UITableViewController

@property (nonatomic, assign) int Lrc_Index;
@property (nonatomic, assign) SCLrcTableViewCell *currentCell;
@property (nonatomic, assign) SCLrcTableViewCell *lrcOldCell;

// 用来显示锁屏歌词
@property (nonatomic, strong) UITableView *lockScreenTableView;
@property (nonatomic, assign) SCLrcTableViewCell *lockCurrentCell;
@property (nonatomic, assign) SCLrcTableViewCell *lockLrcOldCell;
@property (nonatomic, assign) NSInteger currentRow;
@property (nonatomic, assign) BOOL isDragging;

@property (nonatomic, assign) int old_Index;
@property (nonatomic, assign) int mLineNumber;
@property (nonatomic, assign) BOOL mIsLRCPrepared;

- (instancetype)initWithStyle:(UITableViewStyle)style;
- (void)SC_SetUpLrcTableViewFrame:(CGRect)frame;
- (void)setLrc_Index:(int)Lrc_Index;
- (void)AnalysisLRC:(NSString *)lrcStr;
- (UIImage *)getBlurredImage:(UIImage *)image;

@end
