//
//  UIView+LF.m
//  新浪微博（搭建框架）
//
//  Created by slimdy on 16/8/8.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "UIView+LF.h"

@implementation UIView (LF)
-(void)setX:(float)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame =frame;
}
-(void)setY:(float)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
-(void)setWidth:(float)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
-(void)setHeight:(float)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
-(float)x{
    return self.frame.origin.x;
}
-(float)y{
    return self.frame.origin.y;
}
-(float)width{
    return self.frame.size.width;
}
-(float)height{
    return self.frame.size.height;
}
@end
