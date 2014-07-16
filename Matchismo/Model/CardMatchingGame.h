//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Andrei-Daniel Anton on 08/07/14.
//  Copyright (c) 2014 Andrei-Daniel Anton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, strong  ) NSMutableAttributedString *rezult;
@property (nonatomic          ) NSUInteger numberOfCards;

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;
- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
- (void)setNewScore:(NSInteger)newScore;
- (void)unchooseCards;

@end
