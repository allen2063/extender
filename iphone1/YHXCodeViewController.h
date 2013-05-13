//
//  YHXCodeViewController.h
//  iphone1
//
//  Created by Zeng Yifei on 13-3-8.
//  Copyright (c) 2013年 KaiYan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHXSetPageViewController.h"


@interface YHXCodeViewController : UIViewController<UITextFieldDelegate>{
    YHXSoapAPI * soap;
    YHXSoapFor5G * soapFor5G;
    UIActivityIndicatorView * activityIndicator;
    NSNotificationCenter *nc;
    YHXSetPageViewController * setPage;
    NSString * Channel;
}

@property(assign,nonatomic)IBOutlet UITextField *codeTextField;

@property(assign,nonatomic)IBOutlet UILabel * name1Label;
@property(assign,nonatomic)IBOutlet UILabel * security1Label;
@property(assign,nonatomic)IBOutlet UILabel * code1Label;


@property(assign,nonatomic)IBOutlet UILabel * nameLabel;
@property(assign,nonatomic)IBOutlet UILabel *securityLabel;
@property(nonatomic,assign)UIActivityIndicatorView * activityIndicator;
@property(nonatomic,assign)NSString * getCode;
-(void)getNameAndSecurity:(NSString*)name1 :(NSString*)security1 :(NSString *)channel;
@end
