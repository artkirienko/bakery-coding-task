FROM ruby:2.6.3
COPY ./ /usr/src/app/
WORKDIR /usr/src/app
RUN bundle
CMD ["ruby", "lib/bakery_runner.rb"]
