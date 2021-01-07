//
//  WLToastData.h
//  WLToastView
//
//  Created by jzjy on 2021/1/4.
//

#import <Foundation/Foundation.h>

#import "WLToastViewTypes.h"

@interface WLToastData : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

/**
 *  创建实例
 *
 *  @param config - 配置信息
 *  @return 实例
 */
+ (instancetype)withConfig:(void(^)(WLToastData *config))config;

/**
 *  创建实例
 *
 *  @param style        - 样式，详见枚举：WLToastViewStyle
 *  @param image        - 图片，可以是：UIImage, NSData, NSURL, 图片名称，图片路径字符串
 *  @param text         - 文本
 *  @param detail       - 详情
 *  @param customView   - 自定义视图
 *  @return 实例
 */
+ (instancetype)withStyle:(WLToastViewStyle)style image:(id)image text:(NSString *)text detail:(NSString *)detail customView:(UIView *)customView;

/**
 *  创建实例
 *
 *  @param style    - 样式，详见枚举：WLToastViewStyle
 *  @param image    - 图片，可以是：UIImage, NSData, NSURL, 图片名称，图片路径字符串
 *  @param text     - 文本
 *  @param detail   - 详情
 *  @return 实例
 */
+ (instancetype)withStyle:(WLToastViewStyle)style image:(id)image text:(NSString *)text detail:(NSString *)detail;

/**
 *  创建实例
 *
 *  @param image    - 图片，可以是：UIImage, NSData, NSURL, 图片名称，图片路径字符串
 *  @param text     - 文本
 *  @param detail   - 详情
 *  @return 实例
 */
+ (instancetype)withImage:(id)image text:(NSString *)text detail:(NSString *)detail;

/**
 *  创建实例
 *
 *  @param customView   - 自定义视图
 *  @return 实例
 */
+ (instancetype)withCustomView:(UIView *)customView;





#pragma mark - Properties

/** 样式，详见枚举：WLToastViewStyle */
@property (nonatomic,assign) WLToastViewStyle style;

/** 图片，可以是：UIImage, NSData, NSURL, 图片名称，图片路径字符串 */
@property (nonatomic,strong) id image;

/** 文本 */
@property (nonatomic,copy)   NSString *text;

/** 详情 */
@property (nonatomic,copy)   NSString *detail;

/** 自定义视图 */
@property (nonatomic,strong) UIView *customView;



/** 是否显示活动指示器 */
@property (nonatomic,assign,readonly) BOOL showActIndicator;

/** 是否显示图片 */
@property (nonatomic,assign,readonly) BOOL showImage;

/** 是否显示自定义视图 */
@property (nonatomic,assign,readonly) BOOL showCustomView;



/** 是否显示文本 */
@property (nonatomic,assign,readonly) BOOL showText;

/** 是否显示详情 */
@property (nonatomic,assign,readonly) BOOL showDetail;



@property (nonatomic,assign,readonly) BOOL animated;

@end
