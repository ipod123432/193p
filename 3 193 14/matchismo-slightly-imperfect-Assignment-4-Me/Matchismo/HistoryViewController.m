//
//  HistoryViewController.m
//  Matchismo
//
//  Created by Roger on 5/30/14.
//  Copyright (c) 2014 m2m server software gmbh. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textbox;

@end

@implementation HistoryViewController

@synthesize history = _history;

-(NSMutableArray *)history
{
    if (!_history) _history = [NSMutableArray arrayWithObject:@""];
    return _history;
}
-(void)setHistory:(NSMutableArray *)history
{
    _history = history;
    if (self.view.window) [self updateUI];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)updateUI
{
    NSString *hold = @"";
    NSMutableAttributedString *attrhold = [[NSMutableAttributedString alloc]initWithString:@""];
    for (id move in self.history) {
        if ([move isKindOfClass:[NSString class]])
        {
            hold = [hold stringByAppendingString:move];
            hold = [hold stringByAppendingString:@"\n"];
        } else if ([move isKindOfClass:[NSAttributedString class]]) {
            [attrhold appendAttributedString:move];
            [attrhold appendAttributedString:([[NSAttributedString alloc]initWithString:@"\n"])];
        }
    }
    // means nothing in attributed string, no changes
    if ([attrhold isEqualToAttributedString: [[NSMutableAttributedString alloc]initWithString:@""]]) {
        self.textbox.text = hold;
    } else {
        self.textbox.attributedText = attrhold;
    }

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
