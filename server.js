const data = JSON.stringify([{"ident": "Brennon Schow", "here": false}, {"ident": "Brock Pettyjohn", "here": false}, {"ident": "Emily Keator", "here": true}]);

// const data = {
//   "Joe Blank": true,
//   "Brack Carmony": true,
//   "Brennon Schow": true,
//   "Megan Fisher": false,
//   "Beth Telford": true,
//   "Mason Galland": false,
//   "Doug Maxfield": true,
//   "Brock Pettyjohn": true,
//   "Emily Keator": true
// }

// const data = [
//     { ident: "Joe Blank", here: true },
//     { ident: "Brack Carmony", here: true },
//     { ident: "Brennon Schow", here: true },
//     { ident: "Megan Fisher", here: false },
//     { ident: "Beth Telford", here: true },
//     { ident: "Mason Galland", here: false },
//     { ident: "Doug Maxfield", here: true },
//     { ident: "Brock Pettyjohn", here: true },
//     { ident: "Emily Keator", here: true }
// ]

const bodyParser = require('body-parser')
    , config = require('./config')
    , server_port = config.server_port
    , massive = require('massive')
    , moment = require('moment')()
    , app = require('express')().use(bodyParser.json());

massive(config.URI).then(db => app.set('db', db));

app.get('/api/ping', (req, res) => {
    // console.log('db', app.get('db'))
    // app.get('db').get_users([req.params.userID, req.query.value])
    app.get('db').time_punch([data])
        .then(res => res)
        .catch(err => { console.log('err', err) });
});

console.log('day', moment.format('dddd'));

app.listen(server_port, console.log(`Listening on ${server_port}.`));