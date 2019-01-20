import re, os, time
from urllib.parse import unquote
from urllib.request import urlretrieve

# try to open file using most common html encodings
# assuming file page.html exists in the current folder
for encoding in ('utf-8', 'windows-1251', 'iso-8859-1'):
	input_ = open('page.html', encoding = encoding)
	try:
		raw_text = input_.read()
		break
	except: continue
	finally: input_.close()

start = time.time()

# urls must contain only safe characters plus '%' in case of percent-encoding
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
