//
//  FeedViewController.h
//  RSSReaderNew
//
//  Created by Людмила on 11.10.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSLoaderAndParser.h"
#import "ViewWithText.h"


@interface FeedViewController : UITableViewController <RSSLoaderAndParserDelegate,ViewWithTextDelegate>
{
    NSMutableArray *arrFeeds;
    NSString * fileName;
}

-(void) addFeed;

@end

