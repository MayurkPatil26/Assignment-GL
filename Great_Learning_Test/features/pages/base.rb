require 'selenium-webdriver'
require 'test/unit'

class BaseTest < Test::Unit::TestCase

  def setup
    username= "mayurtestinggl26" #Assign username
    accessToken= "kjOiKpKHHYB6mpMhlcKwYpCRlDgcgdqhp0ekyDnvz3V820H2q1" #Assign accesskey
    gridUrl = "hub.lambdatest.com/wd/hub"
    caps = {
    		'LT:Options' => {
    			"user" => username,
    			"accessKey" => accessToken,
    			"build" => "Great Leaning Registraion Flow",
    			"name" => "Fill Registration Form",
    			"platformName" => "Windows 11",
    			"selenium_version" => "4.0.0",
			    "geoLocation" => "IN"
    		},
    		"browserName" => "Chrome",
    		"browserVersion" => "98.0",
    	}
        # puts (caps)
        # puts ("https://"+username+":"+accessToken+"@"+gridUrl)
        # URL: https://{username}:{accessToken}@hub.lambdatest.com/wd/hub
      @driver = Selenium::WebDriver.for(:remote,
            :url => "https://"+username+":"+accessToken+"@"+gridUrl,
            :capabilities => caps)
      @driver.file_detector = lambda do |args|
      str = args.first.to_s
      str if File.exist?(str)
    end
  end

  def visit_url(url)
    @driver.navigate.to url
  end

  def selectors_from_page_objects(page_object, value = nil)
    output = []
    if page_object.is_a?(Array)
      output << page_object.first
      output << page_object.last
    elsif page_object.is_a?(Hash)
      output = page_object.first
    else
      raise "Locator cannot be nil - #{page_object} #{value}" if value.nil?

      output << page_object
      output << value
    end
    output
  end

  def catch_stale_exception(retry_count = 2, &block)
    begin
      block.call
    rescue Selenium::WebDriver::Error::StaleElementReferenceError => e
      logger.info "[Stale Element Exception] Retrying to find element due to exception #{e.message}"
      retry_count -= 1
      retry if retry_count > 0
    end
  end

  def get_element(selector, check_displayed = true, custom_timeout = nil)
    selector, value = selectors_from_page_objects(selector)
    @selector = selector
    @value = value
    catch_stale_exception(3) do
      if check_displayed
        wait = Selenium::WebDriver::Wait.new(timeout: (custom_timeout.nil? ? 60 : custom_timeout))
        wait.until { @driver.find_element(@selector, @value).displayed? }
      end
      begin
        return @driver.find_element(@selector, @value)
      rescue Exception => e
        return nil
      end
    end
  end

  def get_elements(selector, check_displayed = true, custom_timeout = nil)
    selector, value = selectors_from_page_objects(selector)
    retry_count = 3
    begin
      if check_displayed
        wait = Selenium::WebDriver::Wait.new(:timeout => (custom_timeout.nil? ? 60 : custom_timeout))
        wait.until{@driver.find_elements(selector, value)[0].displayed?}
      end
      elements = @driver.find_elements(selector,value)
      return elements
    rescue Exception => e
      retry_count -= 1
      retry if retry_count > 0
    end
  end

  def get_child_element(parent_element, selector, check_displayed = true)
    selector, value = selectors_from_page_objects(selector)
    catch_stale_exception(3) do
      if check_displayed
        wait = Selenium::WebDriver::Wait.new(:timeout => 60)
        wait.until{parent_element.find_element(selector, value).displayed?}
      end
      parent_element.find_element(selector, value)
    end
  end

  def child_element_disaplyed?(parent_element, selector)
    selector, value = selectors_from_page_objects(selector)
    begin
      catch_stale_exception(3) do
        parent_element.find_element(selector, value).displayed?
      end
    rescue
      return false
    end
  end

  def element_click(element)
    element.click()
  end

  def enter_texts(element, text)
    element.click()
  end

  def click_checkbox(selector)
    checkbox = get_element(selector)
    element_click(checkbox)
  end

  def element_text(selector, check_displayed = true)
    catch_stale_exception(3) do
      get_element(selector, check_displayed).text
    end
  end

  def drop_down_selection(selector, text)
    selector, value = selectors_from_page_objects(selector)
    @selector = selector
    @value = value
    dropdown_list = @driver.find_element(selector, value)
    options = dropdown_list.find_elements(tag_name: 'option')
    options.each { |option| option.click if option.text == text }
  end

  def script_executer(script)
     @driver.execute_script(script)
  end

  def close_the_driver
    @driver.quit
  end
end
