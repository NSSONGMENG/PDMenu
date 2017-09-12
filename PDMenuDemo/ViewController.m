//
//  ViewController.m
//  PDMenuDemo
//
//  Created by songmeng on 17/6/11.
//  Copyright © 2017年 songmeng. All rights reserved.
//

#import "ViewController.h"
#import "PDMenu.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@property (nonatomic, strong) PDMenu    * menu;

@end

@implementation ViewController

- (void)dealloc
{
    NSLog(@" -- %s --",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton    * btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 150, 30)];
    btn.backgroundColor = [UIColor lightGrayColor];
    [btn setTitle:@"下拉菜单" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    NSArray * titles = @[@"first row - first row",
                         @"second row - second row",
                         @"thired row - thired row",
                         @"fourth row - fourth row"];
    _menu = [[PDMenu alloc] initWithTitles:titles itemWidth:100];
}

- (void)btnAction:(UIButton *)btn{
    if ([self.navigationController.viewControllers count] < 2) {
        [self.navigationController pushViewController:[ViewController new] animated:YES];
    }else{
        [_menu showFromView:btn offset:5.f seletedItem:^(NSInteger index, id title) {
            NSLog(@" -- row : %ld -- title : %@ -- ",index,title);
            
            //此处可以直接使用self的强指针，因为PDMenu在dismiss的时候讲它持有的block置为了nil
            [self xx];
        }];
    }
}

- (void)xx
{
    NSLog(@" -- ");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
