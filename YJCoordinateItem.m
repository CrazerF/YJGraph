//
//  YJCoordinateItem.m
//  Graph
//
//  Created by 付与浇 on 2017/5/23.
//  Copyright © 2017年 付与浇. All rights reserved.
//

#import "YJCoordinateItem.h"

@implementation YJCoordinateItem
+ (instancetype)coordinateItemWithXText:(NSString *)xText yValue:(CGFloat)yValue
{
    YJCoordinateItem *item = [[self alloc] init];
    item.xValue = xText;
    item.yValue = yValue;
    
    return item;
}

@end
