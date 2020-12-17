//
//  XCUtils.h
//  Pedometer
//
//  Created by 黄盛全 on 2020/12/12.
//  Copyright © 2020 黄盛全. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XCUtils : NSObject

+ (XCUtils *)shareUtils;//构造单例

///UILabel 根据文字自适应宽度
+ (float) calculateStrwidthWithStr:(NSString *)str Font: (UIFont *) font;

@end

NS_ASSUME_NONNULL_END
