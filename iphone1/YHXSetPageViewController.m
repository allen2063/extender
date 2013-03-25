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

-(void)getName:(NSString *)ssid andSecurity:(NSString *)security andCode:(NSString *)code;
{
    ssidExt = [[NSMutableString alloc] initWithString:ssid];
    securityExt = [[NSString alloc] initWithString:security];
    codeExt = [[NSString alloc] initWithString:code];
    
    NSLog(@"%@",securityExt);
    NSLog(@"%@",ssidExt);
    NSLog(@"%@",codeExt);
    defualtSecurity=securityExt;
    defualtCode=codeExt;
    defualtSSID=defualtSSID;
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

    }else  {
        [self showTableView];
        codeTex.backgroundColor = [UIColor whiteColor];
        self.codeTex.userInteractionEnabled=YES;
        codeTex.placeholder =@"请输入密码";
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

-(void)showKeys
{
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

-(void)showTableView
{
//    UIImageView *imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"netgear"]];
    dataArray1 = [[NSMutableArray alloc]initWithObjects:@"OFF",@"WEP",@"WPA2-PSK-AES",@"WPA/WPA2-PSK", nil];
    
    DataTable = [[UITableView alloc]initWithFrame:CGRectMake(0,420,320,150)];    //初始化tableview
    DataTable.delegate = self;      //指定委托
    DataTable.dataSource = self;    //指定数据委托
    DataTable.separatorColor = [UIColor lightGrayColor];    //设置间隔颜色
//    DataTable.tableHeaderView = imageview;
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
    [UIView animateWithDuration:0.3f animations:^{
        CGRect rect = CGRectMake(0, -96, self.view.frame.size.width, self.view.frame.size.height);
        self.view.frame=rect;
        
    }];
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
    
    [textField resignFirstResponder];
    return YES;
}

-(void)Done
{   NSString * newRadio= @"2.4G";
    NSString * Auto= @"Auto";
    
    NSString * NewWEPLength = @"64";
    NSString * NewKeyIndex = @"1";
    NSString * NewKey1 = @"";
    NSString * NewKey2 = @"";
    NSString * NewKey3 = @"";
    NSString * NewKey4 = @"";

    
    if ([securityExt rangeOfString:@"OFF"].length>0) {
        [soap SetWLANNoSecurity:newRadio :ssidExt :Auto :Auto];
        
    }else if ([securityExt rangeOfString:@"WEP"].length>0) {
        [soap SetWLANWEPByKeys:newRadio :ssidExt :Auto :Auto :Auto :NewWEPLength :NewKeyIndex :NewKey1 :NewKey2 :NewKey3 :NewKey4];
        
    }else if ([securityExt rangeOfString:@"WPA"].length>0) {
        [soap SetWLANWPAPSKByPassphrase:newRadio :ssidExt :Auto :Auto :securityExt :codeExt];
        NSLog(@"密码 %@",codeExt);
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
    
    
    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"设置成功"
//                                                    message:[NSString stringWithFormat:@"现在可以退出程序，请等待中继器重启！"]
//                                                   delegate:self
//                                          cancelButtonTitle:@"确定"
//                                          otherButtonTitles:nil];
//    [alert show];

}

- (void)viewDidLoad
{
    soap = [[YHXSoapAPI alloc]init];

    if ([securityExt isEqualToString:@"WEP"]) {
        [self showKeys];
    }
    
    [ssidExt appendString:@"_EXT"];
    NSLog(@"%@ load",ssidExt);

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
