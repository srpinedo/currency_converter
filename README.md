MVVM Architecture - Currency Converter
Implemented MVVM Pattern
🏗️ Model

CurrencyData.swift: Defines the data structure for currencies

CurrencyService.swift: Handles communication with the external API

🧠 ViewModel

CurrencyConverterViewModel.swift:

Contains all the business logic

Manages the application state

Communicates with the Model (CurrencyService)

Provides formatted data to the Views

🎨 View

ContentView.swift: Main view that orchestrates all components

CurrencySelectionView.swift: Component for selecting currencies

AmountInputView.swift: Component for entering amounts

ExchangeRateView.swift: Component for displaying rates and results

CurrencyPickerView.swift: Modal for selecting currencies

Benefits of this Architecture
✅ Separation of Concerns

Views: Only responsible for presentation

ViewModel: Handles business logic and state

Models: Manage data and services

✅ Testability

The ViewModel can be tested independently

Services can be easily mocked

Views are reusable components

✅ Maintainability

More organized and easy-to-understand code

UI changes don’t affect business logic

Easy to add new features

✅ Reusability

View components can be reused

The ViewModel can be shared across different Views

Services can be used by other ViewModels

Data Flow
User Action → View → ViewModel → Service → API
                ↑                           ↓
                ← View ← ViewModel ← Service ←


User interacts with the View

View notifies the ViewModel

ViewModel processes the business logic

ViewModel calls the Service

Service makes the API request

Data flows back through the chain

View updates automatically

Technical Features

@Published: For automatic binding between ViewModel and View

@StateObject: To maintain the ViewModel instance

@Binding: For two-way communication between Views

Async/Await: For asynchronous network operations

Combine: For reactive programming (implicit in @Published)