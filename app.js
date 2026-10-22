const $=s=>document.querySelector(s);let products=[];
const esc=s=>String(s??'').replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));
const art=p=>p.image?`<img loading="lazy" src="${esc(p.image)}" alt="${esc(p.name)}">`:'<div class="placeholder"><span>✚</span><small>MOSTKBALMED</small></div>';
function render(){const q=$('#search').value.toLowerCase().trim();const filtered=products.filter(p=>[p.name,p.description].join(' ').toLowerCase().includes(q));$('#resultCount').textContent=`${filtered.length} products`;$('#empty').hidden=!!filtered.length;$('#empty').textContent=q?'No matching products found.':'No products have been added yet.';$('#productGrid').innerHTML=filtered.map(p=>`<article class="product-card"><div class="product-image">${art(p)}</div><div class="product-info"><h3>${esc(p.name)}</h3><a class="detail-btn" href="product.html?id=${encodeURIComponent(p.id)}">View Details <span>→</span></a></div></article>`).join('');}
$('#search').addEventListener('input',render);$('#menu').addEventListener('click',()=>{const expanded=$('#nav').classList.toggle('show');$('#menu').setAttribute('aria-expanded',String(expanded));});$('#nav').addEventListener('click',e=>{if(e.target.closest('a')){$('#nav').classList.remove('show');$('#menu').setAttribute('aria-expanded','false');}});$('#year').textContent=new Date().getFullYear();render();
function setContactLink(id, href, missingMessage){
 const el=$(id);if(!el)return;
 if(href){el.href=href;el.removeAttribute('aria-disabled');el.classList.remove('contact-unset');el.title='';}
 else{el.removeAttribute('href');el.setAttribute('aria-disabled','true');el.classList.add('contact-unset');el.title=missingMessage;}
}
function applySettings(s){
 if(!s){showPublicWarning('Website settings are not available. Check the admin settings and Supabase permissions.');return;}
 for(const [id,key] of [['aboutTitle','about_title'],['aboutText','about_text'],['contactTitle','contact_title'],['contactText','contact_text']]){
  if(typeof s[key]==='string'&&s[key].trim())$('#'+id).textContent=s[key];
 }
 const photo=$('#servicesPreview'),hint=$('#serviceHint');
 const image=String(s.maintenance_image||'').trim();
 if(photo){
  photo.onload=()=>{photo.hidden=false;if(hint)hint.hidden=true;};
  photo.onerror=()=>{photo.hidden=true;if(hint){hint.hidden=false;hint.textContent='تعذر فتح الصورة المحفوظة. افتح الأدمن وارفعها مرة أخرى.';}};
  if(/^https?:\/\//i.test(image)){photo.hidden=true;photo.src=image;if(hint){hint.hidden=false;hint.textContent='جاري تحميل الصورة...';}}
  else{photo.hidden=true;photo.removeAttribute('src');if(hint){hint.hidden=false;hint.textContent='لم يتم حفظ صورة الصيانة والتجهيزات في Supabase. افتح الأدمن واحفظ الصورة.';}}
 }
 const wa=String(s.whatsapp||'').replace(/\D/g,'');
 const phone=String(s.phone||'').replace(/[^0-9+]/g,'');
 setContactLink('#whatsappButton',wa.length>=10?'https://wa.me/'+wa:'','Add WhatsApp number in Admin → Contact');
 setContactLink('#phoneButton',phone.length>=5?'tel:'+phone:'','Add landline number in Admin → Contact');
}
function showPublicWarning(message){
 console.error('[MOSTKBALMED settings]',message);
 const hint=$('#serviceHint');if(hint){hint.hidden=false;hint.textContent='تعذر تحميل الصورة من إعدادات الموقع. '+message;}
 const warning=$('#settingsWarning');if(warning){warning.hidden=false;warning.textContent=message;}
}
(async()=>{
 const cfg=window.MOSTKBALMED_CONFIG||{};
 if(!cfg.url||!cfg.anonKey){showPublicWarning('Supabase config.js is missing.');return;}
 const headers={apikey:cfg.anonKey,Accept:'application/json'};
 if(!cfg.anonKey.startsWith('sb_publishable_'))headers.Authorization='Bearer '+cfg.anonKey;
 const base=cfg.url.replace(/\/$/,'')+'/rest/v1/';
 // Load settings independently of products: product failures must never disable contact or hover.
 const settingsTask=(async()=>{
  try{
   const res=await fetch(base+'med_settings?select=*&id=eq.1',{headers,cache:'no-store'});
   const body=await res.json();
   if(!res.ok)throw Error('Settings HTTP '+res.status+': '+(body.message||JSON.stringify(body)));
   if(!Array.isArray(body)||!body.length)throw Error('med_settings has no row with id=1.');
   applySettings(body[0]);
  }catch(e){showPublicWarning(e.message);}
 })();
 const productsTask=(async()=>{
  try{
   const res=await fetch(base+'med_products?select=id,name,image,description&active=eq.true&order=created_at.desc',{headers,cache:'no-store'});
   if(!res.ok)throw Error('Products HTTP '+res.status);
   products=await res.json();render();
  }catch(e){console.error(e);$('#empty').hidden=false;$('#empty').textContent='Unable to load products. Please try again later.';}
 })();
 await Promise.allSettled([settingsTask,productsTask]);
})();

// Desktop hover and keyboard focus; hide immediately when pointer leaves.
const serviceTrigger=$('#serviceAbout');
if(serviceTrigger){
 serviceTrigger.addEventListener('pointerenter',()=>serviceTrigger.classList.add('preview-open'));
 serviceTrigger.addEventListener('mouseenter',()=>serviceTrigger.classList.add('preview-open'));
 serviceTrigger.addEventListener('pointerleave',()=>serviceTrigger.classList.remove('preview-open'));
 serviceTrigger.addEventListener('mouseleave',()=>serviceTrigger.classList.remove('preview-open'));
 serviceTrigger.addEventListener('focus',()=>serviceTrigger.classList.add('preview-open'));
 serviceTrigger.addEventListener('blur',()=>serviceTrigger.classList.remove('preview-open'));
 serviceTrigger.addEventListener('click',()=>serviceTrigger.classList.toggle('preview-open'));
 document.addEventListener('click',e=>{if(!serviceTrigger.contains(e.target))serviceTrigger.classList.remove('preview-open')});
}
