Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F417660A2608
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 08:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Y44o3B7j
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63127112689;
	Fri, 30 Oct 2026 08:36:03 +0000 (UTC)
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 172B510E875
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 08:35:42 +0000 (UTC)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36a3451ea93so921151eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 01:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793349341; x=1793954141;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FTMZO+rBcCXxH4RPbO9KLFiR9MgGXAqzy2TOrnCZA+k=;
 b=Y44o3B7jJt+rBT8f/txk8Ebm/U2mqO2mYavfFT23r9vtXqM6glQCS7NUEUACF/Um2D
 3PDZaOJGWQhSW1m6vzIs4CyoZAQSjAEwBLwVp5MMz7z+pjv9oxZLeoIc9i5D/VLllSip
 XkjwnjbjtXcvN9Em56V+vipIGIWwDiuAsmJp9ycYKsFn/ClW7IERGoy5cvcIiNqiRCH4
 4m3uSb8eM6IfSCZMz8fein2YT7OGwvb+s9Luure2MAhlryMViCbFwd6Ca7how2qwfEhA
 Ivf4kpSy8N6VFRetxa4rII/9rbxKUAWtx//6ILBM2tR3475Kno3KmmzeHoqesjuL+Txx
 mJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793349341; x=1793954141;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FTMZO+rBcCXxH4RPbO9KLFiR9MgGXAqzy2TOrnCZA+k=;
 b=qWFZeT2bJy5KgjCOXH06YQWXv5FZ6Ugy9fpSBLNZqqnatUBIkLuVahmxqiAyXvm726
 X7pAuSqT7ou6H/VI6Ui57bZqhWOv6blGKQW2yvhu8CviTb+gToWQtL/sUd/xhCf7TMOO
 Th7Q+om7iU1CEXYHosIBeQmK90F1H7Hleve0ri3MJLYY6HlmIYYwesj5m4/QVKlDNDR5
 NVRcyxRbd8zYUHR6Tivi2sIHrZ0TxlF1caLDMwVTkNMzEWOCXrtL6y7FWTfpCECBlrBS
 J+AFgq4NCjUGETegp+W17IIeh/TfCs0JFqM8m+eqUDBneL1ZSIKxotB+MuHookO5Wtdz
 NcmQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxX8zNGsjsaHR7LKs/TVZuyaVjKa/b0X7FvxNmgXebiDbHCXadJEIE5cN+dxDwdlFSvvroWQgGlZHY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJg3ptQ/xlgWE/T/V6TybHXmyCbnhGRfsOs3mqE4lnTrFXOw2JK
 84dNhm4xAEOF00uAWp+WK/3A15uumdidLAN6HT1klq6TTwIXmJtMmR1JZADEYMzi9QlbGDvG+aN
 R7ODvCQ/7B3asmkmZ0J3aj0JKtg==
X-Received: from dybnl1.prod.google.com ([2002:a05:7300:cf81:b0:36a:1c45:2f79])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:1602:b0:369:f9da:a70f with SMTP id
 5a478bee46e88-36a423af719mr2291912eec.17.1793349340856; 
 Fri, 30 Oct 2026 01:35:40 -0700 (PDT)
Date: Fri, 30 Oct 2026 08:35:35 +0000
In-Reply-To: <20261030083539.777877-1-almasrymina@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261030083539.777877-1-almasrymina@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261030083539.777877-2-almasrymina@google.com>
Subject: [PATCH net v5 1/4] net: devmem: unmap dma_buf synchronously on queue
 uninstall
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Paolo Abeni <pabeni@redhat.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
 Kaiyuan Zhang <kaiyuanz@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@meta.com>,
 Pavel Begunkov <asml.silence@gmail.com>, 
 David Wei <dw@davidwei.uk>, Taehee Yoo <ap420073@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Stanislav Fomichev <sdf.kernel@gmail.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Daniel Borkmann <daniel@iogearbox.net>,
 Nikolay Aleksandrov <razor@blackwall.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Kaifeng Wang <kaifengw@google.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When a bound net_device is unregistered while userspace still holds a
netlink or TCP socket reference on a devmem binding,
mp_dmabuf_devmem_uninstall() clears binding->dev to NULL so
netdev_nl_sock_priv_destroy() will not touch the unregistered
net_device, but leaves the dma_buf attachment mapped until
__net_devmem_dmabuf_binding_free() runs later on socket close.

Because dma_buf_dynamic_attach() does not take a reference on dma_dev,
device removal frees dma_dev while the attachment is still mapped.
Closing the netlink socket afterwards triggers a slab use-after-free in
dma_unmap_sg_attrs():

  BUG: KASAN: slab-use-after-free in dma_unmap_sg_attrs+0x76/0x2b0
  Read of size 8 at addr ffff88810fae64b0 by task kworker/3:1/53
  Workqueue: events __net_devmem_dmabuf_binding_free
  Call Trace:
   dma_unmap_sg_attrs+0x76/0x2b0
   unmap_udmabuf+0x8e/0x100
   dma_buf_unmap_attachment+0x145/0x330
   dma_buf_unmap_attachment_unlocked+0x96/0x130
   __net_devmem_dmabuf_binding_free+0x156/0x2e0
  Freed by task 9:
   kfree+0x1b8/0x550
   nsim_bus_dev_release+0xe/0x60
   device_release+0xcf/0x250

Add net_devmem_dmabuf_binding_unmap() serialized under binding->lock
and null out binding->sgt and binding->attachment after unmapping so
unmapping is idempotent across queue uninstall and deferred binding
destruction. Call it synchronously when the last bound RX queue is
uninstalled in mp_dmabuf_devmem_uninstall(), except when a leased
queue is unleased: the physical device is still registered and, if
restarting its queue failed, may still be using the binding.

The same use-after-free happens when the netlink socket is closed
before the device is removed but RX tokens keep the binding alive. Once
its queues are closed, nothing DMAs into an RX binding anymore and the
outstanding tokens only need the net_iovs, so unmap it in
net_devmem_unbind_dmabuf(), and reject RX devmem net_iovs in
validate_xmit_unreadable_skb(). Make netif_mp_close_rxq() return an
error when a queue failed to restart and may still be using the binding.
Such a binding stays mapped and keeps binding->dev. Record a queue in
bound_rxqs before opening it, so that a failed bind never leaves a
queue using the binding without unbind knowing about it.

Keep bindings in net_devmem_dmabuf_bindings until they are freed and
hide unbound ones from TX lookups with an xarray mark, so that on
NETDEV_UNREGISTER the remaining unbound RX bindings of the device can be
found, detached and unmapped, unless the device is a virtual device
leasing queues, for the same reason as above. The walk runs under the
device's instance lock and is skipped when the device only moves to
another netns. Factor out net_devmem_lock_dev() and
net_devmem_unlock_dev() and use them in both
netdev_nl_sock_priv_destroy() and __net_devmem_dmabuf_binding_free(), so
a binding the walk finds under the xarray lock stays alive while it is
detached.

This issue was found via LLM-assisted code review (Sashiko) and
reproduced and verified with the new nl_netdev.py selftest on netdevsim
(not tested on real hardware).

Fixes: f8350a4358fc ("net: page_pool: add a mp hook to unregister_netdevice*")
Fixes: 0afc44d8cdf6 ("net: devmem: fix kernel panic when netlink socket close after module unload")
Suggested-by: Stanislav Fomichev <sdf@fomichev.me>
Cc: Taehee Yoo <ap420073@gmail.com>
Cc: Tariq Toukan <tariqt@nvidia.com>
Cc: Kaifeng Wang <kaifengw@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
---
v5:
- Inline net_devmem_dev_unregister_rx() into net_devmem_dev_unregister()
  (Stanislav).
- Factor out net_devmem_lock_dev() and net_devmem_unlock_dev() and clear
  binding->dev after unmapping and re-acquiring the xarray lock so
  __net_devmem_dmabuf_binding_free() cannot free the binding while
  net_devmem_dev_unregister() is still accessing it (Sashiko).
- Reject RX devmem net_iovs in validate_xmit_unreadable_skb() so an RX
  binding is not unmapped while its net_iovs are in flight on TX
  (Sashiko).

v4:
- Unmap RX bindings in net_devmem_unbind_dmabuf() once their queues are
  closed, and make netif_mp_close_rxq() report queue restart failures.
  The NETDEV_UNREGISTER walk only handles bindings whose queue failed
  to restart (Stanislav).
- Drop net_devmem_lock. Walk the bindings under the xarray lock, and
  take the instance lock of binding->dev in the final free (Stanislav).
- Record a queue in bound_rxqs before opening it, so unbind knows about
  every queue using the binding (Sashiko).

v3:
- Run the NETDEV_UNREGISTER walk under the netdev instance lock so it
  cannot race with net_devmem_unbind_dmabuf() (Sashiko).
- Skip the walk when the device only moves to another netns (Sashiko).

v2:
- Don't unmap when a leased queue is unleased (Sashiko).
- Unmap unbound RX bindings on NETDEV_UNREGISTER; keep bindings in
  net_devmem_dmabuf_bindings until freed, hidden from TX lookups by
  NET_DEVMEM_BINDING_LIVE (Sashiko).
- Update the binding->lock and binding->ref comments (Sashiko).
---
 include/net/page_pool/memory_provider.h |   4 +-
 net/core/dev.c                          |   4 +-
 net/core/devmem.c                       | 173 ++++++++++++++++++++----
 net/core/devmem.h                       |  31 ++++-
 net/core/netdev-genl.c                  |  16 +--
 net/core/netdev_rx_queue.c              |  26 ++--
 6 files changed, 198 insertions(+), 56 deletions(-)

diff --git a/include/net/page_pool/memory_provider.h b/include/net/page_pool/memory_provider.h
index 137cfc50833ac..bceb5f7740e2f 100644
--- a/include/net/page_pool/memory_provider.h
+++ b/include/net/page_pool/memory_provider.h
@@ -36,8 +36,8 @@ void net_mp_niov_clear_page_pool(struct net_iov *niov);
 int netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 		      const struct pp_memory_provider_params *p,
 		      struct netlink_ext_ack *extack);
-void netif_mp_close_rxq(struct net_device *dev, unsigned int rxq_idx,
-			const struct pp_memory_provider_params *old_p);
+int netif_mp_close_rxq(struct net_device *dev, unsigned int rxq_idx,
+		       const struct pp_memory_provider_params *old_p);
 
 /**
   * net_mp_netmem_place_in_cache() - give a netmem to a page pool
diff --git a/net/core/dev.c b/net/core/dev.c
index 3ac700d37e596..1aece2fe2429f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4181,10 +4181,12 @@ static struct sk_buff *validate_xmit_unreadable_skb(struct sk_buff *skb,
 
 	shinfo = skb_shinfo(skb);
 
+	/* All net_iovs in an unreadable skb share the same binding. */
 	if (shinfo->nr_frags > 0) {
 		niov = netmem_to_net_iov(skb_frag_netmem(&shinfo->frags[0]));
 		if (net_is_devmem_iov(niov) &&
-		    READ_ONCE(net_devmem_iov_binding(niov)->dev) != dev)
+		    (net_devmem_iov_binding(niov)->direction != DMA_TO_DEVICE ||
+		     READ_ONCE(net_devmem_iov_binding(niov)->dev) != dev))
 			goto out_free;
 	}
 
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 32fafbfa1359e..4610de805ef08 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -12,6 +12,7 @@
 #include <linux/mm.h>
 #include <linux/netdevice.h>
 #include <linux/types.h>
+#include <net/netdev_lock.h>
 #include <net/netdev_queues.h>
 #include <net/netdev_rx_queue.h>
 #include <net/page_pool/helpers.h>
@@ -19,12 +20,14 @@
 #include <net/sock.h>
 #include <net/tcp.h>
 
+#include "dev.h"
 #include "devmem.h"
 #include "mp_dmabuf_devmem.h"
 
 /* Device memory support */
 
 static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);
+#define NET_DEVMEM_BINDING_LIVE XA_MARK_1
 
 static const struct memory_provider_ops dmabuf_devmem_ops;
 
@@ -64,9 +67,89 @@ static void net_devmem_dmabuf_binding_release(struct percpu_ref *ref)
 	schedule_work(&binding->unbind_w);
 }
 
+static void
+net_devmem_dmabuf_binding_unmap(struct net_devmem_dmabuf_binding *binding)
+{
+	mutex_lock(&binding->lock);
+	if (binding->sgt) {
+		dma_resv_lock(binding->dmabuf->resv, NULL);
+		dma_buf_unmap_attachment(binding->attachment, binding->sgt,
+					 binding->direction);
+		dma_buf_unpin(binding->attachment);
+		dma_resv_unlock(binding->dmabuf->resv);
+		dma_buf_detach(binding->dmabuf, binding->attachment);
+		binding->sgt = NULL;
+		binding->attachment = NULL;
+	}
+	mutex_unlock(&binding->lock);
+}
+
+/**
+ * net_devmem_lock_dev() - lock a binding's net_device if still alive
+ * @binding:		devmem binding whose @dev pointer to lock
+ * @dev_tracker:	reftracker for the held net_device reference
+ *
+ * Safely dereference @binding->dev, acquire netdev_lock() on the device, and
+ * verify that @binding->dev has not been cleared while waiting for the lock.
+ *
+ * Invariant: @binding->dev is set once at bind time and is only ever cleared to
+ * NULL while holding netdev_lock(dev) (in mp_dmabuf_devmem_uninstall(),
+ * net_devmem_unbind_dmabuf(), or net_devmem_dev_unregister() during
+ * NETDEV_UNREGISTER before synchronize_net() and netdev_run_todo() free the
+ * net_device).
+ *
+ * Taking rcu_read_lock() guarantees that a non-NULL @dev read from
+ * @binding->dev has not yet completed unregister_netdevice_many_notify()
+ * (which waits for an RCU grace period via synchronize_net() after
+ * NETDEV_UNREGISTER before freeing the net_device), so netdev_hold() can
+ * safely acquire a reference before sleeping on netdev_lock(). Once
+ * netdev_lock(dev) is held, re-checking that READ_ONCE(binding->dev) == dev
+ * guarantees that the device has not yet been detached from @binding and
+ * cannot finish unregistering until net_devmem_unlock_dev().
+ *
+ * Return: The locked and held net_device if @binding->dev is still non-NULL,
+ * or NULL if already cleared.
+ */
+struct net_device *
+net_devmem_lock_dev(struct net_devmem_dmabuf_binding *binding,
+		    netdevice_tracker *dev_tracker)
+{
+	struct net_device *dev;
+
+	rcu_read_lock();
+	dev = READ_ONCE(binding->dev);
+	if (!dev) {
+		rcu_read_unlock();
+		return NULL;
+	}
+	netdev_hold(dev, dev_tracker, GFP_ATOMIC);
+	rcu_read_unlock();
+
+	netdev_lock(dev);
+	if (READ_ONCE(binding->dev) != dev) {
+		netdev_unlock(dev);
+		netdev_put(dev, dev_tracker);
+		return NULL;
+	}
+
+	return dev;
+}
+
+void net_devmem_unlock_dev(struct net_device *dev,
+			   netdevice_tracker *dev_tracker)
+{
+	if (!dev)
+		return;
+
+	netdev_unlock(dev);
+	netdev_put(dev, dev_tracker);
+}
+
 void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 {
 	struct net_devmem_dmabuf_binding *binding = container_of(wq, typeof(*binding), unbind_w);
+	netdevice_tracker dev_tracker;
+	struct net_device *dev = NULL;
 
 	if (binding->freelist)
 		WARN(binding->free_count != binding->area.num_niovs,
@@ -74,12 +157,12 @@ void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 		     binding->area.num_niovs, binding->free_count);
 
 	kvfree(binding->area.niovs);
-	dma_resv_lock(binding->dmabuf->resv, NULL);
-	dma_buf_unmap_attachment(binding->attachment, binding->sgt,
-				 binding->direction);
-	dma_buf_unpin(binding->attachment);
-	dma_resv_unlock(binding->dmabuf->resv);
-	dma_buf_detach(binding->dmabuf, binding->attachment);
+	if (binding->direction == DMA_FROM_DEVICE)
+		dev = net_devmem_lock_dev(binding, &dev_tracker);
+	net_devmem_dmabuf_binding_unmap(binding);
+	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
+	net_devmem_unlock_dev(dev, &dev_tracker);
+
 	dma_buf_put(binding->dmabuf);
 	xa_destroy(&binding->bound_rxqs);
 	percpu_ref_exit(&binding->ref);
@@ -124,11 +207,13 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 	struct netdev_rx_queue *rxq;
 	unsigned long xa_idx;
 	unsigned int rxq_idx;
+	bool busy = false;
 
-	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
+	xa_clear_mark(&net_devmem_dmabuf_bindings, binding->id,
+		      NET_DEVMEM_BINDING_LIVE);
 
 	/* Ensure no tx net_devmem_lookup_dmabuf() are in flight after the
-	 * erase.
+	 * mark is cleared.
 	 */
 	synchronize_net();
 
@@ -143,12 +228,45 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 
 		rxq_idx = get_netdev_rx_queue_index(rxq);
 
-		netif_mp_close_rxq(binding->dev, rxq_idx, &mp_params);
+		if (netif_mp_close_rxq(binding->dev, rxq_idx, &mp_params))
+			busy = true;
+	}
+
+	if (binding->direction == DMA_FROM_DEVICE && binding->dev && !busy) {
+		net_devmem_dmabuf_binding_unmap(binding);
+		WRITE_ONCE(binding->dev, NULL);
 	}
 
 	percpu_ref_kill(&binding->ref);
 }
 
+void net_devmem_dev_unregister(struct net_device *dev)
+{
+	struct net_devmem_dmabuf_binding *binding;
+	unsigned long xa_idx;
+
+	netdev_assert_locked(dev);
+
+	if (dev->reg_state != NETREG_UNREGISTERING)
+		return;
+
+	xa_lock(&net_devmem_dmabuf_bindings);
+	xa_for_each(&net_devmem_dmabuf_bindings, xa_idx, binding) {
+		if (binding->direction != DMA_FROM_DEVICE ||
+		    READ_ONCE(binding->dev) != dev ||
+		    xa_get_mark(&net_devmem_dmabuf_bindings, xa_idx,
+				NET_DEVMEM_BINDING_LIVE))
+			continue;
+
+		xa_unlock(&net_devmem_dmabuf_bindings);
+		if (!netif_is_queue_leasee(dev))
+			net_devmem_dmabuf_binding_unmap(binding);
+		xa_lock(&net_devmem_dmabuf_bindings);
+		WRITE_ONCE(binding->dev, NULL);
+	}
+	xa_unlock(&net_devmem_dmabuf_bindings);
+}
+
 int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 				    struct net_devmem_dmabuf_binding *binding,
 				    struct netlink_ext_ack *extack)
@@ -164,20 +282,16 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 	if (binding->niov_shift != PAGE_SHIFT)
 		mp_params.rx_page_size = 1U << binding->niov_shift;
 
-	err = netif_mp_open_rxq(dev, rxq_idx, &mp_params, extack);
-	if (err)
-		return err;
-
 	rxq = __netif_get_rx_queue(dev, rxq_idx);
 	err = xa_alloc(&binding->bound_rxqs, &xa_idx, rxq, xa_limit_32b,
 		       GFP_KERNEL);
 	if (err)
-		goto err_close_rxq;
+		return err;
 
-	return 0;
+	err = netif_mp_open_rxq(dev, rxq_idx, &mp_params, extack);
+	if (err)
+		xa_erase(&binding->bound_rxqs, xa_idx);
 
-err_close_rxq:
-	netif_mp_close_rxq(dev, rxq_idx, &mp_params);
 	return err;
 }
 
@@ -345,6 +459,8 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 			      GFP_KERNEL);
 	if (err < 0)
 		goto err_free_niovs;
+	xa_set_mark(&net_devmem_dmabuf_bindings, binding->id,
+		    NET_DEVMEM_BINDING_LIVE);
 
 	list_add(&binding->list, &priv->bindings);
 
@@ -375,9 +491,11 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 struct net_devmem_dmabuf_binding *net_devmem_lookup_dmabuf(u32 id)
 {
 	struct net_devmem_dmabuf_binding *binding;
+	unsigned long xa_idx = id;
 
 	rcu_read_lock();
-	binding = xa_load(&net_devmem_dmabuf_bindings, id);
+	binding = xa_find(&net_devmem_dmabuf_bindings, &xa_idx, id,
+			  NET_DEVMEM_BINDING_LIVE);
 	if (binding) {
 		if (!net_devmem_dmabuf_binding_get(binding))
 			binding = NULL;
@@ -551,16 +669,17 @@ static void mp_dmabuf_devmem_uninstall(void *mp_priv,
 	unsigned long xa_idx;
 
 	xa_for_each(&binding->bound_rxqs, xa_idx, bound_rxq) {
-		if (bound_rxq == rxq) {
-			xa_erase(&binding->bound_rxqs, xa_idx);
-			if (xa_empty(&binding->bound_rxqs)) {
-				mutex_lock(&binding->lock);
-				ASSERT_EXCLUSIVE_WRITER(binding->dev);
-				WRITE_ONCE(binding->dev, NULL);
-				mutex_unlock(&binding->lock);
-			}
-			break;
+		if (bound_rxq != rxq)
+			continue;
+
+		xa_erase(&binding->bound_rxqs, xa_idx);
+		if (xa_empty(&binding->bound_rxqs)) {
+			if (!rxq->lease)
+				net_devmem_dmabuf_binding_unmap(binding);
+			ASSERT_EXCLUSIVE_WRITER(binding->dev);
+			WRITE_ONCE(binding->dev, NULL);
 		}
+		break;
 	}
 }
 
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 8fa089776610a..a9c38ed6eaa44 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -21,7 +21,9 @@ struct net_devmem_dmabuf_binding {
 	struct dma_buf *dmabuf;
 	struct dma_buf_attachment *attachment;
 	struct sg_table *sgt;
-	/* Physical NIC that does the actual DMA for this binding. */
+	/* Physical NIC that does the actual DMA for this binding. Set at bind
+	 * time and cleared to NULL under netdev_lock(dev).
+	 */
 	struct net_device *dev;
 	/* Opaque cookie identifying the virtual device (e.g. netkit) the user
 	 * called bind-tx on. Used only for pointer comparison. Never
@@ -30,7 +32,7 @@ struct net_devmem_dmabuf_binding {
 	void *vdev;
 	possible_net_t net;
 	kuid_t uid;
-	/* Protect dev */
+	/* Serialize net_devmem_dmabuf_binding_unmap() on attachment and sgt */
 	struct mutex lock;
 
 	/* The user holds a ref (via the netlink API) for as long as they want
@@ -41,7 +43,8 @@ struct net_devmem_dmabuf_binding {
 	 *
 	 * The binding undos itself and unmaps the underlying dmabuf once all
 	 * those refs are dropped and the binding is no longer desired or in
-	 * use.
+	 * use. RX bindings are unmapped earlier when their queues are closed or
+	 * uninstalled, unless a leased or busy queue may still use the binding.
 	 *
 	 * net_devmem_net_iov_inc_ref() on dmabuf net_iovs will increment this
 	 * reference, making sure that the binding remains alive until all the
@@ -94,7 +97,13 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 		       const struct sock *nl_sk,
 		       struct netlink_ext_ack *extack);
 struct net_devmem_dmabuf_binding *net_devmem_lookup_dmabuf(u32 id);
+struct net_device *
+net_devmem_lock_dev(struct net_devmem_dmabuf_binding *binding,
+		    netdevice_tracker *dev_tracker);
+void net_devmem_unlock_dev(struct net_device *dev,
+			   netdevice_tracker *dev_tracker);
 void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding);
+void net_devmem_dev_unregister(struct net_device *dev);
 int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 				    struct net_devmem_dmabuf_binding *binding,
 				    struct netlink_ext_ack *extack);
@@ -177,11 +186,27 @@ static inline struct net_devmem_dmabuf_binding *net_devmem_lookup_dmabuf(u32 id)
 	return NULL;
 }
 
+static inline struct net_device *
+net_devmem_lock_dev(struct net_devmem_dmabuf_binding *binding,
+		    netdevice_tracker *dev_tracker)
+{
+	return NULL;
+}
+
+static inline void
+net_devmem_unlock_dev(struct net_device *dev, netdevice_tracker *dev_tracker)
+{
+}
+
 static inline void
 net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 {
 }
 
+static inline void net_devmem_dev_unregister(struct net_device *dev)
+{
+}
+
 static inline int
 net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 				struct net_devmem_dmabuf_binding *binding,
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 384fdc5ae5145..9c5bf17b04e57 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -1476,20 +1476,9 @@ void netdev_nl_sock_priv_destroy(struct netdev_nl_sock *priv)
 
 	mutex_lock(&priv->lock);
 	list_for_each_entry_safe(binding, temp, &priv->bindings, list) {
-		mutex_lock(&binding->lock);
-		dev = binding->dev;
-		if (!dev) {
-			mutex_unlock(&binding->lock);
-			net_devmem_unbind_dmabuf(binding);
-			continue;
-		}
-		netdev_hold(dev, &dev_tracker, GFP_KERNEL);
-		mutex_unlock(&binding->lock);
-
-		netdev_lock(dev);
+		dev = net_devmem_lock_dev(binding, &dev_tracker);
 		net_devmem_unbind_dmabuf(binding);
-		netdev_unlock(dev);
-		netdev_put(dev, &dev_tracker);
+		net_devmem_unlock_dev(dev, &dev_tracker);
 	}
 	mutex_unlock(&priv->lock);
 }
@@ -1513,6 +1502,7 @@ static int netdev_genl_netdevice_event(struct notifier_block *nb,
 		if (READ_ONCE(netdev->reg_state) == NETREG_UNREGISTERED)
 			break;
 		netdev_lock(netdev);
+		net_devmem_dev_unregister(netdev);
 		netdev_genl_dev_notify(netdev, NETDEV_CMD_DEV_DEL_NTF);
 		netdev_unlock(netdev);
 		break;
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index 00a7011eb4d57..a7261fedd5e76 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -275,8 +275,8 @@ int netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 	return ret;
 }
 
-static void __netif_mp_close_rxq(struct net_device *dev, unsigned int rxq_idx,
-				 const struct pp_memory_provider_params *old_p)
+static int __netif_mp_close_rxq(struct net_device *dev, unsigned int rxq_idx,
+				const struct pp_memory_provider_params *old_p)
 {
 	struct netdev_queue_config qcfg[2];
 	struct netdev_rx_queue *rxq;
@@ -289,35 +289,41 @@ static void __netif_mp_close_rxq(struct net_device *dev, unsigned int rxq_idx,
 	 */
 	if (dev->reg_state > NETREG_REGISTERED &&
 	    !rxq->mp_params.mp_ops)
-		return;
+		return 0;
 
 	if (WARN_ON_ONCE(rxq->mp_params.mp_ops != old_p->mp_ops ||
 			 rxq->mp_params.mp_priv != old_p->mp_priv))
-		return;
+		return -EINVAL;
 
 	netdev_queue_config(dev, rxq_idx, &qcfg[0]);
 	memset(&rxq->mp_params, 0, sizeof(rxq->mp_params));
 	netdev_queue_config(dev, rxq_idx, &qcfg[1]);
 
 	err = netdev_rx_queue_reconfig(dev, rxq_idx, &qcfg[0], &qcfg[1]);
-	WARN_ON(err && err != -ENETDOWN);
+	if (err == -ENETDOWN)
+		return 0;
+	WARN_ON(err);
+	return err;
 }
 
-void netif_mp_close_rxq(struct net_device *dev, unsigned int rxq_idx,
-			const struct pp_memory_provider_params *old_p)
+int netif_mp_close_rxq(struct net_device *dev, unsigned int rxq_idx,
+		       const struct pp_memory_provider_params *old_p)
 {
+	int ret;
+
 	if (WARN_ON_ONCE(rxq_idx >= dev->real_num_rx_queues))
-		return;
+		return -EINVAL;
 	if (!netif_rxq_is_leased(dev, rxq_idx))
 		return __netif_mp_close_rxq(dev, rxq_idx, old_p);
 
 	if (!__netif_get_rx_queue_lease(&dev, &rxq_idx, NETIF_VIRT_TO_PHYS)) {
 		WARN_ON_ONCE(1);
-		return;
+		return -EINVAL;
 	}
 	netdev_lock(dev);
-	__netif_mp_close_rxq(dev, rxq_idx, old_p);
+	ret = __netif_mp_close_rxq(dev, rxq_idx, old_p);
 	netdev_unlock(dev);
+	return ret;
 }
 
 void __netif_mp_uninstall_rxq(struct netdev_rx_queue *rxq,
-- 
2.56.0.385.gac671c819a-goog

