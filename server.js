const bodyParser = require('body-parser')
    , config = require('./config')
    , server_port = config.server_port
    , massive = require('massive')
    , moment = require('moment')()
    , app = require('express')().use(bodyParser.json());

const data = JSON.stringify([
    {"username": "Brennon Schow", "here": true}, 
    {"username": "Brock Pettyjohn", "here": true}, 
    {"username": "Emily Keator", "here": false},
    {"username": "Chris Lemke", "here": true}
].map(person => Object.assign(person, {date_time: moment.format('MMM D YYYY H:mm')})));

massive(config.URI).then(db => app.set('db', db));

app.get('/api/ping', (req, res) => {
    app.get('db').time_punch([data])
        .then(response => res.status(200).send(response))
        .catch(err => { console.log('err', err) });
});

app.listen(
    server_port, 
    console.log(`Port ${server_port}, ${moment.format('MMM D YYYY, H:mm')}.`)
);