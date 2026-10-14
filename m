Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA407CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:18:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 384B210F6A3;
	Wed, 14 Oct 2026 16:18:14 +0000 (UTC)
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5756B10EA8F
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 16:18:01 +0000 (UTC)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3510d0baf63so3644842eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 09:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791994681; x=1792599481;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ivOUg8vGPcnE+LE9XwDoyhijZ8m1lm4RK26pVgGfAJ8=;
 b=XLHgu5COExIM+5ik3y5Qu0Ygnm2i9MyQhlx54mEYZZJJPFq11NSi1Bv0/qn9uCJ5Vd
 NwtZxONWn/PYELNk0gCNoPgNOfpzxrA9iQlnWdBQZGOw8v+dhWmobmfHrCEXAEl0g+zq
 RasIi3zoOfqkJ6J+3tEeBcsNNZ2Oq3bvkZjC6nnXhds8eKGG5R1UE/ArnxMnh53R8LGT
 hOwA9x3SvnRW7HNvlykXeBCzsALMtHVMsgnO0IAaJPyHCnbEq/uaOb7Gzw3id4O9CiTp
 J0HGRsH6EwN4oSl2fY5Y66ntFFdiTRYkcgjXvU7UwvWFlS13uUepXyfq4C1Pjciee4yH
 v9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791994681; x=1792599481;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ivOUg8vGPcnE+LE9XwDoyhijZ8m1lm4RK26pVgGfAJ8=;
 b=mOtTMcg1t6QwKZ1GwR2Iz33prN8xap/R3JIjnXUwOyaPOC4X0/3QyW/0IKuEsfvFYt
 sh5o0VwSmHJgm+QJPSWhoWvLBw2MWO/02SCEhktW4jXC9i9rXcP3YMhEHUXGmNPWySRn
 7vy1juM4WwqPD0mWxY6/mdT6JyUgYqjPwTm+KLVh7PLbmusdgmbQc5YzEoIUIxeE9eAx
 WD2TenPHXMusleQqY7f2aqtyYIqhMBkAFOETWGcJ0CS96Vemkl2XMfxoBhi92VPKzIsS
 RuuS3vRSz2C8/6wGPSz5ooLsFpxBiOf5dAe2JHm9JOOvPE5gXwlJ4AAJlQC8PaAGyy72
 L1cA==
X-Forwarded-Encrypted: i=1;
 AKwUvByar1e74G9FuM9U9CP1o1WuG8MxDqvl3MXe3fxlnGfbZTZCWrg/ZBjKTxkSXNbmAJyUkQHdFvzWIw8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKHyFPkT+J97saOiB3pecdG115jqgwGWYcWKKbs+DQ/xR25L+3Q
 sxzPBJd8+m1ts4SzT8afNEtO4sHmg5EmzfQ65c7sno0I+WioIgmA/YOfaEUGjThScmvTd40b6j0
 J20CFC6cEIhy2dai8sK9bdqmPfQ==
X-Received: from dycmv5.prod.google.com ([2002:a05:693c:2805:b0:351:5787:a37a])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:f8c:b0:35c:ea0d:a9a6 with SMTP id
 5a478bee46e88-35cea0daeb8mr4982706eec.32.1791994677848; 
 Wed, 14 Oct 2026 09:17:57 -0700 (PDT)
Date: Wed, 14 Oct 2026 16:17:52 +0000
In-Reply-To: <20261014161754.3782346-1-almasrymina@google.com>
Mime-Version: 1.0
References: <20261014161754.3782346-1-almasrymina@google.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261014161754.3782346-3-almasrymina@google.com>
Subject: [PATCH net v3 2/4] net: devmem: detach TX bindings on
 NETDEV_UNREGISTER
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
 Eric Dumazet <edumazet@kernel.org>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
 "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
 Daniel Borkmann <daniel@iogearbox.net>, 
 Nikolay Aleksandrov <razor@blackwall.org>, Tariq Toukan <tariqt@nvidia.com>, 
 Kaifeng Wang <kaifengw@google.com>, Dragos Tatulea <dtatulea@nvidia.com>
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

TX devmem bindings (NETDEV_CMD_BIND_TX) have no bound RX queues, so
mp_dmabuf_devmem_uninstall() never runs when binding->dev or
binding->vdev unregisters. As a result, binding->dev and binding->vdev
dangle pointing to freed struct net_device memory, and the dma_buf
remains attached and mapped after device removal.

Closing the netlink socket after netdev unregistration dereferences the
freed struct net_device in netdev_nl_sock_priv_destroy():

  BUG: unable to handle page fault for address: ffff88824ca9b000
  Oops: Oops: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:netdev_nl_sock_priv_destroy+0xbd/0x1e0
  Call Trace:
   genl_release+0xf5/0x190
   netlink_release+0xd01/0x18d0
   __sock_release+0xb0/0x270
   sock_close+0x18/0x20

Extend net_devmem_dev_unregister() to TX bindings, including ones
whose netlink socket is already closed but which TCP retransmits keep
alive:
- When binding->dev (the physical DMA-capable device) unregisters,
  clear the binding's NET_DEVMEM_BINDING_LIVE mark and both
  binding->dev and binding->vdev. Then wait for in-flight RCU/TX readers
  with a single synchronize_net() and unmap the detached bindings'
  dma_bufs under binding->lock.
- When only binding->vdev (virtual device) unregisters while
  binding->dev lives, only clear binding->vdev so no new TX sends match
  the virtual device while allowing in-flight TX packets on binding->dev
  to finish DMA safely.

Fixes: bd61848900bf ("net: devmem: Implement TX path")
Fixes: 1abe839b34ae ("net: devmem: support TX over NETMEM_TX_NO_DMA devices")
Cc: Kaiyuan Zhang <kaiyuanz@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: Tariq Toukan <tariqt@nvidia.com>
Cc: Kaifeng Wang <kaifengw@google.com>
Assisted-by: LLM
Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
v3:
- Detach all matching TX bindings first, then call synchronize_net()
  once before unmapping them, instead of once per binding. Don't wait
  for a grace period when only binding->vdev is cleared, since vdev is
  never dereferenced (Sashiko).
- Don't detach TX bindings when the device only moves to another netns
  (Sashiko).

v2:
- Build on the net_devmem_dev_unregister() walk from the previous patch,
  so unbound TX bindings are also detached (Sashiko). Clear the
  binding's LIVE mark instead of erasing its ID.
- The walk holds net_devmem_lock, which the final free also takes
  before erasing the binding, instead of using RCU and
  percpu_ref_tryget(), so it no longer takes a binding reference
  (Stanislav).
---
 net/core/devmem.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 93cc2815d935a..dd07203076808 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -192,9 +192,55 @@ net_devmem_dev_unregister_rx(struct net_devmem_dmabuf_binding *binding,
 	mutex_unlock(&binding->lock);
 }
 
+static bool
+net_devmem_dev_unregister_tx(struct net_devmem_dmabuf_binding *binding,
+			     unsigned long xa_idx, struct net_device *dev)
+{
+	if (READ_ONCE(binding->dev) == dev) {
+		xa_clear_mark(&net_devmem_dmabuf_bindings, xa_idx,
+			      NET_DEVMEM_BINDING_LIVE);
+
+		mutex_lock(&binding->lock);
+		WRITE_ONCE(binding->dev, NULL);
+		WRITE_ONCE(binding->vdev, NULL);
+		mutex_unlock(&binding->lock);
+		return true;
+	}
+
+	if (READ_ONCE(binding->vdev) == dev) {
+		mutex_lock(&binding->lock);
+		WRITE_ONCE(binding->vdev, NULL);
+		mutex_unlock(&binding->lock);
+	}
+
+	return false;
+}
+
+static void net_devmem_unmap_detached_tx(void)
+{
+	struct net_devmem_dmabuf_binding *binding;
+	unsigned long xa_idx;
+
+	/* Ensure no tx net_devmem_lookup_dmabuf() or
+	 * validate_xmit_unreadable_skb() are in flight after detach.
+	 */
+	synchronize_net();
+
+	xa_for_each(&net_devmem_dmabuf_bindings, xa_idx, binding) {
+		if (binding->direction != DMA_TO_DEVICE ||
+		    READ_ONCE(binding->dev))
+			continue;
+
+		mutex_lock(&binding->lock);
+		net_devmem_dmabuf_binding_unmap(binding);
+		mutex_unlock(&binding->lock);
+	}
+}
+
 void net_devmem_dev_unregister(struct net_device *dev)
 {
 	struct net_devmem_dmabuf_binding *binding;
+	bool tx_detached = false;
 	unsigned long xa_idx;
 
 	if (dev->reg_state != NETREG_UNREGISTERING)
@@ -204,7 +250,12 @@ void net_devmem_dev_unregister(struct net_device *dev)
 	xa_for_each(&net_devmem_dmabuf_bindings, xa_idx, binding) {
 		if (binding->direction == DMA_FROM_DEVICE)
 			net_devmem_dev_unregister_rx(binding, xa_idx, dev);
+		else if (net_devmem_dev_unregister_tx(binding, xa_idx, dev))
+			tx_detached = true;
 	}
+
+	if (tx_detached)
+		net_devmem_unmap_detached_tx();
 	mutex_unlock(&net_devmem_lock);
 }
 
-- 
2.56.0.176.g3575e65682-goog

