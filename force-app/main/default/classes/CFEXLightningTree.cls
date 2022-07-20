public class CFEXLightningTree {
    @AuraEnabled
    public string label;
    @AuraEnabled
    public string name;
    @AuraEnabled
    public Boolean expanded;
    @AuraEnabled
    public list<CFEXLightningTree> items;

    public CFEXLightningTree(){
        items = new list<CFEXLightningTree>();
        expanded = true;
    }

    public static list<CFEXLightningTree> convertCFEX2LightningTree(List<Datum> data){
        list<CFEXLightningTree> treeItems = new list<CFEXLightningTree>();
        for(Datum d:data){
            CFEXLightningTree CF = new CFEXLightningTree();
            CF.label = d.title;
            CF.name = d.key;
            if(d.children != null && !d.children.isEmpty()){
                CF.items = convertCFEX2LightningTree(d.children);
            }
            treeItems.add(CF);
        }

        return treeItems;
    }
}
