# -*- coding: utf-8 -*-
""" Web scraping script using requests and bs4
    Used for web scraping tutorial session by the Stanford Data Science
    Drop-in. February 2, 2015.

    Requires:
    BeautifulSoup(http://www.crummy.com/software/BeautifulSoup)
        pip install beautifulsoup4
            or
        easy_install beautifulsoup4
    Requests(http://docs.python-requests.org/)
        pip install requests
            or
        easy_install requests

    This will use some basics of BeautifulSoup to explore the source (html) of
    the BeautifulSoup website itself!
    (http://www.crummy.com/software/BeautifulSoup/)
@author: Jongbin Jung (jongbin at stanford edu)
"""

from bs4 import BeautifulSoup
import requests

web_page = requests.get('http://www.crummy.com/software/BeautifulSoup/')

soup = BeautifulSoup(web_page.content)


