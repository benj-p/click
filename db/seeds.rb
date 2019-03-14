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
"https://images.pexels.com/photos/167682/pexels-photo-167682.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
"https://images.pexels.com/photos/102127/pexels-photo-102127.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
"https://images.pexels.com/photos/53621/calculator-calculation-insurance-finance-53621.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
"https://images.pexels.com/photos/33692/coins-currency-investment-insurance.jpg?auto=compress&cs=tinysrgb&dpr=2&w=500"]

izzy_pic = "https://avatars1.githubusercontent.com/u/40670298?s=400&u=1548eda59e882bcc68d46407c5df2417f27c0ea8&v=4"
jonny_pic = "https://avatars1.githubusercontent.com/u/40580116?s=460&v=4"
leti_pic = "https://avatars2.githubusercontent.com/u/45164755?s=400&v=4"
kitty_pic = "https://avatars1.githubusercontent.com/u/24207615?s=400&v=4"
sahar_pic = "https://avatars1.githubusercontent.com/u/37933922?s=400&v=4"
ben_pic = "https://avatars2.githubusercontent.com/u/43788107?s=400&v=4"
sophie_pic = "https://avatars2.githubusercontent.com/u/30593507?s=400&v=4"
jack_pic = "https://avatars1.githubusercontent.com/u/39552144?s=400&v=4"
janie_pic = "https://avatars2.githubusercontent.com/u/43782388?s=400&v=4"
chai_pic = "https://avatars2.githubusercontent.com/u/44784077?s=400&v=4"
taniya_pic = "https://avatars0.githubusercontent.com/u/43338205?s=400&v=4"

fake_student_photos = ["","https://avatars2.githubusercontent.com/u/20525002?s=400&v=4", "https://avatars1.githubusercontent.com/u/33252472?s=400&v=4",
                       "https://avatars0.githubusercontent.com/u/26303419?s=400&v=4", "https://avatars3.githubusercontent.com/u/26220481?s=400&v=4",
                       "https://avatars2.githubusercontent.com/u/9754165?s=400&v=4", "https://avatars1.githubusercontent.com/u/46600044?s=400&v=4",
                       "https://avatars2.githubusercontent.com/u/28908341?s=400&v=4", "https://avatars2.githubusercontent.com/u/45601799?s=400&v=4",
                       "https://avatars1.githubusercontent.com/u/34004218?s=400&v=4", "https://avatars0.githubusercontent.com/u/8197176?s=400&v=4",
                       "https://avatars2.githubusercontent.com/u/44532593?s=400&v=4", "https://avatars3.githubusercontent.com/u/45002552?s=400&v=4",
                       "https://avatars1.githubusercontent.com/u/1092958?s=400&v=4", "https://avatars1.githubusercontent.com/u/30057590?s=400&v=4",
                       "https://avatars0.githubusercontent.com/u/39322308?s=400&v=4", "https://avatars2.githubusercontent.com/u/16212592?s=400&v=4",
                       "https://avatars0.githubusercontent.com/u/44875680?s=400&v=4", "https://avatars2.githubusercontent.com/u/45258443?s=400&v=4",
                       "https://avatars3.githubusercontent.com/u/16183242?s=400&v=4", "https://avatars0.githubusercontent.com/u/44930318?s=400&v=4",
                       "https://avatars2.githubusercontent.com/u/44314288?s=400&v=4", "https://avatars0.githubusercontent.com/u/40442483?s=400&v=4"
                      ]

puts "creating students..."
students = (1..22).each_with_object({}) do |i, student|
  student[i] = User.create(email: Faker::Internet.email, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name , password: "secret", remote_photo_url: fake_student_photos[i] )
end

puts "creating teachers..."
teachers = (1..2).each_with_object({}) do |i, teacher|
  teacher[i] = User.create(email: Faker::Internet.email, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name , password: "secret", is_teacher: true)
end

puts "creating event types"
EventType.create(name: "Completed deck")
EventType.create(name: "Shared deck")
EventType.create(name: "Extreme score")

puts "creating curriculums..."
image_counter = 0
User.where(is_teacher: true).each do |teacher|
  2.times do
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
  1.times do
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
r3 = Resource.create({name: "Review Map", text: "Did you review your map? Check it out here.", url: "https://i.pinimg.com/originals/ef/42/48/ef4248406036f7cc716b9bb135f6424a.gif"})
r4 = Resource.create({name: "Review Map", text: "Check out this map of countries bordering France", url: "http://1.bp.blogspot.com/-v3vM7BxTBI4/VmZ13EEK9NI/AAAAAAAAFsg/y6rsSSIZ5uc/s1600/situation+g%C3%A9opolitique+de+la+France+et+ses+pays+voisins+Carte.gif"})
r5 = Resource.create!({name: "Review Map", text: "Hey students! Those are all the countries in the EU", url: "https://www.schengenvisainfo.com/wp-content/uploads/2016/08/Member_States_of_the_European_Union.png"})
r6 = Resource.create({name: "Review Map", text: "Check out this map of Lithuania", url: "https://www.local-life.com/vilnius/pages/m.1-795_12.jpg"})
r7 = Resource.create({name: "Review Wikipedia", text: "Wikipedia is always a good place to start your research", url: "https://en.wikipedia.org/wiki/World_Tourism_rankings"})
r8 = Resource.create({name: "Review Map", text: "Remember, per capita means for each person", url: "https://jakubmarian.com/wp-content/uploads/2014/11/mc-donalds-2016.jpg"})

puts "creating answers..."
answers = ["True", "False"]
Deck.all.each do |deck|
  8.times do
    answers.shuffle!
    Card.create(deck: deck, question: Faker::Quote.famous_last_words, correct_answer: answers[0], wrong_answer: answers[1])
  end
end

puts "creating demo seeds..."
teacher = User.create(email: "izzyweber@gmail.com", first_name: "Izzy", last_name: "Weber" , password: "secret", is_teacher: true, remote_photo_url: izzy_pic)

# intro_to_accounting = Curriculum.create({user: teacher, name: "Intro to Accounting", image: curriculum_images[-1]})
intro_to_tax = Curriculum.create({user: teacher, name: "Intro to Taxation", image: curriculum_images[-2]})
geography = Curriculum.create({user: teacher, name: "Elementary Geography", image: curriculum_images[4]})

# financial_statement_basics = Deck.create({curriculum: intro_to_accounting, name: "Financial Statement Basics", due_date: Date.today()-10})
# journal_entry_basics = Deck.create({curriculum: intro_to_accounting, name: "Basic Journal Entries", due_date: Date.today()+3})
fun_facts_taxes = Deck.create({curriculum: intro_to_tax, name: "Fun Facts About Taxes", due_date: Date.today()-2})
europe = Deck.create({curriculum: geography, name: "Europe Review", due_date: Date.today()+3})
asia = Deck.create({curriculum: geography, name: "Fun Facts About Asia", due_date: Date.today()-3})
americas = Deck.create({curriculum: geography, name: "American Geography", due_date: Date.today()-8})

# a_1 = Card.create({deck: financial_statement_basics, question: 'One of the three sections of the statement of cash flows is called "Cash Flows from Manufacturing Activities."', correct_answer: "False" , wrong_answer: "True" })
# a_2 = Card.create({deck: financial_statement_basics, question: 'The act of declaring and paying a cash dividend affects both the income statement and the statement of cash flows.', correct_answer: "False" , wrong_answer: "True" })
# a_3 = Card.create({deck: financial_statement_basics, question: 'Form 10-Q is the quarterly report publicly traded companies int he US must file with the SEC.', correct_answer: "True" , wrong_answer: "False" })
# b_1 = Card.create({deck: journal_entry_basics, question: 'REI receives $500 cash from a customer for a rock-climbing class that will take place in two months. This transaction increases two balance sheet accounts.', correct_answer: "True" , wrong_answer: "False" })
# b_2 = Card.create({deck: journal_entry_basics, question: 'On August 2nd 2018, the Seahawks (an NFL team) receive cash in advance from fans purchasing tickets to the Seahawks vs. Packers game which will take place in September 2018. The August 2nd journal entry will cause total stockholder’s equity to decrease.', correct_answer: "False" , wrong_answer: "True" })
# b_3 = Card.create({deck: journal_entry_basics, question: 'When a company pays an employee’s salary in advance of the time that the employee earns the salary, prepaid salary is recorded as an asset.  Then, as the employee earns the salary, both expenses and liabilities will increase.', correct_answer: "False" , wrong_answer: "True" })
c_1 = Card.create({deck: fun_facts_taxes, question: "During the Middle Ages, European governments placed a tax on soap. France didn't repeal its soap tax until 1835", correct_answer: "False" , wrong_answer: "True", resource: r2})
c_2 = Card.create({deck: fun_facts_taxes, question: 'In 1712, England imposed a tax on printed wallpaper. Builders avoided the tax by hanging plain wallpaper and then painting patterns on the walls."', correct_answer: "True" , wrong_answer: "False", resource: r1})
c_3 = Card.create({deck: fun_facts_taxes, question: 'In 1705, Russian Emperor Peter the Great placed a tax on beards, hoping to force men to adopt the clean-shaven look that was common in Western Europe.', correct_answer: "True" , wrong_answer: "False", resource: r2})

d_1 = Card.create({deck: europe, question: 'The UK is comprised of 5 countries.', correct_answer: "False" , wrong_answer: "True", resource: r3})
d_2 = Card.create({deck: europe, question: 'Germany borders France.', correct_answer: "True" , wrong_answer: "False", resource: r4})
d_3 = Card.create({deck: europe, question: 'Jonny Gates is Europes top football player', correct_answer: "False" , wrong_answer: "True", resource: r2})
d_4 = Card.create({deck: europe, question: 'Ljubljana is the capital of Lithuania', correct_answer: "False" , wrong_answer: "True", resource: r6})
d_5 = Card.create({deck: europe, question: "Russia takes up 30 percent of Europe's land area", correct_answer: "False" , wrong_answer: "True"})
d_6 = Card.create({deck: europe, question: 'Croissants were invented in Austria.', correct_answer: "True" , wrong_answer: "False"})
d_7 = Card.create({deck: europe, question: 'Per capita, which country has the most McDonalds in Europe?', correct_answer: "Sweden" , wrong_answer: "Germany", resource: r8})
d_8 = Card.create({deck: europe, question: 'Italy is the most visited country in Europe.', correct_answer: "False" , wrong_answer: "True", resource: r7})
d_9 = Card.create({deck: europe, question: 'Which country is not part of the European Union?', correct_answer: "Norway" , wrong_answer: "Finland", resource: r5})

e_1 = Card.create({deck: asia, question: 'There are 60 countries in Asia.', correct_answer: "False" , wrong_answer: "True", resource: r2})
e_2 = Card.create({deck: asia, question: 'Bhutan is the smallest country by land area and population.', correct_answer: "False" , wrong_answer: "True", resource: r2})
e_3 = Card.create({deck: asia, question: 'Budhism is the oldest religion in Asia.', correct_answer: "False" , wrong_answer: "True"})
e_4 = Card.create({deck: asia, question: 'India is the country in the Asia with the cheapest labor.', correct_answer: "True" , wrong_answer: "False", resource: r2})
e_5 = Card.create({deck: asia, question: 'English is the national language in Singapore.', correct_answer: "False" , wrong_answer: "True", resource: r2})
e_6 = Card.create({deck: asia, question: 'A law was enacted in China that requires adults to visit their elderly parents often.', correct_answer: "True" , wrong_answer: "False", resource: r2})
e_7 = Card.create({deck: asia, question: 'Apples were first dicovered in Asia.', correct_answer: "False" , wrong_answer: "True", resource: r2})
e_8 = Card.create({deck: asia, question: 'Pakistan is the 3rd most populated country in Asia after china and India.', correct_answer: "False" , wrong_answer: "True", resource: r2})
f_1 = Card.create({deck: americas, question: 'To visit the Grand Canyon, you can go to Arizona.', correct_answer: "True" , wrong_answer: "False", resource: r2})
f_2 = Card.create({deck: americas, question: 'There are four Le Wagon schools in Latin America.', correct_answer: "True" , wrong_answer: "False", resource: r2})
f_3 = Card.create({deck: americas, question: 'Puerto Rico is the most populous Island in the Caribbean.', correct_answer: "False" , wrong_answer: "True", resource: r2})
f_4 = Card.create({deck: americas, question: 'Columbus sailed to America in 1492.', correct_answer: "True" , wrong_answer: "False", resource: r2})
f_5 = Card.create({deck: americas, question: 'Sao Paulo is the capital of Brazil.', correct_answer: "False" , wrong_answer: "True", resource: r2})
f_6 = Card.create({deck: americas, question: 'Which country has more wild bears?', correct_answer: "Russia" , wrong_answer: "Canada", resource: r2})
f_7 = Card.create({deck: americas, question: 'What is the easternmost state in the US', correct_answer: "Alaska" , wrong_answer: "Hawaii", resource: r2})
f_8 = Card.create({deck: americas, question: 'California has more residents than all of Canada.', correct_answer: "True" , wrong_answer: "False", resource: r2})

teacher_sections = []
sections = (1..4).each_with_object({}) do |i, section|
    teacher_sections << Section.create(name: ('A'..'D').to_a[i-1], curriculum: intro_to_tax)
end

Section.create(name: 'A', curriculum: geography)
Section.create(name: 'B', curriculum: geography)
Section.create(name: 'C', curriculum: geography)
Section.create(name: 'D', curriculum: geography)

# teacher_sections.each do |section|
#   10.times do
#     reg = Registration.new(user: User.offset(rand(User.count)).first, section: section)
#     reg.save unless reg.user.is_teacher
#   end
# end

User.where(is_teacher: false).each do |student|
  1.times do
    Registration.create(user: student, section: teacher_sections.sample)
  end
end

puts "creating attempts..."
responses = ["Correct", "Incorrect", "I don't know", "Correct"]

User.where(is_teacher: false).each do |student|
  student.sections.each do |section|
    section.curriculum.decks.each do |deck|
      deck.cards.take(rand(deck.cards.count)).each do |card|
        Attempt.create(user: student, card: card, response: responses.sample)
      end
    end
  end
end

student1 = User.create(email: "jonnygates@gmail.com", first_name: "Jonny", last_name: "Gates", password: "secret", remote_photo_url: jonny_pic)
student2 = User.create(email: "leti@email.com", first_name: "Letizia", last_name: "Ackaouy", password: "secret", remote_photo_url: leti_pic)
student3 = User.create(email: "ben@email.com", first_name: "Ben", last_name: "Pham", password: "secret", remote_photo_url: ben_pic)
student4 = User.create(email: "kitty@email.com", first_name: "Kitty", last_name: "Mayo", password: "secret", remote_photo_url: kitty_pic)
student5 = User.create(email: "sahar@email.com", first_name: "Sahar", last_name: "Khan", password: "secret", remote_photo_url: sahar_pic)
student6 = User.create(email: "shopie@email.com", first_name: "Sophie", last_name: "Spratley", password: "secret", remote_photo_url: sophie_pic)
student7 = User.create(email: "taniya@email.com", first_name: "Taniya", last_name: "Amidon", password: "secret", remote_photo_url: taniya_pic)
student8 = User.create(email: "chai@email.com", first_name: "Chai", last_name: "Chai", password: "secret", remote_photo_url: chai_pic)
student9 = User.create(email: "janie@email.com", first_name: "Janie", last_name: "Amero", password: "secret", remote_photo_url: janie_pic)
student10 = User.create(email: "jack@email.com", first_name: "Jack", last_name: "Burke", password: "secret", remote_photo_url: jack_pic)

izzys_geography_class = [student1, student2, student3, student4, student5, student6, student7, student8, student9, student10]
izzys_geography_class.each do |student|
  unless student.first_name == "Jonny"
    Registration.create(user: student, section: Section.last)
    Registration.create(user: student, section: Section.where(name: "A").last)
    Registration.create(user: student, section: Section.where(name: "B").last)
    Registration.create(user: student, section: Section.where(name: "C").last)
  end
end

Registration.create(user: student1, section: Section.last)

#random attempts for most decks cards and students
Section.last.users.where.not(first_name: "Jonny").each do |student|
  student.sections.each do |section|
    section.curriculum.decks.each do |deck|
      deck.cards.where.not(question: "Croissants were invented in Austria.").take(rand(deck.cards.count)).each do |card|
        Attempt.create(user: student, card: card, response: responses.sample)
      end
    end
  end
end

# poor attempts for croissant question
Section.last.users.where.not(first_name: %w(Jonny, Izzy)).each do |student|
  student.sections.each do |section|
    section.curriculum.decks.each do |deck|
      deck.cards.where(question: "Croissants were invented in Austria.").take(rand(deck.cards.count)).each do |card|
        Attempt.create(user: student, card: card, response: "Incorrect")
      end
    end
  end
end

# Jonny wrong answers seed
student1.sections.each do |section|
  section.curriculum.decks.each do |deck|
    deck.cards.order(id: :asc).take(5).each do |card|
      Attempt.create(user: student1, card: card, response: "Incorrect")
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

2.times do
  TodoItem.create(name: random_title(User.take(1).first, Deck.take(1).first), user: teacher, completed: true)
end

TodoItem.create(name: random_title(User.take(1).first, Deck.take(1).first), user: teacher)

puts "Seeding complete!! Done in #{ end_time - start_time } seconds."
