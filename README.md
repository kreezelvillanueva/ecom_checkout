# Ecom Checkout - Marketplace Checkout System

## 📌 Project Overview

Ecom Checkout is a **Marketplace Checkout System** built with **Ruby on Rails 7** and **React.js**. It allows users to upload product listings, add items to a shopping cart, apply discounts, and calculate totals dynamically.

## 🛠 Tech Stack

- **Backend:** Ruby on Rails 7 (API mode enabled for JSON responses)
- **Frontend:** React.js (Rendered via Rails views using `react-rails` gem)
- **Database:** PostgreSQL
- **Package Manager:** Yarn
- **Build Tool:** ESBuild
- **Testing:** RSpec (Rails) & Jest (React)
- **Containerization:** Docker & Docker Compose

---

## 🚀 Features

1. **Upload Products**: Users can upload a JSON file containing product details.
2. **View Products**: List all available products dynamically fetched from the database.
3. **Shopping Cart**: Add items to the cart and remove items.
4. **Discounts Applied**:
   - **10% off** for orders greater than **$20**
   - **15% off** for orders greater than **$50**
   - **20% off** for orders greater than **$100**
5. **Order Total Calculation**: Displays total price, applied discount, and final amount.
6. **Persistent Cart**: Cart data is saved in the database per user session.

---

## 🛠 Setup Instructions

### 🔹 Prerequisites

Ensure you have the following installed:

- **Docker & Docker Compose**
- **Ruby 3.3** (managed via `rbenv` or `rvm`)
- **PostgreSQL**
- **Node.js** & **Yarn**

### 🔹 Installation

1. **Clone the repository**

   ```sh
   git clone https://github.com/your-username/ecom_checkout.git
   cd ecom_checkout
   ```

2. **Start the application using Docker**

   ```sh
   make setup
   make start
   ```

   This will build the app, install dependencies, create the database, and run the server.

3. **Run database migrations**

   ```sh
   make migrate
   ```

4. **Seed sample data (Optional)**

   ```sh
   make seed
   ```

5. **Access the application**

   - **Frontend:** `http://localhost:3000`
   - **API Endpoints:** `http://localhost:3000/products.json` & `http://localhost:3000/cart.json`

6. **Stop the application**

   ```sh
   make stop
   ```

---

## 🛒 Usage

### 1️⃣ Upload Products

- Navigate to `Upload Products`
- Select a **products.json** file and upload

Example JSON format:

```json
[
  { "uuid": 1411, "name": "Jockey Wheels - Orange", "price": "15.39" },
  { "uuid": 23881, "name": "Chain Ring 146mm", "price": "65.95" }
]
```

### 2️⃣ View Product List

- Products are dynamically listed after uploading.

### 3️⃣ Add Products to Cart

- Click **Add to Cart** next to any product.
- The shopping cart updates instantly.

### 4️⃣ View Shopping Cart

- Displays the list of added items, unit prices, total costs, and discounts.
- Users can remove items from the cart.

### 5️⃣ Apply Discounts Automatically

- Discount logic applies based on total cart value.

---

## ✅ Testing

### 🔹 Run RSpec Tests (Rails API)

```sh
make test
```

### 🔹 Run Jest Tests (React Components)

```sh
make test-js
```

---

## 🚀 Future Improvements

- Implement user authentication (Devise + JWT)
- Add checkout functionality
- Store past orders
- Improve UI styling with TailwindCSS or Bootstrap

---

## 📜 License

This project is licensed under the MIT License.

---

## 🤝 Contributions

Contributions are welcome! Please open an issue or create a pull request with improvements.

---

## 📝 Authors

- **Your Name** - [GitHub Profile](https://github.com/your-username)

---

🎉 **Happy Coding!** 🎉

