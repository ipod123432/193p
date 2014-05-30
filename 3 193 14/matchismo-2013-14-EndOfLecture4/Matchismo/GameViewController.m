//
//  GameViewController.m
//  Matchismo
//
//  Created by Roger on 5/27/14.
//  Copyright (c) 2014 m2m server software gmbh. All rights reserved.
//

#import "GameViewController.h"
#import "HistoryViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController

- (IBAction)slideChanged:(UISlider *)sender {
    int discreteVal = round([sender value]); //round
    [sender setValue:(float)discreteVal];
    if ([self.pastMoves[discreteVal] isKindOfClass:[NSString class]])
    {
        self.resultLabel.text = self.pastMoves[discreteVal];
    } else if ([self.pastMoves[discreteVal] isKindOfClass:[NSAttributedString class]]) {
        self.resultLabel.attributedText = self.pastMoves[discreteVal];
    }
    self.resultLabel.alpha = 0.6;
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

- (void)changeResultLabelAndStoreResult
{
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
    if (self.game) {
        [self changeResultLabelAndStoreResult];
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
            if (self.mode)
            {
                self.game.mode = [self.mode selectedSegmentIndex] + 2;
            }
            [self updateUI];
            
        }
    }
}


- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
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
    if ([segue.identifier isEqualToString:@"historyID"])
    {
     //   HistoryViewController *vc = [segue destinationViewController];
      //  vc.history = self.pastMoves;
        [segue.destinationViewController setHistory:self.pastMoves];
    }
}

@end
