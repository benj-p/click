require 'date'
require 'faker'

puts "starting to seed..."

Registration.destroy_all
Section.destroy_all
User.destroy_all

students = (1..50).each_with_object({}) do |i, student|
  student[i] = User.create(email: Faker::Internet.email, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name , password: "secret")
end

teachers = (1..5).each_with_object({}) do |i, teacher|
  teacher[i] = User.create(email: Faker::Internet.email, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name , password: "secret", is_teacher: true)
end

sections = (1..10).each_with_object({}) do |i, section|
  section[i] = Section.new(name: ('A'..'Z').to_a[i-1])
end

students.each_with_index do |student, index|
  a = (1..10).to_a.shuffle
  (1..3).to_a.sample.times do
    registration = Registration.new
    registration.user = students[index+1]
    registration.section = sections[a.pop]
    registration.save
  end
end

puts "completed seeding..."
