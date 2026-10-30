Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD8660A262B
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 08:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DI1bbqcM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A91A10E875;
	Fri, 30 Oct 2026 08:35:52 +0000 (UTC)
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 579AC112689
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 08:35:44 +0000 (UTC)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-189d17eca17so440541c88.1
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 01:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793349343; x=1793954143;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=F0zE/6OtBk5Lv6PuQXE1z46Ii6lr5+GgEZoby1iAKkE=;
 b=DI1bbqcMKGHfs/tudXZ52/JIIZEPXCEFYKsmXJShK5hfAPVNTu3ZVrHM750ACTK0vH
 YmtdTj62/k0dD7ROzLyGDbxuMZclmpfrNXdzSHD29pKJPYIxNE9qQcB0xuYUll/odJjE
 sBA4r4Rgm5CEjTfI1abGldzuDqACGxq9Pl5NBhF5clKzZKx+iNCfArk0hx2OThVMBQFd
 dUdWzJUZ5HtHKk7gT2SAG45az8L1hO5w4ob0B4HQiYt0XbLD9TojCFiHcM22ZC/t+nJB
 /u2bcn+vQOhOBJrXHoG1NhYNvmhRZwZAIhQlc/q77ntqN7t+AfvKht8Ybp/sPkNE7F3r
 JoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793349343; x=1793954143;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F0zE/6OtBk5Lv6PuQXE1z46Ii6lr5+GgEZoby1iAKkE=;
 b=1nzbqTudqobfzqUiwqieKm5tlPjsuApBS4WnVF/Hf+BQiwUQIWUVAEU78M5pmc6GiJ
 JmIgg4QENZrl9kzWZAK6LuxLZXbku0arFQjKKtc3uDKbqVWNOvQR/fmAJUCyMbnDp5dn
 XzOYSyMofQlLtsBQHClVnJbxNROCXOuic6ZbKsEADBBDgZ12SLivxWsw992mmSOsq2Y4
 uAP4SE0sOa0/+FHOdJeceVuoD4kCREKNwXkColeoPFD31IP6mIZKSpz7euSohvLT/LkS
 KrTl8MblEs/wYojPjDjQjPnKZThcHdHRYlkWKZqqX8uoQWK1/KxgvdEM2bHc3OO5825+
 eeYw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZvdi+3K36pus7mQHqRChBbbTAUV+zQNFFA5BhW9QkqZy8ITytsCFIXhPeI67aqO0Wr9MvS6TLMYI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKeNXPby71RoUPIbgwenAgDT3Vhv9YaKy7385RzGIdmiidpBRLq
 7WdZJhdGkp4hRRXg66BqHGewo+jJD3AIq6vWAZG415W5NRPDWNwQk/DyZiNAY4wb+n2bJXBSh7X
 qiQnGC2V6j4PO07xR6Xcyjtv9CQ==
X-Received: from dlbec15.prod.google.com ([2002:a05:7022:d8f:b0:19f:9e93:9354])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7023:904:b0:168:3243:c907 with SMTP id
 a92af1059eb24-1ad85de518fmr460495c88.24.1793349343177; 
 Fri, 30 Oct 2026 01:35:43 -0700 (PDT)
Date: Fri, 30 Oct 2026 08:35:37 +0000
In-Reply-To: <20261030083539.777877-1-almasrymina@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261030083539.777877-1-almasrymina@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261030083539.777877-4-almasrymina@google.com>
Subject: [PATCH net v5 3/4] netdevsim: support devmem RX and TX bindings
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

Set a 64-bit DMA mask and UINT_MAX max segment size on nsim_bus_dev in
nsim_bus_probe() when direct DMA mapping is supported, enable
NETMEM_TX_DMA on the netdevsim net_device, and configure page_pool
instances with PP_FLAG_ALLOW_UNREADABLE_NETMEM and queue_idx, plus
PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV when a DMA mask and
PP_DMA_INDEX_BITS are available, so devmem bind-rx and bind-tx netlink
operations can be tested against netdevsim in software selftests.

The pp_hold debugfs file allocates pages from the queue 0 page pool, so
refuse it when that pool is absent or backed by a memory provider, and
take the netdev instance lock there so a concurrent bind-rx cannot swap
the pool in between. Since netdevsim forwards TX skbs in software
without a DMA engine, drop unreadable or net_iov skbs in
nsim_start_xmit().

Cc: Tariq Toukan <tariqt@nvidia.com>
Cc: Kaifeng Wang <kaifengw@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
---
v5:
- Configure the DMA mask and dma_parms in nsim_bus_probe() gated on
  dma_pci_p2pdma_supported(), and require PP_DMA_INDEX_BITS before
  setting PP_FLAG_DMA_MAP so page_pool_scrub() can unmap inflight pages
  on 32-bit builds (Sashiko).
- Check for NULL ns->rq in nsim_pp_hold_write() and drop unreadable or
  net_iov skbs at the start of nsim_start_xmit() (Sashiko).

v3:
- Only request page pool DMA mapping when CONFIG_HAS_DMA is set
  (Sashiko).
- Refuse pp_hold on a page pool backed by a memory provider, under the
  netdev instance lock (Sashiko).
- Drop unreadable skbs in the software PSP path when it would have to
  checksum the payload (Sashiko).
---
 drivers/net/netdevsim/bus.c       |  9 +++++++++
 drivers/net/netdevsim/netdev.c    | 33 +++++++++++++++++++++++++------
 drivers/net/netdevsim/netdevsim.h |  1 +
 3 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
index b792ee10b1c1a..5f8f0c2f76939 100644
--- a/drivers/net/netdevsim/bus.c
+++ b/drivers/net/netdevsim/bus.c
@@ -5,6 +5,7 @@
 
 #include <linux/completion.h>
 #include <linux/device.h>
+#include <linux/dma-mapping.h>
 #include <linux/idr.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -416,6 +417,14 @@ static int nsim_bus_probe(struct device *dev)
 {
 	struct nsim_bus_dev *nsim_bus_dev = to_nsim_bus_dev(dev);
 
+	if (dma_pci_p2pdma_supported(dev) &&
+	    !dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(64))) {
+		dev->dma_parms = &nsim_bus_dev->dma_parms;
+		dma_set_max_seg_size(dev, UINT_MAX);
+	} else {
+		dev->dma_mask = NULL;
+	}
+
 	return nsim_drv_probe(nsim_bus_dev);
 }
 
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index eebc02ccc4a92..0372a9bd63bbb 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -133,6 +133,10 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	int dr;
 
 	rcu_read_lock();
+	if (!skb_frags_readable(skb) ||
+	    (skb_shinfo(skb)->nr_frags &&
+	     skb_frag_is_net_iov(&skb_shinfo(skb)->frags[0])))
+		goto out_drop_any;
 	if (!nsim_ipsec_tx(ns, skb))
 		goto out_drop_any;
 
@@ -422,19 +426,27 @@ static int nsim_poll(struct napi_struct *napi, int budget)
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
 
+	if (ns->nsim_bus_dev->dev.dma_mask && PP_DMA_INDEX_BITS)
+		params.flags |= PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
+
 	pool = page_pool_create(&params);
 	if (IS_ERR(pool))
 		return PTR_ERR(pool);
@@ -458,7 +470,7 @@ static int nsim_init_napi(struct netdevsim *ns)
 	for (i = 0; i < dev->num_rx_queues; i++) {
 		rq = ns->rq[i];
 
-		err = nsim_create_page_pool(&rq->page_pool, &rq->napi);
+		err = nsim_create_page_pool(dev, &rq->page_pool, &rq->napi, i);
 		if (err)
 			goto err_pp_destroy;
 	}
@@ -770,14 +782,16 @@ nsim_queue_mem_alloc(struct net_device *dev,
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
 
@@ -937,12 +951,16 @@ nsim_pp_hold_write(struct file *file, const char __user *data,
 		return ret;
 
 	rtnl_lock();
+	netdev_lock(ns->netdev);
 	ret = count;
 	if (val == !!ns->page)
 		goto exit;
 
 	if (!netif_running(ns->netdev) && val) {
 		ret = -ENETDOWN;
+	} else if (val && (!ns->rq ||
+			   page_pool_is_unreadable(ns->rq[0]->page_pool))) {
+		ret = -EOPNOTSUPP;
 	} else if (val) {
 		ns->page = page_pool_dev_alloc_pages(ns->rq[0]->page_pool);
 		if (!ns->page)
@@ -954,6 +972,7 @@ nsim_pp_hold_write(struct file *file, const char __user *data,
 	}
 
 exit:
+	netdev_unlock(ns->netdev);
 	rtnl_unlock();
 	return ret;
 }
@@ -1059,6 +1078,8 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
 	ns->netdev->netdev_ops = &nsim_netdev_ops;
 	ns->netdev->stat_ops = &nsim_stat_ops;
 	ns->netdev->queue_mgmt_ops = &nsim_queue_mgmt_ops;
+	if (ns->nsim_bus_dev->dev.dma_mask)
+		ns->netdev->netmem_tx = NETMEM_TX_DMA;
 	netdev_lockdep_set_classes(ns->netdev);
 
 	err = nsim_udp_tunnels_info_create(ns->nsim_dev, ns->netdev);
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index fd5599cd3bb9f..2aa7ea924396e 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -476,6 +476,7 @@ int nsim_setup_tc(struct net_device *dev, enum tc_setup_type type,
 #define NSIM_BUS_DEV_MAX_VFS 4
 struct nsim_bus_dev {
 	struct device dev;
+	struct device_dma_parameters dma_parms;
 	struct list_head list;
 	unsigned int port_count;
 	unsigned int num_queues; /* Number of queues for each port on this bus */
-- 
2.56.0.385.gac671c819a-goog

