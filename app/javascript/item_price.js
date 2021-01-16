window.addEventListener('load', function(){

  const pullDownButton = document.getElementById("item-price")
  console.log(pullDownButton)

  const priceInput = document.getElementById("金額を入力する場所のid");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
  })

  const addTaxDom = document.getElementById("販売手数料を表示する場所のid");
    addTaxDom.innerHTML = "入力した金額をもとに販売手数料を計算する処理"
})