//
//  jsonViewController.m
//  JSONDemo
//
//  Created by student on 4/1/13.
//  Copyright (c) 2013 FVTC. All rights reserved.
//

#import "jsonViewController.h"

@interface jsonViewController ()

@end

@implementation jsonViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)PostButtonClick:(id)sender {
    
    NSString *url = @"http://192.168.1.77:8124/?cmd=allgames";
    [self postDataWithUrl:url withPostBody:@""];
}

- (NSString *) RandomUserName
{
    NSMutableString *randomUser = [[NSMutableString alloc] init];
    NSString *alphabet  = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXZY0123456789";
    for (NSUInteger i = 0U; i < 16; i++) {
        u_int32_t r = arc4random() % [alphabet length];
        unichar c = [alphabet characterAtIndex:r];
        [randomUser appendFormat:@"%C", c];
    }
    return randomUser;
}


- (IBAction)CreateUserClick:(id)sender {
    
    
    NSMutableString *postBody = [[NSMutableString alloc] init];
    
    NSString *timestamp = [self getTimestamp];
    //where we build it
    [postBody appendString:@"{  "];
    [postBody appendFormat:@"\"timestamp\": \"%@\",", timestamp];
    //opening brace for light element
    _login = [self RandomUserName];
    [postBody appendFormat:@"\"login\": \"%@\"", _login];

     //close brace for outside json
    [postBody appendString:@"}  "];
    
     NSLog(@"POST BODY:%@", postBody);

    NSString *url = @"http://192.168.1.77:8124/?cmd=createuser";
    [self postDataWithUrl:url withPostBody:postBody];

}

- (IBAction)JoinGameClick:(id)sender {
    
    
    NSMutableString *postBody = [[NSMutableString alloc] init];
    
    NSString *timestamp = [self getTimestamp];
    //where we build it
    [postBody appendString:@"{  "];
    [postBody appendFormat:@"\"timestamp\": \"%@\",", timestamp];
    [postBody appendFormat:@"\"game_id\": \"%i\",", 0];

    //opening brace for light element
    [postBody appendFormat:@"\"login\": \"%@\"", _login];
    
    //close brace for outside json
    [postBody appendString:@"}  "];
    
    NSLog(@"POST BODY:%@", postBody);
    NSString *url = @"http://192.168.1.77:8124/?cmd=joingame";
    [self postDataWithUrl:url withPostBody:postBody];

    
}


-(NSString *)getTimestamp
{
    float fseconds = [[NSDate date] timeIntervalSince1970];
    fseconds = fseconds / 100;
    fseconds = round(fseconds);
    int seconds = (int) floor(fseconds);
    NSString *t =  [NSString stringWithFormat:@"%i", seconds ];
    return t;
}




- (void) connectionDidFinishLoading:(NSURLConnection *) connection
{
    NSString *response = [[NSString alloc] initWithData:_httpData encoding:NSUTF8StringEncoding];
    NSLog(@"Response:%@", response);
    
}

- (void) connection:(NSURLConnection *) conn didReceiveData:(NSData *)data
{
    [_httpData appendData:data];
}

- (void) postDataWithUrl:(NSString *) urlString withPostBody:(NSString *) postBody;
{
    _httpData = [[NSMutableData alloc] init];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSData *postData = [postBody dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:postData];
    _connection  = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];

}



- (IBAction)GetNumberClick:(id)sender {
    
    NSMutableString *postBody = [[NSMutableString alloc] init];
    
    NSString *timestamp = [self getTimestamp];
    //where we build it
    [postBody appendString:@"{  "];
    [postBody appendFormat:@"\"timestamp\": \"%@\",", timestamp];
    [postBody appendFormat:@"\"lastchecked\": \"%@\",", timestamp];
    [postBody appendFormat:@"\"game_id\": \"%i\",", 0];
    [postBody appendFormat:@"\"login\": \"%@\"", _login];
    //close brace for outside json
    [postBody appendString:@"}  "];

    
    NSLog(@"POST BODY:%@", postBody);
    NSString *url = @"http://192.168.1.77:8124/?cmd=getnumber";
    [self postDataWithUrl:url withPostBody:postBody];
    
}
@end
