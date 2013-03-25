//
//  YHXViewController.h
//  iphone1
//
//  Created by Zeng Yifei on 13-3-6.
//  Copyright (c) 2013年 KaiYan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHXCodeViewController.h"
#import "YHXSoapAPI.h"

@interface YHXViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIProgressView * proView;
    double proValue;
    NSTimer * timer;
    NSTimer * returnTimer;
    UIActivityIndicatorView * activityIndicator;
    
    NSString * command;
    NSNotificationCenter *nc;
    
    UITableView *DataTable;
    NSMutableArray *dataArray1; //定义数据数组1
    NSMutableArray * name;
    NSMutableArray * signal;
    NSMutableArray * security;
    
    BOOL viewLoaded;
    BOOL tableLoaded;
    
    YHXSoapAPI * soap;
    YHXCodeViewController * setPage;
}


@property (strong,nonatomic)IBOutlet UILabel *display;
@property(nonatomic,retain)UIProgressView *proView;
@property(nonatomic,assign)UIActivityIndicatorView * activityIndicator;
@property(nonatomic,retain)NSString * command;



-(void)showProgress;
-(void)showTableView;



@end
