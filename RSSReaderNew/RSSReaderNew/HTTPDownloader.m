//
//  HTTPDownloader.m
//  RSSReaderNew
//
//  Created by Людмила on 11.10.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "HTTPDownloader.h"

@implementation HTTPDownloader

@synthesize delegate;

- (void)loadFromURL:(NSString *)urlString
{
    NSLog(@"LINK IS %@",urlString);
    NSURL *url=[NSURL URLWithString:urlString];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    NSURLConnection *conn=[NSURLConnection connectionWithRequest:request delegate:self];
    if (conn)
    {
        dowloadData=[NSMutableData new];
    }
}

// (Сообщение получено от NSURLConnection) Узел ответил - обнуляем данные
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [dowloadData setLength:0];
}

// (Сообщение получено от NSURLConnection) Получили очередную порцию данных - добавляем в буфер
- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [dowloadData appendData:data];
}

// (Сообщение получено от NSURLConnection) Была ошибка - освобождаем ресурсы
- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"CONNECTION DID FAIL WITH ERROR %@",error);
    // освобождаем ресурсы
    [dowloadData release];
}

// (Сообщение получено от NSURLConnection) Все данные получены
- (void) connectionDidFinishLoading:(NSURLConnection *)connection
{
    // посылаем делегату сообщение о том, что все готово и отдаем результат
    [delegate HTTPDidLoad:dowloadData];
    // освобождаем ресурсы
    [dowloadData release];
}

- (void) dealloc
{
    [super dealloc];
}


@end

