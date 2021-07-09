FROM ruby:3.0.2
COPY ./ /usr/src/app/
WORKDIR /usr/src/app

# Update bundler to the latest available version
RUN gem install bundler:2.0.2

RUN bundle
CMD ["ruby", "lib/bakery_runner.rb"]
