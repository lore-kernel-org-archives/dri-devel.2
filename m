Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66FB1CA9EDE
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 17:43:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A92910E62C;
	Mon, 12 Oct 2026 17:43:18 +0000 (UTC)
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4D9510E639
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 17:43:08 +0000 (UTC)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1665200f4c2so2997080c88.0
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 10:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791826988; x=1792431788;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CnXvDkHRygIjqcgALHUWN066KUbjGPQJV9Mzd8woTCg=;
 b=psMWXE+TVZsqUHXMnSxTIbMwfnZqhwyn+d3K7BcYVm44FhMzr2s3pUnUbjn1tRi+3m
 l7Xe6/5rk/vASbJ8TDQuNqYb6vlhk9AOM56sfJApx2uD6N8zdg2znMNJ1bUOPjoxKmVg
 O4a4FTnt+f/3Ub7vi0vlysjuOQ2X35+y5thoxIHvFWYtFqxsa5p5ceTu8PDW6n2LrDoC
 uZTeFcHSrUDttw8uQUqVXhjPOzwJOiLDFFTXLitVne4fYXJQwXtpDefxC5FZFsg2V/cR
 1EUaSn8pMwHEiLlVQOZytI/OR3Ftdlj+uIJIINY7SmWa3mb4K8IVxq5CfooR9KmYvo7K
 EMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791826988; x=1792431788;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CnXvDkHRygIjqcgALHUWN066KUbjGPQJV9Mzd8woTCg=;
 b=gIqHzgwTq5zJbAujvcJOJqd8biD5AdrDGbfAtA2abiE6fwBKHQJWCEgSSnx3mRgbYK
 Mc0e0a5fahrBfklvCXxLCj3BaA/NlZg0SknGM8TWKyzT7WumWIBpxL9lSlS/LpyRM5hi
 SWwVRLF761SakogIvx5K71C4xWoEec0abhd3XTa3YHfQUXs0/nQOEsS4d6VwtLFL8X/x
 2c/G5vOjQooykQ9/DdiwQik54LNDudB50/3r61WpUKui+eLfN2dS8nVbos2FHy0F0HJD
 mrjwp9/jUNrZ04bKgNHFpRp9N7xn7ZYzFggncV+qqzmK63on12gdJOm8ruooqXvihbjC
 ju+Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwaYIcZDkRA87ypyGmx7xHvB46at8i/SyO4QrmAncpMZPE1we6nDmcxphSYgEpSTQMV+ZqTtWuU+DI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKQ2IFB54N0LdjtnGZaapDxU8iS+aQnUI3Mo1IHpRrKcFUdZes8
 yEFZVrJxqNgmtPY1UyXltHyXJTs/FMJixc0n3kHopDNI40UBWfv0rARVzcK5/HX2LqQDypoac2I
 H4+U9PUsmUTrpdnIynG8hD68xdg==
X-Received: from dlbtu4.prod.google.com ([2002:a05:7022:3c04:b0:157:8b19:354f])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:4508:10b0:154:fa0b:6df1 with SMTP id
 a92af1059eb24-16a5e49d6c9mr12641181c88.37.1791826987357; 
 Mon, 12 Oct 2026 10:43:07 -0700 (PDT)
Date: Mon, 12 Oct 2026 17:42:59 +0000
In-Reply-To: <20261012174300.2338784-1-almasrymina@google.com>
Mime-Version: 1.0
References: <20261012174300.2338784-1-almasrymina@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261012174300.2338784-4-almasrymina@google.com>
Subject: [PATCH net v2 3/4] netdevsim: support devmem RX and TX bindings
From: Mina Almasry <almasrymina@google.com>
To: Jakub Kicinski <kuba@kernel.org>, David Wei <dw@davidwei.uk>, 
 Pavel Begunkov <asml.silence@gmail.com>, Mina Almasry <almasrymina@google.com>,
 Taehee Yoo <ap420073@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
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
 Nikolay Aleksandrov <razor@blackwall.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Tariq Toukan <tariqt@nvidia.com>, 
 Kaifeng Wang <kaifengw@google.com>
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
PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV | PP_FLAG_ALLOW_UNREADABLE_NETMEM
and queue_idx so devmem bind-rx and bind-tx netlink operations can be
tested against netdevsim in software selftests.

Cc: Tariq Toukan <tariqt@nvidia.com>
Cc: Kaifeng Wang <kaifengw@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 drivers/net/netdevsim/bus.c    |  1 +
 drivers/net/netdevsim/netdev.c | 21 +++++++++++++++------
 2 files changed, 16 insertions(+), 6 deletions(-)

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
index b4a99f3ceac60..4415dc01c610b 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -414,16 +414,22 @@ static int nsim_poll(struct napi_struct *napi, int budget)
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
+		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV |
+			 PP_FLAG_ALLOW_UNREADABLE_NETMEM,
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
 
@@ -450,7 +456,7 @@ static int nsim_init_napi(struct netdevsim *ns)
 	for (i = 0; i < dev->num_rx_queues; i++) {
 		rq = ns->rq[i];
 
-		err = nsim_create_page_pool(&rq->page_pool, &rq->napi);
+		err = nsim_create_page_pool(dev, &rq->page_pool, &rq->napi, i);
 		if (err)
 			goto err_pp_destroy;
 	}
@@ -762,14 +768,16 @@ nsim_queue_mem_alloc(struct net_device *dev,
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
 
@@ -1051,6 +1059,7 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
 	ns->netdev->netdev_ops = &nsim_netdev_ops;
 	ns->netdev->stat_ops = &nsim_stat_ops;
 	ns->netdev->queue_mgmt_ops = &nsim_queue_mgmt_ops;
+	ns->netdev->netmem_tx = NETMEM_TX_DMA;
 	netdev_lockdep_set_classes(ns->netdev);
 
 	err = nsim_udp_tunnels_info_create(ns->nsim_dev, ns->netdev);
-- 
2.56.0.385.gd3acb90ef8-goog

