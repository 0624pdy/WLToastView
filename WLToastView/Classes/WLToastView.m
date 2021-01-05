//
//  WLToastView.m
//  WLToastView_Example
//
//  Created by jzjy on 2020/12/31.
//  Copyright © 2020 0624pdy@sina.com. All rights reserved.
//

#import "WLToastView.h"

#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>

#import "WLToastLayout.h"
#import "WLToastData.h"


/** 动画时长 */
static double WLToastAnimationDuration  = 0.2;
/** 缩放动画的最大倍数 */
static double WLToastAnimationMaxScale  = 1.5;


@interface WLToastView ()
{
    NSTimer *_timer;
    NSTimeInterval _time;
}
@property (nonatomic,strong) UIView *containerView;             //内置控件 - 容器
@property (nonatomic,strong) UIActivityIndicatorView *actView;  //内置控件 - 活动指示器
@property (nonatomic,strong) UIImageView *imgView;              //内置控件 - 图片
@property (nonatomic,strong) UILabel *lbl_text;                 //内置控件 - 文本标签
@property (nonatomic,strong) UILabel *lbl_detail;               //内置控件 - 详情
@property (nonatomic,strong) UIView *customView;                //⭕️ 外部控件 - 自定义视图

@property (nonatomic,strong) WLToastLayout *layout;             //布局
@property (nonatomic,assign) WLToastAnimation animation;        //动画，默认：WLToastAnimation_Fade
@property (nonatomic,assign) NSTimeInterval dismissDelay;       //展示时长（单位：秒）（ 延迟 dismissDelay秒 后自动关闭 ），default：1.5
@property (nonatomic,assign) BOOL showBgView;                   //是否显背景层，default：YES
@property (nonatomic,strong) UIColor *bgViewColor;              //背景层颜色，default：RGBA(0, 0, 0, 0.2)
@property (nonatomic,assign) BOOL shouldDismissWhenTapedBgView; //点击背景时是否关闭，default：NO

@property (nonatomic,strong) WLToastData *data;                 //内容

@end

@implementation WLToastView

+ (instancetype)sharedToast {
    static WLToastView *toastView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        toastView = [[WLToastView alloc] init];
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
    
    _animation = WLToastAnimation_Fade;
    _dismissDelay = 1.5;
    _showBgView = YES;
    _bgViewColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    self.shouldDismissWhenTapedBgView = NO;
    
    self.backgroundColor = _bgViewColor;
    self.alpha = 0;
}





#pragma mark -

- (void)removeSubviews {
    
    //内置控件：直接移除，不置nil
    [_actView removeFromSuperview];
    [_imgView removeFromSuperview];
    [_lbl_text removeFromSuperview];
    [_lbl_detail removeFromSuperview];
    
    //外部控件：移除并置nil
    [_customView removeFromSuperview];
    _customView = nil;
}
- (void)showWithData:(WLToastData *)data animated:(BOOL)animated {
    _data = data;
    
    //重置控件
    [self removeSubviews];
    
    //活动指示器、图片、自定义视图
    if (_data.showActIndicator) {
        [self.containerView addSubview:self.actView];
        [self.actView startAnimating];
    } else if (_data.showImage) {
        [self.containerView addSubview:self.imgView];
        
        id imgObj = _data.image;
        if ([imgObj isKindOfClass:[UIImage class]]) {
            _imgView.image = (UIImage *)imgObj;
        } else if ([imgObj isKindOfClass:[NSDate class]]) {
            _imgView.image = [UIImage imageWithData:(NSData *)imgObj];
        } else if ([imgObj isKindOfClass:[NSURL class]]) {
            [_imgView sd_setImageWithURL:(NSURL *)imgObj];
        } else if ([imgObj isKindOfClass:[NSString class]]) {
            NSString *str = (NSString *)imgObj;
            if ([str hasPrefix:@"http"]) {
                [_imgView sd_setImageWithURL:[NSURL URLWithString:str]];
            } else {
                _imgView.image = [UIImage imageNamed:str];
            }
        }
        
    } else if (_data.showCustomView) {
        _customView = self.data.customView;
        [self.containerView addSubview:_customView];
    }

    //text
    if (_data.showText) {
        [self.containerView addSubview:self.lbl_text];
        
        self.lbl_text.text = _data.text;
        [self.lbl_text sizeToFit];
    }
    
    //detail
    if (_data.showDetail) {
        [self.containerView addSubview:self.lbl_detail];
        
        self.lbl_detail.text = _data.detail;
        [self.lbl_detail sizeToFit];
    }
    
    CGFloat TB = self.layout.insets_padding.left;
    CGFloat LR = self.layout.insets_padding.right;
    CGFloat S1 = self.layout.spaceing_actToLbl;
    CGFloat S2 = self.layout.spaceing_lblToLbl;
    CGSize imgSize = self.layout.imgSize;
    
    //活动指示器
    //----------------------------------------------------------------------------------------------
    if (_data.style == WLToastViewStyle_ActivityIndicator) {
        
        [self.containerView addSubview:self.actView];
        [self.actView startAnimating];
        
        //MARK: 1⃣️1⃣️ 活动指示器
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
            
            //MARK: 1⃣️2⃣️ 活动指示器 + text + detail
            if (_data.showText && _data.showDetail) {
                
                [self.lbl_text mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.actView.mas_bottom).mas_offset(S1);
                    make.left.mas_equalTo(self.containerView).mas_offset(LR);
                    make.right.mas_equalTo(self.containerView).mas_offset(-LR);
                }];
                [self.lbl_detail mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.lbl_text.mas_bottom).mas_offset(S2);
                    make.left.mas_equalTo(self.containerView).mas_offset(LR);
                    make.right.mas_equalTo(self.containerView).mas_offset(-LR);
                    make.bottom.mas_equalTo(self.containerView).mas_offset(-TB);
                }];
            }
            //MARK: 1⃣️3⃣️ 活动指示器 + text
            //MARK: 1⃣️4⃣️ 活动指示器 + detail
            else {
                
                UILabel *targetLbl = nil;
                if (_data.showText) {
                    targetLbl = self.lbl_text;
                } else {
                    targetLbl = self.lbl_detail;
                }
                
                [targetLbl mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.actView.mas_bottom).mas_offset(S1);
                    make.left.mas_equalTo(self.containerView).mas_offset(LR);
                    make.right.mas_equalTo(self.containerView).mas_offset(-LR);
                    make.bottom.mas_equalTo(self.containerView).mas_offset(-TB);
                }];
            }
        }
    }
    //图片
    //----------------------------------------------------------------------------------------------
    else if (_data.style == WLToastViewStyle_Image) {
        
        //MARK: 2⃣️1⃣️ 图片
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
            
            //MARK: 2⃣️2⃣️ 图片 + text + detail
            if (_data.showText && _data.showDetail) {
                
                [self.lbl_text mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.imgView.mas_bottom).mas_offset(S1);
                    make.left.mas_equalTo(self.containerView).mas_offset(LR);
                    make.right.mas_equalTo(self.containerView).mas_offset(-LR);
                }];
                [self.lbl_detail mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.lbl_text.mas_bottom).mas_offset(S2);
                    make.left.mas_equalTo(self.containerView).mas_offset(LR);
                    make.right.mas_equalTo(self.containerView).mas_offset(-LR);
                    make.bottom.mas_equalTo(self.containerView).mas_offset(-TB);
                }];
                
            }
            //MARK: 2⃣️3⃣️ 图片 + text
            //MARK: 2⃣️4⃣️ 图片 + detail
            else {
                
                UILabel *targetLbl = nil;
                if (_data.showText) {
                    targetLbl = self.lbl_text;
                } else {
                    targetLbl = self.lbl_detail;
                }
                
                [targetLbl mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.imgView.mas_bottom).mas_offset(S1);
                    make.left.mas_equalTo(self.containerView).mas_offset(LR);
                    make.right.mas_equalTo(self.containerView).mas_offset(-LR);
                    make.bottom.mas_equalTo(self.containerView).mas_offset(-TB);
                }];
            }
        }
    }
    //文本
    //----------------------------------------------------------------------------------------------
    else if (_data.style == WLToastViewStyle_Text) {
        
        //MARK: 3⃣️1⃣️ text + detail
        if (_data.showText && _data.showDetail) {
            
            [self.lbl_text mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.containerView).mas_offset(TB);
                make.left.mas_equalTo(self.containerView).mas_offset(LR);
                make.right.mas_equalTo(self.containerView).mas_offset(-LR);
            }];
            [self.lbl_detail mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.lbl_text.mas_bottom).mas_offset(S2);
                make.left.mas_equalTo(self.containerView).mas_offset(LR);
                make.right.mas_equalTo(self.containerView).mas_offset(-LR);
                make.bottom.mas_equalTo(self.containerView).mas_offset(-TB);
            }];
            
        } else {
            
            //MARK: 3⃣️2⃣️ detail
            if (_data.showText) {
                
                [self.lbl_text mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.mas_equalTo(self.containerView).mas_offset(self.layout.insets_padding);
                }];
                
            }
            //MARK: 3⃣️3⃣️ text
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
    //----------------------------------------------------------------------------------------------
    else {

        //MARK: 4⃣️1⃣️ 自定义
        CGFloat W = self.data.customView.frame.size.width;
        CGFloat H = self.data.customView.frame.size.height;
        W = MIN(W, self.layout.maxWidth);
        H = MIN(H, self.layout.maxHeight);
        
        [self.customView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.containerView);
            make.width.mas_equalTo(W);
            make.height.mas_equalTo(H);
        }];
    }
    
    [self showAnimated:animated];
}
- (void)layoutSelf {
    
    [self addSubview:self.containerView];
    
    CGFloat minL = (UIScreen.mainScreen.bounds.size.width - self.layout.maxWidth)/2;
    
    if (self.showBgView) {
        
        self.backgroundColor = self.bgViewColor;
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.superview);
        }];
        [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.left.mas_greaterThanOrEqualTo(minL);
        }];
        
    } else {
        
        self.backgroundColor = UIColor.clearColor;
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.superview);
        }];
        [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
    }
}
- (void)showAnimated:(BOOL)animated {
    
    UIView *superview = [UIApplication sharedApplication].keyWindow;
    [superview addSubview:self];
    [self layoutSelf];
    
    self.containerView.transform = CGAffineTransformIdentity;
    
    //有动画
    if (animated && self.animation != WLToastAnimation_None) {
        //动画样式：渐变
        if (self.animation == WLToastAnimation_Fade) {
            [UIView animateWithDuration:WLToastAnimationDuration animations:^{
                self.alpha = 1;
            } completion:^(BOOL finished) {
                [self startTimer_ifNeeded];
            }];
        }
        //动画样式：缩放渐变
        else if (self.animation == WLToastAnimation_ScaleFade) {
            self.containerView.transform = CGAffineTransformMakeScale(WLToastAnimationMaxScale, WLToastAnimationMaxScale);
            [UIView animateWithDuration:WLToastAnimationDuration animations:^{
                self.alpha = 1;
                self.containerView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                [self startTimer_ifNeeded];
            }];
        }
        //动画样式：弹性
        else if (self.animation == WLToastAnimation_Bounce) {
            self.containerView.transform = CGAffineTransformMakeScale(WLToastAnimationMaxScale, WLToastAnimationMaxScale);
            [UIView animateWithDuration:WLToastAnimationDuration
                                  delay:0
                 usingSpringWithDamping:0.3
                  initialSpringVelocity:10.0
                                options:UIViewAnimationOptionLayoutSubviews
                             animations:^
            {
                self.alpha = 1;
                self.containerView.transform = CGAffineTransformIdentity;
            }
                             completion:^(BOOL finished)
            {
                [self startTimer_ifNeeded];
            }];
        }
        //动画样式：其他
        else {
            
        }
    }
    //无动画
    else {
        self.alpha = 1;
        [self startTimer_ifNeeded];
    }
}
- (void)dismissAnimated:(BOOL)animated {
    if (animated && self.animation != WLToastAnimation_None) {
        //动画样式：渐变
        if (self.animation == WLToastAnimation_Fade) {
            [UIView animateWithDuration:WLToastAnimationDuration animations:^{
                self.alpha = 0;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }
        //动画样式：缩放渐变
        else if (self.animation == WLToastAnimation_ScaleFade) {
            [UIView animateWithDuration:WLToastAnimationDuration animations:^{
                self.alpha = 0;
                self.containerView.transform = CGAffineTransformMakeScale(WLToastAnimationMaxScale, WLToastAnimationMaxScale);
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }
        //动画样式：弹性
        else if (self.animation == WLToastAnimation_Bounce) {
            [UIView animateWithDuration:WLToastAnimationDuration
                                  delay:0
                 usingSpringWithDamping:1.0
                  initialSpringVelocity:10.0
                                options:UIViewAnimationOptionLayoutSubviews
                             animations:^
            {
                self.alpha = 0;
                self.containerView.transform = CGAffineTransformMakeScale(WLToastAnimationMaxScale, WLToastAnimationMaxScale);
            }
                             completion:^(BOOL finished)
            {
                [self removeFromSuperview];
            }];
        }
        //动画样式：其他
        else {
            
        }
    } else {
        self.alpha = 0;
        [self removeFromSuperview];
    }
}





#pragma mark -

+ (void)showWithData:(WLToastData *)data animated:(BOOL)animated {
    [[WLToastView sharedToast] showWithData:data animated:animated];
}
+ (void)dismissAnimated:(BOOL)animated {
    [[WLToastView sharedToast] dismissAnimated:animated];
}





#pragma mark -

//- (void)willMoveToSuperview:(UIView *)newSuperview {
//    if (newSuperview) {
//        NSLog(@"willMoveToSuperview: %@", NSStringFromClass(newSuperview.class));
//    } else {
//        NSLog(@"willMoveToSuperview: %@", nil);
//    }
//}
//- (void)didMoveToSuperview {
//    if (self.superview) {
//        NSLog(@"didMoveToSuperview: %@", NSStringFromClass(self.superview.class));
//    } else {
//        NSLog(@"didMoveToSuperview: %@", nil);
//    }
//}
//- (void)layoutSubviews {
//    [super layoutSubviews];
//
//}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self];
    if (CGRectContainsPoint(self.containerView.frame, point)) {
        return;
    }
    
    [self resetTimer];
    [self dismissAnimated:YES];
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
        _actView.hidesWhenStopped = YES;
        if (@available(iOS 13.0, *)) {
            _actView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleLarge;
        } else {
            _actView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        }
        _actView.color = UIColor.whiteColor;
    }
    return _actView;
}
- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        _imgView.clipsToBounds = YES;
        _imgView.backgroundColor = UIColor.clearColor;
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
- (void)setShouldDismissWhenTapedBgView:(BOOL)shouldDismissWhenTapedBgView {
    _shouldDismissWhenTapedBgView = shouldDismissWhenTapedBgView;
    
    self.userInteractionEnabled = _shouldDismissWhenTapedBgView;
}





#pragma mark -

+ (WLToastLayout *)layout {
    return [WLToastView sharedToast].layout;
}
+ (void)setLayout:(WLToastLayout *)layout {
    [WLToastView sharedToast].layout = layout;
}
+ (WLToastAnimation)animation {
    return [WLToastView sharedToast].animation;
}
+ (void)setAnimation:(WLToastAnimation)animation {
    [WLToastView sharedToast].animation = animation;
}
+ (NSTimeInterval)dismissDelay {
    return [WLToastView sharedToast].dismissDelay;
}
+ (void)setDismissDelay:(NSTimeInterval)dismissDelay {
    [WLToastView sharedToast].dismissDelay = dismissDelay;
}
+ (BOOL)showBgView {
    return [WLToastView sharedToast].showBgView;
}
+ (void)setShowBgView:(BOOL)showBgView {
    [WLToastView sharedToast].showBgView = showBgView;
}
+ (UIColor *)bgViewColor {
    return [WLToastView sharedToast].bgViewColor;
}
+ (void)setBgViewColor:(UIColor *)bgViewColor {
    [WLToastView sharedToast].bgViewColor = bgViewColor;
}
+ (BOOL)shouldDismissWhenTapedBgView {
    return [WLToastView sharedToast].shouldDismissWhenTapedBgView;
}
+ (void)setShouldDismissWhenTapedBgView:(BOOL)shouldDismissWhenTapedBgView {
    [WLToastView sharedToast].shouldDismissWhenTapedBgView = shouldDismissWhenTapedBgView;
}





#pragma mark - Timer


- (void)startTimer_ifNeeded {
    if (self.data.style != WLToastViewStyle_ActivityIndicator) {
        
        [self resetTimer];
        
        NSLog(@"⏰ start timer");
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(action_timer:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        
        [self action_timer:_timer];
    }
}
- (void)stopTimer {
    [_timer invalidate];
    _timer = nil;
}
- (void)resetTimer {
    [self stopTimer];
    _time = self.dismissDelay;
}
- (void)action_timer:(NSTimer *)timer {
    
    NSLog(@"%.2f", _time);
    
    if (_time <= 0) {
        [self stopTimer];
        NSLog(@"⏰ stop timer");
        [self dismissAnimated:YES];
    }
    
    _time -= 0.1;
}

@end
