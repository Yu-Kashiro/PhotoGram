// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import $, { post } from 'jquery';
import axios from 'axios'
import { csrfToken } from 'rails-ujs'
import * as ActiveStorage from "@rails/activestorage"
ActiveStorage.start();

axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()


document.addEventListener('turbolinks:load', () => {
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
        const currentLikesCount = parseInt(likesCountElement.text(), 10);
        likesCountElement.text(`${currentLikesCount + 1} likes`);
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
        const currentLikesCount = parseInt(likesCountElement.text(), 10);
        likesCountElement.text(`${currentLikesCount - 1} likes`);
      }
      })
      .catch((e) => {
        window.alert('Error')
        console.log(e)
      })
  })

})
