require 'date'
require 'faker'

puts "starting to seed..."

Attempt.destroy_all
Card.destroy_all
Deck.destroy_all
Registration.destroy_all
Section.destroy_all
Curriculum.destroy_all
User.destroy_all

students = (1..50).each_with_object({}) do |i, student|
  student[i] = User.create(email: Faker::Internet.email, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name , password: "secret")
end

teachers = (1..5).each_with_object({}) do |i, teacher|
  teacher[i] = User.create(email: Faker::Internet.email, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name , password: "secret", is_teacher: true)
end

teacher = User.create(email: "izzyweber@gmail.com", first_name: "Izzy", last_name: "Weber" , password: "secret", is_teacher: true)

#Curriculum

intro_to_accounting = Curriculum.create({user: teacher, name: "Intro to Accounting"})
intro_to_tax = Curriculum.create({user: teacher, name: "Intro to Taxation"})

sections = (1..5).each_with_object({}) do |i, section|
  section[i] = Section.create(name: ('A'..'Z').to_a[i-1], curriculum: intro_to_accounting)
end

sections = (6..10).each_with_object({}) do |i, section|
  section[i] = Section.create(name: ('A'..'Z').to_a[i-1], curriculum: intro_to_tax)
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

#Deck

financial_statement_basics = Deck.create({curriculum: intro_to_accounting, name: "Financial Statement Basics", due_date: Date.today()-10})
journal_entry_basics = Deck.create({curriculum: intro_to_accounting, name: "Basic Journal Entries", due_date: Date.today()+3})
fun_facts_taxes = Deck.create({curriculum: intro_to_tax, name: "Fun Facts About Taxes", due_date: Date.today()+5})

#Card

a_1 = Card.create({deck: financial_statement_basics, question: 'One of the three sections of the statement of cash flows is called "Cash Flows from Manufacturing Activities."', correct_answer: "False" , wrong_answer: "True" })
a_2 = Card.create({deck: financial_statement_basics, question: 'The act of declaring and paying a cash dividend affects both the income statement and the statement of cash flows.', correct_answer: "False" , wrong_answer: "True" })
a_3 = Card.create({deck: financial_statement_basics, question: 'Form 10-Q is the quarterly report publicly traded companies int he US must file with the SEC.', correct_answer: "True" , wrong_answer: "False" })
b_1 = Card.create({deck: journal_entry_basics, question: 'REI receives $500 cash from a customer for a rock-climbing class that will take place in two months. This transaction increases two balance sheet accounts.', correct_answer: "True" , wrong_answer: "False" })
b_2 = Card.create({deck: journal_entry_basics, question: 'On August 2nd 2018, the Seahawks (an NFL team) receive cash in advance from fans purchasing tickets to the Seahawks vs. Packers game which will take place in September 2018. The August 2nd journal entry will cause total stockholder’s equity to decrease.', correct_answer: "False" , wrong_answer: "True" })
b_3 = Card.create({deck: journal_entry_basics, question: 'When a company pays an employee’s salary in advance of the time that the employee earns the salary, prepaid salary is recorded as an asset.  Then, as the employee earns the salary, both expenses and liabilities will increase.', correct_answer: "False" , wrong_answer: "True" })
c_1 = Card.create({deck: fun_facts_taxes, question: "During the Middle Ages, European governments placed a tax on soap. France didn't repeal its soap tax until 1835", correct_answer: "False" , wrong_answer: "True" })
#it was England that had the soap tax until then!!
c_2 = Card.create({deck: fun_facts_taxes, question: 'In 1712, England imposed a tax on printed wallpaper. Builders avoided the tax by hanging plain wallpaper and then painting patterns on the walls."', correct_answer: "True" , wrong_answer: "False" })
c_3 = Card.create({deck: fun_facts_taxes, question: 'In 1705, Russian Emperor Peter the Great placed a tax on beards, hoping to force men to adopt the clean-shaven look that was common in Western Europe.', correct_answer: "True" , wrong_answer: "False" })

#Answer

Attempt.create({user: students[1], card: a_1, response: "Correct"})
Attempt.create({user: students[2], card: a_1, response: "Incorrect"})
Attempt.create({user: students[3], card: a_1, response: "Correct"})
Attempt.create({user: students[1], card: a_2, response: "Correct"})
Attempt.create({user: students[2], card: a_2, response: "Incorrect"})
Attempt.create({user: students[3], card: a_2, response: "Incorrect"})
Attempt.create({user: students[1], card: a_3, response: "I don't know"})
Attempt.create({user: students[2], card: a_3, response: "Correct"})
Attempt.create({user: students[3], card: a_3, response: "Correct"})
Attempt.create({user: students[1], card: b_1, response: "Correct"})
Attempt.create({user: students[2], card: b_1, response: "Incorrect"})
Attempt.create({user: students[3], card: b_1, response: "Correct"})
Attempt.create({user: students[1], card: b_2, response: "Correct"})
Attempt.create({user: students[2], card: b_2, response: "Incorrect"})
Attempt.create({user: students[3], card: b_2, response: "Correct"})
Attempt.create({user: students[1], card: b_3, response: "Correct"})
Attempt.create({user: students[2], card: b_3, response: "Correct"})
Attempt.create({user: students[3], card: b_3, response: "Correct"})
Attempt.create({user: students[1], card: c_1, response: "Correct"})
Attempt.create({user: students[2], card: c_1, response: "Incorrect"})
Attempt.create({user: students[3], card: c_1, response: "Correct"})
Attempt.create({user: students[1], card: c_2, response: "Correct"})
Attempt.create({user: students[2], card: c_2, response: "Correct"})
Attempt.create({user: students[3], card: c_2, response: "Correct"})
Attempt.create({user: students[1], card: c_3, response: "I don't know"})
Attempt.create({user: students[2], card: c_3, response: "Incorrect"})
Attempt.create({user: students[3], card: c_3, response: "Correct"})


puts "Seeding complete!!"
