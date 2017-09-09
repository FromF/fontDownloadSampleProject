//
//  AppDelegate.h
//  fontDownloadSample
//
//  Created by FromF on 2017/08/15.
//  Copyright © 2017年 FromF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

#define TRACE(fmt, ...) NSLog((@"[TR]%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define ERROR_LOG(fmt, ...) NSLog((@"[TR-E]%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
