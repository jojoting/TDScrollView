//
//  ViewController.m
//  TDScrollViewDemo
//
//  Created by jojoting on 15/10/16.
//  Copyright © 2015年 jojoting. All rights reserved.
//

#import "ViewController.h"
#import "TDScrollView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array = [[NSArray alloc]initWithObjects:
                      [UIImage imageNamed:@"1.jpg"],
                      [UIImage imageNamed:@"2.jpg"],
                      [UIImage imageNamed:@"3.jpg"],
                      [UIImage imageNamed:@"4.jpg"],
                      nil];
    
    TDScrollView *tdScrollView = [[TDScrollView alloc]initWithFrame:CGRectMake(50, 100, 300, 300) imageArray:array];
    [self.view addSubview:tdScrollView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
