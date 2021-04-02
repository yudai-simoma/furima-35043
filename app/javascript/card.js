const pay = () => {
  // PAY.JPテスト公開鍵
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY); 
  // フォーム送信時にイベントが発火するコード
  const form = document.getElementById("charge-form");
  form.addEventListener("submit", (e) => {
    // 通常のrailsでのフォーム送信をキャンセルした
    e.preventDefault();

    // "charge-form"というidでフォームの情報を取得
    const formResult = document.getElementById("charge-form");
    // フォームに入力された値を取得し、formDataに値を渡している
    const formData = new FormData(formResult);

    // 生成したFormDataオブジェクトから、クレジットカードに関する情報を取得し、変数cardに代入している
    // getの後ろにはname属性の値を入れている（検証ツールで確認できる）
    const card = {
      number: formData.get("purchaser_address[number]"),
      cvc: formData.get("purchaser_address[cvc]"),
      exp_month: formData.get("purchaser_address[exp_month]"),
      exp_year: `20${formData.get("purchaser_address[exp_year]")}`,
    };
    // カード情報をPAY.JP側に送りトークン化するコード
    // 第一引数のcardは、PAY.JP側に送るカードの情報
    // 第二引数のcallbackには、PAY.JP側からトークンが送付された後に実行する処理を記述
    Payjp.createToken(card, (status, response) => {
      if (status == 200) {
        const token = response.id;
        // トークンの値をフォームに含める記述
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }

      // クレジットカードの情報を削除
      document.getElementById("card-number").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");
      document.getElementById("card-cvc").removeAttribute("name");

      // フォームの情報をサーバーサイドに送信
      document.getElementById("charge-form").submit();
    });
  });
};

window.addEventListener("load", pay);