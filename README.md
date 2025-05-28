
This project uses for API test automation. It supports BDD-style tests and integrates with Maven and JUnit5.

## 📁 Project Structure


```
project-root/
├── src/
│   └── test/
│       ├── java/
│       │   └── TestRunner.java
│       │       
│       └── resources/
│           ├── features/
│           │  
│           └── data/
│              
├── pom.xml
└── README.md
```
---

## ⚙️ Technologies Used

- Java 16+
- Karate 
- JUnit 5
- Maven

---

---

## ✅ Assumptions

- API definitions are based on a Swagger. [https://petstore.swagger.io]
- Test data (e.g., payloads) is stored in `.json` files under `src/test/resources/data/`.
- Feature files are located under `src/test/resources/features/`.
- Test runner is located under `src/test/java/TestRunner`.
- The Karate test runner uses JUnit5.
- Use Maven for dependency and build management.

---

---

## 🛠️ How to Set Up

1. **UnZip the file:**

2. **Install dependencies:**

   Ensure Maven and Java 16+ are installed, then run:

   ```bash
   mvn clean install
   ```

---
## 🚀 How to Run Tests

Use the test runner located at `src/test/java/TestRunner`