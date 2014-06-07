//
//  GameViewController.m
//  Matchismo
//
//  Created by Roger on 5/27/14.
//  Copyright (c) 2014 m2m server software gmbh. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController

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
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
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
            self.game.gameType = [self myGameType];
            self.mode.enabled = YES;
            //self.resultLabel.text = @"";
            //self.pastMoves = [NSMutableArray arrayWithObject:@""];
            if (self.mode)
            {
                self.game.mode = [self.mode selectedSegmentIndex] + 2;
            }
            [self updateUI];
        }
    }
}


- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        int cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        
        if ([self attributedTitleForCard:card])
        {
            [cardButton setAttributedTitle:[self attributedTitleForCard:card] forState:UIControlStateNormal];
        } else {
            [cardButton setTitle:[self titleForCard:card]
                        forState:UIControlStateNormal];
        }
        
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.matched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (NSString *)titleForCard:(Card *)card
{
    return card.chosen ? card.contents : @"";
}

- (NSAttributedString *)attributedTitleForCard:(Card *)card
{
    // to be overridden
    return nil;
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.chosen ? @"cardfront" : @"cardback"];
}


- (IBAction)touchCardButton:(UIButton *)sender
{
    self.mode.enabled = NO;
    int cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}

- (NSString *)myGameType
{
    // to be overridden
    return nil;
}

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
        _game.gameType = [self myGameType];
    }
    return _game;
}


-(Deck *)createDeck
{
    return nil;
    //should be overridden
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
