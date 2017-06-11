//
//  PDMenu.h
//  Demo
//
//  Created by songmeng on 17/6/10.
//  Copyright © 2017年 songmeng. All rights reserved.
//

#import <UIKit/UIKit.h>


/** 下拉菜单 */
@interface PDMenu : UIView

@property (nonatomic, readonly) NSArray     * titles;
@property (nonatomic, readonly) CGFloat     width;

/** 选中之后是否自动dismiss，默认为YES */
@property (nonatomic, assign)   BOOL        autoDismiss;


/**
 初始化方法

 @param titles 选项名称数组
 @param width 选项卡宽度，可不填写（最小为最长字符串宽度 ＋ 30，若超过此值，使用设置的数值）
 @return self
 */
- (instancetype)initWithTitles:(NSArray <NSString *>*)titles itemWidth:(CGFloat)width;


/**
 弹出菜单

 @param targetView 显示菜单的视图
 @param offset 菜单相对于targetView在y坐标的偏移量
 @param seleted 选择任意item后回调
 */
- (void)showFromView:(UIView *)targetView
              offset:(CGFloat)offset
         seletedItem:(void(^)(NSInteger index,id title))seleted;

/**
 隐藏菜单
 */
- (void)dismiss;


@end
