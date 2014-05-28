//
//  SetCard.m
//  Matchismo
//
//  Created by Roger on 5/27/14.
//  Copyright (c) 2014 m2m server software gmbh. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

@synthesize color = _color;
@synthesize shape = _shape;
@synthesize shading = _shading;
@synthesize rank = _rank;

-(void)setColor:(NSString *)color
{
    if ([[SetCard validColors] containsObject:color])
    {
        _color = color;
    }
}
-(NSString *)color
{
    return _color ? _color : @"?";
}
-(void)setShape:(NSString *)shape
{
    if ([[SetCard validShapes] containsObject:shape])
    {
        _shape = shape;
    }
}
-(NSString *)shape
{
    return _shape ? _shape : @"?";
}
-(void)setShading:(NSString *)shading
{
    if ([[SetCard validShadings] containsObject:shading])
    {
        _shading = shading;
    }
}
-(NSString *)shading
{
    return _shading ? _shading : @"?";
}
-(void)setRank:(NSUInteger)rank
{
    if ([[SetCard rankStrings] containsObject:[NSString stringWithFormat:@"%d",rank]])
    {
        _rank = rank;
    }
}
-(NSUInteger)rank
{
    return _rank ? _rank : -404;
}

+(NSArray *)validColors
{
    return @[@"red",@"green",@"blue"];
}
//▲ ● ■
+(NSArray *)validShapes
{
    return @[@"triangle",@"circle",@"square"];
}
+(NSArray *)validShadings
{
    return @[@"solid",@"striped",@"empty"];
}
+(NSArray *)rankStrings
{
    return @[@"1",@"2",@"3"];
}
+(NSUInteger)maxRank
{
    return [[self rankStrings]count];
}

@end
