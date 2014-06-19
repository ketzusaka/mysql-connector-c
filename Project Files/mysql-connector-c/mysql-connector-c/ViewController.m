//
//  ViewController.m
//  mysql-connector-c
//
//  Created by James Richard on 6/18/14.
//  Copyright (c) 2014 James Richard. All rights reserved.
//

#import "ViewController.h"
#import "mysql.h"

#define CONNECTION_HOST "localhost"
#define CONNECTION_USER "root"
#define CONNECTION_PASS ""
#define CONNECTION_DB   "datasnippets"

@interface ViewController ()

@property (nonatomic) MYSQL *connection;
@property (nonatomic, copy) NSArray *tables;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.connection = mysql_init(NULL);
        MYSQL *connection = mysql_real_connect(self.connection, CONNECTION_HOST, CONNECTION_USER, CONNECTION_PASS, CONNECTION_DB, 3306, NULL, 0);
        
        if (connection) {
            [self buildTableList];
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to connect to MySQL" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil] show];
        }
    });
}

- (void)buildTableList {
    NSString *SQL = @"SHOW TABLES;";
    int status = mysql_real_query(self.connection, [SQL UTF8String], [SQL length]);
    
    if (status == 0) {
        MYSQL_RES *result = mysql_store_result(self.connection);
        
        if (result == NULL) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to list tables." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil] show];
            });
        } else {
            MYSQL_ROW row;
            
            NSMutableArray *tables = [[NSMutableArray alloc] init];
            while ((row = mysql_fetch_row(result))) {
                char *charData = row[0];
                NSString *stringData = [[NSString alloc] initWithCString:charData encoding:NSUTF8StringEncoding];
                [tables addObject:stringData];
            }
            
            mysql_free_result(result);
            self.tables = tables;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Unable to list tables." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil] show];
        });
    }
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * const ReuseIdentifier = @"ReuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier forIndexPath:indexPath];
    cell.textLabel.text = self.tables[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tables.count;
}

@end
