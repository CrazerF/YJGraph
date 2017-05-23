//
//  YJCoordinateItem.h
//  Graph
//
//  Created by 付与浇 on 2017/5/23.
//  Copyright © 2017年 付与浇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface YJCoordinateItem : NSObject
//x文字
@property (nonatomic, copy) NSString *xValue;
//y轴数据
@property (nonatomic, assign) CGFloat yValue;

+ (instancetype)coordinateItemWithXText:(NSString *)xText yValue:(CGFloat)yValue;

@end
