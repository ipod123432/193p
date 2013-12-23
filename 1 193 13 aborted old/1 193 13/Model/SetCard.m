//
//  SetCard.m
//  1 193 13
//
//  Created by Roger on 11/29/13.
//  Copyright (c) 2013 fleija. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard


-(instancetype) init
{
    self = [super init];
    if (self)
    {
        self.numberOfMatchingCards = 3;
    }
    return self;
}
-(int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == self.numberOfMatchingCards - 1)
    {
        int numMatch = 0;
        int symMatch = 0;
        int shaMatch = 0;
        int colMatch = 0;
        for (SetCard *otherCard in otherCards)
        {
            if ( self.number == otherCard.number )
            {
                numMatch++;
            }
            if ( [self.symbol isEqualToString:otherCard.symbol])
            {
                symMatch++;
            }
            if ( [self.shading isEqualToString:otherCard.shading])
            {
                shaMatch++;
            }
            if ( [self.color isEqualToString:otherCard.color])
            {
                colMatch++;
            }
        }
        if (!(numMatch % 2 || symMatch % 2 || shaMatch % 2 || colMatch % 2))
        {
        
            score += 5;
        }
    }
    return score;
}

-(NSString *)contents
{
    //return [NSString stringWithFormat:@"%@ %@ %@ %d ", self.symbol, self.color, self.shading, self.number];
    //return nil;
    
    
    //solutions
    
        return [NSString stringWithFormat:@"%@:%@:%@:%d", self.symbol, self.color, self.shading, self.number];
    
}

- (void)setNumber:(NSUInteger)number
{
    if (number <= [SetCard maxNumber]) _number = number;
}
- (void)setSymbol:(NSString *)symbol
{
    if ([[SetCard validSymbols] containsObject:symbol]) {
        
        _symbol = symbol;
    } else {
        _symbol = @"?";

    }
}
- (void)setColor:(NSString *)color
{
    if ([[SetCard validColors] containsObject:color]) {
        _color = color;
    } else {
        _color = @"?";
    }
}
- (void)setShading:(NSString *)shading
{
    if ([[SetCard validShadings] containsObject:shading]){
        
        _shading = shading;
    } else {
        _shading = @"?";
    }
}

+(NSArray *)validNumbers
{
    return @[@1, @2, @3];
}
+(NSArray *)validSymbols
{
    return @[@"open", @"striped", @"empty"];
}
//@"▲", @"●", @"■"
+(NSArray *)validColors
{
    return @[@"red", @"green", @"blue"];
}
+(NSArray *)validShadings
{
    return @[@"empty", @"striped", @"filled"];
}
+(NSUInteger)maxNumber
{
    return [[SetCard validNumbers] count];
}
































@end
