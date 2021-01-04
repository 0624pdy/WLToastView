//
//  WLToastLayout.h
//  WLToastView
//
//  Created by jzjy on 2021/1/4.
//

#import <Foundation/Foundation.h>

@interface WLToastLayout : NSObject

@property (nonatomic,assign) CGFloat maxWidth;
@property (nonatomic,assign) CGFloat maxHeight;

@property (nonatomic,assign) UIEdgeInsets insets_padding;   //上左下右内边距

@property (nonatomic,assign) CGSize imgSize;                //图片尺寸

@property (nonatomic,assign) CGFloat spaceing_actToLbl;     //活动指示器 与 lbl 的间距
@property (nonatomic,assign) CGFloat spaceing_imgToLbl;     //图片 与 lbl 的间距
@property (nonatomic,assign) CGFloat spaceing_lblToLbl;     //lbl 的间距

@property (nonatomic,class,readonly) WLToastLayout *defaultLayout;

+ (instancetype)withConfig:(void(^)(WLToastLayout *config))config;

@end
