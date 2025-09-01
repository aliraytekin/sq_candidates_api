require 'faker'

puts "Starting seeds"

Job.destroy_all
Recruiter.destroy_all

puts "Jobs destroyed"

recruiter = []

5.times do
  recruiter << Recruiter.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    password: "123456",
  )
end

puts "Recruiters created"

20.times do
  Job.create!(
    recruiter: recruiter.first, # for mocking user auth
    title: Faker::Job.title,
    category: Faker::Job.field,
    employment_type: ["Full-time", "Part-time", "Contract"].sample,
    location: Faker::Address.full_address,
    posted_at: Faker::Date.backward(days: 30),
    status: Job.statuses.keys.sample,
    description: Faker::Lorem.paragraph(sentence_count: 5)
  )
end

puts "#{Job.count} jobs created"
