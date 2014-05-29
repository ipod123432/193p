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

// convert color copied from stack overflow
-(UIColor *)colorConvert:(NSString *)color withShading:(NSString *)shading
{
    NSString *colorColor = [color stringByAppendingString:@"Color"];
    UIColor *bicol = nil;
    SEL selColor = NSSelectorFromString(colorColor);
    if ([UIColor respondsToSelector:selColor] == YES)
    {
        bicol = [UIColor performSelector:selColor];
        bicol = [bicol colorWithAlphaComponent:[SetCard shadingToCGFloat:shading]];
    }
    return bicol;
}


- (NSAttributedString *)attributedTitleForCard:(Card *)card
{
    if (card.chosen) {
        if ([card isKindOfClass:[SetCard class]]) {
            SetCard *sCard = (SetCard *)card;
            
            // shading color shape rank
            NSMutableAttributedString *title = [NSMutableAttributedString new];
            NSDictionary *attributes = @{@"NSForegroundColorAttributeName":[self colorConvert:sCard.color withShading:sCard.shading],
                                         };
            for (int i = [sCard.rank intValue]; i > 0; i--) {
                NSMutableAttributedString *dastring = [[NSMutableAttributedString alloc]initWithString:[SetCard shapeStrings][sCard.shape] attributes:attributes];
                [title appendAttributedString:dastring];
            }
            return title;
        }
        return nil;
    } else {
        return [[NSAttributedString alloc]initWithString:@""];
    }
}
- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.chosen ? @"cardfront" : @"cardback"];
}

// oh I need to modify card.contents? nah
-(void)updateUI
{
    [super updateUI];
    for (UIButton *cardButton in self.cardButtons) {
        int cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setAttributedTitle:[self attributedTitleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.matched;
    }
    
    
    if (self.game) {
        NSMutableAttributedString *descrption = [[NSMutableAttributedString alloc]initWithString:@""];
        NSMutableAttributedString *resdes = [[NSMutableAttributedString alloc]initWithString:@""];
        if ([self.game.lastCards count])
        {
            for (Card *cdd in self.game.lastCards)
            {
                if ([cdd isKindOfClass:[SetCard class]])
                {
                    SetCard *card = (SetCard *)cdd;
                    NSAttributedString *space = [[NSAttributedString alloc]initWithString:@""];
                    NSAttributedString *cardatts = [self attributedTitleForCard:card];
                    [descrption appendAttributedString:cardatts];
                    [descrption appendAttributedString:space];
                }
            }
            if (self.game.lastScore > 0) {
                [resdes appendAttributedString:([[NSAttributedString alloc] initWithString:@"Matched "])];
                [resdes appendAttributedString:descrption];
                [resdes appendAttributedString:([[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"for %d points.", self.game.lastScore]])];
            } else if (self.game.lastScore < 0) {
                [resdes appendAttributedString:descrption];
                [resdes appendAttributedString:([[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"don't match. %d point penalty.", -self.game.lastScore]])];
            }
            self.resultLabel.attributedText = resdes;
            [self.pastMoves addObject:resdes];
            self.historySlider.maximumValue = [self.pastMoves count]-1;
            self.historySlider.value = self.historySlider.maximumValue;
            self.resultLabel.alpha = 1;
        }
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
    
    // cuz it's Set. Needs to be modified so not default 2 lol.
    self.game.mode = 3;
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
