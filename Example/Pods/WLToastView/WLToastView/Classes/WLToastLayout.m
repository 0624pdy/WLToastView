//
//  WLToastLayout.m
//  WLToastView
//
//  Created by jzjy on 2021/1/4.
//

#import "WLToastLayout.h"

@implementation WLToastLayout

+ (WLToastLayout *)defaultLayout {
    WLToastLayout *layout = [[WLToastLayout alloc] init];
    
    CGFloat sW = UIScreen.mainScreen.bounds.size.width;
    CGFloat sH = UIScreen.mainScreen.bounds.size.height;
    
    layout.maxWidth             = (sW - 16*2);
    layout.maxHeight            = (sH - 16*2);
    
    layout.insets_padding       = UIEdgeInsetsMake(25, 25, 25, 25);
    
    layout.imgSize = CGSizeMake(49, 49);
    
    layout.spaceing_actToLbl    = 16;
    layout.spaceing_imgToLbl    = 16;
    layout.spaceing_lblToLbl    = 12;
    
    return layout;
}
+ (instancetype)withConfig:(void (^)(WLToastLayout *))config {
    WLToastLayout *layout = WLToastLayout.defaultLayout;
    
    if (config) {
        config(layout);
    }
    
    return layout;
}

@end
