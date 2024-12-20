document.addEventListener("DOMContentLoaded", () => {
  const priceInput = document.getElementById('item-price');
  console.log('DOMContentLoaded fired');

  const updatePriceDisplay = () => {
    console.log('updatePriceDisplay called');
    const inputValue = parseFloat(priceInput.value);
    console.log('inputValue:', inputValue);

    if (!isNaN(inputValue)) {
      const addTaxDom = document.getElementById('add-tax-price');
      const addRevenueDom = document.getElementById('profit');
      if (addTaxDom && addRevenueDom) {
        try {
          const taxValue = Math.floor(inputValue * 0.1);
          console.log('taxValue:', taxValue);
          addTaxDom.innerHTML = taxValue;
          const revenueValue = Math.floor(inputValue - taxValue);
          console.log('revenueValue:', revenueValue);
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
    console.log('price function called');
    if (priceInput) {
      priceInput.removeEventListener("input", updatePriceDisplay);
      priceInput.addEventListener("input", updatePriceDisplay);
      console.log('Event listener added');
    } else {
      console.error('Element with ID "item-price" not found.');
    }
  };
  price();

  window.addEventListener("turbo:load", price);
  window.addEventListener("turbo:render", price);
});