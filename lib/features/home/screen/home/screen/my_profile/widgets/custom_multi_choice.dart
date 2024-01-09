import 'package:flutter/material.dart';
import 'package:pesst/utils/colors.dart';




class CustomMultiChoiceTextField extends StatefulWidget {

final List<String> gender;
  const CustomMultiChoiceTextField({super.key,  required this.gender});
  @override
  _CustomMultiChoiceTextFieldState createState() =>
      _CustomMultiChoiceTextFieldState();
}

class _CustomMultiChoiceTextFieldState
    extends State<CustomMultiChoiceTextField> {

String selectedGender = '';
List<String> genderList = ["Male", "Female", "Other"];
void _selectGender(String gender) {
    setState(() {
      selectedGender = gender;
     
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: greyColor.shade200,
            borderRadius: BorderRadius.circular(12)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField<String>(
              value: widget.gender[0],
              items: genderList.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,),
                );
              }).toList(),
              onChanged: (String? value) {
                if (value != null) {
                  _selectGender(value);
                  widget.gender[0] = value;
                }
              },
              decoration: InputDecoration(
                
                border: UnderlineInputBorder(borderSide: BorderSide.none),
              )
            ),
          ),
        ),
        // TextFormField(
        //   controller: _controller,
        //   readOnly: true,
        //   decoration: InputDecoration(
        //     labelText: widget.gender[0],
        //     suffixIcon: Icon(Icons.arrow_drop_down),
        //   ),
        //   onTap: 
        //     () {
           
        //    _showGenderPicker(context);
        //     // showChoicesDialog(context, widget.gender).then((value) {
        //     //   setState(() {
               
        //     //   });
        //     // });
        //   },       
        // ),
      ],
    );
  }

  // Future<void> showChoicesDialog(BuildContext context, List<String> gender) async {
  //   await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text("Choose Gender"),
  //         content:  CustomShapes(
  //               gender:gender,
  //               withContainer: 70,
  //                heightContainer: 80,
  //              ),
            
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();

  //             },
  //             child: Text("OK"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
    
// void _selectGender(String gender) {
//     setState(() {
//       selectedGender = gender;
//       _controller.text = gender;
//     });
//   }
//     Future<void> _showGenderPicker(BuildContext context) async {
//     return showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           height: 200,
//           child: Column(
//             children: [
//               ListTile(
//                 title: Text('Male'),
//                 onTap: () {
//                   _selectGender('Male');
//                   Navigator.pop(context);
//                 },
//               ),
//               ListTile(
//                 title: Text('Female'),
//                 onTap: () {
//                   _selectGender('Female');
//                   Navigator.pop(context);
//                 },
//               ),
//               // Add more gender options as needed
//             ],
//           ),
//         );
//       },
//     );
//   }

    }
    