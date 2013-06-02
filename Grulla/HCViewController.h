//
//  HCViewController.h
//  Grulla
//
//  Created by Franco Cedillo on 5/18/13.
//  Copyright (c) 2013 HartasCuerdas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property NSArray *fruits;
@property NSDictionary *alphabetizedFruits;
@end
