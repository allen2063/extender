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
    UIActivityIndicatorView * activityIndicator;
    NSNotificationCenter *nc;
    YHXSetPageViewController * setPage;
}

@property(assign,nonatomic)IBOutlet UITextField *code;
@property(assign,nonatomic) UITextField *key1TextField;
@property(assign,nonatomic) UITextField *key2TextField;
@property(assign,nonatomic) UITextField *key3TextField;
@property(assign,nonatomic) UITextField *key4TextField;
@property(assign,nonatomic) UILabel * key1Label;
@property(assign,nonatomic) UILabel * key2Label;
@property(assign,nonatomic) UILabel * key3Label;
@property(assign,nonatomic) UILabel * key4Label;


@property(assign,nonatomic)IBOutlet UILabel * name;
@property(assign,nonatomic)IBOutlet UILabel *security;
@property(nonatomic,assign)UIActivityIndicatorView * activityIndicator;
@property(nonatomic,assign)NSString * getCode;
-(void)getNameAndSecurity:(NSString*)name1 :(NSString*)security1;
@end
