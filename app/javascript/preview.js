if (document.URL.match( /new/ ) || document.URL.match( /edit/ )) {
document.addEventListener('DOMContentLoaded', function(){
  const ImageList = document.getElementById('image-list');

  // 選択した画像を表示する関数
  const createImageHTML = (blob) => {
    // 画像を表示するためのdiv要素を生成
    const imageElement = document.createElement('div');

    // 表示する画像を生成
    const blobImage = document.createElement('img');
    // 画像URLをimg要素のsrc属性に設定
    blobImage.setAttribute('src', blob);
    // cssを適用させる
    blobImage.setAttribute('class', 'blob_image' );
    // 生成したHTMLの要素をブラウザに表示させる
    imageElement.appendChild(blobImage);
    ImageList.appendChild(imageElement);
  };

  document.getElementById('item-image').addEventListener('change', function(e){
    // 画像が表示されている場合のみ、すでに存在している画像を削除する
    const imageContent = document.querySelector('img');
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
}