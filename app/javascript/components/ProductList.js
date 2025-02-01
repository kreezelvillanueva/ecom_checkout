import React, { useState, useEffect } from "react";

console.log("✅ React ProductList Component is Mounted!"); // Debugging

const ProductList = () => {
  const [products, setProducts] = useState([]);

  useEffect(() => {
    console.log("Fetching products..."); // Debugging
    fetch("/products.json")
      .then(response => response.json())
      .then(data => {
        console.log("✅ Fetched Products:", data); // Debugging
        setProducts(data);
      })
      .catch(error => console.error("❌ Error fetching products:", error));
  }, []);

  return (
    <div>
      <h1>Product List</h1>
      {products.length === 0 ? (
        <p>No products available.</p>
      ) : (
        <table>
          <thead>
            <tr>
              <th>UUID</th>
              <th>Name</th>
              <th>Price</th>
            </tr>
          </thead>
          <tbody>
            {products.map((product) => (
              <tr key={product.uuid}>
                <td>{product.uuid}</td>
                <td>{product.name}</td>
                <td>${product.price}</td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </div>
  );
};

ReactRailsUJS.register({ ProductList });

export default ProductList;
