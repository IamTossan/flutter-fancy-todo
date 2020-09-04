import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {
  final Map categories;
  final String selectedCategory;
  final Function onSelectCategory;
  final Function onAddCategory;

  const CategoryList({
    Key key,
    this.selectedCategory,
    this.categories,
    this.onSelectCategory,
    this.onAddCategory,
  }) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    var categoryComponents = widget.categories.keys.map((c) => GestureDetector(
          onTap: () {
            widget.onSelectCategory(c);
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 10.0, 10.0, 10.0),
            width: 160.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.all(Radius.circular(10.0)),
              color: Colors.white,
              gradient: c == widget.selectedCategory
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFFF9E97),
                        Color(0xFFFF5C7C),
                      ],
                    )
                  : null,
              shape: BoxShape.rectangle,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    offset: Offset(5, 5),
                    blurRadius: 1.0,
                    spreadRadius: 1.0)
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 4.0),
                CircularProgressIndicator(
                  value: widget.categories[c].length > 0
                      ? widget.categories[c]
                              .where((t) => t.isDone == true)
                              .length /
                          widget.categories[c].length
                      : 0.01,
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(Color(0xFF5859F9)),
                  backgroundColor: Color(0xFFDEDEFE),
                ),
                Text(
                  '$c ${widget.categories[c].where((t) => t.isDone == true).length}/${widget.categories[c].length}',
                  style: textTheme.bodyText1,
                  textScaleFactor: 1.5,
                ),
                SizedBox(height: 4.0),
              ],
            ),
          ),
        ));

    var addCategoryWidget = GestureDetector(
      onTap: () {
        widget.onAddCategory();
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 10.0, 10.0, 10.0),
        width: 160.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.all(Radius.circular(10.0)),
          color: Colors.white,
          shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                offset: Offset(5, 5),
                blurRadius: 1.0,
                spreadRadius: 1.0)
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.add_circle_outline),
              iconSize: 55.0,
              color: Colors.grey[400],
              onPressed: () {
                widget.onAddCategory();
              },
            ),
            Text(
              'Add new category',
              style: textTheme.bodyText1.apply(color: Colors.grey[500]),
              textScaleFactor: 1.5,
            ),
            SizedBox(height: 12.0)
          ],
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'categories',
          style: textTheme.subtitle1,
        ),
        Container(
          height: 150.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              ...categoryComponents.toList(),
              addCategoryWidget,
            ],
          ),
        ),
      ],
    );
  }
}
