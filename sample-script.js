/* eslint-disable no-console */

let syndicationBaseUrl = 'https://nksht1qr2i.execute-api.us-east-1.amazonaws.com/dev/article';
let syndicationAuthKey = 'test-key';
let syndicationXmlXsl = "sample-html.xsl";


document.getElementById("display-button").onclick = function() {displayArticle()};

let parseXml = function(xmlStr) {
    let xmlDoc = ( new window.DOMParser() ).parseFromString(xmlStr, "text/xml");
    return xmlDoc;
};

async function getArticleXml(articleId) {
    let sURL = syndicationBaseUrl + "/" + articleId + "/xml/";
    const options = {
        method: 'GET',
        headers: {
            'x-api-key': syndicationAuthKey
        }
    };
    let response = await fetch(sURL, options);
    if (response.ok) {
        let data = await response.text();
        return data
    } else {
        console.log("ERROR: Article XML not returned "  + response.status);
        throw new Error(response.status);
    }
}

async function getArticleXsl() {
    let response = await fetch(syndicationXmlXsl);
    if (response.ok) {
        let data = await response.text();
        return data
    } else {
        console.log("ERROR: Article XSL not returned "  + response.status);
        throw new Error(response.status);
    }
}

function tranformArticleXml(xmlDoc) {
    let xsl = getArticleXsl();
    let xsltProcessor = new XSLTProcessor();
    xsltProcessor.importStylesheet(xsl);
    let resultDocument = xsltProcessor.transformToFragment(xmlDoc, document);
    return resultDocument
}

function displayArticle() {
    let articleId = document.getElementById("article-input").value
    getArticleXml(articleId).then((data) => {
        let xml = data.replace(/<![^>]*?>/i, '');
        console.log(xml);
        let xmlDoc = parseXml(xml);
        let htmlFrag = tranformArticleXml(xmlDoc)
        document.getElementById("body-content").appendChild(htmlFrag);
        //document.getElementById("body-content").innerHTML=xml;
    }).catch(err => {
        console.log('error');
    });
}

