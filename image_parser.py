import re, os, time
from urllib.parse import unquote
from urllib.request import urlretrieve

# assuming page.html exists in the current folder
# try to read it with the most common html encodings

for encoding in ('utf-8', 'windows-1251', 'iso-8859-1'):
	try:
		input_ = open('page.html', encoding = encoding)
		raw_text = input_.read()
		break
	except: continue
	finally: input_.close()

# urls must contain only safe characters and '%' in case of the percent-encoding

start = time.time()
pattern = r"https?://[\w~?#!\[\]@'%/&()$.*:+,=;-]+?\.(?:gif|bmp|png|jpe?g)"
urls = set(re.findall(pattern, raw_text))

print('Found %d images in %.3f seconds' % (len(urls), time.time() - start))

with open('urls.txt', 'w') as output:
	output.write('\n'.join(urls))

if input('Download images? [Yes/No]\n').lower() == 'yes':
	target = input('Choose folder: ').replace(' ', r'\ ')
	if re.search(r'\w+?', target):
		if not os.path.exists(target): os.mkdir(target)
		print('Downloading...')
		for url in urls:
			path = target + '/' + unquote(url).split('/')[-1]
			urlretrieve(url, path)
	else: print('Incorrect folder name')
