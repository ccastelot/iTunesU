//
//  PlayingCard.h
//  Matchismo
//
//  Created by Chris Castelot on 12/19/13.
//  Copyright (c) 2013 Chris Castelot. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+(NSArray *)validSuits;
+(NSUInteger)maxRank;
@end
