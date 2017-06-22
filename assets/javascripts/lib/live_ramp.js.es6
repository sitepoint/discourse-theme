import ls from 'discourse/plugins/discourse-theme/lib/local_storage';

const ONE_DAY = 1000 * 60 * 60 * 24;

export const sendPwned = () => {
  const liveRampSent = ls.get("liveRampSent");
  if (!!liveRampSent && Date.now() - ONE_DAY < liveRampSent) return;

  const hashed_emails = JSON.parse(ls.get('liveRamp') || "{}");
  Object.keys(hashed_emails).map((key) => {
    const { md5, sha1, sha256} = hashed_emails[key];

    let scr = document.createElement("script");
    scr.setAttribute("async", "true");
    scr.type = "text/javascript";
    scr.src = `https:\/\/pippio.com/api/sync?pid=8549&it=4&iv=${md5}&it=4&iv=${sha1}&it=4&iv=${sha256}`;
    (document.head || document.getElementsByTagName('head')[0]).appendChild(scr);

    let iframe = document.createElement("iframe");
    iframe.setAttribute("src", `https://p-eu.acxiom-online.com/pixel/ema?eml=${sha1}&ha=sha1&sc=01&pid=6724&t=672401&ot=iframe&dnt=0`);
    iframe.setAttribute("name", "_acxiom");
    iframe.setAttribute("width", 0);
    iframe.setAttribute("height", 0);
    iframe.setAttribute("frameborder", 0);
    document.body.appendChild(iframe);


    ls.set("liveRampSent", Date.now());
  });
}
