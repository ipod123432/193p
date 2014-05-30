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


@interface CardGameViewController : UIViewController

//assignment 3 #1
@property (strong, nonatomic) NSString *type;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mode;

//protected
//for subclasses
- (Deck *)createDeck; //abstract

@end
