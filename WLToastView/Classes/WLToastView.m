//
//  WLToastView.m
//  WLToastView_Example
//
//  Created by jzjy on 2020/12/31.
//  Copyright © 2020 0624pdy@sina.com. All rights reserved.
//

#import "WLToastView.h"

@interface WLToastView ()

@property (nonatomic,strong) UIView *bgView;

@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIActivityIndicatorView *actView;
@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UILabel *lbl_text;
@property (nonatomic,strong) UILabel *lbl_detail;

@end

@implementation WLToastView

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
    
    self.backgroundColor = UIColor.clearColor;
    
    [self addSubview:self.bgView];
    [self addSubview:self.contentView];
}





#pragma mark - <#标识#>

- (void)showAnimated:(BOOL)animated {
    
}
- (void)dismissDelay:(NSTimeInterval)delay {
    
}





#pragma mark - Getter & Setter

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = UIColor.clearColor;
    }
    return _bgView;
}
- (UIActivityIndicatorView *)actView {
    if (!_actView) {
        _actView = [[UIActivityIndicatorView alloc] init];
    
        if (@available(iOS 13.0, *)) {
            _actView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleLarge;
        } else {
            _actView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        }
        
        _actView.hidesWhenStopped = YES;
    }
    return _actView;
}

@end
