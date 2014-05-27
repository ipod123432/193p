//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Roger Zou on 05.26.14.
//  Copyright (c) 2013 m2m server software gmbh. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

@property (nonatomic, strong) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mode;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (nonatomic, strong) NSMutableArray *pastMoves;
@property (weak, nonatomic) IBOutlet UISlider *historySlider;

@end

@implementation CardGameViewController

- (IBAction)slideChanged:(UISlider *)sender {
    int discreteVal = round([sender value]); //round
    [sender setValue:(float)discreteVal];
    self.resultLabel.text = self.pastMoves[discreteVal];
    self.resultLabel.alpha = 0.6;
}

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
    }
    return _game;
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)modeChange:(id)sender {
    int mode = [(UISegmentedControl *)sender selectedSegmentIndex];
    self.game.mode = mode + 2;
}

- (IBAction)dealNow:(id)sender {
    // loads alert confirm, which will handle actions
    UIAlertView *dealAlert = [[UIAlertView alloc]initWithTitle:@"Redeal" message:@"Confirm redeal?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"redeal", @"cancel", nil];
    dealAlert.cancelButtonIndex = 1; //set cancel as cancel
    // tag for identification when handling
    dealAlert.tag = 1;
    [dealAlert show];
}

// Handles confirmation window for Deal
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // tag indicates is Redeal alert
    if (alertView.tag == 1)
    {
        if (buttonIndex == [alertView cancelButtonIndex])
        {
            //cancel clicked, nothing happen
        } else {
            //redeal
            self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[self createDeck]];
            self.mode.enabled = YES;
            self.resultLabel.text = @"";
            self.pastMoves = [NSMutableArray arrayWithObject:@""];
            self.game.mode = [self.mode selectedSegmentIndex] + 2;
            [self updateUI];

        }
    }
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    self.mode.enabled = NO;
    int cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        int cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle:[self titleForCard:card]
                    forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.matched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    if (self.game) {
        NSString *description = @"";
        if ([self.game.lastCards count])
        {
            NSMutableArray *cardContents =  [NSMutableArray array];
            for (Card *card in self.game.lastCards)
            {
                [cardContents addObject:card.contents];
            }
            description = [cardContents componentsJoinedByString:@" "];
        }
        if (self.game.lastScore > 0) {
            description = [NSString stringWithFormat:@"Matched %@ for %d points.", description, self.game.lastScore];
        } else if (self.game.lastScore < 0) {
            description = [NSString stringWithFormat:@"%@ don't match. %d point penalty.", description, -self.game.lastScore];
        }
        self.resultLabel.text = description;
        [self.pastMoves addObject: description];
        self.historySlider.maximumValue = [self.pastMoves count]-1;
        self.historySlider.value = self.historySlider.maximumValue;
        self.resultLabel.alpha = 1;
    }
}

-(NSMutableArray *)pastMoves
{
    if (!_pastMoves) _pastMoves = [NSMutableArray arrayWithObject:@""];
    return _pastMoves;
}

- (NSString *)titleForCard:(Card *)card
{
    return card.chosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.chosen ? @"cardfront" : @"cardback"];
}

@end
