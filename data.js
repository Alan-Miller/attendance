const moment = require('moment')()

const users = JSON.stringify([
  { "username": "Todd Rasband", "here": false },
  { "username": "Doug Maxfield", "here": false },
  { "username": "Alan Miller", "here": false },
  { "username": "Emily Keator", "here": false }
].map(person => Object.assign(person, { date_time: moment.format('MMM D YYYY H:mm') })));

module.exports = {
  users,
  time: moment.format('MMM D YYYY, H:mm')
}