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
    menu.style = MenuStyleBlack;

    [menu showFromView:view seletedItem:^(NSInteger index, id title) {
        NSLog(@" -- row : %ld -- title : %@ -- ",index,title);
    }];
