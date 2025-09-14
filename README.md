# Candidates API (Recruiter Console Backend)

This is the backend API for the Recruiter Console technical test.  
It is built with **Ruby on Rails (API mode)** and serves JSON responses to a React frontend.
NB: Run rails s first then npm start

---

## 🚀 Features

- Recruiters can manage jobs:
  - Create
  - Edit (update)
  - Delete
- Basic search endpoint for jobs (filter by title/location).
- Fake candidates can be proxied via the backend (e.g. using `randomuser.me`).

---

## ⚙️ Setup

### Prerequisites
- Ruby 3.3+
- Bundler
- PostgreSQL
- Node.js + Yarn (for frontend, optional)

### Installation
```bash
git clone https://github.com/aliraytekin/cq_candidates_api.git
cd candidates-api

bundle install
rails db:create db:migrate db:seed