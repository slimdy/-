//
//  LFWeiBoCell.h
//  新浪微博（展示数据）
//
//  Created by slimdy on 16/8/12.
//  Copyright © 2016年 slimdy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LFWeiBoViewModel;
@interface LFWeiBoCell : UITableViewCell
/**
 *  cell 的数据
 */
@property (nonatomic,strong) LFWeiBoViewModel *weiBoVM;
/**
 *  创建自定义cell
 *
 *  @param tableView
 *
 *  @return 自定义cell
 */
+(instancetype)createWeiBoCellWith:(UITableView *)tableView;

@end
