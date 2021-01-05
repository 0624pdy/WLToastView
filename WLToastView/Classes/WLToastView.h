//
//  WLToastView.h
//  WLToastView_Example
//
//  Created by jzjy on 2020/12/31.
//  Copyright © 2020 0624pdy@sina.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WLToastViewTypes.h"
@class WLToastLayout;
@class WLToastData;

@interface WLToastView : UIView

/**
 *  单例
 */
+ (instancetype)sharedToast;

/** 布局信息 */
@property (nonatomic,class) WLToastLayout *layout;

/** 动画样式，详见枚举：WLToastAnimation */
@property (nonatomic,class) WLToastAnimation animation;

/** 延迟关闭的时间（展示时长） */
@property (nonatomic,class) NSTimeInterval dismissDelay;

/** 是否显示背景视图 */
@property (nonatomic,class) BOOL showBgView;

/** 背景视图的颜色，默认：RGBA(0, 0, 0, 0.2) */
@property (nonatomic,class) UIColor *bgViewColor;

/** 点击背景视图是否关闭，默认：NO */
@property (nonatomic,class) BOOL shouldDismissWhenTapedBgView;





#pragma mark - 显示 & 隐藏（Show & Hide）

/**
 *  显示、展示、出现
 *
 *  @param data     -  要显示的信息
 *  @param animated - 是否带动画，优先级：animated > animation。
 */
+ (void)showWithData:(WLToastData *)data animated:(BOOL)animated;

/**
 *  隐藏、关闭、消失
 *
 *  @param animated - 是否带动画
 */
+ (void)dismissAnimated:(BOOL)animated;

@end
