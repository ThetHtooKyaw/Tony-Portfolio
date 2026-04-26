# tony_portfolio

A responsive Flutter web portfolio showcasing Tony's skills, projects, awards, and contact information.

---

## 🚀 Features

- **Responsive Design:** Adapts seamlessly to desktop, tablet, and mobile screens.
- **Animated UI:** Smooth transitions and interactive hover effects throughout.
- **Portfolio Sections:**
  - **Home:** Introduction, experience, and projects.
  - **Awards:** Major and minor certificates, with detailed certificate views.
  - **Contact:** Contact form with validation and feedback.
- **Navigation:** Fast, declarative routing using `go_router`.
- **Theming:** Custom color scheme and typography.
- **Robust Testing:** Includes unit and widget tests for reliability.

---

## 🗂️ Project Structure

```
lib/
  core/
    data/           # Static data for menu, skills, projects, etc.
    status/         # Success/Failure result classes
    theme/          # App colors, formats, and theme
    utils/          # Snackbars, base view model, router
  src/
    not_found_view.dart
    award/
      views/        # Award and certificate screens
      widgets/      # Award-related widgets
    contact/
      repo/         # Contact service
      view_model/   # Contact form logic
      views/        # Contact screen
      widgets/      # (reserved for contact widgets)
    home/
      views/        # Home sections
      widgets/      # Home-related widgets
    widgets/        # Shared widgets (app bar, menu buttons, etc.)
main.dart           # App entry point
```

---

## 🧪 Testing

- **Unit & Widget Tests:** Located in the `test/` directory.
- Run all tests with:
  ```sh
  flutter test
  ```

---

## 🛠️ Getting Started

1. **Clone the repository:**

   ```sh
   git clone https://github.com/yourusername/tony_portfolio.git
   cd tony_portfolio
   ```

2. **Install dependencies:**

   ```sh
   flutter pub get
   ```

3. **Run the app:**
   ```sh
   flutter run -d chrome
   ```

---

## 📄 License

This project is for personal portfolio use.  
Feel free to explore and adapt for your own learning!

---

## 🙋‍♂️ About

Built and maintained by Tony Johnson.  
For questions or feedback, please use the contact form in the app.
