//
//  ViewController.m
//  MMMMM
//
//  Created by jmit on 16/8/25.
//  Copyright © 2016年 godHands. All rights reserved.
//

#import "ViewController.h"
#import "LeeWaveView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    LeeWaveView *wave = [[LeeWaveView alloc]initWithFrame:CGRectMake(0,100, 320, 40)];
    [self.view addSubview:wave];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
