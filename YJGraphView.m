//
//  YJGraphView.m
//  Graph
//
//  Created by 付与浇 on 2017/5/23.
//  Copyright © 2017年 付与浇. All rights reserved.
//

#import "YJGraphView.h"
#import "YJGraphDrawView.h"
#import "YJGraphConfig.h"

@interface YJGraphView ()
{
    NSArray *_coordinates;
    UIColor *_graphColor;
    BOOL _animation;
}

@property (nonatomic,weak) YJGraphDrawView *graphDrawView;

@end

@implementation YJGraphView
- (instancetype)initWithCoordiantes:(NSArray *)coordinates graphColor:(UIColor *)graphColor animated:(BOOL)animation
{
    if (self = [super init]) {
        _coordinates = coordinates;
        _graphColor = graphColor;
        _animation = animation;
        
        
        //设置滚动视图的课滚动范围
        self.contentSize = CGSizeMake(kEdgeInsertSpace * 2 +kXSpace * 2 + kDistanceBetweenPointAndPoit * (_coordinates.count - 1), 0);
        
        //去掉一些效果
        self.bounces = NO;
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
    
}

/**
 *  开始绘制
 */
- (void)stroke
{
    YJGraphDrawView *graphDrawView = [[YJGraphDrawView alloc] initWithCoordiantes:_coordinates graphColor:_graphColor animated:_animation];
    
    graphDrawView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:graphDrawView];
    
    _graphDrawView = graphDrawView;
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _graphDrawView.frame = CGRectMake(0, 0, self.contentSize.width, self.frame.size.height);
}

@end
