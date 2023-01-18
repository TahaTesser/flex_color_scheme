import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

/// A Hive data type adapter for enum [ThemeMode].
class ThemeModeAdapter extends TypeAdapter<ThemeMode> {
  @override
  ThemeMode read(BinaryReader reader) {
    final int index = reader.readInt();
    return ThemeMode.values[index];
  }

  @override
  void write(BinaryWriter writer, ThemeMode obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 150;
}

/// A Hive data type adapter for class [Color].
class ColorAdapter extends TypeAdapter<Color> {
  @override
  Color read(BinaryReader reader) {
    final int value = reader.readInt();
    return Color(value);
  }

  @override
  void write(BinaryWriter writer, Color obj) {
    writer.writeInt(obj.value);
  }

  @override
  int get typeId => 151;
}

/// A Hive data type adapter for enum [FlexScheme].
class FlexSchemeAdapter extends TypeAdapter<FlexScheme> {
  @override
  FlexScheme read(BinaryReader reader) {
    final int index = reader.readInt();
    return FlexScheme.values[index];
  }

  @override
  void write(BinaryWriter writer, FlexScheme obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 152;
}

/// A Hive data type adapter for enum [FlexSurfaceMode].
class FlexSurfaceModeAdapter extends TypeAdapter<FlexSurfaceMode> {
  @override
  FlexSurfaceMode read(BinaryReader reader) {
    final int index = reader.readInt();
    return FlexSurfaceMode.values[index];
  }

  @override
  void write(BinaryWriter writer, FlexSurfaceMode obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 153;
}

/// A Hive data type adapter for enum [FlexTabBarStyle].
class FlexInputBorderTypeAdapter extends TypeAdapter<FlexInputBorderType> {
  @override
  FlexInputBorderType read(BinaryReader reader) {
    final int index = reader.readInt();
    return FlexInputBorderType.values[index];
  }

  @override
  void write(BinaryWriter writer, FlexInputBorderType obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 154;
}

/// A Hive data type adapter for enum [FlexAppBarStyle].
class FlexAppBarStyleAdapter extends TypeAdapter<FlexAppBarStyle> {
  @override
  FlexAppBarStyle read(BinaryReader reader) {
    final int index = reader.readInt();
    return FlexAppBarStyle.values[index];
  }

  @override
  void write(BinaryWriter writer, FlexAppBarStyle obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 155;
}

/// A Hive data type adapter for enum [FlexTabBarStyle].
class FlexTabBarStyleAdapter extends TypeAdapter<FlexTabBarStyle> {
  @override
  FlexTabBarStyle read(BinaryReader reader) {
    final int index = reader.readInt();
    return FlexTabBarStyle.values[index];
  }

  @override
  void write(BinaryWriter writer, FlexTabBarStyle obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 156;
}

/// A Hive data type adapter for enum [FlexSystemNavBarStyle].
class FlexSystemNavBarStyleAdapter extends TypeAdapter<FlexSystemNavBarStyle> {
  @override
  FlexSystemNavBarStyle read(BinaryReader reader) {
    final int index = reader.readInt();
    return FlexSystemNavBarStyle.values[index];
  }

  @override
  void write(BinaryWriter writer, FlexSystemNavBarStyle obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 157;
}

/// A Hive data type adapter for enum [SchemeColor], nullable.
///
/// Handles storing <null> value as -1 and returns anything out of enum
/// index range as null value.
class FlexSchemeColorAdapter extends TypeAdapter<SchemeColor?> {
  @override
  SchemeColor? read(BinaryReader reader) {
    final int index = reader.readInt();
    if (index < 0 || index >= SchemeColor.values.length) {
      return null;
    } else {
      return SchemeColor.values[index];
    }
  }

  @override
  void write(BinaryWriter writer, SchemeColor? obj) {
    writer.writeInt(obj?.index ?? -1);
  }

  @override
  int get typeId => 158;
}

/// A Hive data type adapter for enum [NavigationDestinationLabelBehavior].
class NavigationDestinationLabelBehaviorAdapter
    extends TypeAdapter<NavigationDestinationLabelBehavior> {
  @override
  NavigationDestinationLabelBehavior read(BinaryReader reader) {
    final int index = reader.readInt();
    return NavigationDestinationLabelBehavior.values[index];
  }

  @override
  void write(BinaryWriter writer, NavigationDestinationLabelBehavior obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 159;
}

/// A Hive data type adapter for enum [NavigationRailLabelType].
class NavigationRailLabelTypeAdapter
    extends TypeAdapter<NavigationRailLabelType> {
  @override
  NavigationRailLabelType read(BinaryReader reader) {
    final int index = reader.readInt();
    return NavigationRailLabelType.values[index];
  }

  @override
  void write(BinaryWriter writer, NavigationRailLabelType obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 160;
}

/// A Hive data type adapter for enum [FlexSliderIndicatorType], nullable.
///
/// Handles storing <null> value as -1 and returns anything out of enum
/// index range as null value.
class FlexSliderIndicatorTypeAdapter
    extends TypeAdapter<FlexSliderIndicatorType?> {
  @override
  FlexSliderIndicatorType? read(BinaryReader reader) {
    final int index = reader.readInt();
    if (index < 0 || index >= FlexSliderIndicatorType.values.length) {
      return null;
    } else {
      return FlexSliderIndicatorType.values[index];
    }
  }

  @override
  void write(BinaryWriter writer, FlexSliderIndicatorType? obj) {
    writer.writeInt(obj?.index ?? -1);
  }

  @override
  int get typeId => 161;
}

/// A Hive data type adapter for enum [ShowValueIndicator], nullable.
///
/// Handles storing <null> value as -1 and returns anything out of enum
/// index range as null value.
class ShowValueIndicatorAdapter extends TypeAdapter<ShowValueIndicator?> {
  @override
  ShowValueIndicator? read(BinaryReader reader) {
    final int index = reader.readInt();
    if (index < 0 || index >= ShowValueIndicator.values.length) {
      return null;
    } else {
      return ShowValueIndicator.values[index];
    }
  }

  @override
  void write(BinaryWriter writer, ShowValueIndicator? obj) {
    writer.writeInt(obj?.index ?? -1);
  }

  @override
  int get typeId => 162;
}
