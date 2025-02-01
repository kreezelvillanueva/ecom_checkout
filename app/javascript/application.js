import "@hotwired/turbo-rails";
import "./controllers";
import ReactRailsUJS from "react_ujs";

console.log("✅ Rails JavaScript Loaded - React should be initializing now...");
// Ensure React components are loaded from `app/javascript/components/`
ReactRailsUJS.useContext(require.context("components", true, /\.js$/));

console.log("✅ ReactRailsUJS:", ReactRailsUJS);
