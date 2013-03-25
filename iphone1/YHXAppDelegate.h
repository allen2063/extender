//
//  YHXAppDelegate.h
//  iphone1
//
//  Created by Zeng Yifei on 13-3-6.
//  Copyright (c) 2013年 KaiYan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHXViewController;



@interface YHXAppDelegate : UIResponder <UIApplicationDelegate>
{
    NSMutableArray * my;
    NSString * str;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) YHXViewController *viewController;
@property (strong, nonatomic) UINavigationController *nav;

@property (nonatomic,retain)NSMutableArray *my;
@property (nonatomic,retain)NSString *str;
@end
