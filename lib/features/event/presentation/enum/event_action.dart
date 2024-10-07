import 'package:flutter/material.dart';

enum EventAction { edit, delete }

IconData getActionIcon(EventAction action) {
  switch (action) {
    case EventAction.edit:
      return Icons.edit;
    case EventAction.delete:
      return Icons.delete;
    // Add icons for future actions here
  }
}

String getActionLabel(EventAction action) {
  switch (action) {
    case EventAction.edit:
      return 'Edit';
    case EventAction.delete:
      return 'Delete';
    // Add labels for future actions here
  }
}
