# docker-rails-frontend

### Prerequisites

You need to build CI for Ruby On Rails application with modern frontend feature-tests.

### Dependencies

#### Backend

Standart Rails 4.x - 5.x dependencies:

- MRI Ruby 2.2.3
- Bundler 1.10.6
- main Debian packages

#### Frontend

Webpacker boilerplate:

- Node 6.7.0
- npm 3.10.3
- yarn 1.2.1

#### Testing

Javascript feature-tests drivers like Capybara-webkit or Phantom-JS is deprecated. So we need actual headless browser and Selenium:

- Firefox 56.0.1 (first version including headless)
- Geckodriver 0.19.0
- gtk3

### Image

Image is available in repo [georgegorbanev/rails-webpacker-selenium
](https://cloud.docker.com/app/georgegorbanev/repository/docker/georgegorbanev/rails-webpacker-selenium/general)
