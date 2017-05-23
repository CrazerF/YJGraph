//
//  YJGraphDrawView.h
//  Graph
//
//  Created by 付与浇 on 2017/5/23.
//  Copyright © 2017年 付与浇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJGraphDrawView : UIView

/**
 *  初始化方法
 *
 *  @param coordinates 数据,数组里为YJCoordinateItem的对象
 *  @param graphColor    曲线图颜色
 *  @param animation   是否需要动画
 *
 *  @return a object of YJGraphView class
 */
- (instancetype)initWithCoordiantes:(NSArray *)coordinates graphColor:(UIColor *)graphColor animated:(BOOL)animation;

@end
