//
//  GameViewController.h
//  Matchismo
//
//  Created by Roger on 5/27/14.
//  Copyright (c) 2014 m2m server software gmbh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"


@interface GameViewController : UIViewController

@property (nonatomic, strong) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mode;

- (Deck *)createDeck;
- (NSString *)titleForCard:(Card *)card;
- (NSAttributedString *)attributedTitleForCard:(Card *)card;
- (void)updateUI;
- (UIImage *)backgroundImageForCard:(Card *)card;
- (NSString *)myGameType;

@end
