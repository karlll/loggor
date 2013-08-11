loggor
======

Tail logfiles in your browser

## Setup

	$ bundle install

Add allowed log files to ``map.yml``:

	"foo.log": /tmp/foo/foo.log

## Start

	$ ruby loggor.rb

## View log

Visit ``http://localhost:4567/log/<log-file>``

E.g. to view ``/tmp/foo/foo.log``, open ``http://localhost:4567/log/foo.log``

## Requirements

* ruby 1.9.3+
* Browser supporting WebSockets

## Version information

* 0.0.1 - Initial version

## License

MIT License

