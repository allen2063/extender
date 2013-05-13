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

@synthesize codeTextField;

@synthesize code1Label;
@synthesize name1Label;
@synthesize security1Label;

@synthesize nameLabel;
@synthesize securityLabel;
@synthesize activityIndicator;
@synthesize getCode;
extern NSString* preferredLang;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //if([codeTextField isFirstResponder])
        [codeTextField resignFirstResponder];
        codeTextField.text=@"";
}


- (void)viewDidLoad
{
    getCode=@"";        // 无密码时不点击键盘也能获得初值
    nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(nextPage:) name:@"SetRouterWLAN" object:nil];
    [nc addObserver:self selector:@selector(error:) name:@"codeError" object:nil];
    [nc addObserver:self selector:@selector(error:) name:@"False" object:nil];
    soap = [[YHXSoapAPI alloc]init];
    if ([isextender isEqualToString:@"2"]) {
        soapFor5G =[[YHXSoapFor5G alloc]init];
    }
    if (!setPage) {
        setPage = [[YHXSetPageViewController alloc]init];
        NSLog(@"string!!!");
    }
    
    activityIndicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    if ([activityIndicator isAnimating]) {
        [activityIndicator stopAnimating];
    }
    
    if ([preferredLang isEqualToString:@"zh-Hans"]) {
        codeTextField.placeholder =@"请输入密码";
        
        self.navigationItem.title=@"进入所选网络的安全设置";
        UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithTitle:@"继续" style:UIBarButtonSystemItemTrash  target:self action:@selector(next)];
        self.navigationItem.rightBarButtonItem = buttonItem;

    }else{
        codeTextField.placeholder =@"Please enter password";
        
        self.navigationItem.title=@"Enter these curity settings of the selected WiFi network.";
        UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithTitle:@"Continue" style:UIBarButtonSystemItemTrash  target:self action:@selector(next)];
        self.navigationItem.rightBarButtonItem = buttonItem;
        
        code1Label.text=@"Passphrase";
        security1Label.text=@"Safe mode";
        name1Label.text=@"SSID";
    }

    
    
    codeTextField.secureTextEntry = YES; //密码类型
    codeTextField.clearsOnBeginEditing =YES;//下次编辑时清除内容；
    codeTextField.delegate =self;//设置代理用于实现协议
    codeTextField.keyboardType=UIKeyboardAppearanceAlert;
   
    
    
    
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
    
}
-(void)getNameAndSecurity:(NSString*)name1 :(NSString*)security1 :(NSString *)channel
{
    nameLabel.text=name1;
    securityLabel.text=security1;
    Channel = channel;
    NSLog(@"%@   %@",channel,security1);

    NSLog(@"%@",securityLabel.text);
    
    NSLog(@"%@23232",securityLabel.text);
    if ([securityLabel.text rangeOfString: @"OFF"].length>0) {
        codeTextField.backgroundColor = [UIColor grayColor];
        self.navigationItem.rightBarButtonItem.enabled=YES;
        
        if ([preferredLang isEqualToString:@"zh-Hans"]) {
            codeTextField.placeholder =@"无需输入密码";
        }else codeTextField.placeholder =@"Don't need to enter a password";
      
        self.codeTextField.userInteractionEnabled=NO;
        
    }else {
        self.navigationItem.rightBarButtonItem.enabled=NO;
        codeTextField.backgroundColor = [UIColor whiteColor];
        if ([preferredLang isEqualToString:@"zh-Hans"]) {
            codeTextField.placeholder =@"请输入密码";
        }else codeTextField.placeholder =@"Please enter the password";
        
        self.codeTextField.userInteractionEnabled=YES;
          }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
//CGRect curFrame=self.view.frame;
    textField.returnKeyType =UIReturnKeyDone;                   //return键变成什么键
    textField.clearButtonMode =UITextFieldViewModeWhileEditing; //输入框中是否有叉号，在什么时候显示，用于一次性删除输入框中的内容
    [UIView animateWithDuration:0.3f animations:^{
        //int offset = curFrame.origin.y+96-(self.view.frame.size.height-216);
        CGRect rect;
//        if ([security.text isEqualToString:@"WEP"]) //WEP有密钥 得高点
//        {
//             rect = CGRectMake(0, -205, self.view.frame.size.width, self.view.frame.size.height);
//        }else{
             rect = CGRectMake(0, -96, self.view.frame.size.width, self.view.frame.size.height);
//        }
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
    NSLog(@"%@",Channel);
    
    if ([Channel isEqualToString:@"2.4G"]) {
        
      if ([securityLabel.text rangeOfString:@"OFF"].length>0) {
          [soap SetRouterWLANNoSecurity:newRadio :nameLabel.text :Auto :Auto :NewVerify];
      }
      else if ([securityLabel.text rangeOfString:@"WEP"].length>0){
          [soap SetRouterWLANWEPByKeys:newRadio :nameLabel.text :Auto :Auto :Auto :NewWEPLength :NewKeyIndex :getCode :NewVerify];}
      else if([securityLabel.text rangeOfString:@"WPA"].length>0){
    
          [soap SetRouterWLANWPAPSKByPassphrase:newRadio :nameLabel.text :Auto :Auto :securityLabel.text :getCode :NewVerify];
      }                       //securityLabel.text   @"WPA2-PSK-AES"
    }
    else if ([Channel isEqualToString:@"5G"]){
        if ([securityLabel.text rangeOfString:@"OFF"].length>0) {
            [soapFor5G SetRouterWLANNoSecurity:@"5G" :nameLabel.text :Auto :Auto :NewVerify];
        }
        else if ([securityLabel.text rangeOfString:@"WEP"].length>0){
            [soapFor5G SetRouterWLANWEPByKeys:@"5G" :nameLabel.text :Auto :Auto :Auto :NewWEPLength :NewKeyIndex :getCode :NewVerify];}
        else if([securityLabel.text rangeOfString:@"WPA"].length>0){
            
            [soapFor5G SetRouterWLANWPAPSKByPassphrase:@"5G" :nameLabel.text :Auto :Auto :securityLabel.text :getCode :NewVerify];
        }
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
    if([codeTextField isFirstResponder]){
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
            self.view.frame = rect;          //view 回复到原处
            
            [codeTextField resignFirstResponder];
        } completion:^(BOOL finished) {
            if ([Channel isEqualToString:@"2.4G"]) {
                [setPage getName:nameLabel.text andSecurity:securityLabel.text andCode:getCode andChanle:@"2.4G"] ;
            }else [setPage getName:nameLabel.text andSecurity:securityLabel.text andCode:getCode andChanle:@"5G"] ;
            [self.navigationController pushViewController:setPage animated:YES];
        }];
    }
    else{
        if ([Channel isEqualToString:@"2.4G"]) {
            [setPage getName:nameLabel.text andSecurity:securityLabel.text andCode:getCode andChanle:@"2.4G"] ;
        }else [setPage getName:nameLabel.text andSecurity:securityLabel.text andCode:getCode andChanle:@"5G"] ;
        [self.navigationController pushViewController:setPage animated:YES];
    }
}

- (void)dealloc
{
    [nc removeObserver:self];
    [activityIndicator release];
    [soap release];
    [setPage release];

    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
