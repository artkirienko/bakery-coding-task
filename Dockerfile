FROM ruby:2.7.0
COPY ./ /usr/src/app/
WORKDIR /usr/src/app

# Update bundler to the latest available version
RUN gem install bundler

RUN bundle
CMD ["ruby", "lib/bakery_runner.rb"]
