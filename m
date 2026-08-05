Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15181C55ABF
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 20:43:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C8F110EFF5;
	Wed,  5 Aug 2026 20:43:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GRJbjFB4";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EE2110EFF5
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 20:43:06 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2cea3004256so18325245ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 05 Aug 2026 13:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785962585; x=1786567385; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2K4H3UPgw3tGv5WudQmjsxRnE42MxKX+N5QsyYMK1TE=;
 b=GRJbjFB4gH10fOq99DNL2Tgmr8w24slmNUKQ8l/2BepJIIve+VgBY/XqoLr4ytRs7p
 ypvMD1WkACheKSH05bfYbiOQWfxtED0Un75q39gPzhucr4BfewrSFrpGNrWZXgPnx6Lm
 vPibd+qpq3IGUatt7WJDS3aAA36uKMO0+HKnH7cAvFqetYJfe2K7lwaFhTR68Nu+XklC
 HJBNSXIEtcEMhd//xKyxOeNP36LAx08appZuCpHJzPaYinmMqX/6uhsTK7OTPeoHxhQm
 Cs8lHzqD6O4CIuHyLMI5hofy/HQqzytKedM1f7RkOA2LSSoAc/3HBCN4MdnwmYu2xDb8
 aISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785962585; x=1786567385;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2K4H3UPgw3tGv5WudQmjsxRnE42MxKX+N5QsyYMK1TE=;
 b=M8hAJu7IdV7SYotoX9uFucYLdAU4FqB96++PMPavTTV69bjuS/x6YT1nI6JPsC/Yl5
 wou7Xwi9UL2y6cFUMa+xVXkB1ygCyiridTLOF77shTPIoFz7/fMLGGwWofzHzQ11mBxU
 eD167qSGMbsxd6YMzbTMRR+bzHSCxZQ0Ydz/efxPDHSvZp1bnXR7oDW4nDRaKjSMkYiB
 83HYXrmTyM92IGUwAc7xvU2R6cLhGpa+X3+g/1d0DXTyvmCi0Mqv3UpVBkqCqHutdl2q
 ParSonzBmMb4yQpik+TWowHWx//729v/uyz+tcY981eahP25Wj3Kvd0/0d1Re2rLxYB8
 knoQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrVVo6TOLqsQRlwo2edjeDL6T/4d9wvyPA/xTEAAPNQ/j1fLMC3glRkv43r6igdgHpxpRrpoyq55ms=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwOcBf1eg+X/KUSxATVe9xPoz4w76AQuvgXjo2sJSrZ/CPfoWSj
 yDk4lYgI4a+mbRgfBROhgIV1DTSf8n+0r/Eh/eyGkL9M8/msBJTWDWH7
X-Gm-Gg: AR+sD10mH3XaYlnZG6tan94pJw95gnLmNjKJ6sN+nF4oW8HkevG7oweTkvmhIcfB+hf
 SJqr2QHddLjmNRxo4bc362sKRdach+EwOOY44ZclJK3KoBdLLby4qweKt9CvNDDjVl69lDFIMBO
 mnZI5hFcgBEUsJKhVcoUzksCT+w5oqWg812VW9aP7ws2QPf79MqNxQCC8cNSX8/JIS9fYRbQyns
 bxT4aSyRBfQlSStXsDwkMWqnRajA9ZeTIGpC7Kg7CmG4DEsePQH9LezfQfoxUkAEl26l32J89Pa
 zmxn4gchbhXp8UGJaNKaRfL62RAJa5si1Gw9Oj8dElvhqN7JZOXSa6TnQG3+lYZ5bCen9zzJRzv
 RAPFWUwRpk8hbpJh+fy7qhURSTIeoD3+lAqYmke1VWnJUwcqRmuOg2DD9eV0DKNw0Rde835gcRq
 7xazToMDFQCZ2pNQ3XroOvk1oh9y6B8qaOvyXvYnKSPkYQYrEFpcd3Rj+W
X-Received: by 2002:a17:903:1b66:b0:2c9:e9db:8167 with SMTP id
 d9443c01a7336-2d0ca7125c0mr118316705ad.7.1785962585370; 
 Wed, 05 Aug 2026 13:43:05 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4d::])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d0aa49325bsm21037275ad.40.2026.08.05.13.43.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 13:43:04 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 05 Aug 2026 13:42:43 -0700
Subject: [PATCH net-next v8 1/3] net: devmem: allow rx-page-size >
 PAGE_SIZE per dmabuf binding
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-tcpdm-large-niovs-v8-1-3e0225e2808c@meta.com>
References: <20260805-tcpdm-large-niovs-v8-0-3e0225e2808c@meta.com>
In-Reply-To: <20260805-tcpdm-large-niovs-v8-0-3e0225e2808c@meta.com>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org, 
 sdf@fomichev.me, razor@blackwall.org, daniel@iogearbox.net, 
 almasrymina@google.com, matttbe@kernel.org, skhawaja@google.com, 
 dw@davidwei.uk, Joe Damato <joe@dama.to>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
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

From: Bobby Eshleman <bobbyeshleman@meta.com>

Every devmem dmabuf binding today hands the page_pool PAGE_SIZE niovs.
This caps a single RX descriptor at PAGE_SIZE, burning CPU on buffer
churn for large flows.

Add a bind-time netlink attribute, NETDEV_A_DMABUF_RX_PAGE_SIZE, that
lets userspace request a larger niov size. The value must be a power of
two >= PAGE_SIZE.

The TX path is changed to always pass PAGE_SIZE.

Measurements:
Setup: kperf in devmem RX/TX cuda mode, 4 flows, 64 MB messages, 60s,
dctcp, num-rx-queues=4, dmabuf-rx/tx-size-mb=2048, 10 runs per niov
size, mlx5.

CPU Util:

   niov        net sirq %        net idle %         app sys %        app idle %
  -----  ----------------  ----------------  ----------------  ----------------
     4K   62.38 +/-  8.27   33.40 +/-  7.51   54.15 +/- 10.23   43.67 +/- 10.53
    16K   58.91 +/-  5.35   35.23 +/-  5.88   41.05 +/-  8.87   56.42 +/-  9.24
    32K   64.12 +/-  0.68   31.09 +/-  1.48   44.54 +/-  3.51   52.63 +/-  3.65
    64K   54.69 +/-  5.54   39.67 +/-  5.81   35.47 +/-  3.11   61.97 +/-  3.27

RX app sys % drops ~19% from 4K to 64K.

Throughput:

   niov       RX dev Gbps   RX flow avg Gbps
  -----  ----------------  -----------------
     4K  300.63 +/- 53.21    75.16 +/- 13.30
    16K  321.35 +/- 28.20    80.34 +/-  7.05
    32K  347.63 +/-  2.20    86.91 +/-  0.55
    64K  332.11 +/- 14.26    83.03 +/-  3.56

Throughput seems to increase, but the stdev is pretty wide so could just
be noise.

kperf support (not yet merged):
https://github.com/facebookexperimental/kperf/commit/8837577f920876bce6986ec18869ac04439ebcd2

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 Documentation/netlink/specs/netdev.yaml | 19 +++++++++++++++++
 include/uapi/linux/netdev.h             |  1 +
 net/core/devmem.c                       | 37 ++++++++++++++++++++-------------
 net/core/devmem.h                       | 13 ++++++++----
 net/core/netdev-genl-gen.c              | 11 ++++++++--
 net/core/netdev-genl-gen.h              |  1 +
 net/core/netdev-genl.c                  | 18 ++++++++++++++--
 tools/include/uapi/linux/netdev.h       |  1 +
 8 files changed, 78 insertions(+), 23 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 5f143da7458c..3e3f03bd5c29 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -6,6 +6,14 @@ doc: >-
   netdev configuration over generic netlink.
 
 definitions:
+  -
+    type: const
+    name: page-size
+    # Dummy value, codegen needs a number. The real value comes from
+    # the PAGE_SIZE macro in the header below.
+    value: 0
+    header: asm/page.h
+    scope: kernel
   -
     type: flags
     name: xdp-act
@@ -598,6 +606,16 @@ attribute-sets:
         type: u32
         checks:
           min: 1
+      -
+        name: rx-page-size
+        doc: |
+          Size in bytes of each device page the NIC writes into from the bound
+          dmabuf. Must be a power of two and >= PAGE_SIZE; defaults to
+          PAGE_SIZE.
+        type: u32
+        checks:
+          min: page-size
+          max: u32-max
 
 operations:
   list:
@@ -812,6 +830,7 @@ operations:
             - ifindex
             - fd
             - queues
+            - rx-page-size
         reply:
           attributes:
             - id
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 2f3ab75e8cc0..35ff083221c7 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -219,6 +219,7 @@ enum {
 	NETDEV_A_DMABUF_QUEUES,
 	NETDEV_A_DMABUF_FD,
 	NETDEV_A_DMABUF_ID,
+	NETDEV_A_DMABUF_RX_PAGE_SIZE,
 
 	__NETDEV_A_DMABUF_MAX,
 	NETDEV_A_DMABUF_MAX = (__NETDEV_A_DMABUF_MAX - 1)
diff --git a/net/core/devmem.c b/net/core/devmem.c
index 957d6b96216b..f4d60654ce7f 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -46,7 +46,7 @@ static dma_addr_t net_devmem_get_dma_addr(const struct net_iov *niov)
 
 	owner = net_devmem_iov_to_chunk_owner(niov);
 	return owner->base_dma_addr +
-	       ((dma_addr_t)net_iov_idx(niov) << PAGE_SHIFT);
+	       ((dma_addr_t)net_iov_idx(niov) << owner->binding->niov_shift);
 }
 
 static void net_devmem_dmabuf_binding_release(struct percpu_ref *ref)
@@ -93,13 +93,14 @@ net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
 	ssize_t offset;
 	ssize_t index;
 
-	dma_addr = gen_pool_alloc_owner(binding->chunk_pool, PAGE_SIZE,
+	dma_addr = gen_pool_alloc_owner(binding->chunk_pool,
+					1UL << binding->niov_shift,
 					(void **)&owner);
 	if (!dma_addr)
 		return NULL;
 
 	offset = dma_addr - owner->base_dma_addr;
-	index = offset / PAGE_SIZE;
+	index = offset >> binding->niov_shift;
 	niov = &owner->area.niovs[index];
 
 	niov->desc.pp_magic = 0;
@@ -113,12 +114,13 @@ void net_devmem_free_dmabuf(struct net_iov *niov)
 {
 	struct net_devmem_dmabuf_binding *binding = net_devmem_iov_binding(niov);
 	unsigned long dma_addr = net_devmem_get_dma_addr(niov);
+	size_t niov_size = 1UL << binding->niov_shift;
 
 	if (WARN_ON(!gen_pool_has_addr(binding->chunk_pool, dma_addr,
-				       PAGE_SIZE)))
+				       niov_size)))
 		return;
 
-	gen_pool_free(binding->chunk_pool, dma_addr, PAGE_SIZE);
+	gen_pool_free(binding->chunk_pool, dma_addr, niov_size);
 }
 
 void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
@@ -163,6 +165,9 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 	u32 xa_idx;
 	int err;
 
+	if (binding->niov_shift != PAGE_SHIFT)
+		mp_params.rx_page_size = 1U << binding->niov_shift;
+
 	err = netif_mp_open_rxq(dev, rxq_idx, &mp_params, extack);
 	if (err)
 		return err;
@@ -184,10 +189,12 @@ struct net_devmem_dmabuf_binding *
 net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 		       struct device *dma_dev,
 		       enum dma_data_direction direction,
-		       unsigned int dmabuf_fd, struct netdev_nl_sock *priv,
+		       unsigned int dmabuf_fd, unsigned int niov_shift,
+		       struct netdev_nl_sock *priv,
 		       struct netlink_ext_ack *extack)
 {
 	struct net_devmem_dmabuf_binding *binding;
+	size_t niov_size = 1UL << niov_shift;
 	static u32 id_alloc_next;
 	struct scatterlist *sg;
 	struct dma_buf *dmabuf;
@@ -213,6 +220,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 
 	binding->dev = dev;
 	binding->vdev = vdev;
+	binding->niov_shift = niov_shift;
 	xa_init_flags(&binding->bound_rxqs, XA_FLAGS_ALLOC);
 
 	err = percpu_ref_init(&binding->ref,
@@ -255,11 +263,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 		}
 	}
 
-	/* For simplicity we expect to make PAGE_SIZE allocations, but the
-	 * binding can be much more flexible than that. We may be able to
-	 * allocate MTU sized chunks here. Leave that for future work...
-	 */
-	binding->chunk_pool = gen_pool_create(PAGE_SHIFT,
+	binding->chunk_pool = gen_pool_create(niov_shift,
 					      dev_to_node(&dev->dev));
 	if (!binding->chunk_pool) {
 		err = -ENOMEM;
@@ -273,9 +277,12 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 		size_t len = sg_dma_len(sg);
 		struct net_iov *niov;
 
-		if (!IS_ALIGNED(len, PAGE_SIZE)) {
+		if (!IS_ALIGNED(dma_addr, niov_size) ||
+		    !IS_ALIGNED(len, niov_size)) {
 			err = -EINVAL;
-			NL_SET_ERR_MSG(extack, "dma-buf SG length must be PAGE_SIZE aligned");
+			NL_SET_ERR_MSG_FMT(extack,
+					   "dmabuf sg entry (addr=%pad, len=%zu) not aligned to niov size %zu",
+					   &dma_addr, len, niov_size);
 			goto err_free_chunks;
 		}
 
@@ -288,7 +295,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 
 		owner->area.base_virtual = virtual;
 		owner->base_dma_addr = dma_addr;
-		owner->area.num_niovs = len / PAGE_SIZE;
+		owner->area.num_niovs = len >> niov_shift;
 		owner->binding = binding;
 
 		err = gen_pool_add_owner(binding->chunk_pool, dma_addr,
@@ -454,7 +461,7 @@ int mp_dmabuf_devmem_init(struct page_pool *pool)
 	pool->dma_sync = false;
 	pool->dma_sync_for_cpu = false;
 
-	if (pool->p.order != 0)
+	if (pool->p.order != binding->niov_shift - PAGE_SHIFT)
 		return -E2BIG;
 
 	net_devmem_dmabuf_binding_get(binding);
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 3852a56036cb..4a293a7d1149 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -71,6 +71,8 @@ struct net_devmem_dmabuf_binding {
 	 */
 	struct net_iov **tx_vec;
 
+	unsigned int niov_shift;
+
 	struct work_struct unbind_w;
 };
 
@@ -93,7 +95,8 @@ struct net_devmem_dmabuf_binding *
 net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 		       struct device *dma_dev,
 		       enum dma_data_direction direction,
-		       unsigned int dmabuf_fd, struct netdev_nl_sock *priv,
+		       unsigned int dmabuf_fd, unsigned int niov_shift,
+		       struct netdev_nl_sock *priv,
 		       struct netlink_ext_ack *extack);
 struct net_devmem_dmabuf_binding *net_devmem_lookup_dmabuf(u32 id);
 void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding);
@@ -122,10 +125,11 @@ static inline u32 net_devmem_iov_binding_id(const struct net_iov *niov)
 
 static inline unsigned long net_iov_virtual_addr(const struct net_iov *niov)
 {
-	struct net_iov_area *owner = net_iov_owner(niov);
+	struct dmabuf_genpool_chunk_owner *co =
+		net_devmem_iov_to_chunk_owner(niov);
 
-	return owner->base_virtual +
-	       ((unsigned long)net_iov_idx(niov) << PAGE_SHIFT);
+	return net_iov_owner(niov)->base_virtual +
+	       ((unsigned long)net_iov_idx(niov) << co->binding->niov_shift);
 }
 
 static inline bool
@@ -175,6 +179,7 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
 		       struct device *dma_dev,
 		       enum dma_data_direction direction,
 		       unsigned int dmabuf_fd,
+		       unsigned int niov_shift,
 		       struct netdev_nl_sock *priv,
 		       struct netlink_ext_ack *extack)
 {
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index d18c89b5a6c7..f83790341eae 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -11,6 +11,7 @@
 
 #include <uapi/linux/netdev.h>
 #include <net/netdev_netlink.h>
+#include <asm/page.h>
 
 /* Integer value ranges */
 static const struct netlink_range_validation netdev_a_page_pool_id_range = {
@@ -27,6 +28,11 @@ static const struct netlink_range_validation netdev_a_napi_defer_hard_irqs_range
 	.max	= S32_MAX,
 };
 
+static const struct netlink_range_validation netdev_a_dmabuf_rx_page_size_range = {
+	.min	= PAGE_SIZE,
+	.max	= U32_MAX,
+};
+
 /* Common nested types */
 const struct nla_policy netdev_lease_nl_policy[NETDEV_A_LEASE_NETNS_ID + 1] = {
 	[NETDEV_A_LEASE_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
@@ -106,10 +112,11 @@ static const struct nla_policy netdev_qstats_get_nl_policy[NETDEV_A_QSTATS_SCOPE
 };
 
 /* NETDEV_CMD_BIND_RX - do */
-static const struct nla_policy netdev_bind_rx_nl_policy[NETDEV_A_DMABUF_FD + 1] = {
+static const struct nla_policy netdev_bind_rx_nl_policy[NETDEV_A_DMABUF_RX_PAGE_SIZE + 1] = {
 	[NETDEV_A_DMABUF_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
 	[NETDEV_A_DMABUF_FD] = { .type = NLA_U32, },
 	[NETDEV_A_DMABUF_QUEUES] = NLA_POLICY_NESTED(netdev_queue_id_nl_policy),
+	[NETDEV_A_DMABUF_RX_PAGE_SIZE] = NLA_POLICY_FULL_RANGE(NLA_U32, &netdev_a_dmabuf_rx_page_size_range),
 };
 
 /* NETDEV_CMD_NAPI_SET - do */
@@ -219,7 +226,7 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 		.cmd		= NETDEV_CMD_BIND_RX,
 		.doit		= netdev_nl_bind_rx_doit,
 		.policy		= netdev_bind_rx_nl_policy,
-		.maxattr	= NETDEV_A_DMABUF_FD,
+		.maxattr	= NETDEV_A_DMABUF_RX_PAGE_SIZE,
 		.flags		= GENL_UNS_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
diff --git a/net/core/netdev-genl-gen.h b/net/core/netdev-genl-gen.h
index d71b435d72c1..3fae88e8f5c5 100644
--- a/net/core/netdev-genl-gen.h
+++ b/net/core/netdev-genl-gen.h
@@ -12,6 +12,7 @@
 
 #include <uapi/linux/netdev.h>
 #include <net/netdev_netlink.h>
+#include <asm/page.h>
 
 /* Common nested types */
 extern const struct nla_policy netdev_lease_nl_policy[NETDEV_A_LEASE_NETNS_ID + 1];
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index c15d8d4ca1f8..0eea4ee22f24 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -1013,6 +1013,7 @@ netdev_nl_get_dma_dev(struct net_device *netdev, unsigned long *rxq_bitmap,
 int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct net_devmem_dmabuf_binding *binding;
+	unsigned int niov_shift = PAGE_SHIFT;
 	u32 ifindex, dmabuf_fd, rxq_idx;
 	struct netdev_nl_sock *priv;
 	struct net_device *netdev;
@@ -1030,6 +1031,18 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 	ifindex = nla_get_u32(info->attrs[NETDEV_A_DEV_IFINDEX]);
 	dmabuf_fd = nla_get_u32(info->attrs[NETDEV_A_DMABUF_FD]);
 
+	if (info->attrs[NETDEV_A_DMABUF_RX_PAGE_SIZE]) {
+		u32 rx_page_size = nla_get_u32(info->attrs[NETDEV_A_DMABUF_RX_PAGE_SIZE]);
+
+		if (!is_power_of_2(rx_page_size)) {
+			NL_SET_ERR_MSG_ATTR(info->extack,
+					    info->attrs[NETDEV_A_DMABUF_RX_PAGE_SIZE],
+					    "rx-page-size must be a power of 2");
+			return -EINVAL;
+		}
+		niov_shift = ilog2(rx_page_size);
+	}
+
 	priv = genl_sk_priv_get(&netdev_nl_family, NETLINK_CB(skb).sk);
 	if (IS_ERR(priv))
 		return PTR_ERR(priv);
@@ -1080,7 +1093,8 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	binding = net_devmem_bind_dmabuf(netdev, NULL, dma_dev, DMA_FROM_DEVICE,
-					 dmabuf_fd, priv, info->extack);
+					 dmabuf_fd, niov_shift, priv,
+					 info->extack);
 	if (IS_ERR(binding)) {
 		err = PTR_ERR(binding);
 		goto err_rxq_bitmap;
@@ -1221,7 +1235,7 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 	binding = net_devmem_bind_dmabuf(bind_dev,
 					 bind_dev != netdev ? netdev : NULL,
 					 dma_dev, DMA_TO_DEVICE, dmabuf_fd,
-					 priv, info->extack);
+					 PAGE_SHIFT, priv, info->extack);
 	if (IS_ERR(binding)) {
 		err = PTR_ERR(binding);
 		goto err_unlock_bind_dev;
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 2f3ab75e8cc0..35ff083221c7 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -219,6 +219,7 @@ enum {
 	NETDEV_A_DMABUF_QUEUES,
 	NETDEV_A_DMABUF_FD,
 	NETDEV_A_DMABUF_ID,
+	NETDEV_A_DMABUF_RX_PAGE_SIZE,
 
 	__NETDEV_A_DMABUF_MAX,
 	NETDEV_A_DMABUF_MAX = (__NETDEV_A_DMABUF_MAX - 1)

-- 
2.53.0-Meta

