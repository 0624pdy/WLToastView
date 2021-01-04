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

+ (instancetype)withConfig:(void(^)(WLToastData *config))config;
+ (instancetype)withStyle:(WLToastViewStyle)style image:(id)image text:(NSString *)text detail:(NSString *)detail customView:(UIView *)customView;

+ (instancetype)withStyle:(WLToastViewStyle)style image:(id)image text:(NSString *)text detail:(NSString *)detail;
+ (instancetype)withImage:(id)image text:(NSString *)text detail:(NSString *)detail;
+ (instancetype)withCustomView:(UIView *)customView;

@property (nonatomic,assign) WLToastViewStyle style;
@property (nonatomic,strong) id image;
@property (nonatomic,copy)   NSString *text;
@property (nonatomic,copy)   NSString *detail;
@property (nonatomic,strong) UIView *customView;

@property (nonatomic,assign,readonly) BOOL showActIndicator;
@property (nonatomic,assign,readonly) BOOL showImage;
@property (nonatomic,assign,readonly) BOOL showCustomView;

@property (nonatomic,assign,readonly) BOOL showText;
@property (nonatomic,assign,readonly) BOOL showDetail;

@end
