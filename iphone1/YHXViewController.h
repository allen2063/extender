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
#import "YHXSoapFor5G.h"

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
    UITableView *DataTableFor5G;
    NSMutableArray *dataArray1; //定义数据数组1   存放2G列表
    NSMutableArray *dataArray2; //定义数据数组2   存放5G列表
    NSMutableArray * nameArray1;
    NSMutableArray * signalArray1;
    NSMutableArray * securityArray1;
    NSMutableArray * nameArray2;
    NSMutableArray * signalArray2;
    NSMutableArray * securityArray2;
    YHXSoapFor5G *soapFor5G;
    YHXCodeViewController * setPageFor5G;


    BOOL viewLoaded;
    BOOL tableLoaded;
    YHXSoapAPI * soap;
    YHXCodeViewController * setPage;
}

//@property(strong,nonatomic)  NSString* preferredLang;

@property(strong, nonatomic) IBOutlet UILabel *display;
@property(nonatomic, retain) UIProgressView *proView;
@property(nonatomic, assign) UIActivityIndicatorView * activityIndicator;
@property(nonatomic, retain) NSString * command;



//-(void)showProgress;
-(void)showTableView:(NSString *)channel;
-(void)changeTable;


@end
