from selenium import webdriver

options = webdriver.ChromeOptions()
options.add_argument('--display=:1')
options.add_argument('--no-first-run')
options.add_argument('--no-sandbox')
options.add_argument('--window-size=1280,720')
options.add_argument('--start-fullscreen')
options.add_argument('--hide-scrollbars')
# options.add_argument('--disable-features=TranslateUI')
# options.add_argument('--autoplay-policy=no-user-gesture-required')
# options.add_argument('--incognito')
# options.add_argument('--disable-gpu')
# options.add_argument('disable-infobars')
# options.add_argument('--disable-dev-shm-usage')
# options.add_argument('useAutomationExtension=false')

driver = webdriver.Chrome(chrome_options=options)

driver.get("https://www.baidu.com")

driver.get_screenshot_as_file('./baidu.png')
