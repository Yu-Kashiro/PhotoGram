import $ from 'jquery';
import axios from 'axios'
import { csrfToken } from 'rails-ujs'

axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()

document.addEventListener('turbolinks:load', () => {
  const postId = $('.comment-container').data('post-id');

  axios.get(`/posts/${postId}/comments`, {
    headers: {
      'Accept': 'application/json'
    }
  })
  .then((response) => {
    const comments = response.data
    comments.forEach((comment) => {
      $('.comment-container').append(
        `<div class="comment-box">
          <img src="${comment.avatar_url}" class="profile-image">
          <div class="comment-content">
            ${comment.account_id}
            <br>
            ${comment.content}
          </div>
        </div>`
      )
    })
  })

  // 新規コメント追加時
  $('.add-comment-button').on('click', () => {
    const content = $('#comment_content').val()
    if (!content) {
      window.alert('コメントを入力してください')
    } else {
      axios.post(`/posts/${postId}/comments`, {
        comment: {content: content}
      })
        .then((res) => {
          const comment = res.data
          $('.comment-container').append(
            `<div class="comment-box">
              <img src="${comment.avatar_url}" class="profile-image">
              <div class="comment-content">
                ${comment.account_id}
                <br>
                ${comment.content}
              </div>
            </div>`
          )
          $('#comment_content').val('')
        })
    }
  })

});