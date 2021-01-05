//
//  WLToastView+Usage.h
//  WLToastView
//
//  Created by jzjy on 2021/1/5.
//

#import "WLToastView.h"

@interface WLToastView (Usage)



#pragma mark - 通用

/**
 *  显示，通用
 *
 *  @param data     - 配置信息
 *  @param animated - 是否带动画
 */
+ (void)showWithData:(WLToastData *)data animated:(BOOL)animated;



#pragma mark - 活动指示器

/**
 *  显示加载指示器，不会自动关闭，需手动调用：+ (void)dismissAnimated:(BOOL)animated; 关闭
 *
 *  @param text     - 文本
 *  @param detail   - 详情
 *  @param animated - 是否带动画
 */
+ (void)showLoadingWithText:(NSString *)text detail:(NSString *)detail animated:(BOOL)animated;
+ (void)showLoadingWithText:(NSString *)text detail:(NSString *)detail;
+ (void)showLoadingWithText:(NSString *)text;
+ (void)showLoading;



#pragma mark - 图片

/**
 *  显示带图片的提示，1.5秒后自动关闭
 *
 *  @param image    - 图片，可以是：UIImage, NSData, NSURL, 图片名称，图片路径字符串
 *  @param text     - 文本
 *  @param detail   - 详情
 *  @param animated - 是否带动画
 */
+ (void)showImage:(id)image text:(NSString *)text detail:(NSString *)detail animated:(BOOL)animated;
+ (void)showImage:(id)image text:(NSString *)text detail:(NSString *)detail;
+ (void)showImage:(id)image text:(NSString *)text;
+ (void)showImage:(id)image;



#pragma mark - 文本

/**
 *  显示文本指示器，1.5秒后自动关闭
 *
 *  @param text     - 文本
 *  @param detail   - 详情
 *  @param animated - 是否带动画
 */
+ (void)showText:(NSString *)text detail:(NSString *)detail animated:(BOOL)animated;
+ (void)showText:(NSString *)text detail:(NSString *)detail;
+ (void)showText:(NSString *)text;



#pragma mark - 自定义视图

/**
 *  显示自定义视图的指示器，1.5秒后自动关闭
 *
 *  @param customView   - 自定义视图
 *  @param animated     - 是否带动画
 */
+ (void)showCustomView:(UIView *)customView animated:(BOOL)animated;
+ (void)showCustomView:(UIView *)customView;

@end
