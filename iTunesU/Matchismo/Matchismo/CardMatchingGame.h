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

//-(void)resetPreviouslyChosenCards:(Card *)currentCard;

//This is for determinining the number of cards to match
typedef NS_ENUM(NSInteger, cardMatchMode) {
    MatchTwo,
    MatchThree
};

@property (nonatomic) cardMatchMode matchMode;

-(void)resetCardsToMatch:(BOOL)reset;

@property (nonatomic, strong, readonly) NSMutableString *matchResults;

@end
