const bodyParser = require('body-parser')
    , config = require('./config')
    , data = require('./data')
    , server_port = 3333
    , massive = require('massive')
    , moment = require('moment')()
    , app = require('express')().use(bodyParser.json());

massive(config.URI).then(db => app.set('db', db));

app.post('/api/ping', (req, res) => {
    app.get('db').time_punch([data.users])
        .then(response => res.status(200).send(response))
        .catch(err => { console.log('err', err) });
});

app.listen(
    server_port,
    console.log(`
    Listening on port ${server_port}
    Time: ${data.time}
    `)
);