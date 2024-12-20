document.addEventListener('DOMContentLoaded', () => {
  if (gon.payjp_public_key) {
    let payjpInitialized = false;

    const pay = () => {
      const form = document.getElementById('charge-form');
      if (!form) {
        console.log("This is not the purchase page.");
        return; 
      }

      if (payjpInitialized) {
        return;
      }
      payjpInitialized = true;

      const publicKey = gon.payjp_public_key;
      if (!publicKey) {
        console.error("Public key is not defined");
        return;
      }
      const payjp = Payjp(publicKey);
      const elements = payjp.elements();
      const numberElement = elements.create('cardNumber');
      const expiryElement = elements.create('cardExpiry');
      const cvcElement = elements.create('cardCvc');

      numberElement.mount('#number-form');
      expiryElement.mount('#expiry-form');
      cvcElement.mount('#cvc-form');

      form.addEventListener("submit", (e) => {
        payjp.createToken(numberElement).then(function (response) {
          if (response.error) {
            // ここでエラーを処理
          } else {
            const token = response.id;
            const tokenObj = `<input value=${token} name='token' type="hidden">`;
            form.insertAdjacentHTML("beforeend", tokenObj);
          }
          numberElement.clear();
          expiryElement.clear();
          cvcElement.clear();
          form.submit();
        });
        e.preventDefault();
      });
    };

    // DOMContentLoadedのタイミングで、`charge-form`が存在する場合のみpay関数を呼び出す
    document.addEventListener("turbo:load", pay);
    document.addEventListener("turbo:render", pay);

    // 初回読み込み時も実行
    pay();
  } else {
    console.log('PAYJP public key is not set.');
  }
});