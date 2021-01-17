window.addEventListener('load', () => {

  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
 
    const addTaxDom = document.getElementById("add-tax-price");
    addTaxDom.innerHTML = Math.floor(inputValue * 0.1).toLocaleString()

    const addTaxDom2 = document.getElementById("profit");
    addTaxDom2.innerHTML = Math.floor(inputValue * 0.9).toLocaleString()
  })
});