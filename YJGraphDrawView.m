//
//  YJGraphDrawView.m
//  Graph
//
//  Created by 付与浇 on 2017/5/23.
//  Copyright © 2017年 付与浇. All rights reserved.
//

#import "YJGraphDrawView.h"
#import "YJGraphConfig.h"
#import "YJCoordinateItem.h"

@interface NSString (Size)

- (CGSize)sizeWithFontSize:(CGFloat)fontSize maxSize:(CGSize)maxSize;

@end

@implementation NSString (Size)

- (CGSize)sizeWithFontSize:(CGFloat)fontSize maxSize:(CGSize)maxSize
{
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
}

@end
@interface YJGraphDrawView ()
{
    NSArray *_coordinates;
    UIColor *_graphColor;
    BOOL _animation;
}

@end

@implementation YJGraphDrawView

- (instancetype)initWithCoordiantes:(NSArray *)coordinates graphColor:(UIColor *)graphColor animated:(BOOL)animation
{
    if (self = [super init]) {
        _coordinates = coordinates;
        _graphColor = graphColor;
        _animation = animation;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //建立绘图 颜色 线宽
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [[UIColor lightGrayColor] CGColor]);
    CGContextSetLineWidth(context, kCoordinateLineWitdth);
    
    //1、绘制坐标轴
    [self drawCoordinate:context];
    //2、绘制X轴文字
    [self drawXCoordinateText];
    //3、绘制Y轴文字
    [self drawYCoordinateText];
    //4、绘制曲线图
    [self drawGraph];
}

#pragma mark - 4绘制曲线图
- (void)drawGraph
{
    //x,y坐标
    CGFloat startX,startY;
    CGFloat x,y;
    
    CGFloat maxY = [self maxYOfCoodinateYValue];
    CGFloat coordinateHeight = self.frame.size.height - 2 * kEdgeInsertSpace;
    
    //绘制图
    CGMutablePathRef graphPath = CGPathCreateMutable();
    
    
    for (int i = 0; i < _coordinates.count; i++) {
        YJCoordinateItem *item = _coordinates[i];
        CGFloat scale = item.yValue / maxY;
        
        x = kEdgeInsertSpace + kXSpace + kDistanceBetweenPointAndPoit * i;
        y = kEdgeInsertSpace + (1 - scale) * coordinateHeight;
        if (i == 0) {
            startX = x;
            startY = y;
            CGPathMoveToPoint(graphPath, NULL, x, y);
        }else{
        CGPathAddLineToPoint(graphPath, NULL, x, y);
        }
        
        
    }
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor kGraphColor].CGColor;
    //线条的宽度
    layer.lineWidth = kCoordinateLineWitdth;
    layer.lineCap = kCALineCapRound;
    layer.path = graphPath;
    
    
    [self.layer addSublayer:layer];
    
    if (_animation) {
        CABasicAnimation *animation = [ CABasicAnimation animationWithKeyPath : NSStringFromSelector ( @selector (strokeEnd))];
        
        animation.fromValue = @0 ;
        
        animation.toValue = @1 ;
        
        animation.duration = kAnimationDuration ;
        
        [layer addAnimation :animation forKey : NSStringFromSelector ( @selector (strokeEnd))];
    }
    
    CGPathRelease(graphPath);
}

#pragma mark - 3绘制Y轴文字
- (void)drawYCoordinateText
{
    CGFloat maxY = [self maxYOfCoodinateYValue];
    CGFloat rowHeight = [self rowHeight];
    
    //创建一个段落
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentRight;
    
    for (int i = 0; i < kNumberOfRow; i++) {
        NSString *text = [NSString stringWithFormat:@"%.0f",maxY - maxY/kNumberOfRow * i];
        //获取文字的高度
        CGFloat textHeight = [text sizeWithFontSize:kFontSize maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].height;
        //绘图
        [text drawInRect:CGRectMake(0, kEdgeInsertSpace + rowHeight * i - textHeight / 2, kEdgeInsertSpace - 5, rowHeight) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kFontSize],NSParagraphStyleAttributeName:paragraph}];
    }
    
}

- (CGFloat)maxYOfCoodinateYValue
{
    CGFloat maxY = -MAXFLOAT;
    for (YJCoordinateItem *item in _coordinates) {
        if (item.yValue > maxY) {
            maxY = item.yValue;
        }
    }
    return maxY;
}

#pragma mark - 2绘制X轴文字
- (void)drawXCoordinateText
{
    for (int i = 0; i < _coordinates.count; i++) {
        YJCoordinateItem *item = _coordinates[i];
        //获取文字的宽度
        CGFloat textWidth = [item.xValue sizeWithFontSize:kFontSize maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
        //绘制点
        CGPoint point = CGPointMake(kXSpace - textWidth / 2 + kEdgeInsertSpace + kDistanceBetweenPointAndPoit * i, self.frame.size.height - kEdgeInsertSpace);
        
        [item.xValue drawAtPoint:point withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kFontSize]}];
    }
}


#pragma mark - 1绘制坐标轴
- (void)drawCoordinate:(CGContextRef)context
{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    //绘制坐标框
    CGContextAddRect(context, CGRectMake(kEdgeInsertSpace,
                                         kEdgeInsertSpace,
                                         width - 2 * kEdgeInsertSpace,
                                         height - 2 * kEdgeInsertSpace));
    CGContextStrokePath(context);
    
    //绘制虚线
    CGFloat lengths[1] = {5};
    CGContextSetLineDash(context, 0, lengths, sizeof(lengths) / sizeof(lengths[0]));
    
    //行高
    CGFloat rowHeight = [self rowHeight];
    
    for (int i = 1; i < kNumberOfRow; i++) {
        CGFloat y = kEdgeInsertSpace + rowHeight * i;
        CGContextMoveToPoint(context, kEdgeInsertSpace, y);
        CGContextAddLineToPoint(context, width - kEdgeInsertSpace, y);
        CGContextStrokePath(context);
    }
    
    
}

//计算行高
- (CGFloat)rowHeight
{
    return  (self.frame.size.height - kEdgeInsertSpace * 2) / kNumberOfRow;
}


@end
