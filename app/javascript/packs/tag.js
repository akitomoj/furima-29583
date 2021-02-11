if (location.pathname.match("items/new")){
  document.addEventListener("DOMContentLoaded", () => {
    const inputElement = document.getElementById("item-tagname");
    inputElement.addEventListener("keyup", () => {
      const keyword = document.getElementById("item-tagname").value;
      const XHR = new XMLHttpRequest();
      XHR.open("GET", `search/?keyword=${keyword}`, true);
      XHR.responseType = "json";
      XHR.send();
      XHR.onload = () => {
        
        const searchResult = document.getElementById("search-result");
        searchResult.innerHTML = "";
        if (XHR.response) {
          const tagName = XHR.response.keyword;
          tagName.forEach((item) => {
            const childElement = document.createElement("div");
            childElement.setAttribute("class", "weight-bold-text");
            childElement.setAttribute("id", item.id);
            childElement.innerHTML = item.tag_name;
            searchResult.appendChild(childElement);
            const clickElement = document.getElementById(item.id);
            clickElement.addEventListener("click", () => {
              document.getElementById("item-tagname").value = clickElement.textContent;
              clickElement.remove();
            });
          });
        };
      };
    });
  });
};