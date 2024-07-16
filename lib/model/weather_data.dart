class WeatherData {
  final String mainCondition;
  final double temparature;

  WeatherData({required this.mainCondition, required this.temparature});

  factory WeatherData.fromMap(Map<String, dynamic> map) {
    return WeatherData(
      mainCondition: map['weather'][0]['main'] as String,
      temparature: map['main']['temp'] as double,
    );
  }
}
