window.addEventListener('load', () => {

  // 金額を入力した数値をpriceInputという変数に格納する
  const priceInput = document.getElementById("item-price");
  // 値が入力されるたびにイベントが発火する
  priceInput.addEventListener("input", () => {
    // 入力した金額の値を取得する
    const inputValue = priceInput.value;
  })

  // 販売手数料が表示される数値をtaxInputという変数に格納する
  const addTaxDom = document.getElementById("add-tax-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const Tax = 0.1;
    const Price = inputValue * Tax;
    const allTaxPrice = Math.floor(Price);
    addTaxDom.innerHTML = allTaxPrice
  })
  
  // 販売利益が表示される数値をprofitInputという変数に格納する
  const profitDom = document.getElementById("profit");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const Tax = 0.1;
    const Price = inputValue * Tax;
    const allTaxPrice = Math.floor(Price);
    const profitPrice = inputValue - allTaxPrice;
    profitDom.innerHTML = Math.floor(profitPrice);
  })
});
