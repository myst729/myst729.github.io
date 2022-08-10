---
layout: post
title: 编写一个浏览器书签应用
tag: [coding, red]
date: 2012-08-03
---

这也不是什么新鲜玩意了，不过可能还是有些同学不知道。那么先来了解一下什么是书签应用 ([bookmarklet](https://en.wikipedia.org/wiki/Bookmarklet))。下面是一个使用了 `javascript` 协议的超链接：

```html
<a href="javascript:void function(){alert(document.title)}()">Click Me</a>
```

注意它的 `href` 属性并不是我们常见的 HTTP/HTTPS 协议。这是 JavaScript 语言的发明者 [Brendan Eich](https://en.wikipedia.org/wiki/Brendan_Eich) 最早在 [Netscape Navigator](https://en.wikipedia.org/wiki/Netscape_Navigator) 中引入的。点击这类超链接的时候将会执行一段 JavaScript 脚本。它可以像普通超链接一样加入收藏夹，这一点尤其有用，这使得我们编写的脚本可以不再受限于某个特定的页面。通过点击收藏夹中的书签，脚本可以在任意页面中执行。`void` 关键字的作用在于强制函数返回 `undefined`，这可以避免函数执行后的返回值对当前页面产生意外的修改。它的另一个作用是将后面的匿名函数声明转换成表达式以便进行求值，这是执行匿名函数常见的几种方法之一。而将代码包裹于匿名函数中，则是为了不产生全局变量。由于整个脚本是一个 HTML 标签的属性值，需要包裹在双引号中，因此脚本必须写成一行，并且脚本内不能够再出现双引号，否则，你懂的……

现在来试着点一下这个 <a href="javascript:void function(){alert(document.title)}()">Click Me</a> ，看到了什么？把它拖进书签栏，再到别的页面点击这个书签，看看会弹出什么内容？

接下来我们来看一个改变页面背景色的 JavaScript 小应用。

[演示一](demos/demo-1.html)

这里我用了 `span` 而不是 `a` 标签。这没有什么关系，最终我们都会把它写成一个 `a` 标签，现在我们需要的只是那段 JavaScript 代码。点击后将弹出一个可关闭的修改页面背景色的面板。（这个应用是我随手写的，没有考虑浏览器兼容的问题，如果你打算写一个跨浏览器的应用，还是应该处理好这一点。）好了，我们要做的事情就是把这个小应用做成一个书签应用，以便在任意页面中使用它。

根据前面的介绍，我们要做的第一件事，就是把代码写成“一行流”。注意我对代码做了一些调整，省去了一些字符。对一个 bookmarklet 来说，字符数可是很珍贵的（后面会告诉你为什么）。

[演示二](demos/demo-2.html)

接下来就要把这段一行流代码放在一个 `a` 标签的 `href` 属性里，在匿名函数中执行并使用 `void` 关键字强制返回 `undefined`。可是问题来了，原先的代码中同时出现了单引号和双引号，怎么办？回想一下，平时我们写 JavaScript 代码时，同时要用到单引号和双引号的情况，最常见的是什么？对了，用 <code>innerHTML</code> 写入 HTML 代码，这里我们遇到的也是这种情况。再来想一下 HTML 规范中对标签属性的规定，如果属性值没有包含空格，是可以不用双引号包裹的，比如下面两种写法，在规范中都是允许的。

```html
<span class="someclass">text</span>
<span class=someclass>text</span>
```

那…… 中间有空格的怎么办？

```html
<p style="padding:0 5px">text</p>
```

答案是…… 换一种写法！

```html
<p style=padding-left:5px;padding-right:5px>text</p>
```

好！来看看完成的结果吧。把下面示例三中的超链接存成书签，在浏览别的页面的时候点击它试试。

[演示三](demos/demo-3.html)

---

## 附录：一些废话

为什么说字符数对一个 bookmarklet 来说很珍贵？因为杯具的 IE6 只支持字符数不超过 508 的书签！幸好它已经快死了，而 IE7 以后的版本以及其他现代浏览器，这个限制都在 2000 以上。当然了，这对于编写复杂的书签应用来说还是比较紧张的。但我们还可以向文档内写入 `script` 标签，就像常见的动态脚本加载那样。这样理论上就可以插入非常非常……非常多的代码。最后，不管是你自己编写应用，还是使用别人发布的应用，都应该谨慎一些，因为书签应用也有潜在的风险—— **XSS 攻击能做的事，它都能做**！
