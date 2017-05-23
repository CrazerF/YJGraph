# YJGraph
## 4步绘制出一个曲线图（Stroked a curve graph only need four steps ）

### ///1、导入Graph文件夹后，导入头文件

    #import "YJGraphView.h"
    #import "YJCoordinateItem.h"

### ///2、给定一个存储YJCoordinateItem对象数组

    NSMutableArray *coordiantes = [NSMutableArray array];
    //x轴数据
    NSArray *xText = @[@"第一天",@"第二天",@"第三天",@"第四天",@"第五天",@"第六天",@"第七天"];
    //y轴数据
    NSArray *yValue = @[@"50",@"66",@"30",@"100",@"72",@"85",@"45"];
    for (NSInteger i = 0; i < 7; i++)
    {
    YJCoordinateItem *item = [YJCoordinateItem coordinateItemWithXText:xText[i]
    yValue:[yValue[i] integerValue] ];
    [coordiantes addObject:item];
    }

### ///3、创建曲线图

    YJGraphView *graphView = [[YJGraphView alloc] initWithCoordiantes:coordiantes
                 graphColor:[UIColor redColor]
                   animated:YES];
    graphView.frame = CGRectMake(0, 100, self.view.frame.size.width, 300);
    [self.view addSubview:graphView];


### ///4、开始绘制

    [graphView stroke];
