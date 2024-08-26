const price = () => {

const priceInput = document.getElementById("item-price");
priceInput.addEventListener("input", () => {
  const inputValue = priceInput.value;
})

const addTaxDom = document.getElementById("add-tax-price");
const addProfit = document.getElementById("profit");
priceInput.addEventListener("input", () => {
  const price = parseInt(priceInput.value) || 0;
  const tax = Math.floor(price * 0.1);
  const profit = Math.floor(price - tax);
  addTaxDom.innerHTML = tax;
  addProfit.innerHTML = profit;
});

};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);
