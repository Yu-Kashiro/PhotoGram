import $, { post } from 'jquery';
import axios from 'axios'
import { csrfToken } from 'rails-ujs'
import * as ActiveStorage from "@rails/activestorage"
ActiveStorage.start();

axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()

document.addEventListener('turbolinks:load', () => {
  const headerData = $('.header');
  const dataset = headerData.data()
  const accountId = dataset.accountId

  axios.get(`/accounts/${accountId}/follows`)
  .then((response) => {
    const hasFollowed = response.data.hasFollowed
    if (hasFollowed) {
      $('.unfollow-button').removeClass('hidden')
    } else {
      $('.follow-button').removeClass('hidden')
    }
  });

  $('.follow-button').on('click', () => {
    axios.post(`/accounts/${accountId}/follows`)
    .then((response) => {
      if (response.data.status === 'ok') {
        $('.unfollow-button').removeClass('hidden')
        $('.follow-button').addClass('hidden')
        const followersCountElement = $(`.followers-count`);
        const currentFollowersCount = parseInt(followersCountElement.text(), 10);
        followersCountElement.text(`${currentFollowersCount + 1}`);
      }
      })
      .catch((e) => {
        window.alert('Error')
        console.log(e)
      })
  })

  $('.unfollow-button').on('click', () => {
    axios.post(`/accounts/${accountId}/unfollows`)
    .then((response) => {
      if (response.data.status === 'ok') {
        $('.unfollow-button').addClass('hidden')
        $('.follow-button').removeClass('hidden')
        const followersCountElement = $(`.followers-count`);
        const currentFollowersCount = parseInt(followersCountElement.text(), 10);
        followersCountElement.text(`${currentFollowersCount - 1}`);
      }
      })
      .catch((e) => {
        window.alert('Error')
        console.log(e)
      })
  })

})

