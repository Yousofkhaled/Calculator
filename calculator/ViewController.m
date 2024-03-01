//
//  ViewController.m
//  calculator
//
//  Created by Admin on 22/08/2023.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *result_label;

@end

@implementation ViewController

NSMutableArray <NSMutableString * > *s;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    s = [[NSMutableArray<NSMutableString*> alloc] init];
    
    [s addObject: [NSMutableString stringWithString: @"0"]];
    
}

-(void) append_digit : (NSMutableString *) d to: (NSMutableString *) number {
    
    if ([d isEqualToString:@"."]) {
        if ([number isEqualToString:@""]) {
            [number appendString:@"0."];
        }
        else {
            int cnt = 0;
            for (int i=0;i<[number length] ; ++i) {
                if ([number characterAtIndex:i] == '.') {
                    cnt = 1;
                }
            }
            
            if (cnt == 0)
                [number appendString:@"."];
        }
    }
    else {
        if ([number isEqualToString:@"0"]) {
            number = [NSMutableString stringWithString:@""];
            [number appendString:d];
        }
        else {
            [number appendString:d];
        }
    }
    
}

- (IBAction)number_button:(id)sender {
    int pressed_number = (int)[sender tag];
    
//    NSLog(@"-------before--------");
//    for (int i=0;i<[s count];++i)
//        NSLog(@"%@", s[i]);
    
    NSMutableString * digit = [NSMutableString stringWithFormat:@"%d", pressed_number];
    
    if (pressed_number == -1) {
        digit = [NSMutableString stringWithString:@"."];
    }
    
    NSLog(@"%@", digit);
    
    if ([s count] == 1) {
        if ([s[0] isEqualToString: @"0"]) {
            s[0] = [NSMutableString stringWithString: @""];
            
            //[s[0] appendString:digit];
            [self append_digit:digit to:s[0]];
        }
        else {
            //[s[0] appendString:digit];
            [self append_digit:digit to:s[0]];
        }
        _result_label.text = s[0];
        _result_label.text = [NSMutableString stringWithString:s[0]];
    }
    else if ([s count] == 2) {
        
        if ([s[1] isEqualToString:@"="]) {
            
            s[0] = [NSMutableString stringWithString: @""];
            //[s[0] appendString:digit];
            [self append_digit:digit to:s[0]];
            
            [s removeObject:s[1]];
            
            _result_label.text = s[0];
            //_result_label.text = [NSMutableString stringWithFormat: @"%.2f", [s[0] floatValue]];
            _result_label.text = [NSMutableString stringWithString:s[0]];
            
        }
        
        else {
            //[s addObject:[NSMutableString stringWithFormat:@"%d", pressed_number]];
            [s addObject:[NSMutableString stringWithString:@""]];
            [self append_digit:digit to:s[2]];
            
            _result_label.text = s[2];
            //_result_label.text = [NSMutableString stringWithFormat: @"%.2f", [s[2] floatValue]];
            _result_label.text = [NSMutableString stringWithString:s[2]];
        }
    }
    else {
        if ([s[2] isEqualToString: @"0"]) {
            s[2] = [NSMutableString stringWithString: @""];
            //[s[2] appendString:digit];
            [self append_digit:digit to:s[2]];
        }
        else {
            //[s[2] appendString:digit];
            [self append_digit:digit to:s[2]];
        }
        _result_label.text = s[2];
        //_result_label.text = [NSMutableString stringWithFormat: @"%.2f", [s[2] floatValue]];
        _result_label.text = [NSMutableString stringWithString:s[2]];
    }
    
//    NSLog(@"-------after--------");
//    for (int i=0;i<[s count];++i)
//        NSLog(@"%@", s[i]);
    
}
- (IBAction)ac_button:(id)sender {
    [s removeAllObjects];
    [s addObject: [NSMutableString stringWithString: @"0"]];
    
    _result_label.text = s[0];
    //_result_label.text = [NSMutableString stringWithFormat: @"%.2f", [s[0] floatValue]];
    _result_label.text = [NSMutableString stringWithString:s[0]];
}

float calc (float num1, float num2, NSMutableString * op) {
    if ([op isEqualToString: @"+"])
        return num1 + num2;
    if ([op isEqualToString: @"-"])
        return num1 - num2;
    if ([op isEqualToString: @"x"])
        return num1 * num2;
    if ([op isEqualToString: @"/"]){
        if (num2 == 0)
            return 999999;
        return num1 / num2;
    }
    if ([op isEqualToString: @"%"]) {
        if (floor(num1) != num1 || floor(num2) != num2)
            return 999999;
        return (int)num1 % (int)num2;
    }
    return 999999;
}

- (IBAction)operation_button:(id)sender {
    
    char o[7] = {'=', '+', '-', 'x', '/', '%'};
    
    char operation = o[(int)[sender tag]];
    
    if (operation == '=') {
        if ([s count] == 1){
            ;// do nothing
            [s addObject:[NSMutableString stringWithFormat:@"%c", operation]];
        }
        else if ([s count] == 2) {
            [s removeObject: s[1]];
        }
        else {
            float num1 = [s[0] floatValue];
            float num2 = [s[2] floatValue];
            
            float res = calc (num1, num2, s[1]);
            
            [s removeAllObjects];
            
            [s addObject: [NSMutableString stringWithFormat: @"%.2f", res]];
            
            _result_label.text = s[0];
            _result_label.text = [NSMutableString stringWithFormat: @"%.2f", [s[0] floatValue]];
            
            [s addObject:[NSMutableString stringWithFormat:@"%c", operation]];
        }
        
    }
    else if (operation == '%') {
        if ([s count] == 1){
            ;// do nothing
            float num1 = [s[0] floatValue];
            num1 /= 100;
            s[0] = [NSMutableString stringWithFormat:@"%.4f", num1];
        }
        else if ([s count] == 2) {
            [s removeObject: s[1]];
            float num1 = [s[0] floatValue];
            num1 /= 100;
            s[0] = [NSMutableString stringWithFormat:@"%.4f", num1];
        }
        else {
            float num1 = [s[0] floatValue];
            float num2 = [s[2] floatValue];
            
            float res = calc (num1, num2, s[1]);
            
            [s removeAllObjects];
            
            res /= 100;
            [s addObject: [NSMutableString stringWithFormat: @"%.2f", res]];
            
            _result_label.text = s[0];
            _result_label.text = [NSMutableString stringWithFormat: @"%.4f", [s[0] floatValue]];
        }
        _result_label.text = [NSMutableString stringWithFormat: @"%.4f", [s[0] floatValue]];
    }
    
    else if ([s count] == 1) {
        [s addObject:[NSMutableString stringWithFormat:@"%c", operation]];
    }
    else if ([s count] == 2) {
        s[1] = [NSMutableString stringWithFormat:@"%c", operation];
    }
    else {
        float num1 = [s[0] floatValue];
        float num2 = [s[2] floatValue];
        
        float res = calc (num1, num2, s[1]);
        
        [s removeAllObjects];
        
        [s addObject: [NSMutableString stringWithFormat: @"%.2f", res]];
        
        _result_label.text = s[0];
        _result_label.text = [NSMutableString stringWithFormat: @"%.2f", [s[0] floatValue]];
        
        [s addObject:[NSMutableString stringWithFormat:@"%c", operation]];
    }

    
    if ([_result_label.text isEqualToString:@"999999.00"]) {
        _result_label.text = @"NaN";
    }
}

- (IBAction)erase_button:(id)sender {
    
}


@end
