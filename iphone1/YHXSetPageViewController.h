//
//  YHXSetPageViewController.h
//  iphone1
//
//  Created by Zeng Yifei on 13-3-8.
//  Copyright (c) 2013年 KaiYan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHXSoapAPI.h"
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
    NSString * defualtSecurity;
    NSMutableString * defualtSSID;
    NSString * defualtCode;
    NSString * NewKeyIndex;
    
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
@property(assign,nonatomic)NSMutableString * ssidExt;
@property(assign,nonatomic)NSString * securityExt;
@property(assign,nonatomic)NSString * codeExt;
@property(assign,nonatomic)NSString * defualtSecurity;
@property(assign,nonatomic)NSMutableString * defualtSSID;
@property(assign,nonatomic)NSString * defualtCode;
@property(assign,nonatomic)NSString * NewKeyIndex;

@property(assign,nonatomic)IBOutlet UITextField *name;
@property(assign,nonatomic)IBOutlet UITextField *codeTex;

-(void)showTableView;
-(IBAction)switchChange;

-(void)getName:(NSString *)name andSecurity:(NSString *)security andCode:(NSString *)code;
@end
