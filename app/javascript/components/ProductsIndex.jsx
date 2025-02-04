import React, { useState, useEffect } from "react";
import ProductList from "./ProductList";
import ShoppingCart from "./ShoppingCart";
import ProductUpload from "./ProductUpload";

console.log("React ProductsIndex Component is Mounted!");

const ProductsIndex = () => {
  const [products, setProducts] = useState([]);
  const [cart, setCart] = useState([]);

  //  Fetch products function
  const fetchProducts = () => {
    fetch("/products.json")
      .then(response => response.json())
      .then(data => {
        console.log(" Loaded Products:", data);
        setProducts(data);
      })
      .catch(error => console.error("❌ Error loading products:", error));
  };

  //  Fetch cart function
  const fetchCart = () => {
    fetch("/carts.json")
      .then(response => response.json())
      .then(data => {
        console.log(" Loaded Cart:", data);
        setCart(data);
      })
      .catch(error => console.error("❌ Error loading cart:", error));
  };

  //  Ensure both cart & products load on first render
  useEffect(() => {
    fetchProducts();
    fetchCart();
  }, []);

  const getCSRFToken = () => {
    return document.querySelector('meta[name="csrf-token"]').getAttribute("content");
  };

  //  Function to add product to cart
  const addToCart = (product) => {
    fetch(`/carts/${product.uuid}`, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": getCSRFToken(),
      },
      body: JSON.stringify({ product_id: product.uuid }), //  Use UUID
    })
      .then(response => {
        if (!response.ok) {
          return response.text().then(text => {
            throw new Error(text);
          });
        }
        return response.json();
      })
      .then(updatedCartItems => {
        console.log(" Cart Updated:", updatedCartItems);

        setCart(prevCart => {
          const cartMap = new Map();

          prevCart.forEach(item => {
            cartMap.set(item.product.uuid, { ...item });
          });

          updatedCartItems.forEach(item => {
            if (cartMap.has(item.product.uuid)) {
              cartMap.get(item.product.uuid).quantity = item.quantity;
            } else {
              cartMap.set(item.product.uuid, { ...item });
            }
          });

          return Array.from(cartMap.values());
        });
      })
      .catch(error => console.error("❌ Error updating cart:", error));
  };

  const removeFromCart = (cartItemId) => {
    fetch(`/carts/${cartItemId}`, {
      method: "DELETE",
      headers: { "X-CSRF-Token": getCSRFToken() },
    })
    .then(response => {
      if (!response.ok) {
        return response.text().then(text => {
          throw new Error(text);
        });
      }
      return response.json();
    })
    .then(() => {
      console.log(" Item Deleted. Fetching updated cart...");
      fetchCart();
    })
    .catch(error => console.error("Error removing item from cart:", error));
  };
  

  return (
    <div>
      <h1>Marketplace</h1>
      <ProductUpload onUploadSuccess={fetchProducts} />
      <ProductList products={products} addToCart={addToCart} />
      <ShoppingCart cart={cart} removeFromCart={removeFromCart} />
    </div>
  );
};

export default ProductsIndex;
