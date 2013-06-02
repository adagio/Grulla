//
//  HCViewController.m
//  Grulla
//
//  Created by Franco Cedillo on 5/18/13.
//  Copyright (c) 2013 HartasCuerdas. All rights reserved.
//

#import "HCViewController.h"

@interface HCViewController ()

@end

@implementation HCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.fruits = @[@"Apple", @"Pineapple", @"Orange", @"Banana", @"Pear", @"Kiwi", @"Strawberry", @"Mango", @"Walnut", @"Apricot", @"Tomato", @"Almond", @"Date", @"Melon", @"Water Melon", @"Lemon", @"Blackberry", @"Coconut", @"Fig", @"Passionfruit", @"Star Fruit"];
    self.alphabetizedFruits = [self alphabetizeFruits:self.fruits];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSArray *keys = [self.alphabetizedFruits allKeys];
    return [keys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *unsortedKeys = [self.alphabetizedFruits allKeys];
    NSArray *sortedKeys = [unsortedKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSString *key = [sortedKeys objectAtIndex:section];
    NSArray *fruitsForSection = [self.alphabetizedFruits objectForKey:key];
    return [fruitsForSection count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell Identifier";
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // Fetch Fruit
    NSArray *unsortedKeys = [self.alphabetizedFruits allKeys];
    NSArray *sortedKeys = [unsortedKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSString *key = [sortedKeys objectAtIndex:[indexPath section]];
    NSArray *fruitsForSection  = [self.alphabetizedFruits objectForKey:key];
    NSString *fruit = [fruitsForSection objectAtIndex:[indexPath row]];
    [cell.textLabel setText:fruit];
    return cell;
}

- (NSDictionary *)alphabetizeFruits:(NSArray *)fruits {
    NSMutableDictionary *buffer = [[NSMutableDictionary alloc] init];
    // Put Fruits in Sections
    for (int i = 0; i < [fruits count]; i++) {
        NSString *fruit = [fruits objectAtIndex:i];
        NSString *firstLetter = [[fruit substringToIndex:1] uppercaseString];
        if ([buffer objectForKey:firstLetter]) {
            [(NSMutableArray *)[buffer objectForKey:firstLetter] addObject:fruit];
        } else {
            NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithObjects:fruit, nil];
            [buffer setObject:mutableArray forKey:firstLetter];
        }
    }
    // Sort Fruits
    NSArray *keys = [buffer allKeys];
    for (int j = 0; j < [keys count]; j++) {
        NSString *key = [keys objectAtIndex:j];
        [(NSMutableArray *)[buffer objectForKey:key] sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }
    NSDictionary *result = [NSDictionary dictionaryWithDictionary:buffer];
    return result;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSArray *keys = [[self.alphabetizedFruits allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSString *key = [keys objectAtIndex:section];
    return key;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Fetch Fruit
    NSArray *unsortedKeys = [self.alphabetizedFruits allKeys];
    NSArray *sortedKeys = [unsortedKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSString *key = [sortedKeys objectAtIndex:[indexPath section]];
    NSArray *fruitsForSection = [self.alphabetizedFruits objectForKey:key];
    NSString *fruit = [fruitsForSection objectAtIndex:[indexPath row]];
    NSLog(@"Fruit Selected > %@", fruit);
}

@end
