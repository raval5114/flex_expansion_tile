# 🔽 Flex Expansion Tile

## 📦 Version 0.0.1

A lightweight, customizable, and flexible expansion tile widget for Flutter. Unlike the default `ExpansionTile`, this widget allows developers to provide any `List<Widget>` and offers extensive styling options and interaction callbacks.

---

## ✨ Features

- ✅ Accepts any widgets as children (`List<Widget>`)
- ✅ Smooth expand/collapse animation using `AnimatedCrossFade`
- ✅ Callbacks for expansion change and child interactions
- ✅ Fully customizable background, padding, margin, borders, and elevation
- ✅ Simple, efficient, and composable

---

## 📚 Table of Contents

- [Features](#-features)
- [Parameters](#-parameters)
- [Getting Started](#-getting-started)
- [Installation](#-installation)
- [Usage Example](#-usage-example)
- [License](#-license)

## 🎛 Parameters

| Parameter            | Type                    | Default      | Description                                                     |
| -------------------- | ----------------------- | ------------ | --------------------------------------------------------------- |
| `title`              | `Widget`                | **required** | The main clickable area of the tile. Usually a `Text` or `Row`. |
| `children`           | `List<Widget>`          | `[]`         | Widgets shown when the tile is expanded. Accepts any widget.    |
| `initiallyExpanded`  | `bool`                  | `false`      | Whether the tile starts expanded.                               |
| `onExpansionChanged` | `ValueChanged<bool>?`   | `null`       | Called when the tile expands or collapses.                      |
| `onChildInteraction` | `VoidCallback?`         | `null`       | Called when any of the expanded children is tapped.             |
| `backgroundColor`    | `Color?`                | `null`       | Background color of the tile container.                         |
| `borderRadius`       | `BorderRadiusGeometry?` | `12.0`       | Rounds the tile's corners.                                      |
| `border`             | `BoxBorder?`            | `null`       | Draws a border around the tile.                                 |
| `padding`            | `EdgeInsetsGeometry?`   | `null`       | Inner spacing inside the tile's container.                      |
| `margin`             | `EdgeInsetsGeometry?`   | `null`       | Outer spacing around the tile.                                  |
| `elevation`          | `double?`               | `null`       | Adds shadow beneath the tile.                                   |

## 🚀 Getting Started

### 🔧 Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  flex_expansion_tile: ^0.0.1
```

## 🛠️ Usage Example

Here’s a simple usage example of `FlexExpansionTile` inside a Flutter app:

```dart
import 'package:flutter/material.dart';
import 'package:flex_expansion_tile/flex_expansion_tile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Flex Expansion Tile')),
        body: ListView(
          children: [
            FlexExpansionTile(
              title: Text('Expandable Settings'),
              initiallyExpanded: false,
              onExpansionChanged: (bool expanded) {
                print('Tile is now: ${expanded ? "Expanded" : "Collapsed"}');
              },
              onChildInteraction: () {
                print('Child widget tapped!');
              },
              backgroundColor: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              elevation: 3,
              children: [
                ListTile(title: Text('Option 1')),
                ListTile(title: Text('Option 2')),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Perform Action'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```
