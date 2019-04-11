<div align="center">
  <h1>border-crosser</h1>

  <a href="https://www.emojione.com/emoji/1f5fa">
  <img height="80" width="80" alt="octopus" src="https://raw.githubusercontent.com/benedictfischer09/border_crosser_ruby/master/other/map.png" />
  </a>

  <p>Set it, forget it, find it. Trace requests across systems with ease.</p>
</div>

<hr />

## The Problem

Your code queues a background job? The background job sends a message on your message bus? Another app picks up that message and makes a HTTP request to one of your services.  On and on.  You won't remember to manually set a flag at every step to ensure you can trace this whole process, so let border crosser do it for you!

## This Solution

Most border points support passing metadata.  Think HTTP headers, kafka headers, sidekiq middleware args, etc.

To make that metadata work to your advantage the calling code has to pass an identifier through the metadata, and the receiving code has to parse that metadata, grab the identifier, and hydrate it into a global store.

Take sidekiq for example, border crosser gem adds sidekiq middleware to queue an identifier every time it queues a background job.  The worker middlware reads that identifier and hydrates it into a global store.  If the background job makes a HTTP request that library is monkey patched to send the identifier in the request headers.  On and on.


## Is this safe in production?
New relic's instrumentation gem and other performance monitoring tools also take this approach of monkey patching popular tools to get insights about what is happening and when.  If you trust those tools in production you can trust this approach.


## Installation

```
gem install border_crosser
```

## Other Languages

There is nothing stopping applications written in Python, Go, or any other langague from picking up the identifier and following this simple protocol.

Custom HTTP header: X-Distributed-Tracing
Custom kafka header: X-Distributed-Tracing

More suppport for popular messaging tools like kinesis and sns are under investigation.
