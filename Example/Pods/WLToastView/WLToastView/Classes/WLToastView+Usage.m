//
//  WLToastView+Usage.m
//  WLToastView
//
//  Created by jzjy on 2021/1/5.
//

#import "WLToastView+Usage.h"

#import "WLToastData.h"

@implementation WLToastView (Usage)

#pragma mark -

+ (void)showLoadingWithText:(NSString *)text detail:(NSString *)detail animated:(BOOL)animated {
    WLToastData *data = [WLToastData withStyle:WLToastViewStyle_ActivityIndicator image:nil text:text detail:detail];
    [self showWithData:data animated:animated];
}
+ (void)showLoadingWithText:(NSString *)text detail:(NSString *)detail {
    WLToastData *data = [WLToastData withStyle:WLToastViewStyle_ActivityIndicator image:nil text:text detail:detail];
    [self showWithData:data animated:YES];
}
+ (void)showLoadingWithText:(NSString *)text {
    WLToastData *data = [WLToastData withStyle:WLToastViewStyle_ActivityIndicator image:nil text:text detail:nil];
    [self showWithData:data animated:YES];
}
+ (void)showLoading {
    WLToastData *data = [WLToastData withStyle:WLToastViewStyle_ActivityIndicator image:nil text:nil detail:nil];
    [self showWithData:data animated:YES];
}

#pragma mark -

+ (void)showImage:(id)image text:(NSString *)text detail:(NSString *)detail animated:(BOOL)animated {
    WLToastData *data = [WLToastData withImage:image text:text detail:detail];
    [self showWithData:data animated:animated];
}
+ (void)showImage:(id)image text:(NSString *)text detail:(NSString *)detail {
    WLToastData *data = [WLToastData withImage:image text:text detail:detail];
    [self showWithData:data animated:YES];
}
+ (void)showImage:(id)image text:(NSString *)text {
    WLToastData *data = [WLToastData withImage:image text:text detail:nil];
    [self showWithData:data animated:YES];
}
+ (void)showImage:(id)image {
    WLToastData *data = [WLToastData withImage:image text:nil detail:nil];
    [self showWithData:data animated:YES];
}

#pragma mark -

+ (void)showText:(NSString *)text detail:(NSString *)detail animated:(BOOL)animated {
    WLToastData *data = [WLToastData withStyle:WLToastViewStyle_Text image:nil text:text detail:detail];
    [self showWithData:data animated:animated];
}
+ (void)showText:(NSString *)text detail:(NSString *)detail {
    WLToastData *data = [WLToastData withStyle:WLToastViewStyle_Text image:nil text:text detail:detail];
    [self showWithData:data animated:YES];
}
+ (void)showText:(NSString *)text {
    WLToastData *data = [WLToastData withStyle:WLToastViewStyle_Text image:nil text:text detail:nil];
    [self showWithData:data animated:YES];
}

#pragma mark -

+ (void)showCustomView:(UIView *)customView animated:(BOOL)animated {
    WLToastData *data = [WLToastData withCustomView:customView];
    [self showWithData:data animated:animated];
}
+ (void)showCustomView:(UIView *)customView {
    WLToastData *data = [WLToastData withCustomView:customView];
    [self showWithData:data animated:YES];
}

@end
