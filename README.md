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


# Architecture Explanation
The application follows the Repository Pattern with Provider for state management.

# Architecture Flow
# Presentation Layer

Responsible for UI rendering and user interactions.

Components:

View (screens) 

Widgets

Providers

# Repository Layer

Acts as a bridge between the state and data sources.

Responsibilities:

Fetch weather data from the API

Handle data-related operations

Return results to the Provider

# Data Layer

Responsible for managing data from different sources.

Components:

Weather Model
Local Storage Service (Hive)

# State Management

Provider is used to:

Manage loading states

Update weather information

Handle cached data

Manage recent searches

Notify the UI when state changes

# Local Storage

Hive is used for:

Caching the most recently viewed weather data

Storing recent city searches

Persisting the selected app theme (Dark/Light Mode)

# Offline Support

When internet connectivity is unavailable:

The application checks for cached weather data.

If cached data exists, it is displayed to the user.

The UI indicates that cached data is being shown.

If no cached data exists, an appropriate error message is displayed.

This approach ensures the application remains functional even without an active internet connection.
