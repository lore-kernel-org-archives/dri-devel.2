Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0765CCC6B3A
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 16:39:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD31F10E05E;
	Thu, 15 Oct 2026 16:39:30 +0000 (UTC)
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FF9610E98D
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 16:39:21 +0000 (UTC)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35a4d2e39acso3684541eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792082361; x=1792687161;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7vrwp4HC01Z0kE3Wy37HFrMt6VtKQXq+YFsCUGH+2uM=;
 b=J3rauZO1a5M1DHhE1cflh+kr9gIekoEes+vqir2MwIm0+Pkbn0/ckw3l1xcMxpAbAl
 oMr90+Nkylle5CdRxPr3nPbA4tliuBBuN12XRmZatNh5m0AVZtYWKUyNWFWT9QHwdZ0K
 swn+A8FnBjp+7gYFl9knvQ+3ngCRU0gTQgSY4m7TDYclYjlyJiYR+lolSIMF+yr6Zm04
 TU5Zhyl6EJO/8DOYxiQ5Ehi6lEDe9UTXYZln5iyXiZ70dsM7b7N+tQYbafKWYbXJzGQ3
 KWpIr7WO4sSsWEMvbbKt/LhwQsjt+qESYfO5+pBXGgT/s/OiqQ/C3+z3nYMdrZbC5eFS
 PT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792082361; x=1792687161;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7vrwp4HC01Z0kE3Wy37HFrMt6VtKQXq+YFsCUGH+2uM=;
 b=pdc3eEK3cMK5WYLXXlx15oGChILPDNaQOScQ5zNuYKfsSGbdkdWOF9ch4OL/rKbQNL
 iWISWvxLJ6eslcWdmi2SZlhVsWqT/+XHvbbGSGrixRQQ4bh/tiY/Xs9glVivQ3JkYl+1
 4kooqh9Xil8LtKiBh8tgGDGE3RjYUJB+aYaKG9trkpa/wFMa5zl3ds8vePtCEMs1J/zU
 HNSpP677cbDjpbZiUxaqiMy/s3+U6jbGs1qYv/qccpj6sKCwUX+aY3idmM0sp72atDPE
 bG/N3C8wqPLgGcLz8kevVOTzuh2xwDiVDExpG2rkT9ogju0Qe31Cc9Tn/eOspkJ9fxjM
 BY6A==
X-Forwarded-Encrypted: i=1;
 AKwUvBz30GbMwm+aquRmkxvWazqcUqNRHjGAPfj52QCpIyimqKtGaixWr4EstnOXG8oTt3N27kkButzsLDY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIz3xngzyxFtBaunfZV38WgKYcvm9SX59LBin1n1onkXIGNa6Ek
 5HYC4Yv+bmAvphIN0tpQE8OiD8s6t7PyTiIaZpF2cpU7qCop+FPoCCMloQiIMJ989GeAHLIVEEf
 6m58oykMtiZT8AFul/g/aB6Pf6A==
X-Received: from dybtm1.prod.google.com ([2002:a05:7300:f0c1:b0:358:cd5e:4e5c])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:e002:b0:35d:5a2c:2321 with SMTP id
 5a478bee46e88-35d5a2c2980mr8679042eec.20.1792082358745; 
 Thu, 15 Oct 2026 09:39:18 -0700 (PDT)
Date: Thu, 15 Oct 2026 16:39:13 +0000
In-Reply-To: <20261015163915.1166043-1-almasrymina@google.com>
Mime-Version: 1.0
References: <20261015163915.1166043-1-almasrymina@google.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261015163915.1166043-3-almasrymina@google.com>
Subject: [PATCH net v4 2/4] net: devmem: detach TX bindings on
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
  binding->dev and binding->vdev, and unmap the dma_buf under
  binding->lock. No grace period is needed: the device is already
  closed, so nothing hands the DMA addresses to the hardware anymore,
  and concurrent senders only compare against binding->dev.
- When only binding->vdev (virtual device) unregisters while
  binding->dev lives, only clear binding->vdev so no new TX sends match
  the virtual device while allowing in-flight TX packets on binding->dev
  to finish DMA safely.

Fixes: bd61848900bf ("net: devmem: Implement TX path")
Fixes: 1abe839b34ae ("net: devmem: support TX over NETMEM_TX_NO_DMA devices")
Suggested-by: Stanislav Fomichev <sdf@fomichev.me>
Cc: Kaiyuan Zhang <kaiyuanz@google.com>
Cc: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: Tariq Toukan <tariqt@nvidia.com>
Cc: Kaifeng Wang <kaifengw@google.com>
Assisted-by: LLM
Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
v4:
- Detach and unmap TX bindings directly from the xarray walk, without a
  grace period or a second pass (Stanislav).

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
 net/core/devmem.c | 22 +++++++++++++++++++++-
 net/core/devmem.h |  3 ++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 20d95b24d5951..d33a092c6e4bb 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -207,11 +207,30 @@ net_devmem_dev_unregister_rx(struct net_devmem_dmabuf_binding *binding,
 			    NET_DEVMEM_BINDING_LIVE);
 }
 
+static bool
+net_devmem_dev_unregister_tx(struct net_devmem_dmabuf_binding *binding,
+			     unsigned long xa_idx, struct net_device *dev)
+{
+	if (binding->direction != DMA_TO_DEVICE)
+		return false;
+
+	if (READ_ONCE(binding->vdev) == dev)
+		WRITE_ONCE(binding->vdev, NULL);
+
+	if (READ_ONCE(binding->dev) != dev)
+		return false;
+
+	__xa_clear_mark(&net_devmem_dmabuf_bindings, xa_idx,
+			NET_DEVMEM_BINDING_LIVE);
+	return true;
+}
+
 static void net_devmem_dev_detach(struct net_devmem_dmabuf_binding *binding,
 				  struct net_device *dev)
 {
 	mutex_lock(&binding->lock);
 	WRITE_ONCE(binding->dev, NULL);
+	WRITE_ONCE(binding->vdev, NULL);
 	if (!netif_is_queue_leasee(dev))
 		net_devmem_dmabuf_binding_unmap(binding);
 	mutex_unlock(&binding->lock);
@@ -229,7 +248,8 @@ void net_devmem_dev_unregister(struct net_device *dev)
 
 	xa_lock(&net_devmem_dmabuf_bindings);
 	xa_for_each(&net_devmem_dmabuf_bindings, xa_idx, binding) {
-		if (!net_devmem_dev_unregister_rx(binding, xa_idx, dev))
+		if (!net_devmem_dev_unregister_rx(binding, xa_idx, dev) &&
+		    !net_devmem_dev_unregister_tx(binding, xa_idx, dev))
 			continue;
 
 		xa_unlock(&net_devmem_dmabuf_bindings);
diff --git a/net/core/devmem.h b/net/core/devmem.h
index a834e0f698c7e..ce069e1736416 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -39,7 +39,8 @@ struct net_devmem_dmabuf_binding {
 	 * The binding undos itself and unmaps the underlying dmabuf once all
 	 * those refs are dropped and the binding is no longer desired or in
 	 * use. RX bindings are unmapped earlier, once they are no longer
-	 * installed on any queue.
+	 * installed on any queue. TX bindings are unmapped earlier if their
+	 * device is unregistered.
 	 *
 	 * net_devmem_get_net_iov() on dmabuf net_iovs will increment this
 	 * reference, making sure that the binding remains alive until all the
-- 
2.56.0.176.g3575e65682-goog

