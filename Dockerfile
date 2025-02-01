# syntax=docker/dockerfile:1

# Base image with specified Ruby version
ARG RUBY_VERSION=3.3.0
FROM ruby:$RUBY_VERSION-slim as base

# Set working directory
WORKDIR /app

# Set environment variables
ENV RAILS_ENV="development" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development" \
    NODE_VERSION=18.19.0 \
    YARN_VERSION=1.22.22

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
    curl \
    build-essential \
    git \
    libpq-dev \
    libvips \
    postgresql-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js and Yarn
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g corepack && corepack enable && \
    corepack prepare yarn@$YARN_VERSION --activate && \
    npm install -g yarn@$YARN_VERSION || true

# Ensure binaries are available in PATH
ENV PATH="/usr/local/bin:$PATH"

# Verify installation
RUN which node && node -v
RUN which npm && npm -v
RUN which yarn && yarn -v

# Install application dependencies
COPY Gemfile Gemfile.lock ./
RUN bundle config set frozen false && bundle install

# Copy application code
COPY . .

# Set user for security
RUN useradd -m rails && chown -R rails:rails /app
USER rails

# Expose port for Rails server
EXPOSE 3000

# Default command
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
