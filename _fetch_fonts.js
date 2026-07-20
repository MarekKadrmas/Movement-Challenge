const fs=require('fs'), https=require('https'), path=require('path');
const UA='Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0 Safari/537.36';
function get(url){return new Promise((res,rej)=>{https.get(url,{headers:{'User-Agent':UA}},r=>{const c=[];r.on('data',d=>c.push(d));r.on('end',()=>res(Buffer.concat(c)));}).on('error',rej);});}
(async()=>{
  const cssUrl='https://fonts.googleapis.com/css2?family=Figtree:wght@400;500;600;700;800;900&family=Space+Grotesk:wght@500;600;700&display=swap';
  let css=(await get(cssUrl)).toString('utf8');
  const urls=[...new Set(css.match(/https:\/\/[^)\s]+\.woff2/g)||[])];
  console.log('woff2 souboru:',urls.length);
  fs.mkdirSync(path.join(__dirname,'fonts'),{recursive:true});
  for(const u of urls){
    const name=u.split('/').slice(-2).join('-'); // unikatni nazev
    const buf=await get(u);
    fs.writeFileSync(path.join(__dirname,'fonts',name),buf);
    css=css.split(u).join('fonts/'+name);
    console.log(' ',name,buf.length,'B');
  }
  // font-display: block s kratkym timeoutem neni treba - preload je nacte pred renderem; nech swap
  fs.writeFileSync(path.join(__dirname,'fonts','fonts.css'),css);
  console.log('WROTE fonts/fonts.css', css.length,'B');
  console.log('PRELOADS:');
  for(const u of urls){ console.log('<link rel="preload" as="font" type="font/woff2" crossorigin href="fonts/'+u.split('/').slice(-2).join('-')+'">'); }
})();
