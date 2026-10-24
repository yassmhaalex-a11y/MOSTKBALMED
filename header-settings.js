/* V21: Header text is loaded on every page, including admin. */
(async()=>{
  const cfg=window.MOSTKBALMED_CONFIG;
  if(!cfg?.url||!cfg?.anonKey)return;
  try{
    const headers={apikey:cfg.anonKey,Accept:'application/json'};
    if(!cfg.anonKey.startsWith('sb_publishable_'))headers.Authorization='Bearer '+cfg.anonKey;
    const response=await fetch(cfg.url.replace(/\/$/,'')+'/rest/v1/med_settings?select=brand_name,brand_subtitle&id=eq.1',{headers,cache:'no-store'});
    if(!response.ok)throw Error('Header settings unavailable');
    const settings=(await response.json())[0]||{};
    const name=document.getElementById('siteBrandName');
    if(name&&settings.brand_name?.trim()){
      name.textContent=settings.brand_name.trim();
      // Keep the final three characters highlighted, like the original MOSTKBALMED branding.
      const raw=settings.brand_name.trim();
      if(raw.toUpperCase().endsWith('MED')&&raw.length>3){
        name.textContent=raw.slice(0,-3);
        const accent=document.createElement('span');accent.className='accent';accent.textContent=raw.slice(-3);name.append(accent);
      }
    }
    const subtitle=document.querySelector('.brand small');
    if(subtitle&&typeof settings.brand_subtitle==='string'&&settings.brand_subtitle.trim())subtitle.textContent=settings.brand_subtitle;
  }catch(error){console.warn('Header settings:',error.message);}
})();
