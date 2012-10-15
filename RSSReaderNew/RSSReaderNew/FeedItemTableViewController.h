//
//  FeedItemTableViewController.h
//  RSSReaderNew
//
//  Created by Людмила on 11.10.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSLoaderAndParser.h"

@interface FeedItemTableViewController : UITableViewController <RSSLoaderAndParserDelegate>{
    NSArray *arrItems;
    NSString *rssUrlLink;
}

@property (nonatomic,retain) NSArray *arrItems;

- (id) initWithRSSLink:(NSString *)rssLink;

@end
