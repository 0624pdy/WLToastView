//
//  WLToastView.h
//  WLToastView_Example
//
//  Created by jzjy on 2020/12/31.
//  Copyright © 2020 0624pdy@sina.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WLToastViewTypes.h"
#import "WLToastLayout.h"

@interface WLToastView : UIView

+ (instancetype)sharedToast;

+ (void)setLayout:(WLToastLayout *)layout;




+ (void)showLoadingWithText:(NSString *)text detail:(NSString *)detail animated:(BOOL)animated;
+ (void)showLoadingWithText:(NSString *)text detail:(NSString *)detail;
+ (void)showLoadingWithText:(NSString *)text;
+ (void)showLoading;

+ (void)showImage:(id)image text:(NSString *)text detail:(NSString *)detail animated:(BOOL)animated;
+ (void)showImage:(id)image text:(NSString *)text detail:(NSString *)detail;
+ (void)showImage:(id)image text:(NSString *)text;
+ (void)showImage:(id)image;

+ (void)showText:(NSString *)text detail:(NSString *)detail animated:(BOOL)animated;
+ (void)showText:(NSString *)text detail:(NSString *)detail;
+ (void)showText:(NSString *)text;

+ (void)showCustomView:(UIView *)customView animated:(BOOL)animated;
+ (void)showCustomView:(UIView *)customView;

+ (void)dismissAnimated:(BOOL)animated;

@end
