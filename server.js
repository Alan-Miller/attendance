const bodyParser = require('body-parser')
    , config = require('./config')
    , port = config.port
    , massive = require('massive')
    , moment = require('moment')()
    , app = require('express')().use(bodyParser.json());

massive(config.URI).then(db => app.set('db', db));



console.log('day', moment.format('dddd'));

app.listen(port, console.log(`Listening on ${port}.`));