Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8D9CC6B39
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 16:39:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBB9B112405;
	Thu, 15 Oct 2026 16:39:24 +0000 (UTC)
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB8151123EA
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 16:39:18 +0000 (UTC)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-147be78cd56so21501202c88.1
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792082358; x=1792687158;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ng4zxpw+boV8S1ELPw0fhKdUN4Zin1qbWJGc8Tx1FlY=;
 b=Fk+/ELWibun5G7CINmCznhwDKvP7g4PlfANEe9k7vFsf1pfR+Ki/mbxmR05WrphJEQ
 IKEmYNgBYDpQcNHodogYDkMLVgTEoh2r5xumyibQFWDNegIqr0dsGTFhUvS43xMDpx7d
 4OsuXieb2O503GJx79a9O4Y3QUv56vYVuBAspxxsFKv8izwhq3gt3pXLkpMaeNfo+86N
 xN7/ac4h4//jA1CipwvYULgO/7syVFP9qyl97rPQxUNTLnIKSoDNuqi3HmLcWvWSykaQ
 N99PppHmqM6m/H2UuXwN0mDNvhCv7v8/FdiJynXVmBgDufKJIeIZXgISKhn81yPpXJtL
 4KQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792082358; x=1792687158;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ng4zxpw+boV8S1ELPw0fhKdUN4Zin1qbWJGc8Tx1FlY=;
 b=aJdPZKnni8SMdOoS0JLF+QKjPO/W1BtD7s/aDabAIAwVPK039WZa5woSX/Yjz1IS6S
 cPUZUsD3gg8xuKcBL0aE7DZ8zMqaD7FHuL7U8fksOdDyMO1b+NWGUqIQNQMOKgrsxaZf
 IVSECd/cTDdzhiprUbChTA7q9jm4JeMRYJdLW/n4wZEJsE38N+KYveWSiAZ3lRv6MEhp
 xWqLAXZkkgCiP8/zORdLXYoBmldkx9lfXPVKRPQ5irUdNwpC3ZQ0Ci3J2Fy4Bt9fhqOq
 KK3YjFAazvhmEle/W9s3z5fEWhosldzY2bRVs1EoLeCoMX/mihdFNv6tXCiuTTZ+7pES
 Ya9Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwjZ9IEBvpcRktJ9e1pDoqQoXkewyVZm0geu2w14Al/2/kevYElFMSN4G0F+xlsRE6kHnUNthjwOKc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIidkpmadbRALPJ7Uxu3wW5nEAKWcxzJGYEkq2jq+Zg8Q9lCFWX
 7hmdVyvWuR42r6i3YqlxstkXqWegkuln/5qmlrAvzW/jvnFSOTChJoVgs84/aDuSEkql7GYbpN6
 FAwewYcvTLVZ5N3fPFx7wducRZA==
X-Received: from dlbrx16.prod.google.com ([2002:a05:7022:1710:b0:14e:353:712f])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:2094:20b0:163:a197:722d with SMTP id
 a92af1059eb24-18069ea6621mr3696080c88.4.1792082357554; 
 Thu, 15 Oct 2026 09:39:17 -0700 (PDT)
Date: Thu, 15 Oct 2026 16:39:12 +0000
In-Reply-To: <20261015163915.1166043-1-almasrymina@google.com>
Mime-Version: 1.0
References: <20261015163915.1166043-1-almasrymina@google.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261015163915.1166043-2-almasrymina@google.com>
Subject: [PATCH net v4 1/4] net: devmem: unmap dma_buf synchronously on queue
 uninstall
From: Mina Almasry <almasrymina@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Mina Almasry <almasrymina@google.com>, 
 Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, 
 Stanislav Fomichev <sdf@fomichev.me>, Taehee Yoo <ap420073@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, 
 Kaiyuan Zhang <kaiyuanz@google.com>, Bobby Eshleman <bobbyeshleman@meta.com>,
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
 "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>,
 Daniel Borkmann <daniel@iogearbox.net>, 
 Tariq Toukan <tariqt@nvidia.com>, Kaifeng Wang <kaifengw@google.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

When a bound net_device is unregistered while userspace still holds a
netlink or TCP socket reference on a devmem binding,
mp_dmabuf_devmem_uninstall() clears binding->dev to NULL so
netdev_nl_sock_priv_destroy() will not touch the unregistered
net_device, but leaves the dma_buf attachment mapped until
__net_devmem_dmabuf_binding_free() runs later on socket close.

Because dma_buf_attach() does not take a reference on dma_dev, device
removal frees dma_dev while the attachment is still mapped. Closing the
netlink socket afterwards triggers a slab use-after-free in
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
net_devmem_unbind_dmabuf(). Make netif_mp_close_rxq() return an error
when a queue failed to restart and may still be using the binding. Such
a binding stays mapped and keeps binding->dev. Record a queue in
bound_rxqs before opening it, so that a failed bind never leaves a
queue using the binding without unbind knowing about it.

Keep bindings in net_devmem_dmabuf_bindings until they are freed and
hide unbound ones from TX lookups with an xarray mark, so that on
NETDEV_UNREGISTER the remaining unbound RX bindings of the device can be
found, detached and unmapped, unless the device is a virtual device
leasing queues, for the same reason as above. The walk runs under the
device's instance lock and is skipped when the device only moves to
another netns. Like netdev_nl_sock_priv_destroy(),
__net_devmem_dmabuf_binding_free() takes the instance lock of
binding->dev before unmapping and erasing the binding, so a binding the
walk finds under the xarray lock stays alive while it is detached.

Fixes: f8350a4358fc ("net: page_pool: add a mp hook to unregister_netdevice*")
Fixes: 0afc44d8cdf6 ("net: devmem: fix kernel panic when netlink socket close after module unload")
Suggested-by: Stanislav Fomichev <sdf@fomichev.me>
Cc: Taehee Yoo <ap420073@gmail.com>
Cc: Tariq Toukan <tariqt@nvidia.com>
Cc: Kaifeng Wang <kaifengw@google.com>
Assisted-by: LLM
Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
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
 net/core/devmem.c                       | 137 +++++++++++++++++++-----
 net/core/devmem.h                       |  10 +-
 net/core/netdev-genl.c                  |   1 +
 net/core/netdev_rx_queue.c              |  26 +++--
 5 files changed, 140 insertions(+), 38 deletions(-)

diff --git a/include/net/page_pool/memory_provider.h b/include/net/page_pool/memory_provider.h
index 255ce4cfd9755..a999a9b28bc70 100644
--- a/include/net/page_pool/memory_provider.h
+++ b/include/net/page_pool/memory_provider.h
@@ -26,8 +26,8 @@ void net_mp_niov_clear_page_pool(struct net_iov *niov);
 int netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 		      const struct pp_memory_provider_params *p,
 		      struct netlink_ext_ack *extack);
-void netif_mp_close_rxq(struct net_device *dev, unsigned int rxq_idx,
-			const struct pp_memory_provider_params *old_p);
+int netif_mp_close_rxq(struct net_device *dev, unsigned int rxq_idx,
+		       const struct pp_memory_provider_params *old_p);
 
 /**
   * net_mp_netmem_place_in_cache() - give a netmem to a page pool
diff --git a/net/core/devmem.c b/net/core/devmem.c
index f4d60654ce7fd..20d95b24d5951 100644
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
@@ -20,6 +21,7 @@
 #include <net/tcp.h>
 #include <trace/events/page_pool.h>
 
+#include "dev.h"
 #include "devmem.h"
 #include "mp_dmabuf_devmem.h"
 #include "page_pool_priv.h"
@@ -27,6 +29,7 @@
 /* Device memory support */
 
 static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);
+#define NET_DEVMEM_BINDING_LIVE XA_MARK_1
 
 static const struct memory_provider_ops dmabuf_devmem_ops;
 
@@ -58,9 +61,26 @@ static void net_devmem_dmabuf_binding_release(struct percpu_ref *ref)
 	schedule_work(&binding->unbind_w);
 }
 
+static void
+net_devmem_dmabuf_binding_unmap(struct net_devmem_dmabuf_binding *binding)
+{
+	lockdep_assert_held(&binding->lock);
+
+	if (!binding->sgt)
+		return;
+
+	dma_buf_unmap_attachment_unlocked(binding->attachment, binding->sgt,
+					  binding->direction);
+	dma_buf_detach(binding->dmabuf, binding->attachment);
+	binding->sgt = NULL;
+	binding->attachment = NULL;
+}
+
 void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 {
 	struct net_devmem_dmabuf_binding *binding = container_of(wq, typeof(*binding), unbind_w);
+	netdevice_tracker dev_tracker;
+	struct net_device *dev;
 
 	size_t size, avail;
 
@@ -74,9 +94,23 @@ void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 		  size, avail))
 		gen_pool_destroy(binding->chunk_pool);
 
-	dma_buf_unmap_attachment_unlocked(binding->attachment, binding->sgt,
-					  binding->direction);
-	dma_buf_detach(binding->dmabuf, binding->attachment);
+	mutex_lock(&binding->lock);
+	dev = binding->dev;
+	if (dev)
+		netdev_hold(dev, &dev_tracker, GFP_KERNEL);
+	mutex_unlock(&binding->lock);
+
+	if (dev)
+		netdev_lock(dev);
+	mutex_lock(&binding->lock);
+	net_devmem_dmabuf_binding_unmap(binding);
+	mutex_unlock(&binding->lock);
+	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
+	if (dev) {
+		netdev_unlock(dev);
+		netdev_put(dev, &dev_tracker);
+	}
+
 	dma_buf_put(binding->dmabuf);
 	xa_destroy(&binding->bound_rxqs);
 	percpu_ref_exit(&binding->ref);
@@ -128,11 +162,13 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
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
 
@@ -147,12 +183,62 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 
 		rxq_idx = get_netdev_rx_queue_index(rxq);
 
-		netif_mp_close_rxq(binding->dev, rxq_idx, &mp_params);
+		if (netif_mp_close_rxq(binding->dev, rxq_idx, &mp_params))
+			busy = true;
+	}
+
+	if (binding->direction == DMA_FROM_DEVICE && binding->dev && !busy) {
+		mutex_lock(&binding->lock);
+		WRITE_ONCE(binding->dev, NULL);
+		net_devmem_dmabuf_binding_unmap(binding);
+		mutex_unlock(&binding->lock);
 	}
 
 	percpu_ref_kill(&binding->ref);
 }
 
+static bool
+net_devmem_dev_unregister_rx(struct net_devmem_dmabuf_binding *binding,
+			     unsigned long xa_idx, struct net_device *dev)
+{
+	return binding->direction == DMA_FROM_DEVICE &&
+	       READ_ONCE(binding->dev) == dev &&
+	       !xa_get_mark(&net_devmem_dmabuf_bindings, xa_idx,
+			    NET_DEVMEM_BINDING_LIVE);
+}
+
+static void net_devmem_dev_detach(struct net_devmem_dmabuf_binding *binding,
+				  struct net_device *dev)
+{
+	mutex_lock(&binding->lock);
+	WRITE_ONCE(binding->dev, NULL);
+	if (!netif_is_queue_leasee(dev))
+		net_devmem_dmabuf_binding_unmap(binding);
+	mutex_unlock(&binding->lock);
+}
+
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
+		if (!net_devmem_dev_unregister_rx(binding, xa_idx, dev))
+			continue;
+
+		xa_unlock(&net_devmem_dmabuf_bindings);
+		net_devmem_dev_detach(binding, dev);
+		xa_lock(&net_devmem_dmabuf_bindings);
+	}
+	xa_unlock(&net_devmem_dmabuf_bindings);
+}
+
 int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 				    struct net_devmem_dmabuf_binding *binding,
 				    struct netlink_ext_ack *extack)
@@ -168,20 +254,16 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
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
 
@@ -331,6 +413,8 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 			      GFP_KERNEL);
 	if (err < 0)
 		goto err_free_chunks;
+	xa_set_mark(&net_devmem_dmabuf_bindings, binding->id,
+		    NET_DEVMEM_BINDING_LIVE);
 
 	list_add(&binding->list, &priv->bindings);
 
@@ -359,9 +443,11 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
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
@@ -529,16 +615,19 @@ static void mp_dmabuf_devmem_uninstall(void *mp_priv,
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
+			mutex_lock(&binding->lock);
+			ASSERT_EXCLUSIVE_WRITER(binding->dev);
+			WRITE_ONCE(binding->dev, NULL);
+			if (!rxq->lease)
+				net_devmem_dmabuf_binding_unmap(binding);
+			mutex_unlock(&binding->lock);
 		}
+		break;
 	}
 }
 
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 4a293a7d1149c..a834e0f698c7e 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -27,7 +27,7 @@ struct net_devmem_dmabuf_binding {
 	 */
 	void *vdev;
 	struct gen_pool *chunk_pool;
-	/* Protect dev */
+	/* Protect dev, attachment and sgt */
 	struct mutex lock;
 
 	/* The user holds a ref (via the netlink API) for as long as they want
@@ -38,7 +38,8 @@ struct net_devmem_dmabuf_binding {
 	 *
 	 * The binding undos itself and unmaps the underlying dmabuf once all
 	 * those refs are dropped and the binding is no longer desired or in
-	 * use.
+	 * use. RX bindings are unmapped earlier, once they are no longer
+	 * installed on any queue.
 	 *
 	 * net_devmem_get_net_iov() on dmabuf net_iovs will increment this
 	 * reference, making sure that the binding remains alive until all the
@@ -100,6 +101,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 		       struct netlink_ext_ack *extack);
 struct net_devmem_dmabuf_binding *net_devmem_lookup_dmabuf(u32 id);
 void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding);
+void net_devmem_dev_unregister(struct net_device *dev);
 int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 				    struct net_devmem_dmabuf_binding *binding,
 				    struct netlink_ext_ack *extack);
@@ -196,6 +198,10 @@ net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
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
index 33b9f4eb9565a..b04e22937b789 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -1488,6 +1488,7 @@ static int netdev_genl_netdevice_event(struct notifier_block *nb,
 		break;
 	case NETDEV_UNREGISTER:
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
2.56.0.176.g3575e65682-goog

