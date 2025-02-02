import React from "react";
import PropTypes from "prop-types";

console.log("✅ React ProductList Component is Mounted!");

const ProductList = ({ products, addToCart }) => {
  return (
    <div>
      <h2>Product List</h2>
      {products.length === 0 ? (
        <p>No products available.</p>
      ) : (
        <table>
          <thead>
            <tr>
              <th>UUID</th>
              <th>Name</th>
              <th>Price</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            {products.map((product) => (
              <tr key={product.uuid}>
                <td>{product.uuid}</td>
                <td>{product.name}</td>
                <td>${parseFloat(product.price).toFixed(2)}</td>
                <td>
                  <button 
                    onClick={() => addToCart(product)} 
                    className="add-to-cart-btn"
                  >
                    Add to Cart
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </div>
  );
};

// ✅ Prop Validation to catch potential issues
ProductList.propTypes = {
  products: PropTypes.array.isRequired,
  addToCart: PropTypes.func.isRequired,
};

export default ProductList;
