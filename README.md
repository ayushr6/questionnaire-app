# Toonsutra Questionnaire App
### Overview
The Toonsutra Questionnaire App is a platform designed to enhance the comic reading experience by integrating dynamic user interfaces, custom components, and a seamless flow between pages. This app incorporates data-driven functionality with a focus on modularity and scalability.

## Key Features
- Interactive comic browsing experience.
- Modular design with reusable components.
- Local integration of pre-defined data for a streamlined development process.

## Folder Structure
### `lib` Folder
#### `wrapper/base_wrapper.dart`

- This file acts as a navigation and layout manager for the app.

- It includes a navigation bar to switch between key sections like Home, Favorites, and Settings.

- Manages page-specific titles and consistent styling across the app.

#### `custom_page.dart`

- A reusable widget for creating pages with a consistent gradient background, title bar, and customizable content area.

### `src` Folder
#### `data/Toonsutra_Comics_Data.csv`

- Contains pre-defined comic data, including details such as title, genre, description, and image URLs.

- This CSV file is `not used` directly within the app. Instead, it is used to `update` the MongoDB `database via an API`.

### Schemas and Models:

#### `Comic Schema`

Defines the structure for storing comic data, including fields for:

- `Title`: The name of the comic.

- `Description`: A brief summary of the comic plot.

- `Genre`: Categorization into multiple genres.

- `Image URL`: Path to the comic cover image.

The schema is utilized for backend integration to ensure data consistency.

#### `User Schema`

Structures user-related data for potential features such as personalization and interaction tracking.

### Data Source
- Some comics have been `scraped from Toonsutra` using custom scraping scripts.

- The dataset `(Toonsutra_Comics_Data.csv)` forms the core data for app functionality. It is processed and `used to update the MongoDB database` via an API.

### Acknowledgments

All comic data utilized is limited to scraped content from Toonsutra and manually curated entries.

- No external sources of code (youtube, github, etc.) or resources have been used in the development of this app, aside from GPT-generated assistance and comics sourced from Toonsutra.