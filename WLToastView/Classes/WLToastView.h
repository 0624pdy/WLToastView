//
//  WLToastView.h
//  WLToastView_Example
//
//  Created by jzjy on 2020/12/31.
//  Copyright © 2020 0624pdy@sina.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WLToastViewTypes.h"

@interface WLToastView : UIView

- (void)showAnimated:(BOOL)animated;
- (void)dismissDelay:(NSTimeInterval)delay;

@end
