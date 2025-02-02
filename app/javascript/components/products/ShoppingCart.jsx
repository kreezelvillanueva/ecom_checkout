import React from "react";
import PropTypes from "prop-types";

const ShoppingCart = ({ cart,  removeFromCart }) => {
  console.log("✅ Shopping Cart Loaded:", cart);

  // ✅ Compute Total Price
  const total = cart.reduce((sum, item) => sum + item.product.price * item.quantity, 0);

  // ✅ Calculate Discount Based on Total
  let discount = 0;
  if (total > 100) discount = 0.2; // 20% off
  else if (total > 50) discount = 0.15; // 15% off
  else if (total > 20) discount = 0.1; // 10% off

  const discountAmount = total * discount;
  const discountedTotal = total - discountAmount;

  return (
    <div className="shopping-cart">
      <h2>Shopping Cart</h2>
      {cart.length === 0 ? (
        <p className="empty-cart-message">Your cart is empty.</p>
      ) : (
        <table className="cart-table">
          <thead>
            <tr>
              <th>Product</th>
              <th>Unit Price</th>
              <th>Quantity</th>
              <th>Total Cost</th>
            </tr>
          </thead>
          <tbody>
            {cart.map((item) => (
              <tr key={item.product.uuid}>
                <td>{item.product.name}</td>
                <td style={{ textAlign: "right" }}>${parseFloat(item.product.price).toFixed(2)}</td>
                <td style={{ textAlign: "right" }}>{item.quantity}</td>
                <td style={{ textAlign: "right" }}>${(item.product.price * item.quantity).toFixed(2)}</td>
                <td>
                  <button class="btn btn-danger" href="#">
                    <span onClick={() => removeFromCart(item.id)}>
                      Remove
                    </span>
                  </button>
                </td>
              </tr>
            ))}
            {/* 🛠 Horizontal Rule (Empty row with border to act as a separator) */}
            <tr>
              <td colSpan="4">
                <hr></hr>
              </td>
            </tr>
            {/* 🛠 Row for Total */}

            <tr>
              <td colSpan="3" style={{ textAlign: "left", fontWeight: "bold" }}>Total:</td>
              <td style={{ textAlign: "right", fontWeight: "bold" }}>${total.toFixed(2)}</td>
            </tr>

            {/* 🛠 Row for Discount (Only shows if discount is applied) */}
            {discount > 0 && (
              <tr>
                <td colSpan="3" style={{ textAlign: "left", fontWeight: "bold" }}>Discount Applied ({discount * 100}%):</td>
                <td style={{ textAlign: "right", fontWeight: "bold", color: "green" }}>-${discountAmount.toFixed(2)}</td>
              </tr>
            )}

            {/* 🛠 Row for Grand Total */}
            <tr>
              <td colSpan="3" style={{ textAlign: "left", fontWeight: "bold" }}>Grand Total:</td>
              <td style={{ textAlign: "right", fontWeight: "bold", fontSize: "18px" }}>${discountedTotal.toFixed(2)}</td>
            </tr>
          </tbody>
        </table>
      )}
    </div>
  );
};

// ✅ Prop Types Validation
ShoppingCart.propTypes = {
  cart: PropTypes.array.isRequired,
  removeFromCart: PropTypes.func.isRequired,
};

export default ShoppingCart;
