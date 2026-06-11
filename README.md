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

The application follows the **Repository Pattern**, separating the presentation, repository, and data layers to create a clean, maintainable, and scalable architecture.

## Project Structure

```text
lib
│
├── features
│   └── home
│       ├── data
│       │   ├── local
│       │   └── model
│       │
│       ├── presentation
│       │   ├── provider
│       │   ├── view
│       │   └── widgets
│       │
│       └── repo
│
├── general
│   ├── core
│   ├── services
│   ├── utils
│   └── widgets
│
└── main.dart
```

## Features Folder

The `features` folder contains all feature-specific modules. Each feature is divided into separate layers to maintain a clear separation of responsibilities.

### Data Layer

Responsible for handling and managing data.

**Components:**

* Models
* Local Storage (Hive)

### Presentation Layer

Responsible for UI rendering and user interactions.

**Components:**

* Views (Screens)
* Widgets
* Providers

### Repository Layer

Acts as a bridge between the presentation layer and data sources.

**Responsibilities:**

* Fetch weather data from the OpenWeather API
* Handle data-related operations
* Return processed results to the Provider

## General Folder

The `general` folder contains reusable resources shared across the entire application.

### Core

Contains application-wide configurations and constants.

**Examples:**

* API endpoints
* App constants
* Global configurations

### Services

Contains reusable services shared across multiple features.

**Examples:**

* Network services
* Connectivity services
* Storage services

### Utils

Contains utility classes and helper functions.

**Examples:**

* App colors
* Extensions
* Common helper methods

### Widgets

Contains reusable widgets used across multiple features.

**Examples:**

* Custom buttons
* Custom text fields
* Common loading indicators

## State Management

**Provider** is used to:

* Manage loading states
* Update weather information
* Handle cached data
* Manage recent searches
* Notify the UI when state changes

## Local Storage

**Hive** is used for:

* Caching the most recently viewed weather data
* Storing recent city searches
* Persisting the selected app theme (Dark/Light Mode)

## Offline Support

When internet connectivity is unavailable:

1. The application checks for cached weather data.
2. If cached data exists, it is displayed to the user.
3. The UI indicates that cached data is being shown.
4. If no cached data exists, an appropriate error message is displayed.

This ensures the application remains functional even without an active internet connection.

