//
//  MLHttpTool.h
//  ItcastWeibo
//
//  Created by apple on 14-5-19.
//  Copyright (c) 2014年 itcast. All rights reserved.
//  封装整个项目的GET\POST请求

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, MLHttpToolNetworkStates) {
    MLHttpToolNetworkStatesNone, // 没有网络
    MLHttpToolNetworkStates2G, // 2G
    MLHttpToolNetworkStates3G, // 3G
    MLHttpToolNetworkStates4G, // 4G
    MLHttpToolNetworkStatesWIFI // WIFI
};
@interface MLHttpTool : NSObject

/**
 *  发送一个POST请求
 *
 *  @param url     请求路径,只要在一定宏定义的 例如 GE_URL_Chats
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postWithURL:(NSString *)url
             params:(NSDictionary *)params
            success:(void (^)(id json))success
            failure:(void (^)(NSError *error))failure;

/**
 *  发送一个GET请求
 *
 *  @param url     请求路径,只要在一定宏定义的 例如 GE_URL_Chats
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;


/**
 *  发送一个POST请求(上传图片数据)
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param formData  图片参数（NSData）
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)requestImageDataWithURL:(NSString *)url parameters:(NSDictionary *)parameters andImageData:(NSData *)imageData success:(void (^)(id result))success failure:(void (^)(NSError *error))failure;


+ (NSDictionary *)httpRequestWithUrl:(NSString *)url andType:(NSString *)type andRequestBody:(NSString *)requestBody;


+ (MLHttpToolNetworkStates)getNetworkStates;

@end
