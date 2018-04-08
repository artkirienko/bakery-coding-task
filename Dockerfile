FROM ruby:2.5.1
COPY ./ /usr/src/app/
WORKDIR /usr/src/app
RUN bundle
CMD ["ruby", "lib/bakery_runner.rb"]
