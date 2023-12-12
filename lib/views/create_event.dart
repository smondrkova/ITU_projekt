import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itu/controllers/CategoryController.dart';
import 'package:itu/controllers/EventController.dart';
import 'package:itu/models/Event.dart';
import 'package:intl/intl.dart';
import 'package:itu/views/home.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({super.key});

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final _dateController = TextEditingController();
  //final eventController = EventController();

  Event event = Event(
    id: '',
    name: '',
    date: DateTime.now(),
    location: '',
    categoryId: '',
    description: '',
    price: 0.0,
    ticketSellLink: '',
    photoUrl: '',
  );

  final _formKey = GlobalKey<FormState>();
  int _currentViewIndex = 0;

  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  // Widget _buildFormText(String text, String value) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
  //     child: TextFormField(
  //       textAlignVertical: TextAlignVertical.center,
  //       style: const TextStyle(
  //         color: Colors.white,
  //         fontSize: 16,
  //       ),
  //       decoration: const InputDecoration(
  //         border: InputBorder.none,
  //         hintText: 'Vyplň meno podujatia',
  //         hintStyle: TextStyle(
  //           color: Color.fromARGB(110, 255, 255, 255),
  //         ),
  //       ),
  //       onSaved: (value) {
  //         if (value == "name") {
  //           event.name = value!;
  //         } else if (value == "location") {
  //           event.location = value!;
  //         } else if (value == "description") {
  //           event.description = value!;
  //         } else if (value == "ticketSellLink") {
  //           event.ticketSellLink = value!;
  //         }
  //       },
  //     ),
  //   );
  // }

  Widget _buildInsertImage() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          width: 212,
          height: 30,
          child: Text(
            'Vyber titulný obrázok',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: 275,
          height: 275,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: GestureDetector(
                  onTap: getImage,
                  child: Container(
                    width: 275,
                    height: 275,
                    decoration: ShapeDecoration(
                      image: _image == null
                          ? const DecorationImage(
                              image: AssetImage('assets/placeholder.png'),
                              fit: BoxFit.fill,
                            )
                          : DecorationImage(
                              image: FileImage(_image!),
                              fit: BoxFit.fill,
                            ),
                      color: const Color(0xFF3B3B3B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () {
            setState(() {
              _currentViewIndex += 1;
            });
          },
          child: Container(
            width: 144,
            height: 46,
            padding: const EdgeInsets.all(10),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Ďalej',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNeccessaryInfo() {
    return SizedBox(
      width: 328,
      height: 549,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 270,
            child: Text(
              'Vyplň informácie o podujatí',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: 328,
            height: 60,
            child: Stack(
              children: [
                const Positioned(
                  left: 16,
                  top: 0,
                  child: SizedBox(
                    width: 287,
                    height: 21,
                    child: Text(
                      'Názov*',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 21,
                  child: Container(
                    width: 328,
                    height: 39,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF3B3B3B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Vyplň meno podujatia',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(110, 255, 255, 255),
                          ),
                        ),
                        onSaved: (value) {
                          event.name = value!;
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 196,
                height: 60,
                child: Stack(
                  children: [
                    const Positioned(
                      left: 9.56,
                      top: 0,
                      child: SizedBox(
                        width: 171.50,
                        height: 21,
                        child: Text(
                          'Dátum*',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 21,
                      child: Container(
                        width: 196,
                        height: 39,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF3B3B3B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextFormField(
                            controller: _dateController,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            onTap: () async {
                              FocusScope.of(context).requestFocus(
                                  FocusNode()); // to prevent opening default keyboard
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('dd.MM.yyyy').format(pickedDate);
                                _dateController.text = formattedDate;
                                event.date =
                                    pickedDate; // Set the picked date to event.date
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 21),
              SizedBox(
                width: 111,
                height: 60,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 97.12,
                      height: 21,
                      child: Text(
                        'Čas*',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ),
                    Container(
                      width: 111,
                      height: 39,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF3B3B3B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.datetime,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Vyplň čas',
                            hintStyle: TextStyle(
                              color: Color.fromARGB(110, 255, 255, 255),
                            ),
                          ),
                          onSaved: (value) {
                            event.name = value!;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: 328,
            height: 60,
            child: Stack(
              children: [
                const Positioned(
                  left: 16,
                  top: 0,
                  child: SizedBox(
                    width: 287,
                    height: 21,
                    child: Text(
                      'Miesto konania*',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 21,
                  child: Container(
                    width: 328,
                    height: 39,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF3B3B3B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Vyplň miesto podujatia',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(110, 255, 255, 255),
                          ),
                        ),
                        onSaved: (value) {
                          event.name = value!;
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: 328,
            height: 60,
            child: Stack(
              children: [
                const Positioned(
                  left: 16,
                  top: 0,
                  child: SizedBox(
                    width: 287,
                    height: 21,
                    child: Text(
                      'Kategória*',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 21,
                  child: Container(
                    width: 328,
                    height: 39,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF3B3B3B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    // child: Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    //   child: DropdownButtonFormField<String>(
                    //     decoration: const InputDecoration(
                    //       border: InputBorder.none,
                    //       hintText: 'Vyplň meno podujatia',
                    //       hintStyle: TextStyle(
                    //         color: Color.fromARGB(110, 255, 255, 255),
                    //       ),
                    //     ),
                    //     items: categories.map((String category) {
                    //       return DropdownMenuItem<String>(
                    //         value: category,
                    //         child: Text(category),
                    //       );
                    //     }).toList(),
                    //     onChanged: (String? newValue) {
                    //       event.category = newValue!;
                    //     },
                    //     onSaved: (String? value) {
                    //       event.category = value!;
                    //     },
                    //   ),
                    // ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: 328,
            height: 169,
            child: Stack(
              children: [
                const Positioned(
                  left: 15,
                  top: 0,
                  child: SizedBox(
                    width: 287,
                    height: 19.58,
                    child: Text(
                      'Popis*',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 19.58,
                  child: Container(
                    width: 328,
                    height: 138.92,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF3B3B3B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Vyplň popis',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(110, 255, 255, 255),
                          ),
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        onSaved: (value) {
                          event.description = value!;
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              setState(() {
                _currentViewIndex += 1;
              });
            },
            child: Container(
              width: 144,
              height: 46,
              padding: const EdgeInsets.all(10),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Ďalej',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionalInfo() {
    return SizedBox(
      width: 334,
      height: 350,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 334,
            height: 36,
            child: Text(
              'Vyplň informácie o lístkoch (voliteľné)',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: 328,
            height: 60,
            child: Stack(
              children: [
                const Positioned(
                  left: 16,
                  top: 0,
                  child: SizedBox(
                    width: 287,
                    height: 21,
                    child: Text(
                      'Výška vstupného',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 21,
                  child: Container(
                    width: 328,
                    height: 39,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF3B3B3B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Vyplň vstupné',
                          hintStyle: TextStyle(
                              color: Color.fromARGB(110, 255, 255, 255)),
                        ),
                        onSaved: (value) {
                          event.price = double.parse(value!);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: 328,
            height: 125,
            child: Stack(
              children: [
                const Positioned(
                  left: 16,
                  top: 0,
                  child: SizedBox(
                    width: 287,
                    height: 21,
                    child: Text(
                      'Odkaz na predaj lístkov',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 21,
                  child: Container(
                    width: 328,
                    height: 100,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF3B3B3B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Vyplň odkaz',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(110, 255, 255, 255),
                          ),
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        onSaved: (value) {
                          event.ticketSellLink = value!;
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              _formKey.currentState!.save();
              //eventController.createEvent(event);
              // Navigator.pop(context);
            },
            child: Container(
              width: 144,
              height: 46,
              padding: const EdgeInsets.all(10),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Odoslať',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildView(int viewIndex) {
    switch (viewIndex) {
      case 0:
        return Positioned(
          left: 42,
          top: 150,
          child: _buildInsertImage(),
        );
      case 1:
        return Positioned(
          left: 15,
          top: 120,
          child: _buildNeccessaryInfo(),
        );

      case 2:
        return Positioned(
          left: 15,
          top: 120,
          child: _buildOptionalInfo(),
        );

      default:
        return Container(); // Return an empty container by default
    }
  }

  Widget _buildIcon(String iconPath) {
    return Container(
      width: 25,
      height: 25,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(),
      child: Stack(
        children: [
          Positioned(
            left: 2.08,
            top: 2.08,
            child: SizedBox(
              width: 20.83,
              height: 20.83,
              child: SvgPicture.asset(
                iconPath,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Container(
          width: 360,
          height: 675,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(color: Colors.black),
          child: Stack(
            children: [
              const Positioned(
                left: 40,
                top: 50,
                child: SizedBox(
                  width: 267,
                  child: Text(
                    'Vytvor nové podujatie',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: _buildView(_currentViewIndex),
              ),
              Positioned(
                  left: 319,
                  top: 52,
                  child: _buildIcon('assets/icons/info_icon.svg')),
              Positioned(
                left: 8,
                top: 52,
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_currentViewIndex == 0) {
                          // add navigation to user page
                          //navigateToNewPage("UserPage");
                        }
                        _currentViewIndex -= 1;
                      });
                    },
                    child: _buildIcon('assets/icons/left_arrow_icon.svg')),
              ),
            ],
          ),
        ));
  }
}
