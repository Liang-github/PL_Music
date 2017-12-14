//
//  SCIconView.h
//  PLMusic
//
//  Created by PengLiang on 2017/12/13.
//  Copyright © 2017年 PengLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCImageView.h"

@interface SCIconView : UIView

@property (nonatomic, strong) SCImageView *imageView;

- (void)setAlbumImage:(UIImage *)image;

@end
