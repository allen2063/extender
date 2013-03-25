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


#pragma mark - View lifecycle



-(void)refresh
{
   // [self showTableView];
    
    

}


-(void)showTableView
{
    self.navigationItem.rightBarButtonItem.enabled=YES;

    
    UIImageView *imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"netgear"]];

    DataTable = [[UITableView alloc]initWithFrame:CGRectMake(0,420,320,420)];    //初始化tableview
    DataTable.delegate = self;      //指定委托
    DataTable.dataSource = self;    //指定数据委托

    DataTable.separatorColor = [UIColor lightGrayColor];    //设置间隔颜色
    DataTable.tableHeaderView = imageview;
    [UIView animateWithDuration:0.2 animations:^{[DataTable setFrame:CGRectMake(0,0,320,420)];}];         //从底下冒出
    [self.view addSubview:DataTable];                       //加载tableview

    self.navigationItem.title=@"请选择现有网络的名称";
    //self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reload)];
    tableLoaded=YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    NSLog(@"%@",indexPath);
    
    //[display removeFromSuperview];
    
    
    setPage = [[YHXCodeViewController alloc]init];
    
    [self.navigationController pushViewController:setPage animated:YES];
    [setPage getNameAndSecurity:[name objectAtIndex:indexPath.row]  :[security objectAtIndex:indexPath.row]];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return (dataArray1.count)/5;
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
    
    name =[[NSMutableArray alloc]init];    
    signal=[[NSMutableArray alloc]init];
    security=[[NSMutableArray alloc]init];

    for (int q=0;q<(dataArray1.count /5); q++) {
        [name addObject: dataArray1[q*5+1]];
        [signal addObject: dataArray1[q*5+4]];
        [security addObject:dataArray1[q*5+2]];
    }
    cell.textLabel.text = [name objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [signal objectAtIndex:indexPath.row];
    
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 100;
//}

-(void)showProgress  //加载进度条
{
    proView = [[UIProgressView alloc] initWithFrame:CGRectMake(90,250,150,20)];
    [proView setProgressViewStyle:UIProgressViewStyleDefault];
    
    proValue=0;
    [proView setProgress:0.0];
   
    timer = [NSTimer scheduledTimerWithTimeInterval:10.0/60.0 target:self selector:@selector(changeProgress) userInfo:nil repeats:YES];
    [timer fire];
    [self.view addSubview:proView];
}

-(void)changeProgress  //更新进度条
{
    proValue =proValue + 1.0;
    if (proValue>250) {
        [timer invalidate];
    }
    else
    {
        [proView setProgress:(proValue / 250)];
    }
}

-(void)reload
{
    self.navigationItem.rightBarButtonItem.enabled=NO;
    

    if (viewLoaded) {
        if (tableLoaded) {
            tableLoaded=NO;
            [UIView animateWithDuration:0.2 animations:^{[DataTable setFrame:CGRectMake(0,420,320,420)];}
             completion:^(BOOL finished) {
                 [name release];
                 [signal release];
                 [security release];
                 [dataArray1 release];
                 [DataTable release];
//                 if (setPage!=NULL) {
//                     [setPage release];
//                 }
             }];
        }[soap release];
    }
    
    
    
    
    
//    nc = [NSNotificationCenter defaultCenter];
//    [nc addObserver:self selector:@selector(receive:) name:@"Authenticate" object:nil];
//    [nc addObserver:self selector:@selector(error:) name:@"False" object:nil];
//    [nc addObserver:self selector:@selector(getAPInfo:) name:@"GetIPInfo" object:nil];
//    [nc addObserver:self selector:@selector(cofigurationStarted:) name:@"ConfigurationStartedResponse" object:nil];
    
    
//    activityIndicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
//    [activityIndicator setCenter:CGPointMake(160,250)];
//    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    [self.view addSubview:activityIndicator];
    
    if ([activityIndicator isAnimating]) {
        [activityIndicator stopAnimating];
    }
    else
        [activityIndicator startAnimating];
    self.navigationItem.title=@"NETGEAR";
    
    soap = [[YHXSoapAPI alloc]init];
    
    NSString * admin = @"admin";
    NSString * password = @"password";
    [soap Authenticate:admin:password];  //认证
    viewLoaded=YES;
}


- (void)viewDidLoad  //加载不定时进度条
{
    tableLoaded=NO;

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
    [soap Authenticate:admin:password];  //认证
    
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
    
    NSLog(@"setExtender要启动");
    
    [soap SetExtenderMode:NewExtender :New2G :new5G :NewBond ];
}

-(void)getAPInfo:(NSNotification *)note
{
    if ([activityIndicator isAnimating]) {
        [activityIndicator stopAnimating];
    }
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
            
            if ([listItems[e] rangeOfString:signal2].length>0) {
                NSString * info=listItems[e];
                listItems1 = [info componentsSeparatedByString:@";"];
                for (int i =0; i<5; i++) {
                    [finalList addObject:listItems1[i]];
                    NSLog(@"yyyyy  %@",finalList[count1]);
                    count1++;
                }
                NSMutableString * error1 = finalList[count1-1];   //修正两个命令合并后带入的000
                NSArray * correct =[error1 componentsSeparatedByString:@"000"];
                finalList[count1-1]=correct[0];
            }
        }
    }
    
    dataArray1 = finalList;
    
    [soap CofigurationStarted];
    
    [self showTableView];
}


-(void)error:(NSNotification *)note{
    
    //NSLog(@"出错");
    self.navigationItem.rightBarButtonItem.enabled=YES;

    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"出错"
//                                                    message:[NSString stringWithFormat:@"连接出错，请按主页右上角重载按钮重新载入！"]
//                                                   delegate:self
//                                          cancelButtonTitle:@"确定"
//                                          otherButtonTitles:nil];
//    [alert show];
}

-(void)receive:(NSNotification *)note
{
    
    NSLog(@"receive    %@   receive",[[note userInfo] objectForKey:@"1"]);
    NSString * radio = @"2.4G";
    [soap GetAPInfo:radio];              //获取信息
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
    //[setPage release];
    //[soap release];
    [nc removeObserver:self];
    [super dealloc];
}

@end
