//
//  ViewController.m
//  FDQuartz2DGradualChange
//
//  Created by 徐忠林 on 13/01/2017.
//  Copyright © 2017 Feyddy. All rights reserved.
//

#import "ViewController.h"
#import "FDGradualChangeView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    FDGradualChangeView *view = [[FDGradualChangeView alloc] initWithFrame:self.view.frame];
    
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
