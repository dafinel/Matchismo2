//
//  SettingsViewController.m
//  Matchismo
//
//  Created by Andrei-Daniel Anton on 18/07/14.
//  Copyright (c) 2014 Andrei-Daniel Anton. All rights reserved.
//

#import "SettingsViewController.h"
#import "GameSettings.h"

@interface SettingsViewController ()
@property (nonatomic, weak  ) IBOutlet UISlider *mathBonusSlider;
@property (nonatomic, weak  ) IBOutlet UISlider *mismathPenalitySlider;
@property (nonatomic, weak  ) IBOutlet UISlider *costToChooseSlider;
@property (nonatomic ,strong) GameSettings *gameSettings;
@end

@implementation SettingsViewController

#pragma mark - IBAction

- (IBAction)mathBonusSliderAction:(UISlider *)sender {
    self.gameSettings.mathBonus = (int)sender.value;
}

- (IBAction)mismathPenalitySliderAction:(UISlider *)sender {
    self.gameSettings.mathPenality = (int)sender.value;
}

- (IBAction)costToChoseSliderAction:(UISlider *)sender {
    self.gameSettings.flipCost = (int)sender.value;
}

#pragma mark - Initialization

- (GameSettings *)gameSettings
{
    if (!_gameSettings) _gameSettings = [[GameSettings alloc] init];
    return _gameSettings;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.mathBonusSlider.value = self.gameSettings.mathBonus;
    self.mismathPenalitySlider.value = self.gameSettings.mathPenality;
    self.costToChooseSlider.value = self.gameSettings.flipCost;
    
}


@end
