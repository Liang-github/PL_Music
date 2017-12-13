//
//  SCLrcTableViewCell.h
//  PLMusic
//
//  Created by PengLiang on 2017/12/13.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum SC_AnimationType {
    translation,
    scale,
    rotation,
    scaleAlways,
    scaleNormal,
} AnimationType;

@interface SCLrcTableViewCell : UITableViewCell

+ (SCLrcTableViewCell *)SC_CellForRowWithTableView:(UITableView *)tableView;
- (void)addAnimation:(AnimationType)animationType;

@end
