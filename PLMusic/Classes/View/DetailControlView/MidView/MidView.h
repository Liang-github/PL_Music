//
//  MidView.h
//  PLMusic
//
//  Created by PengLiang on 2017/12/13.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCIconView.h"
#import "SCLrcTableView.h"

@interface MidView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic, strong) SCIconView *midIconView;
@property (nonatomic, strong) SCLrcTableView *midLrcView;

@end
