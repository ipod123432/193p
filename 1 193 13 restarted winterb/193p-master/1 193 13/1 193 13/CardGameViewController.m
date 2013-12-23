//
//  CardGameViewController.m
//  1 193 13
//
//  Created by Roger on 11/27/13.
//  Copyright (c) 2013 fleija. All rights reserved.
//

#import "CardGameViewController.h"
//#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
//#import "Deck.h"

@interface CardGameViewController ()
/* deleted in lecture 3
 @property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) Deck *deck; */

@property (weak, nonatomic) IBOutlet UILabel *moveDescriptionLabel;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mode;

@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc]initWithCardCount: [self.cardButtons count]                                                         usingDeck:[self createDeck]];
    return _game;
}


 -(Deck *)createDeck //abstract
 {
     return nil;
     //return [[PlayingCardDeck alloc]init];
 }

- (void) updateUI
{
    for (UIButton *cardButton in self.cardButtons)
    {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
       
        
    }
     self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.moveDescriptionLabel.text = self.game.resultDescription;
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}



- (IBAction)dealBitch {
    self.game = nil;
    self.mode.enabled = YES;
    
    [self updateUI];
    self.moveDescriptionLabel.text = @"Reset";
}

- (IBAction)touchCardButton:(UIButton *)sender {
    /* deleted in lecture 3, replaced
     if ([sender.currentTitle length])
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"]
                          forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    } else {
        Card *randomCard = [self.deck drawRandomCard];
        if (randomCard)
        {
            [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]
                              forState:UIControlStateNormal];
            [sender setTitle:[NSString stringWithFormat:@"%@", randomCard.contents] forState:UIControlStateNormal];
    
        }
    } */
    //changed from int to NSUInt
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    self.game.mode = [self.mode selectedSegmentIndex] + 2;
    self.mode.enabled = NO;
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
    // del in lec 3       self.flipCount++;
}




/*
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self touchCardButton:self.cardButton];
    [self touchCardButton:self.cardButton];
    self.flipCount = 0;
    
    
    // careful technically already 2 flips, 1 card went thru
}
*/


/* my version
 -(Deck *)daDeck
 {
 if (!_daDeck) _daDeck = [[PlayingCardDeck alloc]init];
 return _daDeck;
 
 }
 */
// cs193p version

/* LOLJK deleted in lecture 3 anyway
 -(Deck *)deck
 {
 if (!_deck) _deck = [self createDeck];
 return _deck;
 }
 
 
 
 -(void) setFlipCount:(int)flipCount
 {
 _flipCount = flipCount;
 self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
 } */

@end
