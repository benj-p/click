require 'date'
require 'faker'

start_time = Time.now()

puts "starting to seed..."

puts "destroying current records..."
Attempt.destroy_all
Card.destroy_all
Resource.destroy_all
Deck.destroy_all
Registration.destroy_all
Section.destroy_all
Curriculum.destroy_all
User.destroy_all

puts "Storing images..."

curriculum_images= ["https://images.pexels.com/photos/7366/startup-photos.jpg?auto=compress&cs=tinysrgb&dpr=2&w=500",
"https://images.pexels.com/photos/7102/notes-macbook-study-conference.jpg?auto=compress&cs=tinysrgb&dpr=2&w=500",
"https://images.pexels.com/photos/60582/newton-s-cradle-balls-sphere-action-60582.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
"https://images.pexels.com/photos/159621/open-book-library-education-read-159621.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
"https://images.pexels.com/photos/256520/pexels-photo-256520.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
"https://images.pexels.com/photos/1011329/pexels-photo-1011329.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
"https://images.pexels.com/photos/256417/pexels-photo-256417.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
"https://images.pexels.com/photos/1043514/pexels-photo-1043514.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
"https://images.pexels.com/photos/533189/pexels-photo-533189.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
"https://images.pexels.com/photos/267586/pexels-photo-267586.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
"https://images.pexels.com/photos/167682/pexels-photo-167682.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
"https://images.pexels.com/photos/102127/pexels-photo-102127.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
"https://images.pexels.com/photos/53621/calculator-calculation-insurance-finance-53621.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
"https://images.pexels.com/photos/33692/coins-currency-investment-insurance.jpg?auto=compress&cs=tinysrgb&dpr=2&w=500"]


puts "creating students..."
students = (1..20).each_with_object({}) do |i, student|
  student[i] = User.create(email: Faker::Internet.email, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name , password: "secret")
end

puts "creating teachers..."
teachers = (1..3).each_with_object({}) do |i, teacher|
  teacher[i] = User.create(email: Faker::Internet.email, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name , password: "secret", is_teacher: true)
end



puts "creating curriculums..."
image_counter = 0
User.where(is_teacher: true).each do |teacher|
  3.times do
    Curriculum.create(user: teacher, name: Faker::Educator.course_name, image: curriculum_images[image_counter])
    image_counter += 1
  end
end


puts "creating sections..."
section_names = ('A'..'Z').to_a

Curriculum.all.each do |curriculum|
  counter = 0
  3.times do
    Section.create(name: section_names[counter], curriculum: curriculum)
    counter += 1
  end
end

puts "creating registrations..."
def rand_section
  offset = rand(Section.count)
  Section.offset(offset).first
end

User.where(is_teacher: false).each do |student|
  2.times do
    Registration.create(user: student, section: rand_section)
  end
end

puts "creating decks..."
Curriculum.all.each do |curriculum|
  5.times do
    Deck.create(curriculum: curriculum, name: Faker::Educator.course_name, due_date: Date.today() + rand((1..10)))
  end
end

puts "creating resources..."
r1 = Resource.create!({name: "Review Video", text: "Check out this video review of historical taxes in the UK.", url: "https://www.youtube.com/watch?v=vnJY_vO-xDU"})
r2 = Resource.create({name: "Review Reading", text: "Did you review the reading assignment? Check it out here.", url: "https://londonlovesbusiness.com/5-genuinely-interesting-tax-facts-no-really/"})


puts "creating answers..."
answers = ["True", "False"]
Deck.all.each do |deck|
  8.times do
    answers.shuffle!
    Card.create(deck: deck, question: Faker::Quote.famous_last_words, correct_answer: answers[0], wrong_answer: answers[1])
  end
end

puts "creating demo users..."
teacher = User.create(email: "izzyweber@gmail.com", first_name: "Izzy", last_name: "Weber" , password: "secret", is_teacher: true)


intro_to_accounting = Curriculum.create({user: teacher, name: "Intro to Accounting", image: curriculum_images[-1]})
intro_to_tax = Curriculum.create({user: teacher, name: "Intro to Taxation", image: curriculum_images[-2]})
fake_curric1 = Curriculum.create(user: teacher, name: Faker::Educator.course_name, image: curriculum_images[image_counter])
fake_curric2 = Curriculum.create(user: teacher, name: Faker::Educator.course_name, image: curriculum_images[image_counter+1])

Deck.create(curriculum: fake_curric1, name: "Intro to #{fake_curric1.name}")
Deck.create(curriculum: fake_curric2, name: "Intro to #{fake_curric2.name}")

financial_statement_basics = Deck.create({curriculum: intro_to_accounting, name: "Financial Statement Basics", due_date: Date.today()-10})
journal_entry_basics = Deck.create({curriculum: intro_to_accounting, name: "Basic Journal Entries", due_date: Date.today()+3})
fun_facts_taxes = Deck.create({curriculum: intro_to_tax, name: "Fun Facts About Taxes", due_date: Date.today()+5})

a_1 = Card.create({deck: financial_statement_basics, question: 'One of the three sections of the statement of cash flows is called "Cash Flows from Manufacturing Activities."', correct_answer: "False" , wrong_answer: "True" })
a_2 = Card.create({deck: financial_statement_basics, question: 'The act of declaring and paying a cash dividend affects both the income statement and the statement of cash flows.', correct_answer: "False" , wrong_answer: "True" })
a_3 = Card.create({deck: financial_statement_basics, question: 'Form 10-Q is the quarterly report publicly traded companies int he US must file with the SEC.', correct_answer: "True" , wrong_answer: "False" })
b_1 = Card.create({deck: journal_entry_basics, question: 'REI receives $500 cash from a customer for a rock-climbing class that will take place in two months. This transaction increases two balance sheet accounts.', correct_answer: "True" , wrong_answer: "False" })
b_2 = Card.create({deck: journal_entry_basics, question: 'On August 2nd 2018, the Seahawks (an NFL team) receive cash in advance from fans purchasing tickets to the Seahawks vs. Packers game which will take place in September 2018. The August 2nd journal entry will cause total stockholder’s equity to decrease.', correct_answer: "False" , wrong_answer: "True" })
b_3 = Card.create({deck: journal_entry_basics, question: 'When a company pays an employee’s salary in advance of the time that the employee earns the salary, prepaid salary is recorded as an asset.  Then, as the employee earns the salary, both expenses and liabilities will increase.', correct_answer: "False" , wrong_answer: "True" })
c_1 = Card.create({deck: fun_facts_taxes, question: "During the Middle Ages, European governments placed a tax on soap. France didn't repeal its soap tax until 1835", correct_answer: "False" , wrong_answer: "True", resource: r2})
c_2 = Card.create({deck: fun_facts_taxes, question: 'In 1712, England imposed a tax on printed wallpaper. Builders avoided the tax by hanging plain wallpaper and then painting patterns on the walls."', correct_answer: "True" , wrong_answer: "False", resource: r1})
c_3 = Card.create({deck: fun_facts_taxes, question: 'In 1705, Russian Emperor Peter the Great placed a tax on beards, hoping to force men to adopt the clean-shaven look that was common in Western Europe.', correct_answer: "True" , wrong_answer: "False", resource: r2})

teacher_sections = []
sections = (1..8).each_with_object({}) do |i, section|
  if i <= 4
    teacher_sections << Section.create(name: ('A'..'D').to_a[i-1], curriculum: intro_to_accounting)
  else
    x = i - 4
    teacher_sections << Section.create(name: ('A'..'D').to_a[x-1], curriculum: intro_to_tax)
  end
end

teacher_sections.each do |section|
  15.times do
    reg = Registration.new(user: User.offset(rand(User.count)).first, section: section)
    reg.save unless reg.user.is_teacher
  end
end

student = User.create(email: "jonny@email.com", first_name: "Jonny", last_name: "Gates", password: "secret")

Registration.create(user: student, section: Section.last)
Registration.create(user: student, section: Section.first)


puts "creating attempts..."


responses = ["Correct", "Incorrect", "I don't know"]

User.where(is_teacher: false).each do |student|
  student.sections.each do |section|
    section.curriculum.decks.each do |deck|
      deck.cards.take(rand(deck.cards.count)).each do |card|
        Attempt.create(user: student, card: card, response: responses.sample)
      end
    end
  end
end

end_time = Time.now()

puts "Seeding complete!! Done in #{ end_time - start_time } seconds."
