<?php

use Tygh\Registry;

if (!defined('BOOTSTRAP')) { die('Access denied'); }

function fn_ai_assistant_generate_description($product_name)
{
    $api_key = Registry::get('addons.ai_assistant.api_key');
    if (empty($api_key)) {
        return 'OpenAI API anahtarı eklenti ayarlarından girilmemiş.';
    }

    $prompt = "Bu ürüne etkileyici, SEO uyumlu bir Türkçe açıklama yaz: " . $product_name;

    $ch = curl_init('https://api.openai.com/v1/chat/completions');
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        'Content-Type: application/json',
        'Authorization: Bearer ' . $api_key,
    ]);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode([
        'model' => 'gpt-4o-mini',
        'messages' => [
            ['role' => 'system', 'content' => 'Sen profesyonel bir e-ticaret metin yazarı asistanısın.'],
            ['role' => 'user', 'content' => $prompt],
        ],
    ]));

    $response = curl_exec($ch);
    curl_close($ch);

    $result = json_decode($response, true);
    return $result['choices'][0]['message']['content'] ?? 'API yanıtı alınamadı.';
}
