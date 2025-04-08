// utils/conversion_formulas.dart
List<String> getUnitsForCategory(String category) {
  switch (category) {
    case 'Length':
      return ['Meters', 'Kilometers', 'Miles', 'Feet'];
    case 'Weight':
      return ['Grams', 'Kilograms', 'Pounds', 'Ounces'];
    case 'Temperature':
      return ['Celsius', 'Fahrenheit', 'Kelvin'];
    default:
      return [];
  }
}

double performConversion({
  required String category,
  required double value,
  required String fromUnit,
  required String toUnit,
}) {
  if (fromUnit == toUnit) return value;

  switch (category) {
    case 'Length':
      return _convertLength(value, fromUnit, toUnit);
    case 'Weight':
      return _convertWeight(value, fromUnit, toUnit);
    case 'Temperature':
      return _convertTemperature(value, fromUnit, toUnit);
    default:
      return value;
  }
}

// Length conversion
double _convertLength(double value, String from, String to) {
  const conversionToMeter = {
    'Meters': 1.0,
    'Kilometers': 1000.0,
    'Miles': 1609.34,
    'Feet': 0.3048,
  };

  double inMeters = value * conversionToMeter[from]!;
  return inMeters / conversionToMeter[to]!;
}

// Weight conversion
double _convertWeight(double value, String from, String to) {
  const conversionToGram = {
    'Grams': 1.0,
    'Kilograms': 1000.0,
    'Pounds': 453.592,
    'Ounces': 28.3495,
  };

  double inGrams = value * conversionToGram[from]!;
  return inGrams / conversionToGram[to]!;
}

// Temperature conversion
double _convertTemperature(double value, String from, String to) {
  if (from == 'Celsius') {
    if (to == 'Fahrenheit') return (value * 9 / 5) + 32;
    if (to == 'Kelvin') return value + 273.15;
  } else if (from == 'Fahrenheit') {
    if (to == 'Celsius') return (value - 32) * 5 / 9;
    if (to == 'Kelvin') return (value - 32) * 5 / 9 + 273.15;
  } else if (from == 'Kelvin') {
    if (to == 'Celsius') return value - 273.15;
    if (to == 'Fahrenheit') return (value - 273.15) * 9 / 5 + 32;
  }
  return value;
}
