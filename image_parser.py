import re, os, time

encoding = 'utf-8'

# fetch encoding from the file, utf-8 if none found
with open('page.html') as file:
	for line in file:
		encoding_found = re.search('charset=.+?"', line)
		if encoding_found:
			encoding = encoding_found.group()[8:-1]
			break

# read text with a proper encoding
with open('page.html', encoding = encoding) as file:
	raw_text = file.read()

start = time.time()
pattern = r"https?://[\w~?#!\[\]@'/&()$.*:+,=;-]+?\.(?:gif|bmp|png|jpe?g)"
urls = re.findall(pattern, raw_text, flags=re.ASCII)

print('Found %d images in %.3f seconds' % (len(urls), time.time() - start))

with open('urls.txt', 'w') as output: 
	output.write('\n'.join(urls))

if input('Download images? [Yes/No]\n').lower() == 'yes':
	target = input('Choose folder: ').replace(' ', r'\ ')
	if re.search(r'\w+?', target):
		os.system('mkdir ' + target)
		for url in urls: os.system('cd %s; curl -LO %s' % (target, url))
	else: print('Incorrect folder name')
