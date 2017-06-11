//
//  PDMenu.h
//  Demo
//
//  Created by songmeng on 17/6/10.
//  Copyright © 2017年 songmeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MenuStyle){
    MenuStyleWhite,
    MenuStyleBlack,
};


/** 下拉菜单 */
@interface PDMenu : UIView

@property (nonatomic, readonly) NSArray     * titles;
@property (nonatomic, readonly) CGFloat     width;
@property (nonatomic, assign)   MenuStyle   style;

/** 选中之后是否自动dismiss，默认为YES */
@property (nonatomic, assign)   BOOL        autoDismiss;


/**
 初始化方法

 @param titles 选项名称数组
 @param width 选项卡宽度，可不填写（最小为最长字符串宽度 ＋ 30，若超过此值，使用设置的数值）
 @return self
 */
- (instancetype)initWithTitles:(NSArray <NSString *>*)titles itemWidth:(CGFloat)width;

- (void)showFromView:(UIView *)targetView seletedItem:(void(^)(NSInteger index,id title))seleted;
- (void)dismiss;


@end
