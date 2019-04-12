<div align="center">
  <h1>border-crosser</h1>

  <a href="https://www.emojione.com/emoji/1f5fa">
  <img height="80" width="80" alt="octopus" src="https://raw.githubusercontent.com/benedictfischer09/border_crosser_ruby/master/other/map.png" />
  </a>

  <p>Set it, forget it, trace it when you need it. Trace requests across systems with ease.</p>
</div>

<hr />

## The Problem

Lets imagine a user
1. Does something on your site
2. Their request causes your code to queue a background job
3. The background job sends a message on your message bus and another app picks it up
4. That app (app2) makes a HTTP request to one of your services (app3) because of the message
5. Finally app3 makes a request to app4 because of its request

![graph of the process above](https://raw.githubusercontent.com/benedictfischer09/border_crosser_ruby/master/other/example.png)


If you wanted to search your logs for every process involved that whole graph chances are you don't have a way to do it. To make that possible manually you'd need to explictly set a flag at every step and handle that flag at the next step to ensure you can trace this whole process.  Why do that all that work when you can let border crosser do it for you!

## This Solution

Most border points (HTTP, kafka, background jobs, etc) support passing metadata.  Think HTTP headers, kafka headers, sidekiq middleware args, etc.

To make that metadata contain traceable information the calling code has to pass an identifier through the metadata, and the receiving code has to parse that metadata, grab the identifier, and pass it along the next time a border point is reached.

Border crosser works by adding middleware or monkey patching popular tools so that this happens automatically without calling/receiving code having to do anything.

It holds the identifier in a thread variable so that its globally available anytime a HTTP request is about to be made or a background job queued.  All border crosser has to do is make sure the identifier is passed along in the metadata whenever a border point is being crossed. Easy!


## Is this safe in production?
New relic's instrumentation gem and other performance monitoring tools also take this approach of monkey patching popular tools to get insights about what is happening and when.  If you trust those tools in production you can trust this approach.


## Installation

```
gem install border_crosser
```

## Other Languages

There is nothing stopping applications written in Python, Go, or any other langague from picking up the identifier and following this simple protocol.

Custom HTTP header: X-Border-Crosser
Custom kafka header: X-Border-Crosser

More suppport for popular messaging tools like kinesis and sns are under investigation.
