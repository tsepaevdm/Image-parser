import re, os, time
from urllib.parse import unquote
from urllib.request import urlretrieve
from multiprocessing.dummy import Pool

for encoding in ('utf-8', 'windows-1251', 'iso-8859-1'):
	try:
		input_ = open('page.html', encoding = encoding)
		raw_text = input_.read()
		break
	except: continue
	finally: input_.close()

pattern = r"https?://[\w~?#!\[\]@'%/&()$.*:+,=;-]+?\.(?:gif|bmp|png|jpe?g)"
start = time.perf_counter()
urls = set(re.findall(pattern, raw_text))
print('Found %d images in %.3f seconds' % (len(urls), time.perf_counter() - start))
with open('urls.txt', 'w') as output: output.write('\n'.join(urls))

def download_url(url):
	global target, count, width
	try: 
		count += 1
		print('\n[%*d/%d]' % (width, count, len(urls)), end = '')
		path = target + '/' + unquote(url).split('/')[-1]
		urlretrieve(url, path)
	except: print(' Error!', end = '')

if input('Download images? [Yes/No]\n').lower() == 'yes':
	target = input('Choose folder: ')
	if re.search(r'\w+?', target):
		if not os.path.exists(target): os.mkdir(target)
		count = 0
		width = len(str(len(urls)))
		print('Downloading...', end = '')
		start = time.perf_counter()
		Pool(6).map(download_url, urls)
		print('\nDone [%.3f seconds]' % (time.perf_counter() - start))
	else: print('Incorrect folder name')