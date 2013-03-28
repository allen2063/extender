//
//  YHXSetPageViewController.m
//  iphone1
//
//  Created by Zeng Yifei on 13-3-8.
//  Copyright (c) 2013年 KaiYan. All rights reserved.
//

#import "YHXSetPageViewController.h"
#import "YHXAppDelegate.h"

@interface YHXSetPageViewController ()

@end

@implementation YHXSetPageViewController

@synthesize name;
@synthesize codeTex;
@synthesize securityExt;
@synthesize ssidExt;
@synthesize codeExt;
@synthesize defualtSecurity;
@synthesize defualtCode;
@synthesize defualtSSID;
@synthesize NewKeyIndex;

-(void)getName:(NSString *)ssid andSecurity:(NSString *)security andCode:(NSString *)code;
{
    ssidExt = [[NSMutableString alloc] initWithString:ssid];
    securityExt = [[NSString alloc] initWithString:security];
    codeExt = [[NSString alloc] initWithString:code];
    
    NSLog(@"%@",securityExt);
    NSLog(@"%@",ssidExt);
    NSLog(@"%@",codeExt);
//    defualtSecurity=securityExt;
    defualtSecurity = [[NSString alloc] initWithString:securityExt];
//    defualtCode=codeExt;
    defualtCode = [[NSString alloc] initWithString:codeExt];
//    defualtSSID=ssidExt;
    defualtSSID = [[NSMutableString alloc] initWithFormat:ssidExt,nil];

}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)switchChange
{
    if (    switchView.on == YES) {
        [UIView animateWithDuration:0.2 animations:^{[DataTable setFrame:CGRectMake(0,420,320,150)];}];         //收起来
        if ([securityExt isEqualToString:@"WEP"]&&(![defualtSecurity isEqualToString:@"WEP"])) {
            [self deallocKeys];
        }
        securityExt=defualtSecurity;                //恢复原来的加密方式
        codeExt=defualtCode;
        ssidExt=defualtSSID;
        self.codeTex.userInteractionEnabled=NO;
        codeTex.backgroundColor = [UIColor grayColor];
        codeTex.placeholder =@"将使用路由器密码";
        self.navigationItem.rightBarButtonItem.enabled=YES;
    }else  {
        [self showTableView];
        codeTex.backgroundColor = [UIColor whiteColor];
        self.codeTex.userInteractionEnabled=YES;
        codeTex.placeholder =@"请输入密码";
        if (![defualtSecurity isEqualToString:@"OFF"]) {
            self.navigationItem.rightBarButtonItem.enabled=NO;
        }
    }
    NSLog(@"%@123123",securityExt);
}

-(void)deallocKeys
{
    [key1TextField removeFromSuperview];
    [key2TextField removeFromSuperview];
    [key3TextField removeFromSuperview];
    [key4TextField removeFromSuperview];

    [key1Label removeFromSuperview];
    [key2Label removeFromSuperview];
    [key3Label removeFromSuperview];
    [key4Label removeFromSuperview];

}

-(void)selectIndex1
{
    [btn1 setImage:[UIImage imageNamed:@"3.png" ]  forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"1.png" ]  forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"1.png" ]  forState:UIControlStateNormal];
    [btn4 setImage:[UIImage imageNamed:@"1.png" ]  forState:UIControlStateNormal];
    NewKeyIndex = @"1";
}

-(void)selectIndex2
{
    [btn1 setImage:[UIImage imageNamed:@"1.png" ]  forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"3.png" ]  forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"1.png" ]  forState:UIControlStateNormal];
    [btn4 setImage:[UIImage imageNamed:@"1.png" ]  forState:UIControlStateNormal];
    NewKeyIndex = @"2";
}

-(void)selectIndex3
{
    [btn1 setImage:[UIImage imageNamed:@"1.png" ]  forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"1.png" ]  forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"3.png" ]  forState:UIControlStateNormal];
    [btn4 setImage:[UIImage imageNamed:@"1.png" ]  forState:UIControlStateNormal];
    NewKeyIndex = @"3";
}

-(void)selectIndex4
{
    [btn1 setImage:[UIImage imageNamed:@"1.png" ]  forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"1.png" ]  forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"1.png" ]  forState:UIControlStateNormal];
    [btn4 setImage:[UIImage imageNamed:@"3.png" ]  forState:UIControlStateNormal];
    NewKeyIndex = @"4";
}

-(void)showKeys
{
    
    btn1 = [[UIButton alloc]initWithFrame: CGRectMake(104, 273, 25, 25)];
    [btn1 setImage:[UIImage imageNamed:@"1.png" ]  forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(selectIndex1) forControlEvents:UIControlEventTouchUpInside];
    
    btn2 = [[UIButton alloc]initWithFrame: CGRectMake(104, 308, 25, 25)];
    [btn2 setImage:[UIImage imageNamed:@"1.png" ]  forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(selectIndex2) forControlEvents:UIControlEventTouchUpInside];
    
    btn3 = [[UIButton alloc]initWithFrame: CGRectMake(104, 343, 25, 25)];
    [btn3 setImage:[UIImage imageNamed:@"1.png" ]  forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(selectIndex3) forControlEvents:UIControlEventTouchUpInside];
    
    btn4 = [[UIButton alloc]initWithFrame: CGRectMake(104, 378, 25, 25)];
    [btn4 setImage:[UIImage imageNamed:@"1.png" ]  forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(selectIndex4) forControlEvents:UIControlEventTouchUpInside];
    
    enum{
        UIControlStateNormal =0,
        UIControlStateHighlighted= 1,
    };
    [self.view addSubview:btn1];
    [self.view addSubview:btn2];
    [self.view addSubview:btn3];
    [self.view addSubview:btn4];

    
    
    key1TextField = [[UITextField alloc] initWithFrame:CGRectMake(145.0f, 270.0f, 135.0f, 30.0f)];
    key2TextField = [[UITextField alloc] initWithFrame:CGRectMake(145.0f, 305.0f, 135.0f, 30.0f)];
    key3TextField = [[UITextField alloc] initWithFrame:CGRectMake(145.0f, 340.0f, 135.0f, 30.0f)];
    key4TextField = [[UITextField alloc] initWithFrame:CGRectMake(145.0f, 375.0f, 135.0f, 30.0f)];
    
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

-(void)showTableView
{
    dataArray1 = [[NSMutableArray alloc]initWithObjects:@"OFF",@"WEP",@"WPA2-PSK-AES",@"WPA/WPA2-PSK", nil];
    
    DataTable = [[UITableView alloc]initWithFrame:CGRectMake(0,420,320,150)];    //初始化tableview
    DataTable.delegate = self;      //指定委托
    DataTable.dataSource = self;    //指定数据委托
    DataTable.separatorColor = [UIColor lightGrayColor];    //设置间隔颜色
    [UIView animateWithDuration:0.2 animations:^{[DataTable setFrame:CGRectMake(0,270,320,150)];}];         //从底下冒出
    [self.view addSubview:DataTable];                       //加载tableview
    

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    
    switchView.on = NO;
    
    if (cell!=nil) {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    
    
    cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    
    securityExt = [dataArray1 objectAtIndex:indexPath.row];
    NSLog(@"%@secu  %@",securityExt,defualtSecurity);
    
    if ([securityExt isEqualToString:@"WEP"]) {
        
        
        
        [UIView animateWithDuration:0.2 animations:^{[DataTable setFrame:CGRectMake(0,420,320,150)];}           //收起来
         completion:^(BOOL finished) {
             if ((![defualtSecurity isEqualToString:@"WEP"])) {
                 [self showKeys];
             }
         } ];
        self.navigationItem.rightBarButtonItem.enabled=NO;
        codeTex.userInteractionEnabled=NO;
        codeTex.backgroundColor = [UIColor grayColor];
        codeTex.placeholder = @"请输入密钥";

    }else if ([securityExt isEqualToString:@"OFF"]){
        self.navigationItem.rightBarButtonItem.enabled=YES;
        codeTex.userInteractionEnabled=NO;
        codeTex.backgroundColor = [UIColor grayColor];
        codeTex.placeholder =@"无需输入密码";
    }else if([securityExt rangeOfString:@"WPA"].length>0){
        self.navigationItem.rightBarButtonItem.enabled=NO;
        codeTex.userInteractionEnabled=YES;
        codeTex.backgroundColor = [UIColor whiteColor];
        codeTex.placeholder = @"请输入密码";
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dataArray1 count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  //绘制Cell
{
    static NSString * CellIdentifier = @"Cell";
    UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell1 == nil) {
        cell1= [[[UITableViewCell alloc]initWithFrame:CGRectZero]autorelease];
    }
    [[cell1 textLabel]  setText:[dataArray1 objectAtIndex:indexPath.row]];//给cell添加数据
    
    
    
    return cell1;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.returnKeyType =UIReturnKeyDone;//return键变成什么键
    
    
    
    if ([securityExt isEqualToString:@"WEP"]&&(textField.tag!=1)) //WEP有密钥 得高点
                {
                    [UIView animateWithDuration:0.3f animations:^{
                     CGRect rect = CGRectMake(0, -205, self.view.frame.size.width, self.view.frame.size.height);
                        self.view.frame=rect;}];
                }
    else{
    
    [UIView animateWithDuration:0.3f animations:^{
        CGRect rect = CGRectMake(0, -96, self.view.frame.size.width, self.view.frame.size.height);
        self.view.frame=rect;}];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (![name.text isEqualToString:@""]) {
        [ssidExt setString:name.text];
        NSLog( @"ss%@ss",ssidExt);
    }
    if (![codeTex.text isEqualToString:@""]) {
        codeExt=codeTex.text;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [UIView animateWithDuration:0.3f animations:^{
        CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
        self.view.frame = rect;}];
    if (![codeTex.text isEqualToString:@""]) {
        self.navigationItem.rightBarButtonItem.enabled=YES;
    }
    else if([securityExt isEqualToString:@"WEP"])
    {
        if ([NewKeyIndex isEqualToString:@"1"]&&(![key1TextField.text isEqualToString:@""])) {
            self.navigationItem.rightBarButtonItem.enabled=YES;
        }else if ([NewKeyIndex isEqualToString:@"2"]&&(![key2TextField.text isEqualToString:@""])) {
            self.navigationItem.rightBarButtonItem.enabled=YES;
        }else if ([NewKeyIndex isEqualToString:@"3"]&&(![key3TextField.text isEqualToString:@""])) {
            self.navigationItem.rightBarButtonItem.enabled=YES;
        }else if ([NewKeyIndex isEqualToString:@"4"]&&(![key4TextField.text isEqualToString:@""])) {
            self.navigationItem.rightBarButtonItem.enabled=YES;
        }
    }
    else if(switchView.on==NO)    { self.navigationItem.rightBarButtonItem.enabled=NO;}
    [textField resignFirstResponder];
    
    NSLog(@"%@ 11 %@ 22 %@",securityExt,NewKeyIndex,key1TextField.text);
    return YES;
}

-(void)Done
{   NSString * newRadio= @"2.4G";
    NSString * Auto= @"Auto";
    
    NSString * NewWEPLength = @"64";
    //NewKeyIndex = @"1";
//    NSString * NewKey1 = @"";
//    NSString * NewKey2 = @"";
//    NSString * NewKey3 = @"";
//    NSString * NewKey4 = @"";
    
    
    if ([name.text isEqualToString:@""]) {
        [ssidExt appendString:@"_EXT"];
    }
    
    if ([securityExt rangeOfString:@"OFF"].length>0) {
        [soap SetWLANNoSecurity:newRadio :ssidExt :Auto :Auto];
        
    }else if ([securityExt rangeOfString:@"WEP"].length>0) {
        [soap SetWLANWEPByKeys:newRadio :ssidExt :Auto :Auto :Auto :NewWEPLength :NewKeyIndex :key1TextField.text :key2TextField.text :key3TextField.text :key4TextField.text];
        
    }else if ([securityExt rangeOfString:@"WPA"].length>0) {
        [soap SetWLANWPAPSKByPassphrase:newRadio :ssidExt :Auto :Auto :securityExt :codeExt];
        NSLog(@"密码 %@",codeExt);
        NSLog(@"名字 %@",ssidExt);
    }

}

-(void)finishAndSetEnable:(NSNotification *)note
{
    [soap ConfigurationFinished];
    [soap SetEnable];
    NSLog(@"enable coming");
}

-(void)enabled:(NSNotification *)note
{
    NSLog(@"enabled…………");
}

- (void)viewDidLoad
{
    soap = [[YHXSoapAPI alloc]init];

    if ([securityExt isEqualToString:@"WEP"]) {
        [self showKeys];
    }
    
    name.tag=1;
    
    //NSLog(@"%@ load",ssidExt);

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishAndSetEnable:) name:@"SetWLAN" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enabled:) name:@"SetEnable" object:nil];
    name.placeholder =@"请输入名称";
    name.clearsOnBeginEditing =YES;//下次编辑时清除内容；
    name.delegate =self;//设置代理用于实现协议
    name.keyboardType=UIKeyboardAppearanceAlert;
    

    self.codeTex.userInteractionEnabled=NO;
    codeTex.backgroundColor = [UIColor grayColor];
    codeTex.placeholder =@"将使用路由器密码";
    codeTex.clearsOnBeginEditing =YES;//下次编辑时清除内容；
    codeTex.delegate =self;//设置代理用于实现协议
    codeTex.keyboardType=UIKeyboardAppearanceAlert;

    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonSystemItemTrash  target:self action:@selector(Done)];
    self.navigationItem.rightBarButtonItem = buttonItem;
    
    switchView.on = YES;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)dealloc
{
    [defualtCode release];
    [defualtSecurity release];
    [defualtSSID release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
