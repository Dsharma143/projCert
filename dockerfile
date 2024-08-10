FROM devopsedu/webapp 
ADD ./website/ /var/www/html
RUN rm /var/www/html/index.php
CMD apachectl -D FOREGROUND
