//
//  ScoreViewController.m
//  Matchismo
//
//  Created by Roger on 5/30/14.
//  Copyright (c) 2014 m2m server software gmbh. All rights reserved.
//

#import "ScoreViewController.h"

@interface ScoreViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textbox;

@end

@implementation ScoreViewController

//[[NSUserDefaults standardUserDefaults]arrayForKey:@"scores"];

- (void)updateUI
{
    NSDictionary *scores = [[NSUserDefaults standardUserDefaults]dictionaryForKey:@"scores"];
    NSArray *vals = [scores allValues];
    NSString *hold = @"";
    //NSMutableAttributedString *attrhold = [[NSMutableAttributedString alloc]initWithString:@""];
    for (NSString *val in vals) {
        hold = [hold stringByAppendingString:val];
        hold = [hold stringByAppendingString:@"\n"];
    }
    
    //for (NSDictionary *dict in scores) {
      //  NSString *result = [[dict allValues]firstObject];
        //if ([result isKindOfClass:[NSString class]])
        //{
          //  hold = [hold stringByAppendingString:result];
            //hold = [hold stringByAppendingString:@"\n"];
            //[attrhold appendAttributedString:([[NSAttributedString alloc]initWithString:hold])];
            //hold = @"";
        //}
        //else if ([result isKindOfClass:[NSAttributedString class]]) {
            //[attrhold appendAttributedString:move];
            //[attrhold appendAttributedString:([[NSAttributedString alloc]initWithString:@"\n"])];
        //}
    
   // }
    self.textbox.text = hold;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
