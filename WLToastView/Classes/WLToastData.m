//
//  WLToastData.m
//  WLToastView
//
//  Created by jzjy on 2021/1/4.
//

#import "WLToastData.h"

@interface WLToastData ()

@property (nonatomic,assign) BOOL showActIndicator;
@property (nonatomic,assign) BOOL showImage;
@property (nonatomic,assign) BOOL showCustomView;

@property (nonatomic,assign) BOOL showText;
@property (nonatomic,assign) BOOL showDetail;

@end

@implementation WLToastData

+ (instancetype)withConfig:(void (^)(WLToastData *))config {
    WLToastData *data = [[WLToastData alloc] init];
    
    if (config) {
        config(data);
    }
    
    return data;
}
+ (instancetype)withStyle:(WLToastViewStyle)style image:(id)image text:(NSString *)text detail:(NSString *)detail customView:(UIView *)customView {
    WLToastData *data = [[WLToastData alloc] init];
    
    data.style = style;
    data.image = image;
    data.text = text;
    data.detail = detail;
    data.customView = customView;
    
    return data;
}
+ (instancetype)withStyle:(WLToastViewStyle)style image:(id)image text:(NSString *)text detail:(NSString *)detail {
    return [self withStyle:style image:image text:text detail:detail customView:nil];
}
+ (instancetype)withImage:(id)image text:(NSString *)text detail:(NSString *)detail {
    return [self withStyle:WLToastViewStyle_Image image:image text:text detail:detail customView:nil];
}
+ (instancetype)withCustomView:(UIView *)customView {
    return [self withStyle:WLToastViewStyle_Custom image:nil text:nil detail:nil customView:customView];
}

- (void)resetFlags {
    _showActIndicator = NO;
    _showImage = NO;
    _showCustomView = NO;
}
- (void)setStyle:(WLToastViewStyle)style {
    _style = style;
    
    [self resetFlags];
    
    if (style == WLToastViewStyle_ActivityIndicator) {
        _showActIndicator = YES;
    } else if (style == WLToastViewStyle_Image) {
        _showImage = YES;
    } else if (style == WLToastViewStyle_Custom) {
        _showCustomView = YES;
    }
}
- (void)setText:(NSString *)text {
    _text = text;
    
    _showText = (_text.length > 0);
}
- (void)setDetail:(NSString *)detail {
    _detail = detail;
    
    _showDetail = (_detail.length > 0);
}

@end
