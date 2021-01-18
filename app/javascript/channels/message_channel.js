import consumer from "./consumer"

consumer.subscriptions.create("MessageChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const html = `<p>${data.content.text}</p>`;
    const messages = document.getElementById('messages');
    const newMessage = document.getElementById('message_text');
    messages.insertAdjacentHTML('afterbegin', html);
    newMessage.value='';
// 13行目で受け取ったdataのなかにあるcontentのなかのtextを表示します。
// contentはコントローラーのcreateアクション内で指定したcontentからきています。contentは@messageと同義なので、textを取り出せるというわけです。
  }
});
