import 'package:flutter/material.dart';
import 'package:project/screens/search_screen.dart';
import 'package:project/widgets/subtitle_text.dart';

class CategoryRoundedWidget extends StatelessWidget {
  const CategoryRoundedWidget({
    Key? key,
    required this.image,
    required this.name,
  }) : super(key: key);

  final String image, name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
           Navigator.pushNamed(
                  context,
                  SearchScreen.routeName,
                  arguments:name,
                
                );
      },
      child: Column(
          children: [
            Image.asset(
              image,
              height: 50,
              width: 50,
            ),
            // const SizedBox(
            //   height: 15,
            // ),
            SubtitleTextWidget(
              label: name,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ],
        
      ),
    );
  }
}
