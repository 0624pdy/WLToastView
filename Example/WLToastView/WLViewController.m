//
//  WLViewController.m
//  WLToastView
//
//  Created by 0624pdy@sina.com on 12/31/2020.
//  Copyright (c) 2020 0624pdy@sina.com. All rights reserved.
//

#import "WLViewController.h"

#import <WLToastView/WLToastView.h>

@interface WLViewController ()

@end

@implementation WLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [WLToastView setLayout:WLToastLayout.defaultLayout];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    [WLToastView showLoading];
//    [WLToastView showLoadingWithText:@"玩命加载中..."];
//    [WLToastView showLoadingWithText:@"玩命加载中..." detail:@"请耐心等候，可能需要1～20个工作日"];
    
//    [WLToastView showImage:@""];
    [WLToastView showImage:@"" text:@"登录成功"];
//    [WLToastView showImage:@"" text:@"登录成功" detail:@"欢迎来到XXOOXX"];

//    [WLToastView showText:@"验证码错误，请重新输入"];
//    [WLToastView showText:@"验证码错误，请重新输入" detail:@"剩余次数：0"];

//    [WLToastView showCustomView:[self tmpView]];
}
- (UIView *)tmpView {
    UIView *view = [[UIView alloc] init];
    
    view.frame = CGRectMake(0, 0, 200, 200);
    view.backgroundColor = UIColor.greenColor;
    
    return view;
}

@end
