# TDScrollView
利用3个ImageView建立的多图片循环浏览ScrollView

<h2>导入头文件</h2>
```#import "TDScrollView.h"```

<h2>初始化方法</h2>
```- (instancetype)initWithFrame:(CGRect )frame imageArray:(NSArray *)imageArray;```

<h2>实现代理方法</h2>
```
    tdScrollView.tdDelegate = self;

- (void)td_scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"scroll view did scroll");
}
```

