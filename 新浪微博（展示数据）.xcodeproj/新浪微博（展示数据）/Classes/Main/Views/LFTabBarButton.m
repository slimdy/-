//
//  LFTabBarButton.m
//  新浪微博（搭建框架）
//
//  Created by slimdy on 16/8/8.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import "LFTabBarButton.h"
#import "LFBadgeView.h"
@interface LFTabBarButton()
@property (nonatomic,weak) LFBadgeView *badgeView;
@end
@implementation LFTabBarButton
/**
 *  懒加载badgeView
 *
 *
 */
-(LFBadgeView *)badgeView{
    if (_badgeView == nil) {
        LFBadgeView *badgeView = [LFBadgeView buttonWithType:UIButtonTypeCustom];
        [self addSubview:badgeView];
        _badgeView = badgeView;
    }
    return _badgeView;
}
/**
 *  取消高亮
 *
 *
 */
-(void)setHighlighted:(BOOL)highlighted{}
/**
 *  重写initWithframe 方法 因为buttonWithType 方法 会在底层调用这个方法
 *
 *  @param frame
 *
 *  @return
 */
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        //图片居中显示
        self.imageView.contentMode = UIViewContentModeCenter;
        //文字居中显示
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        //设置字体大小
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}
-(void)setItem:(UITabBarItem *)item{
    _item = item;
    //kvo 当指定的对象的属性被修改了，允许对象接受到通知的机制。每次指定的被观察对象的属性被修改的时候，KVO都会自动的去通知相应的观察者。
    //第一次用来调用回调来设置按钮位子和图片
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    // addObserver : 谁观察；  foKeyPath 被观察者的属性 options 观察属性是新的 context 这个是用来标注 这个KVO 是谁的 在回调中用来判断 是父类的KVO 还是子类的KVO  是一种严谨的做法
    [item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
   [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
}
/**
 *  添加了KVO 以后必须实现的回调
 *
 *  @param keyPath 什么属性
 *  @param object  那个对象的属性
 *  @param change  发生了什么变化
 *  @param context 标示符 是父类 还是子类是观察者
 */
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    // 调用后用来 设置button的样式，这里主要还是为了演示什么是KVO 设计模式
    [self setTitle:_item.title forState:UIControlStateNormal];
    [self setImage:_item.image forState:UIControlStateNormal];
    [self setImage:_item.selectedImage forState:UIControlStateSelected];
    self.badgeView.badgeValue = _item.badgeValue;
    //context 的使用 是为了 防止父类设置的KVO  在子类的毁掉中处理
//    if (object == _tableView && [keyPath isEqualToString:@"contentOffset"]) {
//        [self doSomethingWhenContentOffsetChanges];
//    } else {
//        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];

    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    // 1.imageView
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = self.bounds.size.width;
    CGFloat imageH = self.bounds.size.height *0.7;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    
    // 2.title
    CGFloat titleX = 0;
    CGFloat titleY = imageH - 3;
    CGFloat titleW = self.bounds.size.width;
    CGFloat titleH = self.bounds.size.height - titleY;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    //3.badgeView
    self.badgeView.x = self.width - self.badgeView.width;
    self.badgeView.y = 0;
    
}
@end
