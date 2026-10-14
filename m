Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3348CC6B1D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:18:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 321F310E9DC;
	Wed, 14 Oct 2026 16:18:06 +0000 (UTC)
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05D1D10EA6F
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 16:18:00 +0000 (UTC)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35a4d2e39acso4348369eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 09:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791994679; x=1792599479;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=01xy5PseRVpPPje1JnCly3s3YIplU78ERdCkYH+3Kds=;
 b=gshwqccktfuYjcp6uRVdrluQvhABpMQloyhMnAAFZjQ/dEM51NyQ1334bc3t/jNKxs
 1qF9M+D72uzYhN9mzkLi1fHj4i755TBtrk0mxeSu3/QyKFYWumaemB06c3kwSihU38kb
 JIf/iUI5eUIyH6VnBILrnibhPHXeXNO401HZBn7HnPl15l+SijyPITPDe/7QbsI2UooD
 cklNsT3faP0oweqmsWnEApkj2Sprw3bVpYrksPRJM7d6RNaJZkj8hdWxI9WO2j4O6ogF
 gzbtopmJNrAOX7Em2vuAsAtkHvBaYYTFcMi4PbPk2YetIvpTJ+uzxcBoZ+WZ3a5A2cMB
 XYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791994679; x=1792599479;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=01xy5PseRVpPPje1JnCly3s3YIplU78ERdCkYH+3Kds=;
 b=YyasTHfpRdaBm0K5IJMMIeEokJeeGynZqeCQUZuiZS7Gz66emK5WeMyXTsx15b3Flo
 ARUJsBWX7x/oYkY3kjuotF+3L6TBit7ebvAO6ZWPjq+R+vmJMFXJtfu64wow1oOpPG1T
 FQDS3rGdnnyiZx/TwwYqhvWmkZRPc1dNj70YpXl87Uruu6i9Hul9GUu5XeeF7XdO0ya+
 N3wue5ZgtNtoL31rC31O98XhB5wz594/uZKVkTc4DCEHeswaIkXI5JuQfZWaQazytAiO
 esk0AHHzHGhfBaIqo1CiaTgsKhv4YbDxmGVOUIffNL/fZJxpJO56oB8wbqZI1Y7bFJSv
 z4qA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz+bqpkC5BCnp6OKFTUCY5l+p35RRvM8JroYbqiXdPtiCgCwjW9xoNTy3HJup+mB7qW5sWGBGv+P3g=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIgOJyCKWeID5uEN7ac2myqVK0r032Lbsl7lr/u7UxKZB/9axlp
 t8tFvNQ7+Hiv7o++GvCHTFDB2PCWZSGed5d0198wxEKlBa9BDFDODNeja61uEl4TUydB11fF1QG
 MYn3k5lKlV5Q+oXw5jV7L2LH/zg==
X-Received: from dlcip5.prod.google.com ([2002:a05:7023:c085:b0:16b:e65c:ee1b])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:4541:10b0:144:ed03:8972 with SMTP id
 a92af1059eb24-16a5dee12c8mr21630544c88.16.1791994679033; 
 Wed, 14 Oct 2026 09:17:59 -0700 (PDT)
Date: Wed, 14 Oct 2026 16:17:53 +0000
In-Reply-To: <20261014161754.3782346-1-almasrymina@google.com>
Mime-Version: 1.0
References: <20261014161754.3782346-1-almasrymina@google.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261014161754.3782346-4-almasrymina@google.com>
Subject: [PATCH net v3 3/4] netdevsim: support devmem RX and TX bindings
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

Set a 64-bit DMA mask on nsim_bus_dev, enable NETMEM_TX_DMA on the
netdevsim net_device, and configure page_pool instances with
PP_FLAG_ALLOW_UNREADABLE_NETMEM and queue_idx, plus PP_FLAG_DMA_MAP |
PP_FLAG_DMA_SYNC_DEV when CONFIG_HAS_DMA is set, so devmem bind-rx and
bind-tx netlink operations can be tested against netdevsim in software
selftests.

The pp_hold debugfs file allocates pages from the queue 0 page pool, so
refuse it when that pool is backed by a memory provider, and take the
netdev instance lock there so a concurrent bind-rx cannot swap the pool
in between. The software PSP path checksums the payload when the peer
does not decapsulate, so drop unreadable skbs there.

Cc: Tariq Toukan <tariqt@nvidia.com>
Cc: Kaifeng Wang <kaifengw@google.com>
Assisted-by: LLM
Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
v3:
- Only request page pool DMA mapping when CONFIG_HAS_DMA is set
  (Sashiko).
- Refuse pp_hold on a page pool backed by a memory provider, under the
  netdev instance lock (Sashiko).
- Drop unreadable skbs in the software PSP path when it would have to
  checksum the payload (Sashiko).
---
 drivers/net/netdevsim/bus.c    |  1 +
 drivers/net/netdevsim/netdev.c | 27 +++++++++++++++++++++------
 drivers/net/netdevsim/psp.c    |  5 +++++
 3 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
index 5c55c308487b4..f87f5e037b6fb 100644
--- a/drivers/net/netdevsim/bus.c
+++ b/drivers/net/netdevsim/bus.c
@@ -462,6 +462,7 @@ nsim_bus_dev_new(unsigned int id, unsigned int port_count, unsigned int num_queu
 	nsim_bus_dev->port_count = port_count;
 	nsim_bus_dev->num_queues = num_queues;
 	nsim_bus_dev->initial_net = current->nsproxy->net_ns;
+	dma_coerce_mask_and_coherent(&nsim_bus_dev->dev, DMA_BIT_MASK(64));
 	/* Disallow using nsim_bus_dev */
 	smp_store_release(&nsim_bus_dev->init, false);
 
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index b4a99f3ceac60..357ea9e5623b3 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -414,19 +414,27 @@ static int nsim_poll(struct napi_struct *napi, int budget)
 	return done;
 }
 
-static int nsim_create_page_pool(struct page_pool **p, struct napi_struct *napi)
+static int nsim_create_page_pool(struct net_device *dev, struct page_pool **p,
+				 struct napi_struct *napi, int idx)
 {
+	struct netdevsim *ns = netdev_priv(dev);
 	struct page_pool_params params = {
 		.order = 0,
 		.pool_size = NSIM_RING_SIZE,
+		.flags = PP_FLAG_ALLOW_UNREADABLE_NETMEM,
+		.max_len = PAGE_SIZE,
 		.nid = NUMA_NO_NODE,
-		.dev = &napi->dev->dev,
+		.dev = &ns->nsim_bus_dev->dev,
 		.napi = napi,
 		.dma_dir = DMA_BIDIRECTIONAL,
-		.netdev = napi->dev,
+		.netdev = dev,
+		.queue_idx = idx,
 	};
 	struct page_pool *pool;
 
+	if (IS_ENABLED(CONFIG_HAS_DMA))
+		params.flags |= PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
+
 	pool = page_pool_create(&params);
 	if (IS_ERR(pool))
 		return PTR_ERR(pool);
@@ -450,7 +458,7 @@ static int nsim_init_napi(struct netdevsim *ns)
 	for (i = 0; i < dev->num_rx_queues; i++) {
 		rq = ns->rq[i];
 
-		err = nsim_create_page_pool(&rq->page_pool, &rq->napi);
+		err = nsim_create_page_pool(dev, &rq->page_pool, &rq->napi, i);
 		if (err)
 			goto err_pp_destroy;
 	}
@@ -762,14 +770,16 @@ nsim_queue_mem_alloc(struct net_device *dev,
 	if (ns->rq_reset_mode == 1) {
 		if (!netif_running(ns->netdev))
 			return -ENETDOWN;
-		return nsim_create_page_pool(&qmem->pp, &ns->rq[idx]->napi);
+		return nsim_create_page_pool(dev, &qmem->pp,
+					     &ns->rq[idx]->napi, idx);
 	}
 
 	qmem->rq = nsim_queue_alloc();
 	if (!qmem->rq)
 		return -ENOMEM;
 
-	err = nsim_create_page_pool(&qmem->rq->page_pool, &qmem->rq->napi);
+	err = nsim_create_page_pool(dev, &qmem->rq->page_pool, &qmem->rq->napi,
+				    idx);
 	if (err)
 		goto err_free;
 
@@ -929,12 +939,15 @@ nsim_pp_hold_write(struct file *file, const char __user *data,
 		return ret;
 
 	rtnl_lock();
+	netdev_lock(ns->netdev);
 	ret = count;
 	if (val == !!ns->page)
 		goto exit;
 
 	if (!netif_running(ns->netdev) && val) {
 		ret = -ENETDOWN;
+	} else if (val && page_pool_is_unreadable(ns->rq[0]->page_pool)) {
+		ret = -EOPNOTSUPP;
 	} else if (val) {
 		ns->page = page_pool_dev_alloc_pages(ns->rq[0]->page_pool);
 		if (!ns->page)
@@ -946,6 +959,7 @@ nsim_pp_hold_write(struct file *file, const char __user *data,
 	}
 
 exit:
+	netdev_unlock(ns->netdev);
 	rtnl_unlock();
 	return ret;
 }
@@ -1051,6 +1065,7 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
 	ns->netdev->netdev_ops = &nsim_netdev_ops;
 	ns->netdev->stat_ops = &nsim_stat_ops;
 	ns->netdev->queue_mgmt_ops = &nsim_queue_mgmt_ops;
+	ns->netdev->netmem_tx = NETMEM_TX_DMA;
 	netdev_lockdep_set_classes(ns->netdev);
 
 	err = nsim_udp_tunnels_info_create(ns->nsim_dev, ns->netdev);
diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
index 6b3532b5e360d..908cc0d391dc6 100644
--- a/drivers/net/netdevsim/psp.c
+++ b/drivers/net/netdevsim/psp.c
@@ -86,6 +86,11 @@ nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
 		__wsum csum;
 		int udplen;
 
+		if (!skb_frags_readable(skb)) {
+			rc = SKB_DROP_REASON_PSP_OUTPUT;
+			goto out_unlock;
+		}
+
 		/* Do not decapsulate. Receive the skb with the udp and psp
 		 * headers still there as if this is a normal udp packet.
 		 * psp_dev_encapsulate() sets udp checksum to 0, so we need to
-- 
2.56.0.176.g3575e65682-goog

