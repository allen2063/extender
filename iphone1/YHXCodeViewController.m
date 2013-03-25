//
//  YHXCodeViewController.m
//  iphone1
//
//  Created by Zeng Yifei on 13-3-8.
//  Copyright (c) 2013年 KaiYan. All rights reserved.
//

#import "YHXCodeViewController.h"

@interface YHXCodeViewController ()

@end

@implementation YHXCodeViewController

@synthesize code;
@synthesize key1TextField;
@synthesize key2TextField;
@synthesize key3TextField;
@synthesize key4TextField;
@synthesize key1Label;
@synthesize key2Label;
@synthesize key3Label;
@synthesize key4Label;

@synthesize name;
@synthesize security;
@synthesize activityIndicator;
@synthesize getCode;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    getCode=@"";        // 无密码时不点击键盘也能获得初值
    nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(nextPage:) name:@"SetRouterWLAN" object:nil];
    [nc addObserver:self selector:@selector(error:) name:@"codeError" object:nil];
    soap = [[YHXSoapAPI alloc]init];
    
    activityIndicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];

    
    code.secureTextEntry = YES; //密码类型
    code.placeholder =@"请输入密码";
    code.clearsOnBeginEditing =YES;//下次编辑时清除内容；
    code.delegate =self;//设置代理用于实现协议
    code.keyboardType=UIKeyboardAppearanceAlert;
   
    
    self.navigationItem.title=@"输入所选无线网络的安全设置";
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithTitle:@"继续" style:UIBarButtonSystemItemTrash  target:self action:@selector(next)];
    self.navigationItem.rightBarButtonItem = buttonItem;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)error:(NSNotification *)note{
    
    NSLog(@"出错");
    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误"
//                                                    message:[NSString stringWithFormat:@"密码错误,请重试"]
//                                                   delegate:self
//                                          cancelButtonTitle:@"确定"
//                                          otherButtonTitles:nil];
//    [alert show];
    if ([activityIndicator isAnimating]) {
        [activityIndicator stopAnimating];
    }
    self.navigationItem.rightBarButtonItem.enabled=NO;
    
    //[nc removeObserver:self name:@"codeError" object:nil];
      //  [soap release];
    
    
//    nc = [NSNotificationCenter defaultCenter];
//    [nc addObserver:self selector:@selector(nextPage:) name:@"SetRouterWLAN" object:nil];
//    [nc addObserver:self selector:@selector(error:) name:@"codeError" object:nil];
//    soap = [[YHXSoapAPI alloc]init];
//    
//    code.secureTextEntry = YES; //密码类型
//    code.placeholder =@"请输入密码";
//    code.clearsOnBeginEditing =YES;//下次编辑时清除内容；
//    code.delegate =self;//设置代理用于实现协议
//    code.keyboardType=UIKeyboardAppearanceAlert;
    
}
-(void)getNameAndSecurity:(NSString*)name1 :(NSString*)security1
{
    name.text=name1;
    security.text=security1;
    
   
    
    
    NSLog(@"%@",security.text);
    
    NSLog(@"%@23232",security.text);
    if ([security.text rangeOfString: @"OFF"].length>0) {
        code.backgroundColor = [UIColor grayColor];
        code.placeholder =@"无需输入密码";
        self.code.userInteractionEnabled=NO;
        
    }else self.navigationItem.rightBarButtonItem.enabled=NO;
    
    if ([security.text rangeOfString:@"WEP"].length>0) {
        key1TextField = [[UITextField alloc] initWithFrame:CGRectMake(173.0f, 270.0f, 100.0f, 30.0f)];
        key2TextField = [[UITextField alloc] initWithFrame:CGRectMake(173.0f, 305.0f, 100.0f, 30.0f)];
        key3TextField = [[UITextField alloc] initWithFrame:CGRectMake(173.0f, 340.0f, 100.0f, 30.0f)];
        key4TextField = [[UITextField alloc] initWithFrame:CGRectMake(173.0f, 375.0f, 100.0f, 30.0f)];
        
        key1TextField.borderStyle =UITextBorderStyleRoundedRect;//样式设置为圆角矩形
        key2TextField.borderStyle =UITextBorderStyleRoundedRect;//样式设置为圆角矩形
        key3TextField.borderStyle =UITextBorderStyleRoundedRect;//样式设置为圆角矩形
        key4TextField.borderStyle =UITextBorderStyleRoundedRect;//样式设置为圆角矩形
        
        key1TextField.delegate=self;
        key2TextField.delegate=self;
        key3TextField.delegate=self;
        key4TextField.delegate=self;

        [self.view addSubview:key1TextField];
        [self.view addSubview:key2TextField];
        [self.view addSubview:key3TextField];
        [self.view addSubview:key4TextField];
        
        key1Label = [[UILabel alloc] initWithFrame:CGRectMake(34, 270, 70, 30)];;
        key2Label = [[UILabel alloc] initWithFrame:CGRectMake(34, 305, 70, 30)];;
        key3Label = [[UILabel alloc] initWithFrame:CGRectMake(34, 340, 70, 30)];;
        key4Label = [[UILabel alloc] initWithFrame:CGRectMake(34, 375, 70, 30)];;

        key1Label.text = @"密钥1：";
        key2Label.text = @"密钥2：";
        key3Label.text = @"密钥3：";
        key4Label.text = @"密钥4：";

        key1Label.backgroundColor = [UIColor clearColor];
        key2Label.backgroundColor = [UIColor clearColor];
        key3Label.backgroundColor = [UIColor clearColor];
        key4Label.backgroundColor = [UIColor clearColor];

        [self.view addSubview:key1Label];
        [self.view addSubview:key2Label];
        [self.view addSubview:key3Label];
        [self.view addSubview:key4Label];
    }
    

}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
//CGRect curFrame=self.view.frame;
    textField.returnKeyType =UIReturnKeyDone;//return键变成什么键
    textField.clearButtonMode =UITextFieldViewModeWhileEditing;//输入框中是否有叉号，在什么时候显示，用于一次性删除输入框中的内容
    [UIView animateWithDuration:0.3f animations:^{
        //int offset = curFrame.origin.y+96-(self.view.frame.size.height-216);
        CGRect rect;
        if ([security.text isEqualToString:@"WEP"]) //WEP有密钥 得高点
        {
             rect = CGRectMake(0, -205, self.view.frame.size.width, self.view.frame.size.height);
        }else{
             rect = CGRectMake(0, -96, self.view.frame.size.width, self.view.frame.size.height);}
        self.view.frame=rect;   
    }];                             //view 随着键盘上升
    if ([textField.text isEqualToString:@""]) {
        self.navigationItem.rightBarButtonItem.enabled=NO;
    }
    self.navigationItem.backBarButtonItem.enabled=NO;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    getCode = textField.text;
    NSLog(@"%@1111",textField.text);
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{       
    [UIView animateWithDuration:0.3f animations:^{
        CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
        self.view.frame = rect;}];          //view 回复到原处
    
    if (![textField.text isEqualToString:@""]) {
        self.navigationItem.rightBarButtonItem.enabled=YES;
    }
    self.navigationItem.backBarButtonItem.enabled=YES;
    
    [textField resignFirstResponder];
    return YES;
}

-(void)next
{
    NSString * newRadio= @"2.4G";
    NSString * Auto= @"Auto";

    NSString * NewWEPLength = @"64";
    NSString * NewVerify = @"0";
    NSString * NewKeyIndex = @"1";
    if ([security.text rangeOfString:@"OFF"].length>0) {
        [soap SetRouterWLANNoSecurity:newRadio :name.text :Auto :Auto :NewVerify];
    }
    else if ([security.text rangeOfString:@"WEP"].length>0){
        [soap SetRouterWLANWEPByKeys:newRadio :name.text :Auto :Auto :Auto :NewWEPLength :NewKeyIndex :getCode :NewVerify];}
    else if([security.text rangeOfString:@"WPA"].length>0){
    
        [soap SetRouterWLANWPAPSKByPassphrase:newRadio :name.text :Auto :Auto :security.text :getCode :NewVerify];
    }
    
    
    [activityIndicator setCenter:CGPointMake(160,250)];
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.view addSubview:activityIndicator];
    
    if ([activityIndicator isAnimating]) {
        [activityIndicator stopAnimating];
    }
    else
        [activityIndicator startAnimating];
}

-(void)nextPage:(NSNotification *)note
{
    
    if ([activityIndicator isAnimating]) {
        [activityIndicator stopAnimating];
    }
    if([code isFirstResponder]){
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
            self.view.frame = rect;          //view 回复到原处
            
            [code resignFirstResponder];
        } completion:^(BOOL finished) {
           setPage = [[YHXSetPageViewController alloc]init];
            [setPage getName:name.text andSecurity:security.text andCode:getCode];
            [self.navigationController pushViewController:setPage animated:YES];
        }];
    }
    else{
        setPage = [[YHXSetPageViewController alloc]init];
        [setPage getName:name.text andSecurity:security.text andCode:getCode];
        [self.navigationController pushViewController:setPage animated:YES];
    }
    
}

- (void)dealloc
{
    [nc removeObserver:self];
    [activityIndicator release];
    [soap release];
    [setPage release];
    [key1TextField release];
    [key2TextField release];
    [key3TextField release];
    [key4TextField release];
    [key1Label release];
    [key2Label release];
    [key3Label release];
    [key4Label release];

    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
