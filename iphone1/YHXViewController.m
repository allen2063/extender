//
//  YHXViewController.m
//  iphone1
//
//  Created by Zeng Yifei on 13-3-6.
//  Copyright (c) 2013年 KaiYan. All rights reserved.
//

#import "YHXViewController.h"
#import "YHXAppDelegate.h"

@interface YHXViewController ()

@end

@implementation YHXViewController
@synthesize  display;
@synthesize proView;
@synthesize activityIndicator;	
@synthesize command;
extern NSString* preferredLang;


#pragma mark - View lifecycle


-(void)changeTable          //列表切换
{
    
    if (DataTable.frame.origin.y==0&& !DataTableFor5G.frame.origin.y==0){
        [UIView animateWithDuration:0.2 animations:^{[DataTable setFrame:CGRectMake(0,420,320,420)];}];
        [UIView animateWithDuration:0.2 animations:^{[DataTableFor5G setFrame:CGRectMake(0,0,320,420)];}];         
    }
    else {
        [UIView animateWithDuration:0.2 animations:^{[DataTable setFrame:CGRectMake(0,0,320,420)];}];         
        [UIView animateWithDuration:0.2 animations:^{[DataTableFor5G setFrame:CGRectMake(0,-420,320,420)];}];         
    }

}


-(void)showTableView:(NSString *)channel
{
    NSLog(@"SHOWTABLEVIEW  %@^^^^…………………………………………………………",channel);
    if ([channel isEqualToString:@"5G"]) {
        self.navigationItem.rightBarButtonItem.enabled=YES;             //显示列表后让刷新按钮可用
    }
    
     if ([preferredLang isEqualToString:@"zh-Hans"]) {              
        self.navigationItem.title=@"请选择要接入的网络";
    }else self.navigationItem.title=@"Please select to access the network";
    
    UIImageView *imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"netgear"]];
    imageview.bounds=CGRectMake(100, 100, 320, 42);
    
    if([channel isEqualToString:@"2.4G"])
    {
    DataTable = [[UITableView alloc]initWithFrame:CGRectMake(0,420,320,420)];    //初始化tableview
        DataTable.tag=1;
    DataTable.delegate = self;      //指定委托
    DataTable.dataSource = self;    //指定数据委托

    DataTable.separatorColor = [UIColor lightGrayColor];    //设置间隔颜色
    DataTable.tableHeaderView = imageview;
    [UIView animateWithDuration:0.2 animations:^{[DataTable setFrame:CGRectMake(0,0,320,420)];}];         //从底下冒出
    [self.view addSubview:DataTable];                       //加载tableview
    }
    else if ([channel isEqualToString:@"5G"])
    {
        NSLog(@"5GSHOWTABLEVIEW");
        DataTableFor5G = [[UITableView alloc]initWithFrame:CGRectMake(0,-420,320,420)];    //初始化tableview
        DataTableFor5G.tag=2;
        DataTableFor5G.delegate = self;      //指定委托
        DataTableFor5G.dataSource = self;    //指定数据委托
        UIBarButtonItem *btnChange = [[UIBarButtonItem alloc]initWithTitle:@"2.4G/5G" style:UIBarButtonSystemItemTrash target:self action:@selector(changeTable)];
        self.navigationItem.leftBarButtonItem = btnChange;
            self.navigationItem.leftBarButtonItem.enabled=YES;
        DataTableFor5G.separatorColor = [UIColor lightGrayColor];    //设置间隔颜色
        DataTableFor5G.tableHeaderView = imageview;
        //[UIView animateWithDuration:0.2 animations:^{[DataTableFor5G setFrame:CGRectMake(0,0,320,420)];}];         //从底下冒出
        [self.view addSubview:DataTableFor5G];
    }
    

    tableLoaded=YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (tableView.tag==1) {
        return @"SSID                2.4G              Singnal";
    }else return @"SSID                5G                 Singnal";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    NSLog(@"%@",indexPath);
    
    //[display removeFromSuperview];
    
    if (((tableView.tag==1)&&[[nameArray1 objectAtIndex:indexPath.row] isEqualToString:@"手动设置"])||((tableView.tag==2)&&[[nameArray2 objectAtIndex:indexPath.row] isEqualToString:@"手动设置"])
        ) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"手动设置"
                                                        message:@""
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定",nil];
        alert.alertViewStyle=UIAlertViewStylePlainTextInput;
        [alert textFieldAtIndex:0].placeholder=@"SSID";
        
        if (tableView.tag==1) {
            alert.tag=1;                    
        }else if (tableView.tag==2){
            alert.tag=2;
        }
        [alert show];
        [alert release];
    }
    
    else if (tableView.tag==1) {
        
        [self.navigationController pushViewController:setPage animated:YES];
        [setPage getNameAndSecurity:[nameArray1 objectAtIndex:indexPath.row]  :[securityArray1 objectAtIndex:indexPath.row] :@"2.4G"] ;

    }else if (tableView.tag==2){
        
        [self.navigationController pushViewController:setPageFor5G animated:YES];
        [setPageFor5G getNameAndSecurity:[nameArray2 objectAtIndex:indexPath.row]  :[securityArray2 objectAtIndex:indexPath.row] :@"5G"];
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([isextender isEqualToString:@"1"]) {                        //判断是不是1000，1为1000，2为2500
        if (tableView.tag==1) {
            return (dataArray1.count)/5+1;
        }else return (dataArray2.count)/5+1;
    }else if ([isextender isEqualToString:@"2"])                    //2500的返回过一项数据
    {
        if (tableView.tag==1) {                                     //tag1为2.4G的表   另一个是5G的表
            return (dataArray1.count)/6+1;
        }else return (dataArray2.count)/6+1;
    }else return 0;
     
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
   //     cell = [[[UITableViewCell alloc]initWithFrame:CGRectZero reuseIdentifier:CellIdentifier]autorelease];
//        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero] autorelease];
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
        //[[cell textLabel]  setText:[dataArray1 objectAtIndex:indexPath.row]];//给cell添加数据
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    int items;
    if ([isextender isEqualToString:@"2"]) {
        items = 6;                           //2为2500   每个信息是6个一行
    }
    else if ([isextender isEqualToString:@"1"]){
        items = 5;
    }
    
     if (tableView.tag==1) {                                        //2.4G的列表
         
         nameArray1 =[[NSMutableArray alloc]init];
         signalArray1=[[NSMutableArray alloc]init];
         securityArray1=[[NSMutableArray alloc]init];
         
        for (int q=0;q<(dataArray1.count /items); q++) {
            [nameArray1 addObject: dataArray1[q*items+1]];
            
            if ([isextender isEqualToString:@"2"]) {                //2500的信号强度没带百分号  并且位数也不同
                [signalArray1 addObject: dataArray1[q*items+5]];
               signalArray1[q] = [signalArray1[q] stringByAppendingString:@"%"];
            }else if ([isextender isEqualToString:@"1"]){
                [signalArray1 addObject: dataArray1[q*items+4]];
            }
            
            [securityArray1 addObject:dataArray1[q*items+2]];
        }
         [nameArray1 addObject:@"手动设置"];
         [signalArray1 addObject:@""];
        cell.textLabel.text = [nameArray1 objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [signalArray1 objectAtIndex:indexPath.row];
     }
     else if (tableView.tag==2){                                   //5G的列表
         
         nameArray2 =[[NSMutableArray alloc]init];
         signalArray2=[[NSMutableArray alloc]init];
         securityArray2=[[NSMutableArray alloc]init];
         
         for (int q=0;q<(dataArray2.count /items); q++) {
             [nameArray2 addObject: dataArray2[q*items+1]];
             
             if ([isextender isEqualToString:@"2"]) {                //2500的信号强度没带百分号  并且位数也不同
                 [signalArray2 addObject: dataArray2[q*items+5]];
                 signalArray2[q] = [signalArray2[q] stringByAppendingString:@"%"];
             }else if ([isextender isEqualToString:@"1"]){
                 [signalArray2 addObject: dataArray2[q*items+4]];
             }
             
             [securityArray2 addObject:dataArray2[q*items+2]];
             
         }
         [nameArray2 addObject:@"手动设置"];
         [signalArray2 addObject:@""];
         cell.textLabel.text = [nameArray2 objectAtIndex:indexPath.row];
         cell.detailTextLabel.text = [signalArray2 objectAtIndex:indexPath.row];
     }
    return cell;
}



- (void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch(alert.tag)
    {
        case 1:
            if (buttonIndex == 1) //默认cancelButtonIndex = 0，每个按钮index可设
            {
                for (int q=0; q<nameArray1.count; q++) {
                    if ([[alert textFieldAtIndex:0].text isEqualToString:[nameArray1 objectAtIndex:q]]) {
                        [self.navigationController pushViewController:setPage animated:YES];
                        [setPage getNameAndSecurity:[alert textFieldAtIndex:0].text  :[securityArray1 objectAtIndex:q] :@"2.4G"] ;
                        return;
                    }
                }
                if ([preferredLang isEqualToString:@"zh-Hans"]) {
                    UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"错误"
                                                                     message:@"输入错误，此网络不存在。"
                                                                    delegate:self
                                                           cancelButtonTitle:@"取消"
                                                           otherButtonTitles:nil];
                    [alert1 show];
                    [alert1 release];
                }else {
                    UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"ERROR"
                                                                     message:@"This SSID is not exist"
                                                                    delegate:self
                                                           cancelButtonTitle:@"cancle"
                                                           otherButtonTitles:nil];
                    [alert1 show];
                    [alert1 release];
                }
                
                
            }
           
            break;
        case 2:
            if (buttonIndex == 1) //默认cancelButtonIndex = 0，每个按钮index可设
            {
                for (int q=0; q<nameArray2.count; q++) {
                    if ([[alert textFieldAtIndex:0].text isEqualToString:[nameArray2 objectAtIndex:q]]) {
                        [self.navigationController pushViewController:setPageFor5G animated:YES];
                        [setPageFor5G getNameAndSecurity:[alert textFieldAtIndex:0].text  :[securityArray2 objectAtIndex:q] :@"5G"];
                        return;
                    }
                }
                if ([preferredLang isEqualToString:@"zh-Hans"]) {
                    UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"错误"
                                                                     message:@"输入错误，此网络不存在。"
                                                                    delegate:self
                                                           cancelButtonTitle:@"取消"
                                                           otherButtonTitles:nil];
                    [alert1 show];
                    [alert1 release];
                }else {
                    UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"ERROR"
                                                                     message:@"This SSID is not exist"
                                                                    delegate:self
                                                           cancelButtonTitle:@"cancle"
                                                           otherButtonTitles:nil];
                    [alert1 show];
                    [alert1 release];
                }
                
            }
            break;
        default:
            break;
    }
}

-(void)reload
{
    self.navigationItem.rightBarButtonItem.enabled=NO;
    if (self.navigationItem.leftBarButtonItem) {
        self.navigationItem.leftBarButtonItem.enabled=NO;
    }
    
    if ([preferredLang isEqualToString:@"zh-Hans"]) {
        display.text=@"NETGEAR Extender正在搜索网络。需要一至两分钟时间；请稍后……";
    }else display.text=@"NETGEAR EXTENDER is searching WIFI networks, it will take a few minutes, please waitting";

    if (viewLoaded) {
        if (tableLoaded) {
            tableLoaded=NO;
            [UIView animateWithDuration:0.2 animations:^{[DataTable setFrame:CGRectMake(0,420,320,420)];
                [DataTableFor5G setFrame:CGRectMake(0,-420,320,420)];
            }
             completion:^(BOOL finished) {
//                 [nameArray1 release];
//                 [signalArray1 release];
//                 [securityArray1 release];
                 [dataArray1 release];
                 [DataTable release];
                 [DataTable removeFromSuperview];
                 if ([isextender isEqualToString:@"2"]) {
                     [nameArray2 release];
                     [signalArray2 release];
                     [securityArray2 release];
                     [dataArray2 release];
                     [DataTableFor5G release];
                     [DataTableFor5G removeFromSuperview];
                 }
             }];
        }[soap release];
    }
    
    if ([activityIndicator isAnimating]) {
        [activityIndicator stopAnimating];
    }
    else
        [activityIndicator startAnimating];
    
    soap = [[YHXSoapAPI alloc]init];
    

    [soap AuthenticateWithUserName:@"admin" Password:@"password" AndPort:@"80"];
    viewLoaded=YES;
}

- (void)viewDidLoad  //加载不定时进度条
{
    tableLoaded=NO;
    
    channel5G=channel2G=NO;
    
    if (!setPage) {
        setPage = [[YHXCodeViewController alloc]init];
        setPageFor5G = [[YHXCodeViewController alloc]init];
    }

    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];
    preferredLang = [languages objectAtIndex:0];
    NSLog(@"Preferred Language:%@", preferredLang);

    if ([preferredLang isEqualToString:@"zh-Hans"]) {
        display.text=@"NETGEAR Extender正在搜索网络。需要一至两分钟时间；请稍后……";
    }else display.text=@"NETGEAR EXTENDER is searching WIFI networks, it will take a few minutes, please waitting";
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reload)];
    self.navigationItem.rightBarButtonItem.enabled=NO;
    
    nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(receive:) name:@"Authenticate" object:nil];
    [nc addObserver:self selector:@selector(error:) name:@"False" object:nil];
    [nc addObserver:self selector:@selector(getAPInfo:) name:@"GetIPInfo" object:nil];
    [nc addObserver:self selector:@selector(cofigurationStarted:) name:@"ConfigurationStartedResponse" object:nil];
    
    activityIndicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [activityIndicator setCenter:CGPointMake(160,250)];
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.view addSubview:activityIndicator];
    
    if ([activityIndicator isAnimating]) {
        [activityIndicator stopAnimating];
    }
    else
        [activityIndicator startAnimating];
    self.navigationItem.title=@"NETGEAR";
    
    soap = [[YHXSoapAPI alloc]init];
    
    NSString * admin = @"admin";
    NSString * password = @"password";
    ports = [[NSString alloc]initWithString:@"80"];
    
      [soap AuthenticateWithUserName:admin Password:password AndPort:@"80"];            //认证
    
      
    
    viewLoaded=YES;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

//-(void)setExtenderModeResponse:(NSString)

-(void)cofigurationStarted:(NSNotification *)note
{
    NSString * NewExtender = @"Internet Surfing";
    NSString * New2G = @"Extender";
    NSString * new5G = @"";
    NSString * NewBond  = @"";
    
    
    NSLog(@"setExtender要启动    %@    ",isextender);
    NSLog(@"%@^^^^^^^^^^^^",isextender);
    
    //5G
    if ([isextender rangeOfString:@"2"].length>0) {
        soapFor5G = [[YHXSoapFor5G alloc]init];
        [soapFor5G GetAPInfo:@"5G"];
    }
    
    
    if ([isextender isEqualToString:@"1"]) {
        [soap SetExtenderMode:NewExtender :New2G :new5G :NewBond ];
    }else if ([isextender isEqualToString:@"2"]){
        [soap SetExtenderMode:NewExtender :New2G :New2G :@"5G" ];
    }
}

-(void)getAPInfo:(NSNotification *)note
{
    if ([activityIndicator isAnimating]) {
        [activityIndicator stopAnimating];
    }
    int items;
    if ([isextender isEqualToString:@"2"]) {
        items=6;
    }else if([isextender isEqualToString:@"1"]){
        items=5;
    }
    
    NSLog(@"KEY1 %@  KEY2  %@",[[note userInfo] objectForKey:@"1"],[[note userInfo] objectForKey:@"2"]);
    
    if ([[[note userInfo] objectForKey:@"2"] isEqualToString:@"2.4G"])  //传过来的通知是2.4G的
    {
    dataArray1 = [[NSMutableArray alloc]init];
    NSString *list = [[note userInfo] objectForKey:@"1"];
    NSString *signal1 = @"@";    //分隔符1
    NSString *signal2 = @";";    //分隔符2
    NSArray *listItems;          //由第一个分隔符分出的字符串
    NSArray *listItems1;         //由第二个分隔符分割出的信息
    NSMutableArray *finalList =[[NSMutableArray alloc]init];    //细分后放入的数组
    int count1=0;        //计数器  统计共有多少项
    if ([list rangeOfString:signal1].length>0) {
        listItems = [list componentsSeparatedByString:@"@"];
        
        for (int e=1; e<listItems.count; e++) {
            if ([listItems[e] rangeOfString:signal2].length>0&&[listItems[e] rangeOfString:@"S%"].length==0&&![listItems[e] isEqualToString:@""]) {
                
                NSString * info=listItems[e];
                listItems1 = [info componentsSeparatedByString:@";"];
                NSLog(@"%d   rere",listItems1.count);
                if (items==6&&listItems1.count!=7) {                        //含有分隔符@ ；造成的位子错乱则跳到下一个循环
                    continue;
                }else if (items == 5 &&listItems1.count!=5){
                    continue;
                }
                for (int i =0; i<items; i++) {
//                    if ([listItems1[i] isEqualToString:@"S%"]||[listItems1[i] isEqualToString:@"S"]) {
//                        NSLog(@"turn S%   70%  %@",listItems1[i]);
//                        [finalList addObject:@"70%"];
//                    }else
                        [finalList addObject:listItems1[i]];
                    NSLog(@"yyyyy  %@",finalList[count1]);
                    count1++;
                }
//                NSMutableString * error1 = finalList[count1-1];   //修正两个命令合并后带入的000
//                NSArray * correct =[error1 componentsSeparatedByString:@"000"];
//                finalList[count1-1]=correct[0];
            }
        }
    }
    
    dataArray1 = finalList;
        [self showTableView:@"2.4G"];
        [soap CofigurationStarted];

    }
    
       else  if ([[[note userInfo] objectForKey:@"2"] isEqualToString:@"5G"]) {
    
        dataArray2 = [[NSMutableArray alloc]init];
        NSString *list = [[note userInfo] objectForKey:@"1"];
        NSString *signal1 = @"@";    //分隔符1
        NSString *signal2 = @";";    //分隔符2
        NSArray *listItems;          //由第一个分隔符分出的字符串
        NSArray *listItems1;         //由第二个分隔符分割出的信息
        NSMutableArray *finalList =[[NSMutableArray alloc]init];    //细分后放入的数组
        int count1=0;        //计数器  统计共有多少项
        if ([list rangeOfString:signal1].length>0) {
            listItems = [list componentsSeparatedByString:@"@"];
            
            for (int e=1; e<listItems.count; e++) {
                
                if ([listItems[e] rangeOfString:signal2].length>0) {
                    NSString * info=listItems[e];
                    listItems1 = [info componentsSeparatedByString:@";"];
                    for (int i =0; i<items; i++) {
                        [finalList addObject:listItems1[i]];
                        NSLog(@"5555  %@",finalList[count1]);
                        count1++;
                    }
                }
            }
        }
        
        dataArray2 = finalList;
        
        [self showTableView:@"5G"];

    }
    
}


-(void)error:(NSNotification *)note{
    
    //NSLog(@"出错");
    self.navigationItem.rightBarButtonItem.enabled=YES;
    if ([activityIndicator isAnimating]) {
        [activityIndicator stopAnimating];
    }
    if ([preferredLang isEqualToString:@"zh-Hans"]) {
        display.text=@"请点击主页右上角按钮重新载入！";
    }else display.text = @"Please click the home  top right corner button to reload";
}

-(void)receive:(NSNotification *)note
{
    NSLog(@"receive    %@   receive",[[note userInfo] objectForKey:@"2"]);
    //NSString * radio = @"2.4G";
    [soap GetAPInfo:@"2.4G"];              //获取信息

    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [display release];
    [DataTable release];
    [activityIndicator release];
    [nc removeObserver:self];
    [super dealloc];
}
//-(void)showProgress  //加载进度条
//{
//    proView = [[UIProgressView alloc] initWithFrame:CGRectMake(90,250,150,20)];
//    [proView setProgressViewStyle:UIProgressViewStyleDefault];
//
//    proValue=0;
//    [proView setProgress:0.0];
//
//    timer = [NSTimer scheduledTimerWithTimeInterval:10.0/60.0 target:self selector:@selector(changeProgress) userInfo:nil repeats:YES];
//    [timer fire];
//    [self.view addSubview:proView];
//}
//
//-(void)changeProgress  //更新进度条
//{
//    proValue =proValue + 1.0;
//    if (proValue>250) {
//        [timer invalidate];
//    }
//    else
//    {
//        [proView setProgress:(proValue / 250)];
//    }
//}
@end
