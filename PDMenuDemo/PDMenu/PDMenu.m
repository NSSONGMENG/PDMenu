//
//  PDMenu.m
//  Demo
//
//  Created by songmeng on 17/6/10.
//  Copyright © 2017年 songmeng. All rights reserved.
//

#import "PDMenu.h"
#import "PDMenuCell.h"

#define kItemHeight 40
#define kDefaultFont [UIFont systemFontOfSize:15]
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface PDMenu ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, readwrite) NSArray    * titles;
@property (nonatomic, readwrite) CGFloat    width;
//@property (nonatomic, readwrite) CGFloat    offset;

/** table view的父视图 */
@property (nonatomic, strong) UIView    * btomView;
/** 点击空白返回按钮 */
@property (nonatomic, strong) UIButton  * btomBtn;
@property (nonatomic, strong) UITableView   * tableV;

/** 动画开始时table view的frame，保证弹出与隐藏动画保持方向一致（从哪个方向弹出就从哪个方向隐藏） */
@property (nonatomic, assign) CGRect    animationBeginFrame;

@property (nonatomic, copy) void(^block)(NSInteger index,id title);

@end

@implementation PDMenu

- (instancetype)initWithTitles:(NSArray <NSString *>*)titles itemWidth:(CGFloat)width
{
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        _titles = titles;
        _width  = width;
        _autoDismiss = YES;
        
        [self dealItemWidth];
        [self createSubview];
    }
    
    return self;
}

//UI
- (void)createSubview
{
    _btomBtn = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _btomBtn.backgroundColor = [UIColor clearColor];
    [_btomBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btomBtn];
    
    _btomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _width, kItemHeight * _titles.count)];
    _btomView.backgroundColor = [UIColor clearColor];
    _btomView.clipsToBounds = YES;
    [self addSubview:_btomView];
    
    _tableV = [[UITableView alloc] initWithFrame:_btomView.bounds style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_btomView addSubview:_tableV];
}


#pragma mark -
#pragma mark - public method

- (void)showFromView:(UIView *)targetView
              offset:(CGFloat)offset
         seletedItem:(void(^)(NSInteger index,id title))seleted
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    _block = seleted;
    
    CGRect  rect = [[UIApplication sharedApplication].keyWindow convertRect:targetView.frame fromView:nil];
    
    // x
    CGFloat x = rect.origin.x + rect.size.width /2 + _width / 2 > kScreenWidth ?
    kScreenWidth - _width : rect.origin.x + rect.size.width /2 - _width / 2;
    if (x < 0) x = 0;
    
    // y
    CGFloat y = rect.origin.y + rect.size.height + _btomView.frame.size.height > kScreenHeight ?
    rect.origin.y - _btomView.frame.size.height : rect.origin.y + rect.size.height;
    
    //设定便宜量
    if (y > rect.origin.y) {
        y += offset;
    }else{
        y -= offset;
    }
    
    CGRect  aimFrame = CGRectMake(x,
                                  y,
                                  _width,
                                  _btomView.frame.size.height);
    _btomView.frame = aimFrame;

    if (y > rect.origin.y) {
        //从上往下弹出
        _animationBeginFrame = CGRectMake(0, - aimFrame.size.height, _width, aimFrame.size.height);
    }else{
        //从下往上弹出
        _animationBeginFrame = CGRectMake(0, aimFrame.size.height, _width, aimFrame.size.height);
    }
    
    _tableV.frame = _animationBeginFrame;
    self.backgroundColor = [UIColor clearColor];
    [_tableV reloadData];
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _tableV.frame = _btomView.bounds;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    } completion:nil];
}

- (void)dismiss
{
    //dismiss
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _tableV.frame = _animationBeginFrame;
        self.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

#pragma mark -
#pragma mark - table view

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kItemHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString    * cellIdent = @"menuCell";
    
    PDMenuCell  * cell = [tableView dequeueReusableCellWithIdentifier:cellIdent];
    if (!cell) {
        cell = [[PDMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
        cell.frame = CGRectMake(0, 0, _width, kItemHeight);
        cell.font = kDefaultFont;
    }
    
    cell.title = _titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_block) {
        _block(indexPath.row,_titles[indexPath.row]);
    }
    
    if (_autoDismiss) {
        [self dismiss];
    }
}


#pragma mark -
#pragma mark - other

- (void)dealItemWidth
{
    __block CGFloat w = 0;
    
    [_titles enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGSize  rect = [obj sizeWithAttributes:@{NSFontAttributeName : kDefaultFont}];
        w = MAX(w, rect.width);
    }];
    
    _width = MAX(w + 30, _width);
}


@end
