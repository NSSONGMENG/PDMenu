# PDMenu
一个简单的下拉菜单实现
=======================

### 使用方法
```Objective-C
    NSArray * titles = @[@"first row - first row",
                         @"second row - second row",
                         @"thired row - thired row",
                         @"fourth row - fourth row"];
    PDMenu  * menu = [[PDMenu alloc] initWithTitles:titles itemWidth:100];

    // aView确定了菜单弹出的位置，通常点击了aView，在aView的下方弹出了此菜单
    [menu showFromView:aView offset:5.f seletedItem:^(NSInteger index, id title) {
        NSLog(@" -- row : %ld -- title : %@ -- ",index,title);
    }];
