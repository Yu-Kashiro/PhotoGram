import $ from 'jquery';
import axios from 'axios'
import { csrfToken } from 'rails-ujs'
import * as ActiveStorage from "@rails/activestorage"
ActiveStorage.start();

axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()

// ページが読み込まれたときに実行される処理
document.addEventListener("DOMContentLoaded", () => {
  const posts = $('.post-container');
  posts.each((index, post) => {
    const dataset = $(post).data()
    const postId = dataset.postId

    axios.get(`/posts/${postId}/like`)
    .then((response) => {
      const hasLiked = response.data.hasLiked
      if (hasLiked) {
        $(`.active-heart[data-post-id="${postId}"]`).removeClass('hidden')
      } else {
        $(`.inactive-heart[data-post-id="${postId}"]`).removeClass('hidden')
      }
    })
  });

  $('.inactive-heart').on('click', () => {
    const postId = event.target.dataset.postId
    axios.post(`/posts/${postId}/like`)
    .then((response) => {
      if (response.data.status === 'ok') {
        $(`.active-heart[data-post-id="${postId}"]`).removeClass('hidden')
        $(`.inactive-heart[data-post-id="${postId}"]`).addClass('hidden')
        const likesCountElement = $(`.likes-count[data-post-id="${postId}"]`);
        const likesText = likesCountElement.data('likes-text');
        const currentLikesCount = parseInt(likesCountElement.text(), 10);
        likesCountElement.text(`${currentLikesCount + 1} ${likesText}`);
      }
      })
      .catch((e) => {
        window.alert('Error')
        console.log(e)
      })
  })

  $('.active-heart').on('click', () => {
    const postId = event.target.dataset.postId
    axios.delete(`/posts/${postId}/like`)
    .then((response) => {
      if (response.data.status === 'ok') {
        $(`.active-heart[data-post-id="${postId}"]`).addClass('hidden')
        $(`.inactive-heart[data-post-id="${postId}"]`).removeClass('hidden')
        const likesCountElement = $(`.likes-count[data-post-id="${postId}"]`);
        const likesText = likesCountElement.data('likes-text');
        const currentLikesCount = parseInt(likesCountElement.text(), 10);
        likesCountElement.text(`${currentLikesCount - 1} ${likesText}`);
      }
      })
      .catch((e) => {
        window.alert('Error')
        console.log(e)
      })
  })

})
