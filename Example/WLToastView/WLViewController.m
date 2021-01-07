//
//  WLViewController.m
//  WLToastView
//
//  Created by 0624pdy@sina.com on 12/31/2020.
//  Copyright (c) 2020 0624pdy@sina.com. All rights reserved.
//

#import "WLViewController.h"

#import <WLToastView/WLToastUtil.h>

@interface WLViewController () < UITableViewDataSource, UITableViewDelegate >
{
    NSArray *_datas;
}
@property (weak, nonatomic) IBOutlet UITableView *listView;

@end

@implementation WLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.title = @"WLToastView";
    
    _listView.backgroundColor = [UIColor colorWithRed:(238/255.0) green:(238/255.0) blue:(238/255.0) alpha:1];
    _listView.dataSource = self;
    _listView.delegate = self;
    [_listView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    
    _datas = @[
        @"WLToastAnimation_None",
        @"WLToastAnimation_Fade",
        @"WLToastAnimation_ScaleFade",
        @"WLToastAnimation_Bounce",
    ];
    
    WLToastView.layout = WLToastLayout.defaultLayout;
    WLToastView.animation = WLToastAnimation_ScaleFade;
    WLToastView.dismissDelay = 1.5;
    WLToastView.showBgView = YES;
    WLToastView.bgViewColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





#pragma mark -

- (void)showToastView {
    
    static int i = 0;
    switch (i) {

        case 0: [WLToastView showLoading]; break;
        case 1: [WLToastView showLoadingWithText:@"玩命加载中..."]; break;
        case 2: [WLToastView showLoadingWithText:@"玩命加载中..." detail:@"请耐心等候，可能需要1～20个工作日"]; break;

        case 3: [WLToastView showImage:@"icon_tc_arrow_succeed"]; break;
        case 4: [WLToastView showImage:@"icon_tc_arrow_ failure" text:@"支付失败"]; break;
        case 5: [WLToastView showImage:@"pic_apply" text:@"登录成功" detail:@"欢迎来到XXOOXX"]; break;

        case 6: [WLToastView showText:@"验证码错误，请重新输入"]; break;
        case 7: [WLToastView showText:@"验证码错误，请重新输入" detail:@"剩余次数：0"]; break;

        case 8: [WLToastView showCustomView:[self tmpView]]; break;

        default: break;
    }

    i ++;

    if (i > 8) {
        i = 0;
    }
    
    
    
//    [WLToastView showLoadingWithText:@"订单生成中..."];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//        [WLToastView showLoadingWithText:@"支付中..."];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//            [WLToastView showLoadingWithText:@"验证中..."];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//                [WLToastView showImage:@"pic_apply" text:@"支付成功"];
//            });
//        });
//    });
}
- (UIView *)tmpView {
    UIView *view = [[UIView alloc] init];
    
    view.frame = CGRectMake(0, 0, 200, 200);
    view.backgroundColor = UIColor.orangeColor;
    
    return view;
}





#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = _datas[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    WLToastView.animation = (WLToastAnimation)indexPath.row;
    [self showToastView];
}

@end
