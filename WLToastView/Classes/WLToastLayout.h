//
//  WLToastLayout.h
//  WLToastView
//
//  Created by jzjy on 2021/1/4.
//

#import <Foundation/Foundation.h>

@interface WLToastLayout : NSObject

/** 容器最大宽度，默认：屏幕宽度-32 */
@property (nonatomic,assign) CGFloat maxWidth;

/** 容器最大高度，默认：屏幕高度-32 */
@property (nonatomic,assign) CGFloat maxHeight;


/** 上左下右内边距，默认：(25, 25, 25, 25) */
@property (nonatomic,assign) UIEdgeInsets insets_padding;

/** 图片尺寸，默认：(49, 49) */
@property (nonatomic,assign) CGSize imgSize;


/** 活动指示器 与 lbl 的间距，默认：16 */
@property (nonatomic,assign) CGFloat spaceing_actToLbl;

/** 图片 与 lbl 的间距，默认：16 */
@property (nonatomic,assign) CGFloat spaceing_imgToLbl;

/** lbl 的间距，默认：12 */
@property (nonatomic,assign) CGFloat spaceing_lblToLbl;

/**
 *  创建实例
 *
 *  @param config - 配置信息
 */
+ (instancetype)withConfig:(void(^)(WLToastLayout *config))config;


/** 默认布局 */
@property (nonatomic,class,readonly) WLToastLayout *defaultLayout;

@end
