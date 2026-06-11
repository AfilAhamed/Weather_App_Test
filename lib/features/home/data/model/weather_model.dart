class WeatherModel {
  String? cityName;
  double? temp;
  double? wind;
  int? humidity;
  int? pressure;
  String? condition;
  bool isShowingCachedData = false;

  WeatherModel({
    this.cityName,
    this.temp,
    this.wind,
    this.humidity,
    this.pressure,
    this.condition,
    this.isShowingCachedData = false,
  });

  WeatherModel.fromJson(Map<String, dynamic> json) {
    cityName = json["name"];
    temp = json["main"]["temp"];
    wind = json["wind"]["speed"];
    pressure = json["main"]["pressure"];
    humidity = json["main"]["humidity"];
    condition = json["weather"][0]["main"];
  }

  Map<String, dynamic> toMap() {
    return {
      'cityName': cityName,
      'temp': temp,
      'wind': wind,
      'humidity': humidity,
      'pressure': pressure,
      'condition': condition,
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    return WeatherModel(
      cityName: map['cityName'],
      temp: map['temp'],
      wind: map['wind'],
      humidity: map['humidity'],
      pressure: map['pressure'],
      condition: map['condition'],
    );
  }

  WeatherModel copyWith({
    String? cityName,
    double? temp,
    double? wind,
    int? humidity,
    int? pressure,
    String? condition,
    bool? isShowingCachedData,
  }) {
    return WeatherModel(
      cityName: cityName ?? this.cityName,
      temp: temp ?? this.temp,
      wind: wind ?? this.wind,
      humidity: humidity ?? this.humidity,
      pressure: pressure ?? this.pressure,
      condition: condition ?? this.condition,
      isShowingCachedData: isShowingCachedData ?? this.isShowingCachedData,
    );
  }
}
