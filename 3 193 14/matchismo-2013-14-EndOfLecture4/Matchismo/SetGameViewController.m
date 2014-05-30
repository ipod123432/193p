//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Roger on 5/27/14.
//  Copyright (c) 2014 m2m server software gmbh. All rights reserved.
//

#import "SetGameViewController.h"

@interface SetGameViewController ()

@end

@implementation SetGameViewController

- (Deck *)createDeck
{
    return [[SetCardDeck alloc]init];
}

- (UIColor *)colorStringToUIColor:(NSString *)color
{
    NSDictionary *dict = @{
      @"red" : [UIColor redColor],
      @"green" : [UIColor greenColor],
      @"blue" : [UIColor blueColor]
      };
    return dict[color];
}

- (NSString *)shapeToShape:(NSString *)shape
{
    NSDictionary *dict = @{
                           @"oval" : @"●",
                           @"diamond" : @"▲",
                           @"squiggle" : @"■"
                           };
    return dict[shape];
}

- (NSInteger)shadingToFloat:(NSString *)shading
{
    NSDictionary *dict = @{
                           @"solid" : @1.0,
                           @"striped" : @0.7,
                           @"empty" : @0.3
                           };
    return [dict[shading]floatValue];
}

- (NSAttributedString *)attributedTitleForCard:(Card *)card
{
    if ([card isKindOfClass:[SetCard class]]) {
        SetCard *newCard = (SetCard *)card;
        NSMutableString *atstr = [[NSMutableString alloc]initWithString:@""];
        for (int rank = newCard.rank; rank > 0; rank--) {
            [atstr appendString:[self shapeToShape: newCard.shape]];
        }
        return [[NSAttributedString alloc]
                initWithString:atstr
                attributes: @{NSForegroundColorAttributeName:
                    ([[self colorStringToUIColor:newCard.color] colorWithAlphaComponent:[self shadingToFloat: newCard.shading]])
                              }];
        // to be replaced later
        //return [[NSAttributedString alloc]initWithString:newCard.contents];
    } else {
        return nil;
    }
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Set uses 3 cards so put into 3 card mode
    self.game.mode = 3;
    // nil b/c no segmented control with Set, only 3 card mode
    self.mode = nil;
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
