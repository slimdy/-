//
//  UIImage+LF.h
//  新浪微博（搭建框架）
//
//  Created by slimdy on 16/8/6.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LF)
/**
 *  返回原图
 *
 *  @param imageName 图片名称
 *
 *  @return 图片
 */
+(instancetype)OriginalImageWith:(NSString *)imageName;
/**
 *  它的功能是创建一个内容可拉伸，而边角不拉伸的图片，需要两个参数，第一个是左边不拉伸区域的宽度，第二个参数是上面不拉伸的高度。
 *
 *  @param image 图片
 *
 *  @return 伸缩后的图片
 */
+(instancetype)imageWithStretchableImage:(UIImage *)image;
@end
