# Reciope-App Swift 6
## Implementing the New Concurrency and Testing Frameworks
https://github.com/user-attachments/assets/1b44bab4-9bf3-48c7-886a-61e8b73221bd
## 🔈🔈🔈 Turn the Volume on!

## Summary

This is a demo application I created to showcase the new Swift concurrency features and testing framework.

- The **ViewModel** uses `@MainActor` to ensure UI updates are performed on the main thread.
- I used **actors** for the API and Image Cache, ensuring thread-safe operations.
- All threading is handled using `Task`, `async/await`, and throwing functions.
- The project follows the **MVVM** pattern, with folders for:
  - `Views`
  - `Models` (sorted into `Local` and `API`)
  - `ViewModels`
  - `Services`
  - `Extensions`
  - In a more complex app, I would add a `Coordinators` folder to handle navigation logic.


## Focus Areas
<img width="864" alt="image" src="https://github.com/user-attachments/assets/bd4626fa-b677-4d67-bf6c-eedd44417769" />

1. **Networking Layer**  
   I designed a networking layer, focusing on abstraction and flexibility:
   - A protocol called `EndpointProtocol` was defined to abstract properties like paths and mock data, directly linked to the `enum` of endpoints.
   - A generic static `get` function abstracts the core fetch logic into an isolated, reusable static context, supporting any `Decodable` & `Sendable` conformant struct.
   - The API class provides expressive methods like `fetchRecipes()` with minimal parameterization.
   - Mocking support was added to simulate various dynamic scenarios, including valid responses, empty responses, and invalid responses.

2. **UI and Responsiveness**  
   I focused on creating a responsive UI:
   - Smooth animations were implemented for transitions between non-selected and selected states.
   - The UI handles content loading gracefully, ensuring a glitch-free experience.

3. **Image Caching**  
   The image cache was optimized for performance and testability:
   - It supports asynchronous disk writes while immediately returning the image to the caller.
   - A specific function was added to differentiate between images loaded from the network and cached images during tests.

## Testing
<img width="534" alt="image" src="https://github.com/user-attachments/assets/16a67707-7b3b-4ee4-8f9a-135d867f99d5" />

I added two groups of tests:
1. **Recipe network loading and decoding** tests.
2. **Image caching** tests, including functionality to verify caching behavior by distinguishing between network-loaded and cached images.

## Time Spent

Based on the Git history, the project took approximately **5 hours** from start to completion:
- **2 hours**: API and model layer.
- **1 hour**: Binding the user interface.
- **1 hour**: Image caching.
- **1 hour**: Refactoring and implementing test cases with the new testing framework.

## Trade-offs and Decisions

- **Singleton Approach**  
  While the app follows a traditional MVVM architecture, I used singletons for simplicity to simulate a basic dependency injection approach. This includes services like caching and the API, implemented using actors and a non-isolated singleton for the logging framework (`os.Logger`).

- **Simplistic List Display**  
  The current list implementation works well for fewer than 100 elements. A more robust implementation for larger datasets would require:
  - Using `LazyVStack` for better performance with large lists.
  - Creating a custom `UIViewRepresentable` wrapper for `UICollectionView`.

- **Pending Improvements**  
  - Adding UI tests to automate user interactions.
  - Expanding unit tests for the ViewModel functions.

## Further Work

Moving forward, I want to:
- Add UI tests automating user interactions.
- Further expand test cases for the ViewModel and each of the services to ensure better coverage.
- Improve the list display by adopting `LazyVStack` or `UICollectionView` for handling larger datasets efficiently.
- Consider adding pagination to the recipe get network call
- Expanding the Network service to support other verbs and multipart payloads

## Weakest Part of the Project

- The **list display** could benefit from optimizations like `LazyVStack` or `UICollectionView` for better handling of larger datasets.
- The **image cache** design choice prioritizes asynchronous disk writes, allowing immediate image display but requiring artificial delays (`sleep` functions) in test cases to ensure images are fully written to disk.
- The file system is used as the source of truth for the cache. While suitable for a simple app, a production-level solution would require more sophisticated strategies, such as:
  - Maintaining a secondary source of truth (e.g., a plain text file or database) to manage cache consistency.

## Additional Information

- **Canvas Previews**  
  I added canvas previews for key UI components, ensuring they reflect the canonical states and are fully functional.
- **Generics, Protocols, Macros, and Extensions**  
  The project showcases the use of generics, protocols, macros, and extensions to highlight various Swift capabilities in a typical iOS app.
- **Logging Service**  
  I added a logging service using `os.Logger` to showcase an example of telemetry in an iOS app.

<img width="876" alt="image" src="https://github.com/user-attachments/assets/5d83d2e0-8ac2-4fbc-8a60-39f5d77d79ff" />

<img width="872" alt="image" src="https://github.com/user-attachments/assets/1d34cb01-c9b9-4a66-baf8-364f8c085fd5" />

