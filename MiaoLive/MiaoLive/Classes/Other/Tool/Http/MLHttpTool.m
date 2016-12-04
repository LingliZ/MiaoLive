//
//  MLHttpTool.m
//  ItcastWeibo
//
//  Created by apple on 14-5-19.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "MLHttpTool.h"

static AFHTTPSessionManager *_sessionManager;
@implementation MLHttpTool


+ (void)initialize{
    _sessionManager = [AFHTTPSessionManager manager];
    _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    _sessionManager.requestSerializer.timeoutInterval = 5.0;
}


+ (void)postWithURL:(NSString *)url params:(NSMutableDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    [_sessionManager POST:url
               parameters:params
                 progress:nil
                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          if (success) {
              success(responseObject);
          }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           if (failure) {
              failure(error);
          }
    }];
}


+ (void)getWithURL:(NSString *)url params:(NSMutableDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    [_sessionManager GET:url
               parameters:params
                 progress:nil
                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                      if (success) {
                          success(responseObject);
                      }
                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                      if (failure) {
                          failure(error);
                      }
                  }];
}

+ (void)requestImageDataWithURL:(NSString *)url parameters:(NSDictionary *)parameters andImageData:(NSData *)imageData success:(void (^)(id result))success failure:(void (^)(NSError *error))failure{
    
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//    
//    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
//    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"multipart/form-data", nil];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    
//    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        
////        NSString *datastring = [[NSBundle mainBundle] pathForResource:@"postImage.png" ofType:nil];
////        UIImage *image = [UIImage imageNamed:datastring];
////        NSData *data = UIImagePNGRepresentation(image);
//        [formData appendPartWithFileData:imageData name:@"user" fileName:@"123.png" mimeType:@"image/png"];
//        
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        if (success) {
//            success(responseObject);
//        }
////        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
////        NSLog(@"-------%@",dic);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        if (failure) {
//            failure(error);
//        }
////        NSLog(@"failure   %@",error);
//    }];
}

//+ (NSDictionary *)httpRequestWithUrl:(NSString *)url andType:(NSString *)type andRequestBody:(NSString *)requestBody{
//    
//    //2.创建请求对象
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
//    request.timeoutInterval = 5.0f;
//    
//    request.HTTPMethod = type;
//    
//    //设置请求体
//    request.HTTPBody = [requestBody dataUsingEncoding:NSUTF8StringEncoding];
//    
//    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableContainers error:nil];
//    
//    return dic;
//}

+ (MLHttpToolNetworkStates)getNetworkStates{
    // 判断网络类型
    NSArray *subviews = [[[[UIApplication sharedApplication] valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
        // 保存网络状态
        MLHttpToolNetworkStates states = MLHttpToolNetworkStatesNone;
        for (id child in subviews) {
            if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
                //获取到状态栏码
                int networkType = [[child valueForKeyPath:@"dataNetworkType"] intValue];
                switch (networkType) {
                    case 0:
                        states = MLHttpToolNetworkStatesNone;
                        //无网模式
                        break;
                    case 1:
                        states = MLHttpToolNetworkStates2G;
                        break;
                    case 2:
                        states = MLHttpToolNetworkStates3G;
                        break;
                    case 3:
                        states = MLHttpToolNetworkStates4G;
                        break;
                    case 5:
                    {
                        states = MLHttpToolNetworkStatesWIFI;
                    }
                        break;
                    default:
                        break;
                }
            }
        }
        //根据状态选择
        return states;
    }

@end
