const ReactRailsUJS = require("react_ujs");

import ProductsIndex from "./components/products/ProductsIndex";

const components = {
  ProductsIndex
};

// Register all components with ReactRailsUJS
if (ReactRailsUJS && typeof ReactRailsUJS.useContext === "function") {
  ReactRailsUJS.useContext((key) => components[key]);
  console.log("✅ React components registered:", components);
} else {
  console.error("❌ ReactRailsUJS.useContext is not available!", ReactRailsUJS);
}
