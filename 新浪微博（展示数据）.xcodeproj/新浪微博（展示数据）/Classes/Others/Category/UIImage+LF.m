//
//  UIImage+LF.m
//  新浪微博（搭建框架）
//
//  Created by slimdy on 16/8/6.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "UIImage+LF.h"

@implementation UIImage (LF)
/**
 *  返回图片原始的样子
 *
 *  @param imageName 图片名
 *
 *  @return 原始图片
 */
+(instancetype)OriginalImageWith:(NSString *)imageName{
    UIImage * image = [UIImage imageNamed:imageName ];
    //默认会传出 蓝色的默认渲染图片，此方法将之一原来的样子传出
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
/**
 *  它的功能是创建一个内容可拉伸，而边角不拉伸的图片，需要两个参数，第一个是左边不拉伸区域的宽度，第二个参数是上面不拉伸的高度。
 *
 *  @param image 图片
 *
 *  @return 伸缩后的图片
 */
+(instancetype)imageWithStretchableImage:(UIImage *)image{
    return [image stretchableImageWithLeftCapWidth:image.size.width *0.5 topCapHeight:image.size.height *0.5];
}
@end
