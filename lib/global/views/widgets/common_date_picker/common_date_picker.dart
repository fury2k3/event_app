import 'dart:io' as io;

import 'package:easy_localization/easy_localization.dart';
import 'package:event_app/global/theme/theme.dart';
import 'package:event_app/global/translation/generated/locale_keys.g.dart';
import 'package:event_app/global/utils/const.dart';
import 'package:event_app/global/views/widgets/common_date_picker/common_text_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonDatePicker extends StatefulWidget {
  const CommonDatePicker({
    required this.hint,
    required this.controller,
    required this.validateData,
    super.key,
  });
  final String hint;
  final TextEditingController controller;
  final FormFieldValidator<String>? validateData;

  @override
  State<CommonDatePicker> createState() => _CommonDatePickerState();
}

class _CommonDatePickerState extends State<CommonDatePicker> {
  String dateSelected = DateFormat(dateFormat).format(DateTime.now());
  final minimumDate = DateTime.now().subtract(
    const Duration(days: 365 * 80),
  );
  final initialDateTime = DateTime.now();
  Future<void> _showDatePicker({
    required ThemeData theme,
  }) async {
    if (io.Platform.isIOS) {
      await showCupertinoModalPopup<String>(
        context: context,
        builder: (_) => Center(
          child: Container(
            height: 370,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Center(
                  child: SizedBox(
                    height: 300,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: CupertinoTheme(
                      data: const CupertinoThemeData(
                        textTheme: CupertinoTextThemeData(
                          dateTimePickerTextStyle: TextStyle(
                            color: buttonDarkTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        dateOrder: DatePickerDateOrder.dmy,
                        initialDateTime: initialDateTime,
                        minimumDate: minimumDate,
                        maximumDate: DateTime(datePickerEndYearDate),
                        onDateTimeChanged: (pickedDate) {
                          final formattedDate =
                              DateFormat(dateFormat).format(pickedDate);
                          setState(
                            () {
                              dateSelected = formattedDate;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width / 3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: geryHintLoginInputColor,
                        ),
                      ),
                      child: Material(
                        type: MaterialType.transparency,
                        child: InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: Center(
                            child: Text(
                              LocaleKeys.cancel.tr(),
                              style: theme.textTheme.headlineMedium?.copyWith(
                                fontSize: 13,
                                color: buttonDarkTextColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width / 3,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor:
                              MaterialStateProperty.all(appPrimaryColor),
                        ),
                        onPressed: () {
                          widget.controller.text = dateSelected;
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          LocaleKeys.choose.tr(),
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontSize: 13,
                            color: globalBackgroundColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      final pickedDate = await showDatePicker(
        context: context,
        locale: context.locale,
        initialDate: DateTime.now().subtract(
          const Duration(days: 365 * 18),
        ),
        firstDate: DateTime.now().subtract(
          const Duration(days: 365 * 18),
        ),
        lastDate: DateTime(datePickerEndYearDate),
        builder: (context, child) {
          return Theme(
            data: theme.copyWith(
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: buttonDarkTextColor,
                  textStyle: theme.textTheme.displaySmall?.copyWith(
                    color: buttonDarkTextColor,
                  ),
                ),
              ),
              colorScheme: const ColorScheme.light(
                primary: appPrimaryColor,
                onSurface: geryTextLoginInputColor,
              ),
            ),
            child: child!,
          );
        },
      );
      if (pickedDate != null) {
        final formattedDate = DateFormat(dateFormat).format(pickedDate);
        setState(
          () {
            widget.controller.text = formattedDate;
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CommonTextForm(
      controller: widget.controller,
      hint: widget.hint,
      prefixIcon: const Icon(
        Icons.date_range,
        color: appPrimaryColor,
        size: 26,
      ),
      validateData: widget.validateData,
      onTap: () => _showDatePicker(
        theme: theme,
      ),
      readOnly: true,
    );
  }
}
