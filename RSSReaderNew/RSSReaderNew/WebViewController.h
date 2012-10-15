//
//  WebViewController.h
//  RSSReaderNew
//
//  Created by Людмила on 11.10.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate>{
    NSString *link;
}
- (id) initWithLinkURL:(NSString *)linkURL;
@end

