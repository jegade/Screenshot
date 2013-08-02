var fs = require('fs');

var page = new WebPage(),
    address, output, size,meta;

if (phantom.args.length < 2 || phantom.args.length > 3) {
    console.log('Usage: rasterize.js URL filename');
    phantom.exit();
} else {
    address = phantom.args[0];
    output = phantom.args[1];
    page.viewportSize = { width: 1024, height: 768 };
    page.open(address, function (status) {

        if (status !== 'success') {
       


            console.log('Unable to load the address!');
            phantom.exit();
        
        } else {
          
            meta = page.evaluate( function() {

               var els = document.querySelectorAll('p');
               var tel = document.querySelector('title');

               var content = "";
               var i = 0;

               while(i < els.length) {

                   if (els[i].innerText.length > 120 && content == "") { 
                        
                       content = els[i].innerText;
                   }
                   i++;
               }

               return { 
                        'title': ( tel ? tel.innerText : address ),
                        'content': content,
                };
            });

            meta.output = output;

            fs.write(output+".json",JSON.stringify(meta),'w');
            
            window.setTimeout(function () {
                page.render(output);
                phantom.exit();
            }, 2000);
        }
    });
}
