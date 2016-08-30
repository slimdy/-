//
//  LFPhotoesView.m
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/15.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "LFPhotoesView.h"
#import "LFPhotoModel.h"
#import "LFPhotoView.h"
#import "UIImageView+WebCache.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
@interface LFPhotoesView()
@end

@implementation LFPhotoesView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        for (NSInteger i = 0; i<9; i++) {
            LFPhotoView *imageView = [[LFPhotoView alloc]init];
            imageView.tag = i;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick:)];
            [imageView addGestureRecognizer:tap];
            [self addSubview:imageView];
        }
       
    }
    return self;
}
-(void)imageClick:(UITapGestureRecognizer *)tap{
    UIImageView *tapView = (UIImageView *)tap.view;
    NSMutableArray *mjPhotoArr = [NSMutableArray array];
    for (int i = 0; i< self.pic_urls.count; i++) {
        LFPhotoModel *photo = self.pic_urls[i];
        MJPhoto *p = [[MJPhoto alloc]init];
        NSString *clearImgUrlStr =photo.thumbnail_pic.absoluteString;
        clearImgUrlStr = [clearImgUrlStr stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        p.url = [NSURL URLWithString:clearImgUrlStr];
        p.index = (int)i;
        p.srcImageView =tapView;
        [mjPhotoArr addObject:p];
    }
    MJPhotoBrowser *photoBrowser = [[MJPhotoBrowser alloc]init];
    photoBrowser.photos = mjPhotoArr;
    photoBrowser.currentPhotoIndex = tap.view.tag;
    [photoBrowser show];
    
}
-(void)setPic_urls:(NSArray *)pic_urls{
    
    _pic_urls = pic_urls;
    for (NSInteger i = 0; i < self.subviews.count; i++) {
        LFPhotoView *imagV = self.subviews[i];
        if (i < _pic_urls.count) {
            imagV.hidden = NO;
            LFPhotoModel *photo = self.pic_urls[i];
            imagV.photo = photo;
        }else{
            imagV.hidden = YES;
        }
    }
    
 
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat WH = 90;
    CGFloat margin = 10;
    NSInteger col = 0;
    NSInteger row = 0;
    NSInteger cols = self.pic_urls.count == 4?2:3;
    
    for (NSInteger i = 0; i < self.pic_urls.count; i ++) {
        col = i % cols;
        row = i / cols;
        x = col * (WH + margin);
        y = row * (WH + margin);
        LFPhotoView *imageV = self.subviews[i];
        imageV.frame = CGRectMake(x, y, WH, WH);
    }
    
    
    
}
@end
