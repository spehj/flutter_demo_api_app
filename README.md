# Flutter Demo API App
A simple Flutter demo app for fetching data from the api to display logs on selected dates.

### Features
- [x] One screen
- [x] Three data types: Row with dates of one week, ListView with logs of selected date, Navigation bar "Home"
- [x] Fetch access token from server using auth secrets from .env file.
- [x] Saves token in SecureStorage.
- [x] Fetch logs from api for each chosen week.
- [x] Page view with logs for selected dates with swipe left/right functionality.
- [x] Option to select date by tapping on a date in top Row.
- [x] Arrows to move 1 week forward or backward. Each move makes a new request for Logs of new week.
- [x] Option to choose year for fetching Logs.
- [x] Home button which moves screen to first day of first week of 2020.
- [ ] Dynamic widget size using MediaQuery (not implemented yet).
# Setup/build instructions
Follow these steps to build the app:

1. Clone this repository.
2. In home directory of this project create a .env file.
3. Copy this text and change __your-secret-data__ with your credentials:
~~~
GRANT_TYPE=your-secret-data
EMAIL=your-secret-data
PASSWORD=your-secret-data
CLIENT_ID=your-secret-data
~~~

3. Build and run the app.

## How it looks
<img src="https://user-images.githubusercontent.com/62114221/229529968-7ea9e2db-c07f-4c24-a3a5-4e9fdfd468f0.png" width=30%>

## How it works
<img src="https://user-images.githubusercontent.com/62114221/229532843-7031fbbb-55db-41aa-bcf8-c943c341ef21.gif" width=30%>





