<?php

use Tygh\Registry;

if (!defined('BOOTSTRAP')) { die('Access denied'); }

if ($_SERVER['REQUEST_METHOD'] == 'POST' && $mode == 'generate') {
    $product_name = $_REQUEST['product_name'] ?? '';
    $description = fn_ai_assistant_generate_description($product_name);

    Tygh::$app['ajax']->assign('description', $description);
    exit;
}
