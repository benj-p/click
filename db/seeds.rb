require 'date'
require 'faker'

start_time = Time.now()

puts "starting to seed..."

puts "destroying current records..."
Attempt.destroy_all
FeedEvent.destroy_all
EventType.destroy_all
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
students = (1..30).each_with_object({}) do |i, student|
  student[i] = User.create(email: Faker::Internet.email, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name , password: "secret")
end

puts "creating teachers..."
teachers = (1..3).each_with_object({}) do |i, teacher|
  teacher[i] = User.create(email: Faker::Internet.email, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name , password: "secret", is_teacher: true)
end

puts "creating event types"
EventType.create(name: "Completed deck")
EventType.create(name: "Shared deck")
EventType.create(name: "Extreme score")

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
geography = Curriculum.create({user: teacher, name: "Elementary Geography", image: curriculum_images[-3]})

financial_statement_basics = Deck.create({curriculum: intro_to_accounting, name: "Financial Statement Basics", due_date: Date.today()-10})
journal_entry_basics = Deck.create({curriculum: intro_to_accounting, name: "Basic Journal Entries", due_date: Date.today()+3})
fun_facts_taxes = Deck.create({curriculum: intro_to_tax, name: "Fun Facts About Taxes", due_date: Date.today()-2})
europe = Deck.create({curriculum: geography, name: "Europe Review", due_date: Date.today()-8})
asia = Deck.create({curriculum: geography, name: "Fun Facts About Asia", due_date: Date.today()-3})
americas = Deck.create({curriculum: geography, name: "American Geography", due_date: Date.today()+5})

a_1 = Card.create({deck: financial_statement_basics, question: 'One of the three sections of the statement of cash flows is called "Cash Flows from Manufacturing Activities."', correct_answer: "False" , wrong_answer: "True" })
a_2 = Card.create({deck: financial_statement_basics, question: 'The act of declaring and paying a cash dividend affects both the income statement and the statement of cash flows.', correct_answer: "False" , wrong_answer: "True" })
a_3 = Card.create({deck: financial_statement_basics, question: 'Form 10-Q is the quarterly report publicly traded companies int he US must file with the SEC.', correct_answer: "True" , wrong_answer: "False" })
b_1 = Card.create({deck: journal_entry_basics, question: 'REI receives $500 cash from a customer for a rock-climbing class that will take place in two months. This transaction increases two balance sheet accounts.', correct_answer: "True" , wrong_answer: "False" })
b_2 = Card.create({deck: journal_entry_basics, question: 'On August 2nd 2018, the Seahawks (an NFL team) receive cash in advance from fans purchasing tickets to the Seahawks vs. Packers game which will take place in September 2018. The August 2nd journal entry will cause total stockholder’s equity to decrease.', correct_answer: "False" , wrong_answer: "True" })
b_3 = Card.create({deck: journal_entry_basics, question: 'When a company pays an employee’s salary in advance of the time that the employee earns the salary, prepaid salary is recorded as an asset.  Then, as the employee earns the salary, both expenses and liabilities will increase.', correct_answer: "False" , wrong_answer: "True" })
c_1 = Card.create({deck: fun_facts_taxes, question: "During the Middle Ages, European governments placed a tax on soap. France didn't repeal its soap tax until 1835", correct_answer: "False" , wrong_answer: "True", resource: r2})
c_2 = Card.create({deck: fun_facts_taxes, question: 'In 1712, England imposed a tax on printed wallpaper. Builders avoided the tax by hanging plain wallpaper and then painting patterns on the walls."', correct_answer: "True" , wrong_answer: "False", resource: r1})
c_3 = Card.create({deck: fun_facts_taxes, question: 'In 1705, Russian Emperor Peter the Great placed a tax on beards, hoping to force men to adopt the clean-shaven look that was common in Western Europe.', correct_answer: "True" , wrong_answer: "False", resource: r2})
d_1 = Card.create({deck: europe, question: 'The UK is comprised of 5 countries.', correct_answer: "False" , wrong_answer: "True", resource: r2})
d_2 = Card.create({deck: europe, question: 'Germany borders France.', correct_answer: "True" , wrong_answer: "False", resource: r2})
d_3 = Card.create({deck: europe, question: 'Norway is part of the European Union.', correct_answer: "False" , wrong_answer: "True", resource: r2})
d_4 = Card.create({deck: europe, question: 'Ljubljana is the capital of Lithuania', correct_answer: "False" , wrong_answer: "True"})
d_5 = Card.create({deck: europe, question: "Russia takes up 30 percent of Europe's land area", correct_answer: "False" , wrong_answer: "True"})
d_6 = Card.create({deck: europe, question: 'Croissants were invented in Austria', correct_answer: "True" , wrong_answer: "False"})
d_7 = Card.create({deck: europe, question: 'Per capita, Sweden has the most McDonalds in Europe ', correct_answer: "True" , wrong_answer: "False", resource: r2})
d_8 = Card.create({deck: europe, question: 'Italy is the most visisted country in Europe', correct_answer: "False" , wrong_answer: "True"})
d_9 = Card.create({deck: europe, question: 'Jonny gates is the worlds great football player', correct_answer: "True" , wrong_answer: "False", resource: r2})
e_1 = Card.create({deck: asia, question: 'There are 60 countries in Asia.', correct_answer: "False" , wrong_answer: "True", resource: r2})
e_2 = Card.create({deck: asia, question: 'Bhutan is the smallest country by land area and population.', correct_answer: "False" , wrong_answer: "True", resource: r2})
e_3 = Card.create({deck: asia, question: 'Budhism is the oldest religion in Asia', correct_answer: "False" , wrong_answer: "True"})
e_4 = Card.create({deck: asia, question: 'India is the country in the Asia with the cheapest labor ', correct_answer: "True" , wrong_answer: "False", resource: r2})
e_5 = Card.create({deck: asia, question: 'English is the national language in Singapore', correct_answer: "False" , wrong_answer: "True", resource: r2})
e_6 = Card.create({deck: asia, question: 'A law was enacted in China that requires adults to visit their elderly parents often.', correct_answer: "True" , wrong_answer: "False", resource: r2})
e_7 = Card.create({deck: asia, question: 'Apples were first dicovered in Asia', correct_answer: "False" , wrong_answer: "True", resource: r2})
e_8 = Card.create({deck: asia, question: 'Pakistan is the 3rd most populated country in Asia after china and India', correct_answer: "False" , wrong_answer: "True", resource: r2})
f_1 = Card.create({deck: americas, question: 'To visit the Grand Canyon, you can go to Arizona.', correct_answer: "True" , wrong_answer: "False", resource: r2})
f_2 = Card.create({deck: americas, question: 'There are four Le Wagon schools in Latin America', correct_answer: "True" , wrong_answer: "False", resource: r2})
f_3 = Card.create({deck: americas, question: 'Puerto Rico is the most populous Island in the Caribbean', correct_answer: "False" , wrong_answer: "True", resource: r2})
f_4 = Card.create({deck: americas, question: 'Columbus sailed to American in 1492', correct_answer: "True" , wrong_answer: "False", resource: r2})
f_5 = Card.create({deck: americas, question: 'Sao Paulo is the capital of Brazil.', correct_answer: "False" , wrong_answer: "True", resource: r2})
f_6 = Card.create({deck: americas, question: 'Canada is the coutry with the most wild bears.', correct_answer: "False" , wrong_answer: "True", resource: r2})
f_7 = Card.create({deck: americas, question: 'Alaska is the easternmost state in the US', correct_answer: "True" , wrong_answer: "False", resource: r2})
f_8 = Card.create({deck: americas, question: 'California has more residents than all of Canada.', correct_answer: "True" , wrong_answer: "False", resource: r2})

teacher_sections = []
sections = (1..8).each_with_object({}) do |i, section|
  if i <= 4
    teacher_sections << Section.create(name: ('A'..'D').to_a[i-1], curriculum: intro_to_accounting)
  else
    x = i - 4
    teacher_sections << Section.create(name: ('A'..'D').to_a[x-1], curriculum: intro_to_tax)
  end
end

Section.create(name: 'A', curriculum: geography)
Section.create(name: 'B', curriculum: geography)
Section.create(name: 'C', curriculum: geography)
Section.create(name: 'D', curriculum: geography)

teacher_sections.each do |section|
  15.times do
    reg = Registration.new(user: User.offset(rand(User.count)).first, section: section)
    reg.save unless reg.user.is_teacher
  end
end

student1 = User.create(email: "jonny@email.com", first_name: "Jonny", last_name: "Gates", password: "secret")
student2 = User.create(email: "leti@email.com", first_name: "Letizia", last_name: "Ackaouy", password: "secret")
student3 = User.create(email: "ben@email.com", first_name: "Ben", last_name: "Pham", password: "secret")
student4 = User.create(email: "kitty@email.com", first_name: "Kitty", last_name: "Mayo", password: "secret")
student5 = User.create(email: "sahar@email.com", first_name: "Sahar", last_name: "Khan", password: "secret")
student6 = User.create(email: "shopie@email.com", first_name: "Sophie", last_name: "Spratley", password: "secret")
student7 = User.create(email: "taniya@email.com", first_name: "Taniya", last_name: "Amidon", password: "secret")
student8 = User.create(email: "chai@email.com", first_name: "Chai", last_name: "Chai", password: "secret")
student9 = User.create(email: "janie@email.com", first_name: "Janie", last_name: "Amero", password: "secret")
student10 = User.create(email: "jack@email.com", first_name: "Jack", last_name: "Burke", password: "secret")

izzys_geography_class = [student1, student2, student3, student4, student5, student6, student7, student8, student9, student10]
izzys_geography_class.each do |student|
  Registration.create(user: student, section: Section.last)
end

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
students_array = User.where(is_teacher: false)

puts "creating feed items..."

def random_title(student, deck)
  score = rand(25) + 76
  result = rand(3)

  case result
  when 0 then "#{ student.first_name } completed #{ deck.name } and scored #{ score }%! Don't forget to say well done!"
  when 1 then "#{ student.first_name } completed #{ deck.name } and scored #{ score - 75 }%! Don't forget to follow up!"
  when 2 then "#{ student.first_name } completed #{ deck.name } and answered #{ score }% as unsure. Make sure you check in."
  end
end

20.times do
  student = students_array.offset(rand(students_array.count)).first
  deck = Deck.offset(rand(Deck.count)).first
  FeedEvent.create(user: teacher, about_user: student, title: random_title(student,deck), event_type: EventType.last)
end




puts "Seeding complete!! Done in #{ end_time - start_time } seconds."
