//
//  XCNetworking.h
//  Pedometer
//
//  Created by 黄盛全 on 2020/12/24.
//  Copyright © 2020 黄盛全. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^XCNetworkingBlock)(id __nullable datas, NSString *__nullable error);

@interface XCNetworking : NSObject

@property (nonatomic ,copy) XCNetworkingBlock xcNetworking;

+ (XCNetworking *)sharedInstance;


- (void)getUrl:(NSString *)urlPath parameters:(NSMutableDictionary *)parametersDic Complated:(XCNetworkingBlock)complation ;


- (void)postUrl:(NSString *)urlPath parameters:(NSMutableDictionary *)parametersDic Complated:(XCNetworkingBlock)complation ;


@end

NS_ASSUME_NONNULL_END
