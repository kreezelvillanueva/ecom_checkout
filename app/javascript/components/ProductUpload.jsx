import React, { useState } from "react";

const ProductUpload = ({ onUploadSuccess }) => {
  const [selectedFile, setSelectedFile] = useState(null);

  const getCSRFToken = () => {
    return document.querySelector('meta[name="csrf-token"]').getAttribute("content");
  };

  const handleFileChange = (event) => {
    setSelectedFile(event.target.files[0]);
  };

  const handleUpload = async () => {
    if (!selectedFile) {
      alert("Please select a file.");
      return;
    }

    const formData = new FormData();
    formData.append("file", selectedFile);

    try {
      const response = await fetch("/products", {
        method: "POST",
        headers: {
          "X-CSRF-Token": getCSRFToken(),
        },
        body: formData,
      });

      if (!response.ok) throw new Error("Upload failed!");

      alert("File successfully uploaded!");

      onUploadSuccess();
    } catch (error) {
      console.error("Upload error:", error);
      alert("Upload failed. Please try again.");
    }
  };

  return (
    <div>
      <h2>Upload Products</h2>
      <input type="file" onChange={handleFileChange} />
      <button onClick={handleUpload}>Upload</button>
    </div>
  );
};

export default ProductUpload;
