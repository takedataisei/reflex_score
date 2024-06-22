import consumer from "./consumer"

const initializeChat = () => {
  const communityElement = document.getElementById('community-id');
  if (!communityElement) {
    console.log('Community element not found'); // デバッグ用ログ
    return;
  }

  const communityId = communityElement.getAttribute('data-community-id');
  if (!communityId) {
    console.log('Community ID not found'); // デバッグ用ログ
    return;
  }

  console.log(`Initializing chat for community_id: ${communityId}`); // デバッグ用ログ

  // サブスクリプションの重複チェック
  let alreadyConnected = false;
  for (let subscription of consumer.subscriptions.subscriptions) {
    let alreadyConnectedCommunityId = JSON.parse(subscription.identifier).community_id;
    if (alreadyConnectedCommunityId === communityId) {
      alreadyConnected = true;
      break;
    }
  }

  if (!alreadyConnected) {
    consumer.subscriptions.create({ channel: "CommunityChannel", community_id: communityId }, {
      received(data) {
        const messagesContainer = document.getElementById('messages');
        if (messagesContainer) {
          const newMessage = document.createElement('div');
          newMessage.innerHTML = data.message;
          messagesContainer.insertBefore(newMessage.firstChild, messagesContainer.firstChild);
        }
      }
    });
  }

  const messageForm = document.getElementById('new_message');
  if (messageForm) {
    if (!messageForm.dataset.listenerAdded) {
      console.log('Adding event listener to form'); // デバッグ用ログ
      messageForm.addEventListener('submit', (event) => {
        event.preventDefault();
        const messageInput = document.getElementById('message_content');

        if (!messageInput) {
          console.error("Message input not found"); // デバッグ用ログ
          return;
        }

        fetch(`/communities/${communityId}/messages`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
          },
          body: JSON.stringify({ message: { content: messageInput.value } })
        }).then(response => {
          if (response.ok) {
            messageInput.value = '';
          } else {
            response.json().then(data => {
              console.error("Message save failed:", data.error);
            });
          }
        }).catch(error => {
          console.error("Message save failed:", error);
        });
      });
      messageForm.dataset.listenerAdded = true;
    } else {
      console.log('Listener already added'); // デバッグ用ログ
    }
  } else {
    console.log('Message form not found'); // デバッグ用ログ
  }
};

document.addEventListener('turbo:load', initializeChat);
document.addEventListener('turbo:frame-load', initializeChat);
