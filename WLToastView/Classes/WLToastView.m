//
//  WLToastView.m
//  WLToastView_Example
//
//  Created by jzjy on 2020/12/31.
//  Copyright © 2020 0624pdy@sina.com. All rights reserved.
//

#import "WLToastView.h"

#import <Masonry/Masonry.h>

#import "WLToastLayout.h"
#import "WLToastData.h"

@interface WLToastView ()

@property (nonatomic,strong) UIView *containerView;
@property (nonatomic,strong) UIActivityIndicatorView *actView;
@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UILabel *lbl_text;
@property (nonatomic,strong) UILabel *lbl_detail;

@property (nonatomic,strong) WLToastLayout *layout; //布局
@property (nonatomic,strong) WLToastData *data;     //内容

@end

@implementation WLToastView

+ (instancetype)sharedToast {
    static WLToastView *toastView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        toastView = [[WLToastView alloc] init];
        
        [toastView defaultSetup];
    });
    return toastView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self defaultSetup];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self defaultSetup];
    }
    return self;
}
- (void)defaultSetup {
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    self.alpha = 0;
}
- (void)addSubviews {
    
    [self addSubview:self.containerView];
    
    CGFloat minL = (UIScreen.mainScreen.bounds.size.width - self.layout.maxWidth)/2;
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        //make.width.height.mas_equalTo(110);
        make.left.mas_greaterThanOrEqualTo(minL);
    }];
}

- (void)addConstraintsFor:(UIView *)view isBottom:(BOOL)isBottom {
    
}





#pragma mark - <#标识#>

- (void)showWithData:(WLToastData *)data animated:(BOOL)animated {
    _data = data;
    
    //活动指示器 or 图片
    if (_data.showActIndicator) {
        [self.containerView addSubview:self.actView];
        [self.actView startAnimating];
        [_imgView removeFromSuperview];
    } else {
        [self.containerView addSubview:self.imgView];
        [_actView removeFromSuperview];
    }

    //text
    if (_data.showText) {
        [self.containerView addSubview:self.lbl_text];
        
        self.lbl_text.text = _data.text;
        [self.lbl_text sizeToFit];
        
    } else {
        [_lbl_text removeFromSuperview];
    }
    
    //detail
    if (_data.showDetail) {
        [self.containerView addSubview:self.lbl_detail];
        
        self.lbl_detail.text = _data.detail;
        [self.lbl_detail sizeToFit];
        
    } else {
        [_lbl_detail removeFromSuperview];
    }
    
    CGFloat TB = self.layout.insets_padding.left;
    CGFloat LR = self.layout.insets_padding.right;
    
    //活动指示器
    if (_data.style == WLToastViewStyle_ActivityIndicator) {
        
        //MARK: 1⃣️ 活动指示器
        if (_data.showText == NO && _data.showDetail == NO) {
            
            [self.actView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.containerView).mas_offset(TB);
                make.left.mas_equalTo(self.containerView).mas_offset(LR);
                make.right.mas_equalTo(self.containerView).mas_offset(-LR);
                make.bottom.mas_equalTo(self.containerView).mas_offset(-TB);
            }];
            
        } else {
            
            [self.actView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.containerView).mas_offset(TB);
                make.centerX.mas_equalTo(self.containerView);
            }];
            
            //MARK: 2⃣️ 活动指示器 + text + detail
            if (_data.showText && _data.showDetail) {
                
                [self.lbl_text mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.actView.mas_bottom).mas_offset(self.layout.spaceing_actToLbl);
                    make.left.mas_equalTo(self.containerView).mas_offset(LR);
                    make.right.mas_equalTo(self.containerView).mas_offset(-LR);
                }];
                [self.lbl_detail mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.lbl_text.mas_bottom).mas_offset(self.layout.spaceing_lblToLbl);
                    make.left.mas_equalTo(self.containerView).mas_offset(LR);
                    make.right.mas_equalTo(self.containerView).mas_offset(-LR);
                    make.bottom.mas_equalTo(self.containerView).mas_offset(-TB);
                }];
                
            }
            //MARK: 3⃣️ 活动指示器 + text
            //MARK: 4⃣️ 活动指示器 + detail
            else {
                
                UILabel *targetLbl = nil;
                if (_data.showText) {
                    targetLbl = self.lbl_text;
                } else {
                    targetLbl = self.lbl_detail;
                }
                
                [targetLbl mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.actView.mas_bottom).mas_offset(self.layout.spaceing_actToLbl);
                    make.left.mas_equalTo(self.containerView).mas_offset(LR);
                    make.right.mas_equalTo(self.containerView).mas_offset(-LR);
                    make.bottom.mas_equalTo(self.containerView).mas_offset(-TB);
                }];
                
            }
            
        }
        
    }
    //图片
    else if (_data.style == WLToastViewStyle_Image) {
        
        CGSize imgSize = self.layout.imgSize;
        
        //MARK: 5⃣️ 图片
        if (_data.showText == NO && _data.showDetail == NO) {
            
            [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(imgSize);
                make.top.mas_equalTo(self.containerView).mas_offset(TB);
                make.left.mas_equalTo(self.containerView).mas_offset(LR);
                make.right.mas_equalTo(self.containerView).mas_offset(-LR);
                make.bottom.mas_equalTo(self.containerView).mas_offset(-TB);
            }];
            
        } else {
            
            [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(imgSize);
                make.top.mas_equalTo(self.containerView).mas_offset(TB);
                make.centerX.mas_equalTo(self.containerView);
            }];
            
            //MARK: 6⃣️ 图片 + text + detail
            if (_data.showText && _data.showDetail) {
                
                [self.lbl_text mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.imgView.mas_bottom).mas_offset(self.layout.spaceing_actToLbl);
                    make.left.mas_equalTo(self.containerView).mas_offset(LR);
                    make.right.mas_equalTo(self.containerView).mas_offset(-LR);
                }];
                [self.lbl_detail mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.lbl_text.mas_bottom).mas_offset(self.layout.spaceing_lblToLbl);
                    make.left.mas_equalTo(self.containerView).mas_offset(LR);
                    make.right.mas_equalTo(self.containerView).mas_offset(-LR);
                    make.bottom.mas_equalTo(self.containerView).mas_offset(-TB);
                }];
                
            }
            //MARK: 7⃣️ 图片 + text
            //MARK: 8⃣️ 图片 + detail
            else {
                
                UILabel *targetLbl = nil;
                if (_data.showText) {
                    targetLbl = self.lbl_text;
                } else {
                    targetLbl = self.lbl_detail;
                }
                
                [targetLbl mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.imgView.mas_bottom).mas_offset(self.layout.spaceing_actToLbl);
                    make.left.mas_equalTo(self.containerView).mas_offset(LR);
                    make.right.mas_equalTo(self.containerView).mas_offset(-LR);
                    make.bottom.mas_equalTo(self.containerView).mas_offset(-TB);
                }];
                
            }
            
        }
        
    }
    //文本
    else if (_data.style == WLToastViewStyle_Text) {
        
        //MARK: 9⃣️ text + detail
        if (_data.showText && _data.showDetail) {
            
            [self.lbl_text mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.containerView).mas_offset(TB);
                make.left.mas_equalTo(self.containerView).mas_offset(LR);
                make.right.mas_equalTo(self.containerView).mas_offset(-LR);
            }];
            [self.lbl_detail mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.lbl_text.mas_bottom).mas_offset(self.layout.spaceing_lblToLbl);
                make.left.mas_equalTo(self.containerView).mas_offset(LR);
                make.right.mas_equalTo(self.containerView).mas_offset(-LR);
                make.bottom.mas_equalTo(self.containerView).mas_offset(-TB);
            }];
            
        } else {
            
            //MARK: 1⃣️0⃣️ detail
            if (_data.showText) {
                
                [self.lbl_text mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.mas_equalTo(self.containerView).mas_offset(self.layout.insets_padding);
                }];
                
            }
            //MARK: 1⃣️1⃣️ text
            else if (_data.showDetail) {
                
                [self.lbl_detail mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.mas_equalTo(self.containerView).mas_offset(self.layout.insets_padding);
                }];
                
            } else {
                
                return;
                
            }
            
        }
        
    }
    //自定义
    else {
        
        [self.containerView addSubview:self.data.customView];
        [_actView removeFromSuperview];
        [_imgView removeFromSuperview];
        [_lbl_text removeFromSuperview];
        [_lbl_detail removeFromSuperview];
        
        CGFloat W = self.data.customView.frame.size.width;
        CGFloat H = self.data.customView.frame.size.height;
        W = MIN(W, self.layout.maxWidth);
        H = MIN(H, self.layout.maxHeight);
        
        [self.data.customView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.containerView);
            make.width.mas_equalTo(W);
            make.height.mas_equalTo(H);
        }];
    }
    
    UIView *superview = [UIApplication sharedApplication].keyWindow;
    [superview addSubview:self];
    self.alpha = 1;
    
    [self addSubviews];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
        self.alpha = 0;
    });
}

+ (void)showWithData:(WLToastData *)data animated:(BOOL)animated {
    [[WLToastView sharedToast] showWithData:data animated:animated];
}

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

#pragma mark -

+ (void)dismissAnimated:(BOOL)animated {
    UIView *view = [WLToastView sharedToast];
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            
            view.alpha = 0;
            
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
    } else {
        view.alpha = 0;
        [view removeFromSuperview];
    }
}

- (void)showAnimated:(BOOL)animated {
    
}
- (void)dismissDelay:(NSTimeInterval)delay {
    
}





#pragma mark -

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview) {
        NSLog(@"willMoveToSuperview: %@", NSStringFromClass(newSuperview.class));
    } else {
        NSLog(@"willMoveToSuperview: %@", nil);
    }
}
- (void)didMoveToSuperview {
    if (self.superview) {
        NSLog(@"didMoveToSuperview: %@", NSStringFromClass(self.superview.class));
        [self updateFrames];
    } else {
        NSLog(@"didMoveToSuperview: %@", nil);
    }
}




- (void)updateFrames {
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.superview);
        make.height.mas_equalTo(self.superview);
    }];
}





#pragma mark - Getter & Setter

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        _containerView.backgroundColor = UIColor.blackColor;
        _containerView.layer.cornerRadius = 15;
        _containerView.layer.masksToBounds = YES;
        //_containerView.layer.maskedCorners = (kCALayerMinXMinYCorner | kCALayerMaxXMaxYCorner);
    }
    return _containerView;
}
- (UIActivityIndicatorView *)actView {
    if (!_actView) {
        _actView = [[UIActivityIndicatorView alloc] init];

        if (@available(iOS 13.0, *)) {
            _actView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleLarge;
        } else {
            _actView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        }
        _actView.color = UIColor.whiteColor;

        _actView.hidesWhenStopped = YES;
    }
    return _actView;
}
- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        _imgView.clipsToBounds = YES;
        _imgView.backgroundColor = UIColor.whiteColor;
    }
    return _imgView;
}
- (UILabel *)lbl_text {
    if (!_lbl_text) {
        _lbl_text = [self lblWithFont:[UIFont systemFontOfSize:16 weight:UIFontWeightRegular] color:UIColor.whiteColor alignment:NSTextAlignmentCenter numOfLines:0];
    }
    return _lbl_text;
}
- (UILabel *)lbl_detail {
    if (!_lbl_detail) {
        _lbl_detail = [self lblWithFont:[UIFont systemFontOfSize:14 weight:UIFontWeightRegular] color:UIColor.whiteColor alignment:NSTextAlignmentCenter numOfLines:0];
    }
    return _lbl_detail;
}
- (UILabel *)lblWithFont:(UIFont *)font color:(UIColor *)color alignment:(NSTextAlignment)alignment numOfLines:(NSInteger)numOfLines {
    UILabel *lbl = [[UILabel alloc] init];
    
    lbl.text = @"UILabel";
    lbl.font = font;
    lbl.textColor = color;
    lbl.textAlignment = alignment;
    lbl.numberOfLines = numOfLines;
    
    return lbl;
}





#pragma mark -

+ (void)setLayout:(WLToastLayout *)layout {
    [WLToastView sharedToast].layout = layout;
}

@end
