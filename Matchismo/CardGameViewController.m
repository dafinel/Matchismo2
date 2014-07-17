//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Andrei-Daniel Anton on 07/07/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "HistoryViewController.h"
#import "GameResult.h"

static const int kSegmentedControlID = 100;

@interface CardGameViewController ()

@property (nonatomic, strong) Deck *deck;
@property (nonatomic, strong) CardMatchingGame *game;
@property (nonatomic, weak  ) IBOutlet UILabel *scoreLabel;
@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (nonatomic        ) BOOL enable;
@property (nonatomic, weak  ) IBOutlet UILabel *stringLabel;
@property (nonatomic, strong) NSMutableArray *flipsHistory;
@property (nonatomic, weak  ) IBOutlet UISlider *slideHistory;
@property (strong, nonatomic) GameResult *gameResult;

@end

@implementation CardGameViewController

#pragma mark - Initialization

- (GameResult *)gameResult{
    if (!_gameResult) _gameResult = [[GameResult alloc] init];
    _gameResult.gameType = self.gameType;
    return _gameResult;
}

- (NSMutableArray *)flipsHistory {
    if(!_flipsHistory) {
        _flipsHistory = [[NSMutableArray alloc]init];
    }
    return _flipsHistory;
}

- (CardMatchingGame *)game {
    if(!_game) {
        _game=[[CardMatchingGame alloc]initWithCardCount:[self.cardButtons count]
                                               usingDeck:[self createDeak]];
    }
    return _game;
}
- (Deck *)createDeak{
    
    return nil;
}

#pragma mark - IBActions

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Show History"]) {
        if ([segue.destinationViewController isKindOfClass:[HistoryViewController class]]) {
            HistoryViewController *historyViewController = (HistoryViewController *)segue.destinationViewController;
            historyViewController.history = self.flipsHistory;
        }
    }
}

- (IBAction)slideAction:(UISlider *)sender {
    int slideValue = sender.value;
    self.stringLabel.text = [[self.flipsHistory objectAtIndex:slideValue] string];
}

- (IBAction)redealAction:(UIButton *)sender {
    UISegmentedControl *segControl = (UISegmentedControl*)[self.view viewWithTag:kSegmentedControlID];
    [segControl setEnabled:YES];
    [self.game setNewScore:0];
    [self.game unchooseCards];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",self.game.score];
    self.stringLabel.text = @"Play again";
    
    for(UIButton *cardButton in self.cardButtons){
        cardButton.enabled = YES;
        [cardButton setTitle:[self titleForCard:nil] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backGroundImageForCard:nil] forState:UIControlStateNormal];
    }
    
    _game = [[CardMatchingGame alloc]initWithCardCount:[self.cardButtons count]
                                             usingDeck:[self createDeak]];
    
    [self.flipsHistory removeAllObjects];
    self.slideHistory.maximumValue = 1;
    [self.slideHistory setValue:0];
    self.slideHistory.enabled = NO;
    self.gameResult = nil;
}

- (IBAction)touchCardButton:(UIButton *)sender {
   
    self.slideHistory.enabled = YES;
    int chooseButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chooseButtonIndex];
    [self updateUI];
}

- (void)updateUI {
    for(UIButton *cardButton in self.cardButtons){
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backGroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled =! card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",self.game.score];
        self.gameResult.score = self.game.score;
        self.stringLabel.text = [self.game.rezult string];
        
    }
    [self.flipsHistory addObject:self.game.rezult];
    self.slideHistory.maximumValue = [self.flipsHistory count]-1;
    [self.slideHistory setValue:[self.flipsHistory count]-1 animated:NO];
}

#pragma mark - Getters

- (NSString *)titleForCard:(Card *)card {
    return card.isChosen ? [card.contents string]: @"";
}

- (UIImage *) backGroundImageForCard : (Card *)card {
    return [UIImage imageNamed: card.isChosen ? @"frontcard" : @"backcard"];
}

#pragma mark - Functions

- (void)setNumberOfCardsForGame:(NSUInteger)nr {
    self.game.numberOfCards = nr;
}

@end
