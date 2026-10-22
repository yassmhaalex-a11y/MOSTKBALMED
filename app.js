const $=s=>document.querySelector(s);let categories=[];let products=[];
const catName=id=>categories.find(c=>c.id===id)?.name||'Medical Equipment';
const escapeHTML=s=>String(s??'').replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));
const symbol=id=>({diagnostic:'♡',respiratory:'✚',supplies:'▦',clinic:'⚕'}[id]||'✚');
const art=p=>p.image?`<img loading="lazy" src="${escapeHTML(p.image)}" alt="${escapeHTML(p.name)}">`:`<div class="placeholder"><span>${symbol(p.category)}</span><small>MOSTKBALMED</small></div>`;
function renderCategories(){ $('#categoryGrid').innerHTML=categories.map(c=>`<button class="category-card" data-cat="${escapeHTML(c.id)}"><span class="cat-icon">${escapeHTML(c.icon)}</span><strong>${escapeHTML(c.name)}</strong><small>${escapeHTML(c.description)}</small><span class="arrow">Explore →</span></button>`).join('');
$('#categoryFilter').innerHTML='<option value="all">All Categories</option>'+categories.map(c=>`<option value="${escapeHTML(c.id)}">${escapeHTML(c.name)}</option>`).join(''); }
function render(){const q=$('#search').value.toLowerCase().trim(),cat=$('#categoryFilter').value;const filtered=products.filter(p=>(cat==='all'||p.category===cat)&&[p.name,p.description,catName(p.category)].join(' ').toLowerCase().includes(q));$('#resultCount').textContent=`${filtered.length} products`;$('#empty').hidden=filtered.length!==0;$('#empty').textContent=q||cat!=='all'?'No matching products found.':'No products have been added yet.';$('#productGrid').innerHTML=filtered.map(p=>`<article class="product-card"><div class="product-image">${art(p)}</div><div class="product-info"><span class="tag">${escapeHTML(catName(p.category))}</span><h3>${escapeHTML(p.name)}</h3><a class="detail-btn" href="product.html?id=${encodeURIComponent(p.id)}">View Details <span>→</span></a></div></article>`).join('');}
$('#search').addEventListener('input',render);$('#categoryFilter').addEventListener('change',render);
$('#categoryGrid').addEventListener('click',e=>{const b=e.target.closest('[data-cat]');if(!b)return;$('#categoryFilter').value=b.dataset.cat;render();$('#products').scrollIntoView({behavior:'smooth'});});
$('#menu').addEventListener('click',()=>{const expanded=$('#nav').classList.toggle('show');$('#menu').setAttribute('aria-expanded',String(expanded));});$('#nav').addEventListener('click',e=>{if(e.target.closest('a')){$('#nav').classList.remove('show');$('#menu').setAttribute('aria-expanded','false');}});
$('#year').textContent=new Date().getFullYear();renderCategories();render();
(async function loadCatalog(){
 const cfg=window.MOSTKBALMED_CONFIG||{};
 if(!cfg.url||!cfg.anonKey){$('#empty').hidden=false;$('#empty').textContent='Catalog connection is not configured.';return;}
 try {
  const headers={apikey:cfg.anonKey,Authorization:'Bearer '+cfg.anonKey};
  const base=cfg.url.replace(/\/$/,'')+'/rest/v1/';
  const [cr,pr]=await Promise.all([fetch(base+'med_categories?select=id,name,icon,description&order=name',{headers}),fetch(base+'med_products?select=id,name,category,image,images,description,features&active=eq.true&order=created_at.desc',{headers})]);
  if(!cr.ok||!pr.ok)throw new Error('Catalog fetch failed. Check database setup.');
  categories=await cr.json();products=await pr.json();
  renderCategories();render();
 }catch(e){console.error(e);$('#empty').hidden=false;$('#empty').textContent='Unable to load catalog. Please try again later.';$('#productGrid').innerHTML='';$('#categoryGrid').innerHTML='';$('#resultCount').textContent='';}
})();
