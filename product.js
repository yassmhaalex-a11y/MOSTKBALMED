const esc=s=>String(s??'').replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));
const params=new URLSearchParams(location.search),id=params.get('id');
const target=document.getElementById('productDetail');
document.getElementById('year').textContent=new Date().getFullYear();
function show(p,category){
 document.title=p.name+' | MOSTKBALMED';
 const features=Array.isArray(p.features)?p.features:[];
 const picture=p.image?`<img src="${esc(p.image)}" alt="${esc(p.name)}">`:'<div class="placeholder"><span>✚</span><small>MOSTKBALMED</small></div>';
 target.innerHTML=`<article class="detail-layout"><div class="detail-image">${picture}</div><div class="detail-text"><span class="tag">${esc(category||'Medical Equipment')}</span><h1>${esc(p.name)}</h1><div class="detail-section"><h2>Product Description</h2><p class="product-description">${esc(p.description||'Contact MOSTKBALMED for product information.')}</p></div>${features.length?`<div class="detail-section"><h2>Specifications & Features</h2><ul>${features.map(f=>`<li>${esc(f)}</li>`).join('')}</ul></div>`:''}<p class="disclaimer">Product information is for browsing only. Confirm specifications and availability with MOSTKBALMED.</p></div></article>`;
}
function fail(msg){target.innerHTML=`<div class="detail-error"><h1>Product unavailable</h1><p>${esc(msg)}</p><a class="cta" href="index.html#products">Browse Products →</a></div>`;}
async function load(){
 if(!id){fail('No product was selected.');return;}
 const cfg=window.MOSTKBALMED_CONFIG||{};
 try{
  if(cfg.url&&cfg.anonKey){
   const headers={apikey:cfg.anonKey,Authorization:'Bearer '+cfg.anonKey};
   const base=cfg.url.replace(/\/$/,'')+'/rest/v1/';
   const r=await fetch(base+'med_products?id=eq.'+encodeURIComponent(id)+'&active=eq.true&select=id,name,category,image,description,features',{headers});
   if(!r.ok)throw new Error('Unable to load the product from Supabase.');
   const rows=await r.json();if(!rows.length){fail('This product could not be found.');return;}
   const c=await fetch(base+'med_categories?id=eq.'+encodeURIComponent(rows[0].category)+'&select=name',{headers});
   const cats=c.ok?await c.json():[];show(rows[0],cats[0]?.name);return;
  }
  const p=(window.CATALOG_PRODUCTS||[]).find(x=>x.id===id);
  if(!p){fail('This product could not be found.');return;}
  show(p,(window.CATALOG_CATEGORIES||[]).find(x=>x.id===p.category)?.name);
 }catch(e){console.error(e);fail('Please check your connection and try again.');}
}
load().finally(()=>{const loader=document.getElementById('pageLoader');loader.classList.add('loader-hide');loader.addEventListener('transitionend',()=>loader.remove(),{once:true});});
