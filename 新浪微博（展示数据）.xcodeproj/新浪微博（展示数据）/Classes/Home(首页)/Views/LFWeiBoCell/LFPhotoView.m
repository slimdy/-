//
//  LFPhotoView.m
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/15.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "LFPhotoView.h"
#import "LFPhotoModel.h"
#import "UIImageView+WebCache.h"
@interface LFPhotoView()
@property (nonatomic, weak) UIImageView *gifView;
@end
@implementation LFPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        UIImageView *gifView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        [self addSubview:gifView];
        _gifView =gifView;
        
    }
    return self;
}
-(void)setPhoto:(LFPhotoModel *)photo{
    _photo = photo;
    [self sd_setImageWithURL:photo.thumbnail_pic placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    NSString *urlStr = photo.thumbnail_pic.absoluteString;
    if ([urlStr hasSuffix:@".gif"]) {
        self.gifView.hidden = NO;
    }else{
        self.gifView.hidden = YES;
    }
    
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.gifView.x = self.width -self.gifView.width;
    self.gifView.y = self.height-self.gifView.height;
    
}
@end
