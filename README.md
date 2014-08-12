# slacks

Serves up random quotes to a slack team, once integration is configured.

## Running

To start a web server for the application, run:

Starting directory should contain the slack integration token, without newline, in
a file named TOKEN, and \000 delimited quotes in a file named LINES.
~~~
    lein ring server-headless SOMEPORT
~~~
Or alternatively
~~~
   ./slackbot.pl daemon -l 'http://localhost:SOMEPORT'
~~~


## License

Do whatever you want with this.

