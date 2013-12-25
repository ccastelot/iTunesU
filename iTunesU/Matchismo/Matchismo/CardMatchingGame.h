//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Chris Castelot on 12/22/13.
//  Copyright (c) 2013 Chris Castelot. All rights reserved.
//

#import "Deck.h"

@interface CardMatchingGame : NSObject

//designated initializer
-(instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck *)deck;

-(void)chooseCardAtIndex:(NSUInteger)index;

-(Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;

@end
