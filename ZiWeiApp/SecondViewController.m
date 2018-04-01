//
//  SecondViewController.m
//  ZiWeiApp
//
//  Created by chksong on 2018/3/5.
//  Copyright © 2018年 cn.goipc. All rights reserved.
//

#import "SecondViewController.h"
#import "Masonry.h"

#define  mainScreenWidth   [UIScreen mainScreen].bounds.size.width
#define  mainScreenHeight   [UIScreen mainScreen].bounds.size.height



@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIView *thisView = self.view  ;
    
    UIView *blueView = [[UIView alloc] init] ;
    blueView.backgroundColor  = [UIColor blueColor] ;
    [self.view addSubview:blueView];
    
    //CGPoint center = CGPointMake(mainScreenWidth/8, mainScreenHeight/8);
    
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
      //  make.left.equalTo(thisView.mas_left);
        make.width.mas_equalTo(mainScreenWidth/4);
        make.height.mas_equalTo(mainScreenHeight/4) ;
        make.left.equalTo(self.view) ;
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
