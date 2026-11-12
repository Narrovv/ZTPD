package app.lucene;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.pl.PolishAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.document.StringField;
import org.apache.lucene.document.TextField;
import org.apache.lucene.index.DirectoryReader;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriterConfig;
import org.apache.lucene.queryparser.classic.ParseException;
import org.apache.lucene.queryparser.classic.QueryParser;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.index.StoredFields;
import org.apache.lucene.search.TopDocs;
import org.apache.lucene.store.ByteBuffersDirectory;
import org.apache.lucene.store.Directory;

import java.io.IOException;

public class Main {

    private static Document buildDoc(String title, String isbn) {
        Document doc = new Document();
        doc.add(new TextField("title", title, Field.Store.YES));
        doc.add(new StringField("isbn", isbn, Field.Store.YES));
        return doc;
    }

    public static void main(String[] args) throws IOException, ParseException {
        // Punkt 11: Analizator dla języka polskiego
        Analyzer analyzer = new PolishAnalyzer();

        // Punkt 5b: Katalog w pamięci RAM
        Directory directory = new ByteBuffersDirectory();

        // Punkt 5c: IndexWriter
        IndexWriterConfig config = new IndexWriterConfig(analyzer);
        IndexWriter w = new IndexWriter(directory, config);

        // Punkt 11: Polskie tytuły
        w.addDocument(buildDoc("Lucyna w akcji", "9780062316097"));
        w.addDocument(buildDoc("Akcje rosną i spadają", "9780385545955"));
        w.addDocument(buildDoc("Bo ponieważ", "9781501168007"));
        w.addDocument(buildDoc("Naturalnie urodzeni mordercy", "9780316485616"));
        w.addDocument(buildDoc("Druhna rodzi", "9780593301760"));
        w.addDocument(buildDoc("Urodzić się na nowo", "9780679777489"));

        w.close();

        // Punkt 12: Historia zapytań (pozostawione w kodzie w komentarzach)
        // 12a) Dokumenty, których pole isbn ma wartość "9780062316097"
        // String querystr = "isbn:9780062316097";

        // 12b) Dokumenty, których tytuł zawiera słowo "urodzić"
        // String querystr = "urodzić";

        // 12c) Dokumenty, których tytuł zawiera słowo "rodzić"
        // String querystr = "rodzić";

        // 12d) Dokumenty, których tytuł zawiera słowo rozpoczynające się od "ro"
        // String querystr = "ro*";

        // 12e) Dokumenty, których tytuł zawiera słowo "ponieważ"
        // String querystr = "ponieważ";

        // 12f) Dokumenty, których tytuł zawiera słowa "Lucyna" i "akcja"
        // String querystr = "Lucyna AND akcja";

        // 12g) Dokumenty, których tytuł zawiera słowo "akcja", a nie zawiera słowa "Lucyna"
        // String querystr = "akcja NOT Lucyna";

        // 12h) Dokumenty, których tytuł zawiera słowa "naturalnie" i "morderca" w odległości max 2 słów od siebie
        // String querystr = "\"naturalnie morderca\"~2";

        // 12i) Dokumenty, których tytuł zawiera słowa "naturalnie" i "morderca" w odległości max 1 słów od siebie
        // String querystr = "\"naturalnie morderca\"~1";

        // 12j) Dokumenty, których tytuł zawiera słowa "naturalnie" i "morderca" w odległości max 0 słów od siebie
        // String querystr = "\"naturalnie morderca\"~0";

        // 12k) Dokumenty, których tytuł zawiera słowo "naturalne"
        // String querystr = "naturalne";

        // 12l) Dokumenty, których tytuł zawiera słowo "naturalne" z tolerancją na literówki
        String querystr = "naturalne~";

        Query q = new QueryParser("title", analyzer).parse(querystr);

        int maxHits = 10;
        IndexReader reader = DirectoryReader.open(directory);
        IndexSearcher searcher = new IndexSearcher(reader);
        TopDocs docs = searcher.search(q, maxHits);
        ScoreDoc[] hits = docs.scoreDocs;

        System.out.println("Query: " + querystr);
        System.out.println("Found " + hits.length + " matching docs.");
        StoredFields storedFields = searcher.storedFields();
        for (int i = 0; i < hits.length; ++i) {
            int docId = hits[i].doc;
            Document d = storedFields.document(docId);
            System.out.println((i + 1) + ". " + d.get("isbn") + "\t" + d.get("title"));
        }

        reader.close();
    }
}