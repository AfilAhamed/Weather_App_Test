# weather_app_task

# Setup Instructions

# API
OpenWeather API is used to fetch real-time weather data based on the searched city.

# Packages Used

# Provider
Used for state management.

# Hive & Hive Flutter
Used to support local storage.

Stores:
Last viewed weather data
Recent search history
User theme preference (Dark/Light Mode)

# Connectivity Plus

Used to monitor internet connectivity.

Responsibilities:
Detect online/offline status
Load cached data when internet is unavailable

# Dio
Used for making API requests to OpenWeather API and handling responses.

# Shimmer
Used to display loading placeholders while weather data is being fetched.

# Toastification
Used to display user feedback messages such as:

Invalid city name
Network errors
Offline cache notifications

# Gap
Used for maintaining consistent spacing throughout the UI.
