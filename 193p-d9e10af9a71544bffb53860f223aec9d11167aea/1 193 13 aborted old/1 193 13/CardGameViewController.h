//
//  CardGameViewController.h
//  1 193 13
//
//  Created by Roger on 11/27/13.
//  Copyright (c) 2013 fleija. All rights reserved.
//

//abstract classes

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController : UIViewController

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *moveDescriptionLabel;

- (void) updateUI;



//protected
//for subclasses
- (Deck *)createDeck; //abstract
- (NSAttributedString *)titleForCard:(Card *)card; //abstract
- (UIImage *)backgroundImageForCard:(Card *)card; //abstract


@end
