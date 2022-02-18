require_relative 'base'

class GreatlearningPage < BaseTest
  def initialize
    setup
  end

  NAME_BOX = [:id, 'name'].freeze
  PHONE_BOX = [:id, 'phone'].freeze
  EMAIL_BOX = [:id, 'email'].freeze
  CITY_BOX = [:id, 'myCity'].freeze
  EXPERIENCE_DROPDOWN = [:id, 'experience'].freeze
  PROGRAMING_EXP_DROPDOWN = [:id, 'programming_exp_in_years'].freeze
  OTHER_LANG_BOX = [:id, 'other_planguages'].freeze

  GRAD_DEGREE_DROPDOWN = [:id, 'grad_degree'].freeze
  GRAD_SPECIAL_BOX = [:id, 'grad_specialization'].freeze
  GRAD_COLLEGEL_BOX = [:id, 'grad_college'].freeze
  GRAD_YEAR_DROPDOWN = [:id, 'grad_year'].freeze
  GRAD_CGPA_BOX = [:id, 'grad_cgpa'].freeze

  PG_DEGREE_DROPDOWN = [:id, 'pg_degree'].freeze
  PG_SPECIAL_BOX = [:id, 'pg_specialization'].freeze
  PG_COLLEGEL_BOX = [:id, 'pg_college'].freeze
  PG_YEAR_DROPDOWN = [:id, 'pg_year'].freeze
  PG_CGPA_BOX = [:id, 'pg_cgpa'].freeze

  LINKDINE_LINK_BOX = [:id, 'linkedinurl'].freeze
  RESUME_UPLOAD_BOX = [:css, 'input[type=file]'].freeze

  QUESTION_BOX = [:id, 'new_question1'].freeze

  PASSWORD_BOX = [:id, 'password'].freeze

  def open_greatlearning(url)
    visit_url(url)
  end

  def fill_basic_info()
    name_element = get_element(NAME_BOX)
    name_element.send_keys("Mayur Patil")
    name_element.send_keys:return
    phone_element = get_element(PHONE_BOX)
    @random_mobile_number =  "6688" + rand(10 ** 6).to_s
    phone_element.send_keys(@random_mobile_number)
    phone_element.send_keys:return
    email_element = get_element(EMAIL_BOX)
    @random_email_id = "mayur+" + (0...10).map { (65 + rand(26)).chr }.join + "@test.com"
    email_element.send_keys(@random_email_id)
    email_element.send_keys:return
    city_element = get_element(CITY_BOX)
    city_element.send_keys("Pune")
    city_element.send_keys:return
    drop_down_selection(EXPERIENCE_DROPDOWN, "PG Student")
    script_executer("document.getElementById('app_step_1').click()")
  end

  def fill_professional_details()
    drop_down_selection(PROGRAMING_EXP_DROPDOWN, "3-5 Years")
    script_executer("document.getElementsByName('programming_languages[]')[1].click()")
    script_executer("document.getElementsByName('programming_languages[]')[2].click()")
    script_executer("document.getElementsByName('programming_languages[]')[3].click()")
    script_executer("document.getElementsByName('programming_languages[]')[4].click()")
    script_executer("document.getElementsByName('programming_languages[]')[6].click()")

    other_lang_element = get_element(OTHER_LANG_BOX)
    other_lang_element.send_keys("Nodejs,Golang")
    other_lang_element.send_keys:return

    script_executer("document.getElementById('professional_section').click()")
  end

  def fill_education_details()

    drop_down_selection(GRAD_DEGREE_DROPDOWN, "B.E./B.Tech.")
    grad_specialization_element = get_element(GRAD_SPECIAL_BOX)
    grad_specialization_element.send_keys("Computer Engineering")
    grad_specialization_element.send_keys:return

    grad_college_element = get_element(GRAD_COLLEGEL_BOX)
    grad_college_element.send_keys("Pillai's college of Engineering")
    grad_college_element.send_keys:return

    drop_down_selection(GRAD_YEAR_DROPDOWN, "2017")

    grad_cgpa_element = get_element(GRAD_CGPA_BOX)
    grad_cgpa_element.send_keys("83.01")
    grad_cgpa_element.send_keys:return

    script_executer("document.getElementById('add_pg_details').click()")
    drop_down_selection(PG_DEGREE_DROPDOWN, "M.E./M.Tech.")
    pg_specialization_element = get_element(PG_SPECIAL_BOX)
    pg_specialization_element.send_keys("Master Computer Engineering")
    pg_specialization_element.send_keys:return

    pg_college_element = get_element(PG_COLLEGEL_BOX)
    pg_college_element.send_keys("Pillai's college of Master Engineering")
    pg_college_element.send_keys:return

    drop_down_selection(PG_YEAR_DROPDOWN, "2019")

    pg_cgpa_element = get_element(PG_CGPA_BOX)
    pg_cgpa_element.send_keys("79.64")
    pg_cgpa_element.send_keys:return
    script_executer("document.getElementById('prof_details_end').click()")
  end

  def fill_linkdine_details()

    lkdin_element = get_element(LINKDINE_LINK_BOX)
    lkdin_element.send_keys("https://www.linkedin.com/in/benjamin-grant-72381ujy3u")


    resume_element = script_executer("return document.getElementById('resume')")
    resume_element.send_keys(Dir.pwd + "/Resume.pdf")

    script_executer("document.getElementById('upload_next').click()")
  end

  def fill_program_demo()
    question_element = get_element(QUESTION_BOX)
    question_element.send_keys("What is cloud Computing?")
    question_element.send_keys:return

    script_executer("document.getElementById('declare').click()")
    script_executer("document.getElementById('submit_app').click()")
  end

  def do_signup()
    chars = (0..9).to_a + ('A'..'z').to_a + ('!'..'?').to_a
    @random_password  = chars.shuffle[0..10].join

    paswword_element = get_element(PASSWORD_BOX)
    paswword_element.send_keys(@random_password)
    paswword_element.send_keys:return

    sleep 50
  end

  def print_user_account_details()
    puts ("Name: " + "Mayur Patil")
    puts ("Mobile No: " + @random_mobile_number)
    puts ("EmailID: " + @random_email_id)
    puts ("Password: " + @random_password)
  end

  def close_the_browser
    close_the_driver
  end
end
