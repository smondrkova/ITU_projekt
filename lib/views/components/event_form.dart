/// File: /lib/views/components/event_form.dart
/// Project: Evento
///
/// Event form for editing event.
///
/// 17.12.2023
///
/// @author Barbora Šmondrková xsmond00

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:itu/controllers/EventController.dart';
import 'package:itu/models/Event.dart';
import 'package:itu/views/components/category_dropdown_menu.dart';

class EventForm extends StatefulWidget {
  final Event event;
  const EventForm({super.key, required this.event});

  @override
  State<EventForm> createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  final EventController _eventController = EventController();

  var _dateController = TextEditingController(
    text: DateFormat('dd.MM.yyyy').format(DateTime.now()),
  );

  var _timeController = TextEditingController(
    text: DateFormat('HH:mm').format(DateTime.now()),
  );

  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationNameController = TextEditingController();
  final TextEditingController locationAddressController =
      TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController ticketSellLinkController =
      TextEditingController();
  final TextEditingController ticketPriceController = TextEditingController();

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

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController(
      text: DateFormat('dd.MM.yyyy').format(widget.event.date_time),
    );
    _timeController = TextEditingController(
      text: DateFormat('HH:mm').format(widget.event.date_time),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('Widget in EVENTFORM event category id: ${widget.event.categoryId}');

    return Form(
      key: _eventController.editFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
                            ? DecorationImage(
                                image: (widget.event.photoUrl != '')
                                    ? AssetImage(widget.event.photoUrl)
                                    : const AssetImage(
                                        'assets/placeholder.png',
                                      ) as ImageProvider<Object>,
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
          SizedBox(
            width: 328,
            height: 60,
            child: Stack(
              children: [
                const Positioned(
                  left: 16,
                  top: 0,
                  child: Text(
                    'Názov*',
                    style: TextStyle(
                      fontSize: 16,
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
                      padding: const EdgeInsets.fromLTRB(20, 18, 0, 0),
                      child: TextFormField(
                        controller: nameController,
                        textAlignVertical: TextAlignVertical.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: widget.event.name,
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(110, 255, 255, 255),
                          ),
                        ),
                        onSaved: (value) {
                          if (value != null && value.isNotEmpty) {
                            widget.event.name = value;
                          }
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
                      child: Text(
                        'Dátum*',
                        style: TextStyle(
                          fontSize: 16,
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
                          padding: const EdgeInsets.fromLTRB(20, 18, 0, 0),
                          child: TextFormField(
                            controller: _dateController,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            onTap: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: widget.event.date_time,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('dd.MM.yyyy').format(pickedDate);
                                _dateController.text = formattedDate;
                                widget.event.date_time = pickedDate;
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
                          fontSize: 16,
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
                        padding: const EdgeInsets.fromLTRB(20, 18, 0, 0),
                        child: TextFormField(
                          controller: _timeController,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          onTap: () async {
                            final TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(
                                  widget.event.date_time),
                            );

                            if (pickedTime != null) {
                              final DateTime now = widget.event.date_time;
                              final DateTime pickedDateTime = DateTime(
                                  now.year,
                                  now.month,
                                  now.day,
                                  pickedTime.hour,
                                  pickedTime.minute);
                              _timeController.text =
                                  DateFormat('HH:mm').format(pickedDateTime);
                            }
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
                  child: Text(
                    'Miesto konania*',
                    style: TextStyle(
                      fontSize: 16,
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
                      padding: const EdgeInsets.fromLTRB(20, 18, 0, 0),
                      child: TextFormField(
                        controller: locationNameController,
                        textAlignVertical: TextAlignVertical.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: widget.event.place_name,
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(110, 255, 255, 255),
                          ),
                        ),
                        onSaved: (value) {
                          if (value != null && value.isNotEmpty) {
                            widget.event.place_name = value;
                          }
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
                  child: Text(
                    'Adresa miesta*',
                    style: TextStyle(
                      fontSize: 16,
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
                      padding: const EdgeInsets.fromLTRB(20, 18, 0, 0),
                      child: TextFormField(
                        controller: locationAddressController,
                        textAlignVertical: TextAlignVertical.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: widget.event.place_address,
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(110, 255, 255, 255),
                          ),
                        ),
                        onSaved: (value) {
                          if (value != null && value.isNotEmpty) {
                            widget.event.place_address = value;
                          }
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
            height: 70,
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
                    height: 45,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF3B3B3B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: CategoryDropdownMenu(event: widget.event),
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
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: TextFormField(
                        controller: descriptionController,
                        textAlignVertical: TextAlignVertical.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: widget.event.description,
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(110, 255, 255, 255),
                          ),
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        onSaved: (value) {
                          widget.event.description = value!;
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 328,
            height: 60,
            child: Stack(
              children: [
                const Positioned(
                  left: 16,
                  top: 0,
                  child: Text(
                    'Výška vstupného',
                    style: TextStyle(
                      fontSize: 16,
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
                      padding: const EdgeInsets.fromLTRB(20, 18, 0, 0),
                      child: TextFormField(
                        controller: ticketPriceController,
                        keyboardType: TextInputType.number,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: widget.event.price.toString(),
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(110, 255, 255, 255)),
                        ),
                        onSaved: (value) {
                          if (value != null && value.isNotEmpty) {
                            widget.event.price = double.parse(value);
                          }
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
                  child: Text(
                    'Odkaz na predaj lístkov',
                    style: TextStyle(
                      fontSize: 16,
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
                        controller: ticketSellLinkController,
                        textAlignVertical: TextAlignVertical.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: widget.event.ticketSellLink,
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(110, 255, 255, 255),
                          ),
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        onSaved: (value) {
                          widget.event.ticketSellLink = value!;
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
              _eventController.updateEvent(widget.event, null);
              Navigator.pop(context);
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
                    'Uložiť zmeny',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
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
}
