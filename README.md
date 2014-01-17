ABFullScrollViewController
==========================

Subclass of ViewController that provide the behaviour of hide the toolbar when user makes scroll in a UITableView. 

### Installation 
For install this component you only need to download the ABFullScrollViewController folder and copy it into your proyect. Then you need to inherate your view controller of ABFullScrollViewController:

	#import "ABFullScrollViewController.h"

	@interface ViewController : ABFullScrollViewController <UITableViewDataSource>

	@end

In .m file you need to implements the classes that allow you to customize the behaviour, for example:

	//The view that you want to set in toolbar view
	-(UIView *) headerView:(UIView *)view forTableView:(UITableView *)tableView
	{
	    [view setFrame:CGRectMake(0, 0, self.tableView.frame.size.width, HEADER_STANDARD_HEIGHT)];
	    
	    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,
	                                                               20/*status bar*/,
	                                                               view.frame.size.width,
	                                                               view.frame.size.height-20)];
	    [label setFont:[UIFont fontWithName:@"Copperplate" size:20]];
	    [label setTextColor:[UIColor blackColor]];
	    [label setTextAlignment:NSTextAlignmentCenter];
	    [label setText:@"ABFullScrollViewController"];
	    [view addSubview:label];
	        
	    return view;
	}

	//The height of the toolbar view
	-(float) headerHeightForTableView:(UITableView *)tableView
	{
	    return HEADER_STANDARD_HEIGHT;
	}

	//The color background color of the toolbar
	- (UIColor *)toolbarBackgroundColor
	{
	    return [UIColor colorWithWhite:1.0 alpha:0.7];
	}

	//The minimum size that you want to show of the toolbar
	- (float)minHeightWithoutHide
	{
	    return 20 /*status bar height*/;
	}

For the last, you need to link in .xib file the tableViewDelegate, the toolbar and the tableView.

![alt tag](https://raw2.github.com/andresbrun/ABFullScrollViewController/master/ABFullScrollViewControllerExample/Demo/instructions_1.png)

## Notes
- This component uses scrollViewDidScroll:, scrollViewDidEndDragging: willDecelerate: and scrollViewDidEndDecelerating so if you need to implment it in you class remember to call the super of it ;).

- This component doesn't work fine with Autolayout :(.

## Examples

![alt tag](https://raw2.github.com/andresbrun/ABFullScrollViewController/master/ABFullScrollViewControllerExample/Demo/ABFullScrollVC_screen_1.png)

## License

ABFullScrollViewController is available under the MIT license. See the LICENSE file for more info.
