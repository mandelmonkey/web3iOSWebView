//
//  browser.m
//  web3
//
//  Created by Chris on 7/2/18.
//  Copyright © 2018 IndieSquare. All rights reserved.
//

#import "browser.h"
 


@interface browser ()

@end

@implementation browser
WKWebView * webView;
TiApp* viewController;
NSString* currentData;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 
-(WKWebView*)getBrowser:(double)width andHeight:(double)height andUrl:(NSString*)url andController:(TiApp*)controller andScript:(NSString*)scriptContent{
   
    viewController = controller;
    
    NSSet *websiteDataTypes
    = [NSSet setWithArray:@[
                            WKWebsiteDataTypeDiskCache,
                            WKWebsiteDataTypeOfflineWebApplicationCache,
                            WKWebsiteDataTypeMemoryCache,
                            WKWebsiteDataTypeLocalStorage,
                            WKWebsiteDataTypeCookies,
                            WKWebsiteDataTypeSessionStorage,
                            WKWebsiteDataTypeIndexedDBDatabases,
                            WKWebsiteDataTypeWebSQLDatabases
                            ]];
    //// All kinds of data
    //NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
    //// Date from
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    //// Execute
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        // Done
    }];
    
    WKPreferences * preferences = [[WKPreferences alloc] init];
    preferences.javaScriptEnabled = true;
    
   // [[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36",@"UserAgent", nil]];
    
    WKWebViewConfiguration * configuration = [[WKWebViewConfiguration alloc] init];
   /* NSString * scriptUrl = [[NSBundle mainBundle] pathForResource:@"web3indie" ofType:@"txt"];
    NSError *error;
    NSString * scriptContent = [NSString stringWithContentsOfFile:scriptUrl encoding:NSUTF8StringEncoding error:&error];
    
    if(error != NULL){
        return NULL;
    }*/
    WKUserScript * script = [[WKUserScript alloc] initWithSource:scriptContent injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:true];
    [configuration.userContentController addUserScript:script];
    configuration.preferences = preferences;
    
    
    webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, width, height) configuration:configuration];
      webView.UIDelegate = self;
    
    if([url rangeOfString:@"/IndieSquare.app/"].location != NSNotFound){

    NSURL* htmlUrl = [NSURL fileURLWithPath:url isDirectory:false];
    [webView loadFileURL:htmlUrl allowingReadAccessToURL:htmlUrl];
    
        
    }else{
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    
    }
  
   
    return webView;
    
    
}

#pragma mark - WKUIDelegate

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView
{
    [webView reload];
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    if(message != NULL){
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:[NSString stringWithFormat:@"%@",message]
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle: NSLocalizedString(@"OK", nil)
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler();
                                                      }]];
    
   [viewController showModalController:alertController animated:YES];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
