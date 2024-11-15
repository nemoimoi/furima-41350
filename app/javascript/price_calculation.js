document.addEventListener("DOMContentLoaded", () => {
  const priceInput = document.getElementById('item-price');

      const updatePriceDisplay = () => {
        const inputValue = parseFloat(priceInput.value);

        if (!isNaN(inputValue)) {
          const addTaxDom = document.getElementById('add-tax-price');
          const addRevenueDom = document.getElementById('profit');

          if (addTaxDom && addRevenueDom) {
            try {
              const taxValue = Math.floor(inputValue * 0.1);
              addTaxDom.innerHTML = taxValue;

              const revenueValue = Math.floor(inputValue - taxValue);
              addRevenueDom.innerHTML = revenueValue;

            } catch (error) {
              console.error("Error updating values:", error);
            }
          } else {
            console.error("Element with ID 'add-tax-price' or 'profit' not found.");
          }
        } else {
          console.error("The value entered is not a valid number.");
        }
      };

    const price = () => {
      if (priceInput) {
        priceInput.removeEventListener("input", updatePriceDisplay);
        priceInput.addEventListener("input", updatePriceDisplay);
      }
    };

    price();
    window.addEventListener("turbo:load", price);
    window.addEventListener("turbo:render", price);
});