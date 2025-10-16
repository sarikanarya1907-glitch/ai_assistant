<div class="control-group">
    <label class="control-label">AI ile Açıklama Oluştur:</label>
    <div class="controls">
        <button class="btn btn-primary" id="generate-ai">Oluştur</button>
    </div>
</div>

<script>
$(function() {
    $('#generate-ai').on('click', function(e) {
        e.preventDefault();
        var productName = $('input[name="product_data[product]"]').val();
        $.ceAjax('request', fn_url('ai_assistant.generate'), {
            method: 'post',
            data: { product_name: productName },
            callback: function(data) {
                $('textarea[name="product_data[full_description]"]').val(data.description);
            }
        });
    });
});
</script>
