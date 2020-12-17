//
//  XCUtils.m
//  Pedometer
//
//  Created by 黄盛全 on 2020/12/12.
//  Copyright © 2020 黄盛全. All rights reserved.
//

#import "XCUtils.h"

@implementation XCUtils

static XCUtils *_utils = nil;

+ (XCUtils *)shareUtils
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _utils = [[self alloc] init];
    });
    return _utils;
    
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _utils = [super allocWithZone:zone];
    });
    return _utils;
}


- (id)copyWithZone:(NSZone *)zone
{
    return _utils;
}

///UILabel 根据文字自适应宽度
+ (float) calculateStrwidthWithStr:(NSString *)str Font: (UIFont *) font
{
    CGRect textRect = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, font.pointSize)
                                        options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                     attributes:@{NSFontAttributeName:font}
                                        context:nil];
    
    return ceil(textRect.size.width);
}

@end
