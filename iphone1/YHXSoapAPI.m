//
//  YHXSoapAPI.m
//  iphone1
//
//  Created by Zeng Yifei on 13-3-12.
//  Copyright (c) 2013年 KaiYan. All rights reserved.
//

#import "YHXSoapAPI.h"
#import "YHXAppDelegate.h"
#import "YHXViewController.h"
@implementation YHXSoapAPI

@synthesize webData;
@synthesize soapResults;
@synthesize xmlParser;
@synthesize elementFound;
@synthesize matchingElement;
@synthesize matchingElement1;
@synthesize conn;
@synthesize getXMLResults;

-(void)Authenticate:(id)NewUsername   :(id)NewPassword
{
    matchingElement = @"ResponseCode";

    NSString * soapMsg = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n"
                          "<SOAP-ENV:Envelope \r\n"
                          "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"\r\n "//
                          "xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\" \r\n"
                          "xmlns:xsd=\"http://www.w3.org/1999/XMLSchema\">\r\n "
                          "<SOAP-ENV:Body>\r\n"
                          "<Authenticate>\r\n"
                          "<NewPassword xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewPassword>\r\n"
                          "<NewUsername xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewUsername>\r\n"
                          "</Authenticate>\r\n"
                          "</SOAP-ENV:Body>\r\n"
                          "</SOAP-ENV:Envelope>\r\n",NewPassword,NewUsername];
    NSLog(@"%@",soapMsg);
    
    NSURL * url = [NSURL URLWithString:@"http://www.mywifiext.com/soap/server_sa/"];
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue: @"urn:NETGEAR_ROUTER:service:DeviceConfig:1#Authenticate" forHTTPHeaderField:@"SOAPAction"];
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [[NSMutableData data]retain];
        //NSLog(@"%@  22222",webData);
    }
    else {
        NSLog(@"not ready");
    }
}

-(void)GetAPInfo :(id)NewRadio
{
    matchingElement = @"ResponseCode";
    matchingElement1 = @"APList";
    
    NSString * soapMsg = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
                          "<SOAP-ENV:Envelope "
                          "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\""
                          "xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\" "
                          "xmlns:xsd=\"http://www.w3.org/1999/XMLSchema\">"
                          "<SOAP-ENV:Body>"
                          "<GetAPInfo>"
                          "<NewRadio xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewRadio>"
                          "</GetAPInfo>"
                          "</SOAP-ENV:Body>"
                          "</SOAP-ENV:Envelope>",NewRadio];
    NSLog(@"%@",soapMsg);
        
    NSURL * url = [NSURL URLWithString:@"http://www.mywifiext.com/soap/server_sa/"];
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];               //设置地址
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];              //指定格式
    [req addValue: @"urn:NETGEAR-ROUTER:service:WLANConfiguration:1#GetAPInfo" forHTTPHeaderField:@"SOAPAction"];   //调用方法
    
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [[NSMutableData data]retain];
        //NSLog(@"%@  22222",webData);
    }
    else {
        NSLog(@"not ready");
    }
}


-(void)CofigurationStarted 
{
    matchingElement = @"ResponseCode";
    matchingElement1 = @"APList";
    
    NSString * soapMsg = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
                          "<SOAP-ENV:Envelope "
                          "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\""
                          "xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\" "
                          "xmlns:xsd=\"http://www.w3.org/1999/XMLSchema\">"
                          "<SOAP-ENV:Body>"
                          "<ConfigurationStarted>"
                          "</ConfigurationStarted>"
                          "</SOAP-ENV:Body>"
                          "</SOAP-ENV:Envelope>"];
    NSLog(@"%@",soapMsg);
    
    NSURL * url = [NSURL URLWithString:@"http://www.mywifiext.com/soap/server_sa/"];
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];               //设置地址
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];              //指定格式
    [req addValue: @"urn:NETGEAR-ROUTER:service:DeviceConfig:1#ConfigurationStarted" forHTTPHeaderField:@"SOAPAction"];   //调用方法
    
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [[NSMutableData data]retain];
        //NSLog(@"%@  22222",webData);
    }
    else {
        NSLog(@"not ready");
    }
}

-(void)SetExtenderMode:(NSString *)NewExtenderMode :(NSString *)New2GRadioMode :(NSString *)New5GRadioMode :(NSString *)NewBondEthernet
{
    matchingElement = @"ResponseCode";
    matchingElement1 = @"APList";
    
    NSLog(@"1111%@222222%@33333%@44444%@55555",NewExtenderMode,New2GRadioMode,New5GRadioMode,NewBondEthernet);
    
    NSString * soapMsg = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
                          "<SOAP-ENV:Envelope "
                          "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\""
                          "xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\" "
                          "xmlns:xsd=\"http://www.w3.org/1999/XMLSchema\">"
                          "<SOAP-ENV:Body>"
                          "<SetExtenderMode>"
                          "<NewExtenderMode xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewExtenderMode>"
                          "<New2GRadioMode xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</New2GRadioMode>"
                          "<New5GRadioMode xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</New5GRadioMode>"
                          "<NewBondEthernet xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewBondEthernet>"
                          "</SetExtenderMode>"
                          "</SOAP-ENV:Body>"
                          "</SOAP-ENV:Envelope>",NewExtenderMode,New2GRadioMode,New5GRadioMode,NewBondEthernet];
    NSLog(@"%@",soapMsg);
    
    NSURL * url = [NSURL URLWithString:@"http://www.mywifiext.com/soap/server_sa/"];
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];               //设置地址
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];              //指定格式
    [req addValue: @"urn:NETGEAR-ROUTER:service:WLANConfiguration:1#SetExtenderMode" forHTTPHeaderField:@"SOAPAction"];   //调用方法
    
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [[NSMutableData data]retain];
        //NSLog(@"%@  22222",webData);
    }
    else {
        NSLog(@"not ready");
    }
}


-(void)SetRouterWLANNoSecurity:(NSString *)NewRadio :(NSString *)NewSSID :(NSString *)NewChannel :(NSString *)NewWirelessMode :(id)NewVerify
{
    matchingElement = @"ResponseCode";
    matchingElement1 = @"APList";
    
    
    NSString * soapMsg = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
                          "<SOAP-ENV:Envelope "
                          "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\""
                          "xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\" "
                          "xmlns:xsd=\"http://www.w3.org/1999/XMLSchema\">"
                          "<SOAP-ENV:Body>"
                          "<SetRouterWLANNoSecurity>"
                          "<NewRadio xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewRadio>"
                          "<NewSSID xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewSSID>"
                          "<NewChannel xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewChannel>"
                          "<NewWirelessMode xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewWirelessMode>"
                          "<NewVerify xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewVerify>"
                          "</SetRouterWLANNoSecurity>"
                          "</SOAP-ENV:Body>"
                          "</SOAP-ENV:Envelope>",NewRadio,NewSSID,NewChannel,NewWirelessMode,NewVerify];
    NSLog(@"%@",soapMsg);
    
    NSURL * url = [NSURL URLWithString:@"http://www.mywifiext.com/soap/server_sa/"];
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];               //设置地址
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];              //指定格式
    [req addValue: @"urn:NETGEAR-ROUTER:service:WLANConfiguration:1#SetRouterWLANNoSecurity" forHTTPHeaderField:@"SOAPAction"];   //调用方法
    
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [[NSMutableData data]retain];
        //NSLog(@"%@  22222",webData);
    }
    else {
        NSLog(@"not ready");
    }
}

-(void)SetRouterWLANWEPByKeys:(NSString *)NewRadio :(NSString *)NewSSID :(NSString *)NewChannel :(NSString *)NewWirelessMode :(NSString *)NewWEPAuthType :(id)NewWEPLength :(id) NewKeyIndex :(NSString *) NewWEPPassphrase :(id)NewVerify
{
    matchingElement = @"ResponseCode";
    matchingElement1 = @"APList";
    
    
    NSString * soapMsg = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
                          "<SOAP-ENV:Envelope "
                          "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\""
                          "xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\" "
                          "xmlns:xsd=\"http://www.w3.org/1999/XMLSchema\">"
                          "<SOAP-ENV:Body>"
                          "<SetRouterWLANWEPByKeys>"
                          "<NewRadio xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewRadio>"
                          "<NewSSID xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewSSID>"
                          "<NewChannel xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewChannel>"
                          "<NewWirelessMode xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewWirelessMode>"
                          "<NewWEPAuthType xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewWEPAuthType>"
                          "<NewWEPLength xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewWEPLength>"
                          "<NewKeyIndex xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewKeyIndex>"
                          "<NewWEPPassphrase xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewWEPPassphrase>"
                          "<NewVerify xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewVerify>"                          
                          "</SetRouterWLANWEPByKeys>"
                          "</SOAP-ENV:Body>"
                          "</SOAP-ENV:Envelope>",NewRadio,NewSSID,NewChannel,NewWirelessMode,NewWEPAuthType,NewWEPLength,NewKeyIndex,NewWEPPassphrase,NewVerify];
    NSLog(@"%@",soapMsg);
    
    NSURL * url = [NSURL URLWithString:@"http://www.mywifiext.com/soap/server_sa/"];
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];               //设置地址
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];              //指定格式
    [req addValue: @"urn:NETGEAR-ROUTER:service:WLANConfiguration:1#SetRouterWLANWEPByKeys" forHTTPHeaderField:@"SOAPAction"];   //调用方法
    
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [[NSMutableData data]retain];
        //NSLog(@"%@  22222",webData);
    }
    else {
        NSLog(@"not ready");
    }
}

-(void)SetRouterWLANWPAPSKByPassphrase:(NSString *)NewRadio :(NSString *)NewSSID :(NSString *)NewChannel :(NSString *)NewWirelessMode :(NSString *)NewWPAEncryptionModes :(NSString *) NewWPAPassphrase :(id)NewVerify
{
    matchingElement = @"ResponseCode";
    matchingElement1 = @"APList";
    
    
    NSString * soapMsg = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
                          "<SOAP-ENV:Envelope"
                          "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\""
                          "xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\" "
                          "xmlns:xsd=\"http://www.w3.org/1999/XMLSchema\">"
                          "<SOAP-ENV:Body>"
                          "<SetRouterWLANWPAPSKByPassphrase>"
                          "<NewRadio xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewRadio>"
                          "<NewSSID xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewSSID>"
                          "<NewChannel xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewChannel>"
                          "<NewWirelessMode xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewWirelessMode>"
                          "<NewWPAEncryptionModes xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewWPAEncryptionModes>"
                          "<NewWPAPassphrase xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewWPAPassphrase>"
                          "<NewVerify xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewVerify>"
                          "</SetRouterWLANWPAPSKByPassphrase>"
                          "</SOAP-ENV:Body>"
                          "</SOAP-ENV:Envelope>",NewRadio,NewSSID,NewChannel,NewWirelessMode,NewWPAEncryptionModes,NewWPAPassphrase,NewVerify];
    NSLog(@"%@",soapMsg);
    
    NSURL * url = [NSURL URLWithString:@"http://www.mywifiext.com/soap/server_sa/"];
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];               //设置地址
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];              //指定格式
    [req addValue: @"urn:NETGEAR-ROUTER:service:WLANConfiguration:1#SetRouterWLANWPAPSKByPassphrase" forHTTPHeaderField:@"SOAPAction"];   //调用方法
    
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [[NSMutableData data]retain];
        //NSLog(@"%@  22222",webData);
    }
    else {
        NSLog(@"not ready");
    }
}


-(void)SetWLANNoSecurity:(NSString *)NewRadio :(NSString *)NewSSID :(NSString *)NewChannel :(NSString *)NewWirelessMode 
{
    matchingElement = @"ResponseCode";
    matchingElement1 = @"APList";
    
    
    NSString * soapMsg = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
                          "<SOAP-ENV:Envelope "
                          "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\""
                          "xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\" "
                          "xmlns:xsd=\"http://www.w3.org/1999/XMLSchema\">"
                          "<SOAP-ENV:Body>"
                          "<SetWLANNoSecurity>"
                          "<NewRadio xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewRadio>"
                          "<NewSSID xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewSSID>"
                          "<NewChannel xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewChannel>"
                          "<NewWirelessMode xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewWirelessMode>"
                          "</SetWLANNoSecurity>"
                          "</SOAP-ENV:Body>"
                          "</SOAP-ENV:Envelope>",NewRadio,NewSSID,NewChannel,NewWirelessMode];
    NSLog(@"%@",soapMsg);
    
    NSURL * url = [NSURL URLWithString:@"http://www.mywifiext.com/soap/server_sa/"];
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];               //设置地址
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];              //指定格式
    [req addValue: @"urn:NETGEAR-ROUTER:service:WLANConfiguration:1#SetWLANNoSecurity" forHTTPHeaderField:@"SOAPAction"];   //调用方法
    
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [[NSMutableData data]retain];
        //NSLog(@"%@  22222",webData);
    }
    else {
        NSLog(@"not ready");
    }
}

-(void)SetWLANWEPByKeys:(NSString *)NewRadio :(NSString *)NewSSID :(NSString *)NewChannel :(NSString *)NewWirelessMode :(NSString *)NewWEPAuthType :(id)NewWEPLength :(id) NewKeyIndex :(NSString *) Newkey1 :(NSString *) Newkey2:(NSString *) Newkey3:(NSString *) Newkey4
{
    matchingElement = @"ResponseCode";
    matchingElement1 = @"APList";
    NSString * soapMsg = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
                          "<SOAP-ENV:Envelope "
                          "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\""
                          "xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\" "
                          "xmlns:xsd=\"http://www.w3.org/1999/XMLSchema\">"
                          "<SOAP-ENV:Body>"
                          "<SetWLANWEPByKeys>"
                          "<NewRadio xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewRadio>"
                          "<NewSSID xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewSSID>"
                          "<NewChannel xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewChannel>"
                          "<NewWirelessMode xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewWirelessMode>"
                          "<NewWEPAuthType xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewWEPAuthType>"
                          "<NewWEPLength xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewWEPLength>"
                          "<NewKeyIndex xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewKeyIndex>"
                          "<Newkey1 xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</Newkey1>"
                          "<Newkey2 xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</Newkey2>"
                          "<Newkey3 xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</Newkey3>"
                          "<Newkey4 xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</Newkey4>"
                          "</SetWLANWEPByKeys>"
                          "</SOAP-ENV:Body>"
                          "</SOAP-ENV:Envelope>",NewRadio,NewSSID,NewChannel,NewWirelessMode,NewWEPAuthType,NewWEPLength,NewKeyIndex,Newkey1,Newkey2,Newkey3,Newkey4];
    NSLog(@"%@",soapMsg);
    
    NSURL * url = [NSURL URLWithString:@"http://www.mywifiext.com/soap/server_sa/"];
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];               //设置地址
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];              //指定格式
    [req addValue: @"urn:NETGEAR-ROUTER:service:WLANConfiguration:1#SetWLANWEPByKeys" forHTTPHeaderField:@"SOAPAction"];   //调用方法
    
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [[NSMutableData data]retain];
        //NSLog(@"%@  22222",webData);
    }
    else {
        NSLog(@"not ready");
    }
}

-(void)SetWLANWPAPSKByPassphrase:(NSString *)NewRadio :(NSString *)NewSSID :(NSString *)NewChannel :(NSString *)NewWirelessMode :(NSString *)NewWPAEncryptionModes :(NSString *) NewWPAPassphrase 
{
    matchingElement = @"ResponseCode";
    matchingElement1 = @"APList";
    
    
    NSString * soapMsg = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
                          "<SOAP-ENV:Envelope"
                          "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\""
                          "xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\" "
                          "xmlns:xsd=\"http://www.w3.org/1999/XMLSchema\">"
                          "<SOAP-ENV:Body>"
                          "<SetWLANWPAPSKByPassphrase>"
                          "<NewRadio xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewRadio>"
                          "<NewSSID xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewSSID>"
                          "<NewChannel xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewChannel>"
                          "<NewWirelessMode xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewWirelessMode>"
                          "<NewWPAEncryptionModes xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewWPAEncryptionModes>"
                          "<NewWPAPassphrase xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</NewWPAPassphrase>"
                          "</SetWLANWPAPSKByPassphrase>"
                          "</SOAP-ENV:Body>"
                          "</SOAP-ENV:Envelope>",NewRadio,NewSSID,NewChannel,NewWirelessMode,NewWPAEncryptionModes,NewWPAPassphrase];
    NSLog(@"%@",soapMsg);
    
    NSURL * url = [NSURL URLWithString:@"http://www.mywifiext.com/soap/server_sa/"];
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];               //设置地址
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];              //指定格式
    [req addValue: @"urn:NETGEAR-ROUTER:service:WLANConfiguration:1#SetWLANWPAPSKByPassphrase" forHTTPHeaderField:@"SOAPAction"];   //调用方法
    
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [[NSMutableData data]retain];
        //NSLog(@"%@  22222",webData);
    }
    else {
        NSLog(@"not ready");
    }
}

-(void)ConfigurationFinished
{
    matchingElement = @"ResponseCode";
    matchingElement1 = @"APList";
    
    NSString * soapMsg = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
                          "<SOAP-ENV:Envelope "
                          "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\""
                          "xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\" "
                          "xmlns:xsd=\"http://www.w3.org/1999/XMLSchema\">"
                          "<SOAP-ENV:Body>"
                          "<ConfigurationFinished>"
                          "<NewConfigStatus xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">1</NewConfigStatus>"
                          "</ConfigurationFinished>"
                          "</SOAP-ENV:Body>"
                          "</SOAP-ENV:Envelope>"];
    NSLog(@"%@",soapMsg);
    
    NSURL * url = [NSURL URLWithString:@"http://www.mywifiext.com/soap/server_sa/"];
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];               //设置地址
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];              //指定格式
    [req addValue: @"urn:NETGEAR-ROUTER:service:DeviceConfig:1#ConfigurationFinished" forHTTPHeaderField:@"SOAPAction"];   //调用方法
    
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [[NSMutableData data]retain];
        //NSLog(@"%@  22222",webData);
    }
    else {
        NSLog(@"not ready");
    }
}

-(void)SetEnable
{
    matchingElement = @"ResponseCode";
    matchingElement1 = @"APList";
    
    NSString * soapMsg = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
                          "<SOAP-ENV:Envelope "
                          "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\""
                          "xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\" "
                          "xmlns:xsd=\"http://www.w3.org/1999/XMLSchema\">"
                          "<SOAP-ENV:Body>"
                          "<SetEnable>"
                          "<NewEnable xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">0</NewEnable>"
                          "</SetEnable>"
                          "</SOAP-ENV:Body>"
                          "</SOAP-ENV:Envelope>"];
    NSLog(@"%@",soapMsg);
    
    NSURL * url = [NSURL URLWithString:@"http://www.mywifiext.com/soap/server_sa/"];
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];               //设置地址
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];              //指定格式
    [req addValue: @"urn:NETGEAR-ROUTER:service:DeviceConfig:1#SetEnable" forHTTPHeaderField:@"SOAPAction"];   //调用方法
    
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [[NSMutableData data]retain];
        //NSLog(@"%@  22222",webData);
    }
    else {
        NSLog(@"not ready");
    }
}




#pragma mark -
#pragma mark URL Connection Data Delegate Methods




// 刚开始接受响应时调用
-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *) response{
    [webData setLength: 0];
    NSLog(@"  刚开始接受响应时调用");

}

// 每接收到一部分数据就追加到webData中
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *) data {
    [webData appendData:data];
    NSLog(@"  每接收到一部分数据就追加到webData中");

}



// 出现错误时
-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *) error {
    conn = nil;
    webData = nil;    NSLog(@"  出现错误时");

        [[NSNotificationCenter defaultCenter] postNotificationName:@"False"
                          object:self
         ];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"出错"
                                                           message:[NSString stringWithFormat:@"连接出错，请按主页右上角重载按钮重新载入！"]
                                                          delegate:self
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil];
    [alert show];
    
}

// 完成接收数据时调用
-(void) connectionDidFinishLoading:(NSURLConnection *) connection {
    NSString *theXML = [[NSString alloc] initWithBytes:[webData mutableBytes]
                                                length:[webData length]
                                              encoding:NSUTF8StringEncoding];
    
    // 打印出得到的XML
    getXMLResults = [[NSMutableString alloc] initWithString:theXML];
    NSLog(@"11完成接收数据时调用11%@完成接收数据时调用", getXMLResults);

    if ([getXMLResults rangeOfString:@"system cannot find the path"].length>0) {
        NSLog(@"出错");
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"接入网络错误"
                                                        message:[NSString stringWithFormat:@"请接入中继器所在网络然后点击首页右上角重载按钮再次扫描"]
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];

        NSNotificationCenter *nc1 = [NSNotificationCenter defaultCenter];
        [nc1 postNotificationName:@"False" object:self ];
    }
    
    
    // 使用NSXMLParser解析出我们想要的结果
    xmlParser = [[NSXMLParser alloc] initWithData: webData];

    [xmlParser setDelegate: self];
    [xmlParser setShouldResolveExternalEntities: YES];
    [xmlParser parse];
}




#pragma mark -
#pragma mark XML Parser Delegate Methods

// 开始解析一个元素名
-(void) parser:(NSXMLParser *) parser didStartElement:(NSString *) elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *) qName attributes:(NSDictionary *) attributeDict {
    if ([elementName isEqualToString:matchingElement]||[elementName isEqualToString:matchingElement1]) {
        if (!soapResults) {
            soapResults = [[NSMutableString alloc] init];
        }
        elementFound = YES;
    }
}

// 追加找到的元素值，一个元素值可能要分几次追加
-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string {
    if (elementFound) {
        [soapResults appendString: string];
    }
}

// 结束解析这个元素名
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:matchingElement]) {
        
        //NSString *soapResults1=@"   123123wgargraga124124    ";
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        //NSLog(@"Sending notification");　 //使用NSDictionary 存储要传递的数据
        NSMutableDictionary *d = [NSDictionary dictionaryWithObject:soapResults forKey:@"1"];
        //发送notification
         NSLog(@"getXMLResults%@  1212344",getXMLResults);
        NSLog(@"soapResults%@  1212344",soapResults);
    
     if([soapResults rangeOfString:@"000"].length>0){                   //代码叠加   000010
        if ([getXMLResults rangeOfString:@"GetAPInfo"].length>0) {
            if ([getXMLResults rangeOfString:@"APList>0<"].length>0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"获取路由列表失败"
                                                                message:[NSString stringWithFormat:@"请按右上角的刷新列表重试！"]
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
                [alert show];
                
            }
            else{
            NSLog(@"GetIPInfo………………");
                [nc postNotificationName:@"GetIPInfo" object:self userInfo:d];}
        }
        else if ([getXMLResults rangeOfString:@"ConfigurationStartedResponse"].length>0){
            NSLog(@"CofigurationStarted………………");
            [nc postNotificationName:@"ConfigurationStartedResponse" object:self userInfo:d];

        }
        else if([getXMLResults rangeOfString:@"SetRouterWLAN"].length>0){
            NSLog(@"SetRouterWLAN………………");
            [nc postNotificationName:@"SetRouterWLAN" object:self userInfo:d];
        }else if([getXMLResults rangeOfString:@"SetWLAN"].length>0){
            NSLog(@"SetWLAN………………");
            [nc postNotificationName:@"SetWLAN" object:self userInfo:d];
        }else if ([getXMLResults rangeOfString:@"SetEnableResponse"].length>0){
            NSLog(@"SetEnable………………");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"设置成功"
                                                            message:[NSString stringWithFormat:@"按确定后将退出程序，请等待中继器重启！"]
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            alert.tag=1;
            [nc postNotificationName:@"SetEnable" object:self userInfo:d];
        }
    }
    else if ([soapResults isEqualToString:@"401"])
        {
            [nc postNotificationName:@"False"
                              object:self
             ];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"出错"
                                                            message:[NSString stringWithFormat:@"连接出错，请按主页右上角重载按钮重新载入！"]
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];

        }
    else if ([soapResults rangeOfString:@"010"].length>0){                               //代码叠加 返回指令叠加  必须
            if ([getXMLResults rangeOfString:@"SetRouterWLAN"].length>0) {
                [nc postNotificationName:@"codeError" object:self userInfo:d];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误"
                                                                message:[NSString stringWithFormat:@"密码错误,请重试"]
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }
    else if ([soapResults isEqualToString:@"0"]) {
                [nc postNotificationName:@"Authenticate"
                                  object:self
                                userInfo:d];
            }

        elementFound = FALSE;
        // 强制放弃解析
        [xmlParser abortParsing];
        soapResults = nil;
    }
}

// 解析整个文件结束后
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if (soapResults) {
        soapResults = nil;
    }
}

// 出错时，例如强制结束解析
- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    if (soapResults) {
        soapResults = nil;
    }
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex :(NSInteger)buttonIndex
{
    if (alertView.tag==1) {
        //if (buttonIndex==0) {
        exit(0);
        //}
        
    }
}

@end
