//
//  ViewWithText.m
//  RSSReaderNew
//
//  Created by Людмила on 11.10.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewWithText.h"


@implementation ViewWithText

@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
 
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void) setLabel:(NSString *) labelText AtPosition:(CGPoint) position WithAlignment:(UITextAlignment) alignment
{
    CGRect bounds=[[UIScreen mainScreen] applicationFrame];
    UILabel * lbl=[[UILabel alloc] initWithFrame:CGRectMake(position.x ,position.y,bounds.size.width-20,30)];
    [lbl setText:labelText];
    lbl.textAlignment=alignment;
    [self.view addSubview:lbl];
    [lbl release];
}

- (UITextField *) setTxtFieldAtPosition:(CGPoint) position WithPlaceHolder:(NSString *) placeholder AndKeyboardType:(UIKeyboardType) keyboardType
{
    CGRect bounds=[[UIScreen mainScreen] applicationFrame];
    UITextField * txtField=[[UITextField alloc] initWithFrame:CGRectMake(position.x ,position.y, bounds.size.width-20, 30)];
    txtField.textColor=[UIColor blackColor];
    txtField.placeholder=placeholder;
    txtField.backgroundColor=[UIColor whiteColor];
    txtField.borderStyle=UITextBorderStyleRoundedRect;
    txtField.keyboardType=keyboardType;
    txtField.returnKeyType=UIReturnKeyDone;
    txtField.clearButtonMode=UITextFieldViewModeAlways;
    txtField.delegate=self;
    [self.view  addSubview:txtField];
    [txtField release];
    return txtField;
}

- (void) showAlertViewErrorURL
{
    UIAlertView *alert=[[UIAlertView alloc]
                        initWithTitle:@"Ошибка при вводе"
                        message:@"Неправильный URL"
                        delegate:self
                        cancelButtonTitle:@"OK"
                        otherButtonTitles: nil];
    [alert show];
    [alert release];
}

- (void) btnOKClicked
{
    NSString *txtName=[txtFieldName text];
    NSString *txtLink=[txtFieldLink text];
    //NSError *error = NULL;	
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"https?://([-\\w\\.]+)+(:\\d+)?(/([\\w/_\\.]*(\\?\\S+)?)?)?" options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray * arrayRes = [regex matchesInString:txtLink options:0 range:NSMakeRange(0, [txtLink length])];
    if ([arrayRes count]!=1)
    {
        [self showAlertViewErrorURL];
        return;
    }
    NSTextCheckingResult *regRes=[arrayRes objectAtIndex:0];
    NSRange rngRes=[regRes range];
    if (rngRes.length!=[txtLink length] || rngRes.location!=0)
    {
        [self showAlertViewErrorURL];
        return;
    }
    [delegate FeedDidInput:txtName withLink:txtLink];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) btnCancelClicked
{
    NSLog(@"Cancel");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) setButtonWithTitle: (NSString *)title AtPosition:(CGPoint) position WithAction:(SEL) action
{
    UIButton * btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame=CGRectMake(position.x, position.y, 80, 30);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    
    CGRect bounds=[[UIScreen mainScreen] applicationFrame];
    [self setLabel:@"Название:" AtPosition:CGPointMake(10,20) WithAlignment:UITextAlignmentLeft];
    [self setLabel:@"URL:" AtPosition:CGPointMake(10,100) WithAlignment:UITextAlignmentLeft];
    txtFieldName=[self setTxtFieldAtPosition:CGPointMake(10,60) WithPlaceHolder:@"<Название>" AndKeyboardType:UIKeyboardTypeDefault];
    txtFieldLink=[self setTxtFieldAtPosition:CGPointMake(10,140) WithPlaceHolder:@"<URL>" AndKeyboardType:UIKeyboardTypeURL];
    [self setButtonWithTitle:@"OK" AtPosition:CGPointMake(30, 200) WithAction:@selector(btnOKClicked)];
    [self setButtonWithTitle:@"Отмена" AtPosition:CGPointMake(bounds.size.width-30-80, 200) WithAction:@selector(btnCancelClicked)];
    self.title=@"Новая лента";
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad
 {
 [super viewDidLoad];
 }
 */

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
