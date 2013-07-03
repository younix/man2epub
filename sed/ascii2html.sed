# convert: ampersand, newline and spaces
s,&,\&amp;,g
s, ,\&nbsp;,g
s,<,\&lt;,g
s,>,\&gt;,g
s,$,<br />,g

s,([^;])&nbsp;([^&]),\1 \2,g

# special
s,_(&[gl]t;),<u>\1</u>,g
s,&[gl]t;(&[gl]t;),<b>\1</b>,g
s,&amp;(&amp;),<b>\1</b>,g

# convert ascii escape sequences: underline and bold
s,_(.),<u>\1</u>,g
s,.(.),<b>\1</b>,g

# delete useless tags
s,</u><u>,,g
s,</b><b>,,g

# links to other manpages
s,([[:alpha:]]+)\(([[:digit:]])\),<a href="\1.xhtml">\1(\2)</a>,g
