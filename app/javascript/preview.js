// if (document.URL.match( /new/ ) || document.URL.match( /edit/ )) {
  document.addEventListener('DOMContentLoaded', function(){
  if (!document.getElementById("item-image")) {return false}
  const ImageList = document.getElementById('image-list');

  // 選択した画像を表示する関数
  const createImageHTML = (blob) => {
    // 画像を表示するためのdiv要素を生成
    const imageElement = document.createElement('div');
    imageElement.setAttribute('class', "image-element")
      let imageElementNum = document.querySelectorAll('.image-element').length

    // 表示する画像を生成
    const blobImage = document.createElement('img');
    // 画像URLをimg要素のsrc属性に設定
    blobImage.setAttribute('src', blob);
    // cssを適用させる
    blobImage.setAttribute('class', 'blob_image' );

    // ファイル選択ボタンを生成
    const inputHTML = document.createElement('input')
    inputHTML.setAttribute('id', `item_image_${imageElementNum}`)
    inputHTML.setAttribute('name', 'item[images][]')
    inputHTML.setAttribute('type', 'file')

    // 生成したHTMLの要素をブラウザに表示させる
    imageElement.appendChild(blobImage);
    imageElement.appendChild(inputHTML)
    ImageList.appendChild(imageElement);
    // 2枚目以降の画像にもイベント発火するように実装
    inputHTML.addEventListener('change', (e) => {
      file = e.target.files[0];
      blob = window.URL.createObjectURL(file);

      createImageHTML(blob)
    })
  }

  document.getElementById('item-image').addEventListener('change', function(e){
    // 編集ページは元の画像は削除してからプレビューを出す
    const imageContent = document.getElementById("item-img");
    if (imageContent){

      imageContent.remove();
    }

    // 選択した画像情報を変数に代入
    const file = e.target.files[0];
    // 取得した画像情報のURLを生成
    const blob = window.URL.createObjectURL(file);
    
    createImageHTML(blob);
    
  });
});
// }