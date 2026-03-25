Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E700109C059
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 19:24:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63B0F10E912;
	Wed, 25 Mar 2026 19:24:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="xS11AQtm";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C91C10E0E4
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 19:23:56 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-486fda2a389so1725815e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774466635; x=1775071435;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YMfoKT234OWAIu2ygAH4xOQ0BTmCnNSAwf62AjGD0Kg=;
 b=xS11AQtmZvxrPwfDH9Fl1aArQJDyex1B+DYqoHJLMzysvsnsV1kBXdOhL/apLGI9Rf
 U2nTWjEos0msjoUDpkWXFCFng/rC7rTcbqUczPSCrdJl3iM72fxYv17yJdLCHaY3/QYU
 AyMMonYIu4WxozePZhgP3IKF2QRkyZFJC4cP4oztUSy8nLQqzXFej48A56XFYO3rdpXK
 oQ9KLB5+7ttdGqtxM4Mcr5iD+3aGHwknSP7MkjO2BbwX2qIE8srtp8sjPQpbea9V06Fr
 8qnjzySmprrkb0fYVTyhV9Zsn3Vw3YK3XJRMLY1J3N9H05BU2qLqvrK5y/5Ivby2Gzlq
 jflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774466635; x=1775071435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YMfoKT234OWAIu2ygAH4xOQ0BTmCnNSAwf62AjGD0Kg=;
 b=jgVoKN1O9M5SwABDzG4xgwuYsaVUrR4gXZ+XfXC2Mdpf55ZbewfVJkyVcNGJJJlnju
 5kEBydxEilu5PxXqvskI3/1kI/ArpRDQXaa8MISrh/wgOsheZueDnBS0v8uv0T7EA7k3
 A4mYWDduGJoo61uyz1FnVP9ggE1F6QYzsAPu2OqF6U4CysyPMlpFLwREI1fx0zGYgXSn
 o5mvGaQV2Y9DSRY0wRF/fIy699U4TrFE7YPYfMSNgE98lxFdb4/zk48n8sJx0vdfTqsW
 vg1TcGNwVkT5h/+q4xsUbMaSnlqDF7og7maUxB1GwcLswOowDqTmciCLszsNh4SH/lSE
 xR5w==
X-Gm-Message-State: AOJu0Yzs8ltvAWkSH4UzUJB5FcBI2aHlrneld8aO1T+ixsOE4SFGjO8+
 j9hpCZX1AST4Lvc4+gFSMi5hkjIUNNJ7VSQWbfR3bm8FL3yYkg7SWop70772FKWJqpEbq5mH6K6
 oqCJbrUF8kA==
X-Gm-Gg: ATEYQzy/jVucJJE3a7CNG3+qpbC16/cxEvURq0lUGNZ0RvSXj588DOOYkx+0P/yYnNa
 47VBFS8M+Kq+ItAPsAK6gIRsPjfH4Bq0cuvxio/KEEGZHVkwqaTI8dLwTkgCsZok924bSDd3mM6
 cLRQGUl+JJdrSnku3fxD1IEaZFrk+Lvt3tCBkWyPY86BVOwMHEnopuY457NOb1TcyQ19SRiJhRn
 F/WGoa2fvU6k+KnaO+Kx1+ZdIG8MUqL8AgtXBt/wNfLgdp2PQhx5Yc1FL/zZSTwoNQ1cjqJDZi+
 Kjaf8rF+zObC0173/Atl3JmZG3f1eu1k5NZ+Y7Ar5wq+G49ajE51DgJHOtD0WuIfOOKDNejWCKl
 RUHynfpTR2tnBiPkG24+DVYKFDmLWco5iMiK1Kp9BpbSRn78v7B1k5oOHSdMTFXW8nMhshx+wFt
 vtT+6EVwR5fY2svqxoLg==
X-Received: by 2002:a05:600c:c4a4:b0:485:1878:7b8c with SMTP id
 5b1f17b1804b1-48716056512mr65908275e9.18.1774466634748; 
 Wed, 25 Mar 2026 12:23:54 -0700 (PDT)
Received: from localhost ([140.209.217.211]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48711702191sm146523035e9.5.2026.03.25.12.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 12:23:54 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 iommu@lists.linux.dev, linux-media@vger.kernel.org
Cc: sumit.semwal@linaro.org, benjamin.gaignard@collabora.com,
 Brian.Starkey@arm.com, jstultz@google.com, tjmercier@google.com,
 christian.koenig@amd.com, m.szyprowski@samsung.com, robin.murphy@arm.com,
 jgg@ziepe.ca, leon@kernel.org, sean.anderson@linux.dev, ptesarik@suse.com,
 catalin.marinas@arm.com, aneesh.kumar@kernel.org, suzuki.poulose@arm.com,
 steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com,
 ashish.kalra@amd.com, suravee.suthikulpanit@amd.com,
 linux-coco@lists.linux.dev
Subject: [PATCH v5 1/2] dma-mapping: introduce DMA_ATTR_CC_SHARED for shared
 memory
Date: Wed, 25 Mar 2026 20:23:51 +0100
Message-ID: <20260325192352.437608-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260325192352.437608-1-jiri@resnulli.us>
References: <20260325192352.437608-1-jiri@resnulli.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Jiri Pirko <jiri@nvidia.com>

Current CC designs don't place a vIOMMU in front of untrusted devices.
Instead, the DMA API forces all untrusted device DMA through swiotlb
bounce buffers (is_swiotlb_force_bounce()) which copies data into
shared memory on behalf of the device.

When a caller has already arranged for the memory to be shared
via set_memory_decrypted(), the DMA API needs to know so it can map
directly using the unencrypted physical address rather than bounce
buffering. Following the pattern of DMA_ATTR_MMIO, add
DMA_ATTR_CC_SHARED for this purpose. Like the MMIO case, only the
caller knows what kind of memory it has and must inform the DMA API
for it to work correctly.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v4->v5:
- rebased on top od dma-mapping-for-next
- s/decrypted/shared/
v3->v4:
- added some sanity checks to dma_map_phys and dma_unmap_phys
- enhanced documentation of DMA_ATTR_CC_DECRYPTED attr
v1->v2:
- rebased on top of recent dma-mapping-fixes
---
 include/linux/dma-mapping.h | 10 ++++++++++
 include/trace/events/dma.h  |  3 ++-
 kernel/dma/direct.h         | 14 +++++++++++---
 kernel/dma/mapping.c        | 13 +++++++++++--
 4 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 677c51ab7510..db8ab24a54f4 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -92,6 +92,16 @@
  * flushing.
  */
 #define DMA_ATTR_REQUIRE_COHERENT	(1UL << 12)
+/*
+ * DMA_ATTR_CC_SHARED: Indicates the DMA mapping is shared (decrypted) for
+ * confidential computing guests. For normal system memory the caller must have
+ * called set_memory_decrypted(), and pgprot_decrypted must be used when
+ * creating CPU PTEs for the mapping. The same shared semantic may be passed
+ * to the vIOMMU when it sets up the IOPTE. For MMIO use together with
+ * DMA_ATTR_MMIO to indicate shared MMIO. Unless DMA_ATTR_MMIO is provided
+ * a struct page is required.
+ */
+#define DMA_ATTR_CC_SHARED	(1UL << 13)
 
 /*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
index 63597b004424..31c9ddf72c9d 100644
--- a/include/trace/events/dma.h
+++ b/include/trace/events/dma.h
@@ -34,7 +34,8 @@ TRACE_DEFINE_ENUM(DMA_NONE);
 		{ DMA_ATTR_PRIVILEGED, "PRIVILEGED" }, \
 		{ DMA_ATTR_MMIO, "MMIO" }, \
 		{ DMA_ATTR_DEBUGGING_IGNORE_CACHELINES, "CACHELINES_OVERLAP" }, \
-		{ DMA_ATTR_REQUIRE_COHERENT, "REQUIRE_COHERENT" })
+		{ DMA_ATTR_REQUIRE_COHERENT, "REQUIRE_COHERENT" }, \
+		{ DMA_ATTR_CC_SHARED, "CC_SHARED" })
 
 DECLARE_EVENT_CLASS(dma_map,
 	TP_PROTO(struct device *dev, phys_addr_t phys_addr, dma_addr_t dma_addr,
diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index b86ff65496fc..7140c208c123 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -89,16 +89,24 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
 	dma_addr_t dma_addr;
 
 	if (is_swiotlb_force_bounce(dev)) {
-		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
-			return DMA_MAPPING_ERROR;
+		if (!(attrs & DMA_ATTR_CC_SHARED)) {
+			if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
+				return DMA_MAPPING_ERROR;
 
-		return swiotlb_map(dev, phys, size, dir, attrs);
+			return swiotlb_map(dev, phys, size, dir, attrs);
+		}
+	} else if (attrs & DMA_ATTR_CC_SHARED) {
+		return DMA_MAPPING_ERROR;
 	}
 
 	if (attrs & DMA_ATTR_MMIO) {
 		dma_addr = phys;
 		if (unlikely(!dma_capable(dev, dma_addr, size, false)))
 			goto err_overflow;
+	} else if (attrs & DMA_ATTR_CC_SHARED) {
+		dma_addr = phys_to_dma_unencrypted(dev, phys);
+		if (unlikely(!dma_capable(dev, dma_addr, size, false)))
+			goto err_overflow;
 	} else {
 		dma_addr = phys_to_dma(dev, phys);
 		if (unlikely(!dma_capable(dev, dma_addr, size, true)) ||
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index df3eccc7d4ca..23ed8eb9233e 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -157,6 +157,7 @@ dma_addr_t dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 	bool is_mmio = attrs & DMA_ATTR_MMIO;
+	bool is_cc_shared = attrs & DMA_ATTR_CC_SHARED;
 	dma_addr_t addr = DMA_MAPPING_ERROR;
 
 	BUG_ON(!valid_dma_direction(dir));
@@ -168,8 +169,11 @@ dma_addr_t dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
 		return DMA_MAPPING_ERROR;
 
 	if (dma_map_direct(dev, ops) ||
-	    (!is_mmio && arch_dma_map_phys_direct(dev, phys + size)))
+	    (!is_mmio && !is_cc_shared &&
+	     arch_dma_map_phys_direct(dev, phys + size)))
 		addr = dma_direct_map_phys(dev, phys, size, dir, attrs, true);
+	else if (is_cc_shared)
+		return DMA_MAPPING_ERROR;
 	else if (use_dma_iommu(dev))
 		addr = iommu_dma_map_phys(dev, phys, size, dir, attrs);
 	else if (ops->map_phys)
@@ -206,11 +210,16 @@ void dma_unmap_phys(struct device *dev, dma_addr_t addr, size_t size,
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 	bool is_mmio = attrs & DMA_ATTR_MMIO;
+	bool is_cc_shared = attrs & DMA_ATTR_CC_SHARED;
 
 	BUG_ON(!valid_dma_direction(dir));
+
 	if (dma_map_direct(dev, ops) ||
-	    (!is_mmio && arch_dma_unmap_phys_direct(dev, addr + size)))
+	    (!is_mmio && !is_cc_shared &&
+	     arch_dma_unmap_phys_direct(dev, addr + size)))
 		dma_direct_unmap_phys(dev, addr, size, dir, attrs, true);
+	else if (is_cc_shared)
+		return;
 	else if (use_dma_iommu(dev))
 		iommu_dma_unmap_phys(dev, addr, size, dir, attrs);
 	else if (ops->unmap_phys)
-- 
2.51.1

