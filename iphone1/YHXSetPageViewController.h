//
//  YHXSetPageViewController.h
//  iphone1
//
//  Created by Zeng Yifei on 13-3-8.
//  Copyright (c) 2013年 KaiYan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHXSoapAPI.h"
#import "YHXSoapFor5G.h"
@interface YHXSetPageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *DataTable;
    NSMutableArray *dataArray1; //定义数据数组1
    UITableViewCell *cell;
    IBOutlet UISwitch *switchView;
    NSMutableString * ssidExt;
    NSString * securityExt;
    NSString * codeExt;
    YHXSoapAPI * soap;
    YHXSoapFor5G * soapFor5G;
    
    BOOL get2Greturn;
    BOOL get5Greturn;

    NSString * defualtSecurity;
    NSMutableString * defualtSSID;
    NSString * defualtCode;
    NSString * NewKeyIndex;
    NSString * Channel;
    
    UITextField * key1TextField;
    UITextField * key2TextField;
    UITextField * key3TextField;
    UITextField * key4TextField;
    
    UILabel * key1Label;
    UILabel * key2Label;
    UILabel * key3Label;
    UILabel * key4Label;
    
    UIButton * btn1;
    UIButton * btn2;
    UIButton * btn3;
    UIButton * btn4;
    
}
@property(assign,nonatomic)IBOutlet UILabel * name1Label;
@property(assign,nonatomic)IBOutlet UILabel * security1Label;
@property(assign,nonatomic)IBOutlet UILabel * code1Label;
@property(assign,nonatomic)IBOutlet UILabel * state;

@property(assign,nonatomic)NSMutableString * ssidExt;
@property(assign,nonatomic)NSString * securityExt;
@property(assign,nonatomic)NSString * codeExt;
@property(assign,nonatomic)NSString * defualtSecurity;
@property(assign,nonatomic)NSMutableString * defualtSSID;
@property(assign,nonatomic)NSString * defualtCode;
@property(assign,nonatomic)NSString * NewKeyIndex;
@property(nonatomic,assign)UIActivityIndicatorView * activityIndicator;
@property(assign,nonatomic)IBOutlet UITextField *name;
@property(assign,nonatomic)IBOutlet UITextField *codeTex;
@property(assign,nonatomic)IBOutlet UILabel *securityLabel;

-(void)showTableView;
-(IBAction)switchChange;
-(IBAction)touchDown:(id)sender;

-(void)getName:(NSString *)name andSecurity:(NSString *)security andCode:(NSString *)code andChanle:(NSString *)channel;
@end
