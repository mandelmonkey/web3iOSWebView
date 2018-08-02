//
//  browser.h
//  web3
//
//  Created by Chris on 7/2/18.
//  Copyright © 2018 IndieSquare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface TiApp : NSObject
-(void)showModalController:(UIViewController*)controller animated:(BOOL)animated;
@end
 
@interface browser : UIViewController <WKUIDelegate> 
-(WKWebView*)getBrowser:(double)width andHeight:(double)height andUrl:(NSString*)url andController:(TiApp*)controller andScript:(NSString*)scriptContent;

@end
