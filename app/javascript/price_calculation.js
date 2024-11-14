document.addEventListener("DOMContentLoaded", () => {
  const priceInput = document.getElementById('item-price');

  if (priceInput) {
    const price = () => {
      console.log("price function executed");

      priceInput.addEventListener("input", () => {
        const inputValue = parseFloat(priceInput.value);
        console.log("Input value:", inputValue);

        if (!isNaN(inputValue)) {
          const addTaxDom = document.getElementById('add-tax-price');
          const addRevenueDom = document.getElementById('profit');

          if (addTaxDom && addRevenueDom) {
            try {
              const taxValue = Math.floor(inputValue * 0.1);
              addTaxDom.innerHTML = taxValue;
              console.log("Updated tax value:", taxValue);

              const revenueValue = Math.floor(inputValue - taxValue);
              addRevenueDom.innerHTML = revenueValue;
              console.log("Updated revenue value:", revenueValue);
            } catch (error) {
              console.error("Error updating values:", error);
            }
          } else {
            console.error("Element with ID 'add-tax-price' or 'profit' not found.");
          }
        } else {
          console.error("The value entered is not a valid number.");
        }
      });
    };

    price();

    window.addEventListener("turbo:load", price);
  } else {
    console.log("Element with ID 'item-price' not found on this page.");
  }
});