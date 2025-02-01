import ReactRailsUJS from "react_ujs";

// ✅ Manually import and register React components
import ProductList from "./components/ProductList";

const registeredComponents = {
  ProductList,
};

// Register all components with ReactRailsUJS
ReactRailsUJS.register(registeredComponents);

console.log("✅ React components registered:", registeredComponents);
