//
//  SetCard.m
//  Matchismo
//
//  Created by Andrei-Daniel Anton on 15/07/14.
//  Copyright (c) 2014 Andrei-Daniel Anton. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

+ (NSArray *)validSymbols {
    return @[@"diamond", @"squiggle", @"oval"];
}

+ (NSArray *)validShadings {
    return @[@"solid", @"striped", @"open"];
}

+ (NSArray *)validColors {
    return @[@"red", @"green", @"purple"];
}

- (int)match:(NSArray *)othercards {
    int score = 0;
    int numberOfSymbol = 0;
    int numberOfShade = 0;
    int numberOfColor = 0;
    int numberOfNumber = 0;
    if ([othercards count] == 3) {
        for (SetCard *otherCard in othercards) {
            numberOfSymbol += [[SetCard validSymbols] indexOfObject: [otherCard.symbol string]];
            numberOfNumber += otherCard.rank;
            
            
            UIColor *symbolColor = [otherCard.symbol attribute:NSForegroundColorAttributeName atIndex:0 effectiveRange:nil];
            CGFloat alpha = 0;
            [symbolColor getHue:nil
                     saturation:nil
                     brightness:nil
                          alpha:&alpha];
            if (alpha == 0) {
                numberOfShade += 1;
            } else if (alpha == 0.5) {
                 numberOfShade += 2;
            } else {
                 numberOfShade += 3;
            }
            if (symbolColor == [UIColor redColor]) {
                numberOfColor += 1;
            } else if(symbolColor == [UIColor greenColor]) {
                 numberOfColor += 2;
            } else if (symbolColor == [UIColor purpleColor]) {
                numberOfColor += 3;
            }
        }
        if ((numberOfSymbol %3 == 0)&&(numberOfShade %3 == 0)&&
            (numberOfNumber %3 == 0)&&(numberOfColor %3 == 0)) {
                score = 1;
        }
    }
    return score;
}

- (NSString *)contents {
    NSAttributedString *text = [[NSAttributedString alloc] initWithAttributedString: self.symbol];
    return [text string];
}

@end
