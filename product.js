const esc=s=>String(s??'').replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));
const params=new URLSearchParams(location.search),id=params.get('id');
const target=document.getElementById('productDetail');
document.getElementById('year').textContent=new Date().getFullYear();
function show(p,category){
 document.title=p.name+' | MOSTKBALMED';
 const features=Array.isArray(p.features)?p.features:[];
 const images=Array.isArray(p.images)&&p.images.length?p.images.filter(Boolean):(p.image?[p.image]:[]);
 const picture=images.length?`<div class="gallery"><div class="detail-image"><img id="mainProductImage" src="${esc(images[0])}" alt="${esc(p.name)}"></div>${images.length>1?`<div class="gallery-controls"><button type="button" id="prevImage" aria-label="Previous image">‹</button><span id="imageCounter">1 / ${images.length}</span><button type="button" id="nextImage" aria-label="Next image">›</button></div><div class="gallery-thumbs">${images.map((src,i)=>`<button type="button" class="gallery-thumb ${i===0?'selected':''}" data-index="${i}" aria-label="Show image ${i+1}"><img src="${esc(src)}" alt="Thumbnail ${i+1}" loading="lazy"></button>`).join('')}</div>`:''}</div>`:'<div class="detail-image placeholder"><span>✚</span><small>MOSTKBALMED</small></div>';
 target.innerHTML=`<article class="detail-layout"><div>${picture}</div><div class="detail-text"><span class="tag">${esc(category||'Medical Equipment')}</span><h1>${esc(p.name)}</h1><div class="detail-section"><h2>Product Description</h2><p class="product-description">${esc(p.description||'Contact MOSTKBALMED for product information.')}</p></div>${features.length?`<div class="detail-section"><h2>Specifications & Features</h2><ul>${features.map(f=>`<li>${esc(f)}</li>`).join('')}</ul></div>`:''}<p class="disclaimer">Product information is for browsing only. Confirm specifications and availability with MOSTKBALMED.</p></div></article>`;
 if(images.length>1){let current=0;const select=i=>{current=(i+images.length)%images.length;document.getElementById('mainProductImage').src=images[current];document.getElementById('imageCounter').textContent=`${current+1} / ${images.length}`;target.querySelectorAll('.gallery-thumb').forEach((b,j)=>b.classList.toggle('selected',j===current));};target.querySelector('#prevImage').onclick=()=>select(current-1);target.querySelector('#nextImage').onclick=()=>select(current+1);target.querySelectorAll('.gallery-thumb').forEach(b=>b.onclick=()=>select(Number(b.dataset.index)));}

}
function fail(msg){target.innerHTML=`<div class="detail-error"><h1>Product unavailable</h1><p>${esc(msg)}</p><a class="cta" href="index.html#products">Browse Products →</a></div>`;}
async function load(){
 if(!id){fail('No product was selected.');return;}
 const cfg=window.MOSTKBALMED_CONFIG||{};
 try{
  if(cfg.url&&cfg.anonKey){
   const headers={apikey:cfg.anonKey};if(!cfg.anonKey.startsWith('sb_publishable_'))headers.Authorization='Bearer '+cfg.anonKey;
   const base=cfg.url.replace(/\/$/,'')+'/rest/v1/';
   const r=await fetch(base+'med_products?id=eq.'+encodeURIComponent(id)+'&active=eq.true&select=id,name,category,image,images,description,features',{headers});
   if(!r.ok)throw new Error('Unable to load the product from Supabase.');
   const rows=await r.json();if(!rows.length){fail('This product could not be found.');return;}
   show(rows[0],'Medical Equipment');return;
  }
  fail('Catalog connection is not configured.');
 }catch(e){console.error(e);fail('Please check your connection and try again.');}
}
load().finally(()=>{const loader=document.getElementById('pageLoader');loader.classList.add('loader-hide');loader.addEventListener('transitionend',()=>loader.remove(),{once:true});});
