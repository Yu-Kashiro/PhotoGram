import $, { post } from 'jquery';
import axios from 'axios'
import { csrfToken } from 'rails-ujs'
import * as ActiveStorage from "@rails/activestorage"
ActiveStorage.start();

axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()
// プロフィール写真関係
document.addEventListener('turbolinks:load', () => {
  $('.profile-pic').on('click', () => {
    $('#profile-pic-input').click();
  });

  $('#profile-pic-input').on('change', (event) => {
    const file = event.target.files[0];
    if (file) {
      // 画像のプレビュー表示
      const reader = new FileReader();
      reader.onload = (e) => {
        $('.profile-pic').attr('src', e.target.result);
      };
      reader.readAsDataURL(file);

      // サーバーに画像をアップロード
      uploadProfileAvatar(file);
    }
  });
});

function uploadProfileAvatar(file) {
  const formData = new FormData();
  formData.append('avatar', file);

  axios.put('/profile', formData, {
    headers: {
      'Content-Type': 'multipart/form-data'
    }
  })
  .then(response => {
    console.log('アップロード成功', response.data);
    $('.profile-pic').attr('src', response.data.url); // 新しい画像URLを適用
  })
  .catch(error => {
    console.error('アップロード失敗', error);
    alert('アップロードに失敗しました。');
  });
}
