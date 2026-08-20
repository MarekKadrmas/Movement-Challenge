import re, base64, urllib.request, sys
UA="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0 Safari/537.36"
css=open('_fonts.css','r',encoding='utf-8').read()
urls=sorted(set(re.findall(r'https://[^)\s]+\.woff2',css)))
print('fonts to inline:',len(urls))
cache={}
for u in urls:
    req=urllib.request.Request(u,headers={'User-Agent':UA})
    data=urllib.request.urlopen(req,timeout=30).read()
    b64=base64.b64encode(data).decode()
    cache[u]='data:font/woff2;base64,'+b64
    print('  ok',u.split('/')[-1],len(data),'bytes')
for u,d in cache.items():
    css=css.replace(u,d)
# build mockup artifact: strip outer wrappers + google fonts <link>, prepend inlined @font-face
mk=open('mockup.html','r',encoding='utf-8').read()
# remove google fonts links + preconnect
mk=re.sub(r'<link[^>]*fonts\.(googleapis|gstatic)[^>]*>','',mk)
# strip doctype/html/head/body wrapper tags (keep inner content)
mk=re.sub(r'<!doctype html>','',mk,flags=re.I)
mk=re.sub(r'</?html[^>]*>','',mk,flags=re.I)
mk=re.sub(r'</?head[^>]*>','',mk,flags=re.I)
mk=re.sub(r'</?body[^>]*>','',mk,flags=re.I)
out='<style>\n'+css+'\n</style>\n'+mk
open('mockup-artifact.html','w',encoding='utf-8').write(out)
print('WROTE mockup-artifact.html bytes:',len(out))
