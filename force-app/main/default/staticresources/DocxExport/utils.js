//Author: Leonid Bartenev

(function (w){
    w.DocxExport = {

        export: function (data, templateURL, outputFileName) {
            JSZipUtils.getBinaryContent(templateURL, function (error, content) {
                if (error) throw error;
                var zip = new JSZip(content);
                var doc = new Docxtemplater().loadZip(zip);
                doc.setData(data);
                doc.setOptions({
                    parser: function(tag) {
                        return {
                            'get': function(scope) {
                                var item;
                                try{
                                    var tagItems = tag.split('.');
                                    item = scope[tagItems[0]];
                                    for(var i = 1; i < tagItems.length; i++){
                                        item = item[tagItems[i]];
                                    }
                                }catch (e) {
                                    console.error();
                                    item = scope[tag]
                                }
                                if(item === undefined) item = '';
                                return item;
                            }
                        };
                    }
                });
                doc.render();
                var out = doc.getZip().generate({
                    type: 'arraybuffer',
                    mimeType: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
                });
                saveAs(new Blob(out), outputFileName);
            });
        }

    };
}(window));