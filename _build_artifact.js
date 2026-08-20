const fs=require('fs'), https=require('https');
const UA='Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0 Safari/537.36';
function get(url){return new Promise((res,rej)=>{https.get(url,{headers:{'User-Agent':UA}},r=>{const c=[];r.on('data',d=>c.push(d));r.on('end',()=>res(Buffer.concat(c)));}).on('error',rej);});}
(async()=>{
  let css=fs.readFileSync('_fonts.css','utf8');
  const urls=[...new Set(css.match(/https:\/\/[^)\s]+\.woff2/g)||[])];
  console.log('fonts to inline:',urls.length);
  for(const u of urls){ const buf=await get(u); css=css.split(u).join('data:font/woff2;base64,'+buf.toString('base64')); console.log('  ok',u.split('/').pop(),buf.length,'bytes'); }
  let mk=fs.readFileSync('mockup.html','utf8');
  mk=mk.replace(/<link[^>]*fonts\.(googleapis|gstatic)[^>]*>/gi,'');
  mk=mk.replace(/<!doctype html>/i,'').replace(/<\/?html[^>]*>/gi,'').replace(/<\/?head[^>]*>/gi,'').replace(/<\/?body[^>]*>/gi,'');
  const out='<style>\n'+css+'\n</style>\n'+mk;
  fs.writeFileSync('mockup-artifact.html',out);
  console.log('WROTE mockup-artifact.html bytes:',out.length);
})();
