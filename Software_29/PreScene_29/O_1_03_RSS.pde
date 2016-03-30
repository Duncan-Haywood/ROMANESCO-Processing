/**
RSS || 2012 || 1.1.0
*/
class RSS extends Romanesco {
  public RSS() {
    //from the index_objects.csv
    romanescoName = "RSS" ;
    IDobj = 3 ;
    IDgroup = 1 ;
    romanescoAuthor  = "Stan Le Punk";
    romanescoVersion = "version 1.1";
    romanescoPack = "Base" ;
    romanescoRender = "classic" ;
    romanescoMode = "" ; // separate the name by a slash and write the next mode immadialtly after this one.
    romanescoSlider = "Fill hue,Fill sat,Fill bright,Fill alpha,Size X,Canvas X,Canvas Y,Canvas Z,Direction X" ;
  }
  //GLOBAL
  FeedReader flux;
  String RSSliberation, RSSlemonde;
  float Rinfo ;
  int info = 0 ; 
  String messageRSS ;
  
  
  //SETUP
  void setting() {
    startPosition(IDobj,width/10, height/2, 0) ;
    
    
    if(internet) {
      String [] fluxRSS = loadStrings(prefenrece_path+"network/RSSReference.txt") ;
      String RSS = join(fluxRSS, "") ;
      flux = new FeedReader(RSS);
    }
    
  }
  
  
  
  
  //DRAW
  void display() {
    float sizeFont = font_size_item[IDobj] ;
    textFont(font[IDobj], sizeFont + ( sizeFont *mix[IDobj]) *allBeats(IDobj) );
    // couleur du texte
    float t = alpha(fill_item[IDobj]) * abs(mix[IDobj]) ;
    if ( sound[IDobj] ) { t = alpha(fill_item[IDobj]) ; } 
    color c = color(hue(fill_item[IDobj]), saturation(fill_item[IDobj]), brightness(fill_item[IDobj]), t ) ;
    // security against the blavk bug opacity
    if (alpha(c) == 0 ) {
      noFill() ; 
      noStroke() ; 
    } else {     
      fill (c) ; 
    }
    
    //hauteur largeur, height & width
    float ratioTextBox ;
    ratioTextBox = allBeats(IDobj) *.25 ;
    if(ratioTextBox < 1 ) ratioTextBox = 1. ;
    float largeur = canvas_x_item[IDobj] *ratioTextBox ;
    float hauteur = canvas_y_item[IDobj] *ratioTextBox ;    
      
    for( int i=info; i < info + 1; i++) {
      //internet = false ;
      if (internet && fullRendering) {
        if(i<flux.entry.length) messageRSS =  (i +""+flux.entry[i]) ;  else messageRSS =("  Big Brother is watching you") ;
      } else messageRSS = ("  Big Brother is watching you") ;
      int r ;
      if ( i > 9 ) r =2 ; else if( i > 0 && i < 10 ) r =1 ; else r =0 ; 
      String hune = messageRSS.substring(r);
      //rotation / degré
      rotation(dir_x_item[IDobj], mouse[IDobj].x, mouse[IDobj].y) ;
      if(horizon[IDobj]) textAlign(CENTER) ; else textAlign(LEFT) ;
      text(hune, 0, 0, largeur, hauteur );
    }
    
    // BUTTON
    if(action[IDobj] && nTouch ) {
      Rinfo = random (1,24) ;
      info = round(Rinfo) ;
    }

  }
}
//end object one





// CLASS
////////////
//class RSS
class FeedReader {  
  SyndFeed feed;  
  String url,description,title;  
  int numEntries;  
  FeedEntry entry[];  
  
  public FeedReader(String _url) {  
    url=_url;  
    try {  
      feed=new SyndFeedInput().build(new XmlReader(new URL(url)));  
      description=feed.getDescription();  
      title=feed.getTitle();  
  
      java.util.List entrl=feed.getEntries();  
      Object [] o=entrl.toArray();  
      numEntries=o.length;  
  
      entry=new FeedEntry[numEntries];  
      for(int i=0; i< numEntries; i++) {  
        entry[i]=new FeedEntry((SyndEntryImpl)o[i]);  
      }  
    }  
    catch(Exception e) {  
      println("Exception in Feedreader: "+e.toString());  
      e.printStackTrace();  
    }  
  }  
  
}  
  
class FeedEntry {  
  Date pubdate;  
  SyndEntryImpl entry;  
  String author, contents, description, url, title;  
  public String newline = System.getProperty("line.separator");  
  
  public FeedEntry(SyndEntryImpl _entry) {  
    try {  
      entry=_entry;  
      author=entry.getAuthor();  
      Object [] o=entry.getContents().toArray();  
      if(o.length>0) contents=((SyndContentImpl)o[0]).getValue();  
      else contents="[No content.]";  
  
      description=entry.getDescription().getValue();  
      if(description.charAt(0)==  
        System.getProperty("line.separator").charAt(0))  
          description=description.substring(1);  
  
      url=entry.getLink();  
      title=entry.getTitle();  
      pubdate=entry.getPublishedDate();  
    }  
    catch(Exception e) {  
      println("Exception in FeedEntry: "+e.toString());  
      e.printStackTrace();  
    }  
  
  }  
  
  //to catch or translate the message
  public String toString() {  
    String s;
    s = title  ; 
    return s;  
  }
} 
