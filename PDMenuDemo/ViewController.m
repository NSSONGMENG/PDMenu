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
    [_menu showFromView:btn offset:5.f seletedItem:^(NSInteger index, id title) {
        NSLog(@" -- row : %ld -- title : %@ -- ",index,title);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
