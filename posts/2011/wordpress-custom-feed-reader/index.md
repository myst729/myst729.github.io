---
layout: post
title: 利用 WordPress 自定义抓取外部 Feed 源
tag: [coding, red]
date: 2011-11-30
---

前阵子高博问我，有没有办法在 WordPress 搭建的站点上显示站外多个来源的 feed 内容。其实这个需求，利用 WordPress 自带的 feed 抓取工具就可以实现。

在 WordPress 安装路径的 wp-includes 目录下，有一个 feed.php 文件，这就是 WordPress 自带的 feed 抓取工具，只要引入这个文件，并且设定适当的参数，就可以从其他站点的 feed 源抓取内容，并按自己的需要来格式化输出和调整样式。废话也不多说了，直接上代码吧。

```php
<?php
/*
Template Name: Custom Feed Reader
*/

include_once(ABSPATH . WPINC . '/feed.php');
$feed = fetch_feed('https://example.com/feed/');
$limit = $feed->get_item_quantity(10);
$items = $feed->get_items(0, $limit);

echo '<h1><a href="' . $feed->get_link() . '">' . $feed->get_title() . '</a></h1>';

if ($limit == 0) {
  echo '<div>The feed is either empty or unavailable.</div>';
} else {
  echo '<ul>';
  foreach ($items as $item) {
    $li = '<li>';
    $li .= '<h3>';
    $li .= '<a href="' . $item->get_permalink() . '">' . $item->get_title() . '</a>';
    $li .= '</h3>';
    $li .= '<p>' . mb_substr($item->get_description(), 0, 200) . ' <span>[...]</span></p>';
    $li .= '</li>';
    echo $li;
  }
  echo '</ul>';
}
?>
```

简单讲解一下。首先，创建一个名为 Custom Feed Reader 的 page 模板。（也可以创建成其他的主题文件，或者作为函数写进 functions.php 方便调用，甚至编写成插件，本文只提供一个抓取和显示 feed 的思路。）接着引入 feed.php 文件，指定要抓取的源。如果来源的条目很多，可以选择只输出部分内容。通过 `get_link()` 和 `get_title()` 可以输出 feed 源的链接和标题。经过循环处理，每一个条目都可以通过 `get_permalink()`、`get_title()` 和 `get_description()` 分别得到条目对应的文章地址、标题和内容。如果想让输出的效果更好看，就要靠 CSS 来搞定了。
