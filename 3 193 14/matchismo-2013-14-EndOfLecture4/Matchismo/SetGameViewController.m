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

// useless actually
- (NSInteger)shadingToFloat:(NSString *)shading
{
    NSDictionary *dict = @{
                           @"solid" : @1.0,
                           @"striped" : @0.7,
                           @"empty" : @0.3
                           };
    return [dict[shading]floatValue];
}
- (NSDictionary *)shadingToDict:(NSString *)shading withAttr:(NSDictionary *)attr
{
    NSDictionary*dict = @{
                          @"solid" : @{NSStrokeWidthAttributeName : @-5},
                          @"striped" : @{NSStrokeWidthAttributeName : @-5, NSStrokeColorAttributeName : attr[NSForegroundColorAttributeName],
                                         NSForegroundColorAttributeName : [attr[NSForegroundColorAttributeName] colorWithAlphaComponent:0.1]
                                         },
                          @"open" : @{NSStrokeWidthAttributeName : @5}
                          };
    return dict[shading];
}

- (NSAttributedString *)attributedTitleForCard:(Card *)card
{
    if ([card isKindOfClass:[SetCard class]]) {
        SetCard *newCard = (SetCard *)card;
        NSMutableString *atstr = [[NSMutableString alloc]initWithString:@""];
        for (int rank = newCard.rank; rank > 0; rank--) {
            [atstr appendString:[self shapeToShape: newCard.shape]];
        }
        NSMutableDictionary* attr = [NSMutableDictionary dictionaryWithDictionary:@{NSForegroundColorAttributeName:
                                    ([self colorStringToUIColor:newCard.color])
                                      }];
        [attr addEntriesFromDictionary:[self shadingToDict:newCard.shading withAttr:attr]];
        return [[NSAttributedString alloc]
                initWithString:atstr
                attributes: attr];
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

- (void)updateUI
{
    [super updateUI];
    self.game.mode = 3;
}

- (void)changeResultLabelAndStoreResult
{
    NSMutableAttributedString *desc = [[NSMutableAttributedString alloc]initWithString:@""];
    if ([self.game.lastCards count])
    {
        for (Card *card in self.game.lastCards)
        {
            [desc appendAttributedString:[self attributedTitleForCard:card]];
            [desc appendAttributedString:([[NSAttributedString alloc]initWithString:@" "])];
        }
        if (self.game.lastScore > 0) {
            [desc appendAttributedString:([[NSAttributedString alloc]initWithString:[NSString stringWithFormat: @"matched for %d points.", self.game.lastScore]])];
        } else if (self.game.lastScore < 0) {
            [desc appendAttributedString:([[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"don't match. %d point penalty.", -self.game.lastScore]])];
        }
        self.resultLabel.attributedText = desc;
        [self.pastMoves addObject:desc];
    }
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.chosen ? @"setfront" : @"cardfront"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Set uses 3 cards so put into 3 card mode
    //self.game.mode = 3;
    // nil b/c no segmented control with Set, only 3 card mode
    //self.mode = nil;
    [self updateUI];
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
