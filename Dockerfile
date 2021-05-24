FROM ruby:2.5.3
WORKDIR /rails-engine-OG
COPY . .
RUN rm Gemfile.lock
RUN gem install rails bundler
RUN bundle install
EXPOSE 3000
CMD ["rails", "s", "-b", "0.0.0.0"]
