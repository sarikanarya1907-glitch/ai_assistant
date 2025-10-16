{literal}
<style>
#ai-chatbox {
  position: fixed;
  bottom: 20px;
  right: 20px;
  width: 320px;
  height: 420px;
  background: #fff;
  border: 1px solid #ccc;
  border-radius: 10px;
  box-shadow: 0 0 10px rgba(0,0,0,0.2);
  display: none;
  flex-direction: column;
  overflow: hidden;
  z-index: 9999;
}
#ai-header {
  background: #007bff;
  color: white;
  padding: 10px;
  text-align: center;
  font-weight: bold;
}
#ai-messages {
  flex: 1;
  padding: 10px;
  overflow-y: auto;
  font-size: 14px;
}
#ai-input {
  display: flex;
  border-top: 1px solid #ccc;
}
#ai-input input {
  flex: 1;
  padding: 8px;
  border: none;
}
#ai-input button {
  padding: 8px 12px;
  border: none;
  background: #007bff;
  color: white;
}
#ai-toggle {
  position: fixed;
  bottom: 20px;
  right: 20px;
  background: #007bff;
  color: white;
  border-radius: 50%;
  width: 60px;
  height: 60px;
  border: none;
  font-size: 20px;
  cursor: pointer;
  z-index: 9999;
}
</style>

<button id="ai-toggle">💬</button>
<div id="ai-chatbox">
  <div id="ai-header">AI Asistan</div>
  <div id="ai-messages"></div>
  <div id="ai-input">
    <input type="text" id="ai-text" placeholder="Mesajınızı yazın..." />
    <button id="ai-send">Gönder</button>
  </div>
</div>

<script>
document.getElementById('ai-toggle').onclick = function() {
  document.getElementById('ai-chatbox').style.display =
    document.getElementById('ai-chatbox').style.display === 'flex' ? 'none' : 'flex';
};

document.getElementById('ai-send').onclick = async function() {
  const input = document.getElementById('ai-text');
  const msg = input.value.trim();
  if (!msg) return;

  const messagesDiv = document.getElementById('ai-messages');
  messagesDiv.innerHTML += `<div><b>Sen:</b> ${msg}</div>`;
  input.value = '';

  const response = await fetch('/?dispatch=ai_assistant.generate_chat', {
    method: 'POST',
    headers: {'Content-Type': 'application/json'},
    body: JSON.stringify({message: msg})
  });
  const data = await response.json();
  messagesDiv.innerHTML += `<div><b>AI Asistan:</b> ${data.reply}</div>`;
  messagesDiv.scrollTop = messagesDiv.scrollHeight;
};
</script>
{/literal}
