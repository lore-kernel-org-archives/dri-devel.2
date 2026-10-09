Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F3CCA6015
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 00:21:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 603E910EA55;
	Fri,  9 Oct 2026 00:21:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="smmQJVWX";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13ABF10EA55
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 00:21:31 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a02718da81so27076575e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 17:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791505289; x=1792110089; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SuA9XknANPL6VvC11pYgn0IAp4/AWH6zzAsKWJ2B0W4=;
 b=smmQJVWXU4//aq6ZvnzBPDMrxR25I7lXPw1mVaLMkiKQc+AC1atRoXkCHzDuult2M8
 7b+LG05dR5Zk8K9u+JNdFbbHYeDViqjUfLlhw6B8yoh3mQTriPy4cicvpSXzoeraxFd4
 h4JX06FOG7/hhUeVK8k9QYrMMT5kgmLa92uNL9JxSbLbM1KL7l2NyUC4tCMC+3zHDjMg
 UfYptd44uQkvEla4IKkl5l6ePhHeAwLg1vdDVyn8RLt3cXzNtJdKkLrUEKzogw6nFd7F
 qXPO5mEXuu04q2uzMbxt6SN0cY8YHuN3/xKSuU2JJSizd7liih4Wqlj3qXp+CYPkvCp9
 ZJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791505289; x=1792110089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SuA9XknANPL6VvC11pYgn0IAp4/AWH6zzAsKWJ2B0W4=;
 b=NnLM3P1iVhU1XZha/V/6pJIbPwpucj7F8NooZetY+liWW8KCntj6EnTOcJVjJBZsUV
 jp3Ue5ltEyLExZIgCDdN0vbfzW0uqKcr8QMdIwIGjtlVY0jm0F7VbhzgtC7ZcEN9M207
 D+b8tVCUtc36Jo1Z8lCdAAkGA9lRDGDZ2vY2lI63fJDXMZ1/Gq1Spj4LXkgmVjAkFqYa
 JC7PyfeFaJ02TTswJJnq69e/IAGyK9sL+1ikpwqagretzP8dA2ipX8BcXz//JD58wpS3
 3WbYH2DAs8Y/0uTfDoox4P4w23xrZRBf3VnMqisyD/QDZKL5xjkzuUtY8pbQQdGXqVtr
 PD/g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzOgIkTfh7XMyPJIe/W0d0RK/25rhHWd0xbW0zyajH9PXkwM5Iq2/mgd89d4K4XNmFwshxtHAAvki4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lB03477JmlL618fdihk7fM0mbp8dEcWsNd8BexbOE+HN2he5Zl
 TNKUytwYD3TjO9sS0we4bpCWv+t+MLVgtjZ8ebCqMrsP3+MNIFART8X1
X-Gm-Gg: AYBFou0Lc9xgUnLTUvit64W77LWOkUoD9YpaYK09Y9d0GPn/M7W/X9o5LcK2/w+4qDf
 9DubDCUJcTcKn7mYoGfijFaaOo4fO+HEqBHHNy4qmRaLWNCZP8Sgc7BauRtS0SB6mTGgpxDNqLO
 Gffp1QNzm1PmI3OTYj/5CD0k3tur1clRWqvKwitlWAsmMZm3ZOgjot6SUwtctYuXAB89FZTIxHY
 Q7kfLS+YChhtwk7QWZXqIV0m+t4jc4dL/5/bKzrT9KQ9pL1UzihPs6c18WEFP71fgqhxJ2/unrH
 tIdihXD/8vo+qN9NnUfXdAscGn5wzjdOZy1njx/74qeVo+SvIUcwO/DHsgFTqEwSc/S2JxAWwgm
 1FTUzef9a57wyciw4/Fy3h0FO5Da9SsCw0JoBUcNJnHTT08CdFdzzDclHzYwgyZzd+UdG5xJEu4
 SRyoDNLOlnWOSjX7ZCdSyXVFj+HRXK33b/phx7EkDbMI2p1rF+eXP17P45z6jwBKm6YS4zdToLS
 s0Dd6oTIA/5/PvOIEkFNd4v/7X1A7u5h/P7SAMtvigcXEcPfyK1WBf2DVraDEFiF0i0ArlifHOp
 2dQ3Rkgjt8eAIcqTMxk2QIx7ESi9KfV/0KblWLbXLtNok5VTa25ilJX/FnNcULhjLEqhhEhRmZ0
 TBwggB90=
X-Received: by 2002:a05:600c:8706:b0:4a0:1efa:c74a with SMTP id
 5b1f17b1804b1-4a18e4b0f6amr2065355e9.20.1791505289240; 
 Thu, 08 Oct 2026 17:21:29 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-ad61-5a01-743c-891f-b33c-cae7.310.pool.telefonica.de.
 [2a02:3100:ad61:5a01:743c:891f:b33c:cae7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18e4987casm3364605e9.1.2026.10.08.17.21.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 Oct 2026 17:21:27 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 Diederik de Haas <diederik@cknow-tech.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andyshrk@163.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Jianfeng Liu <liujianfeng1994@gmail.com>, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] iommu: Add iommu_map_sgtable_dma()
Date: Fri,  9 Oct 2026 02:21:13 +0200
Message-Id: <20261009002114.67851-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261009002114.67851-1-kmehltretter@gmail.com>
References: <20261009002114.67851-1-kmehltretter@gmail.com>
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

DMA-BUF attachments provide DMA addresses, not CPU-side pages.
iommu_map_sgtable() needs those pages, so private-domain importers such
as Rockchip cannot use it with strict DMABUF_DEBUG.

Add an iommu-dma helper to map a live attachment into another domain by
translating through the device's default DMA domain. Roll back target
mappings on error. This still recovers physical addresses internally.

Only non-bounced iommu-dma mappings are supported. Other DMA backends,
marked bus addresses and zero translations return -EOPNOTSUPP, as does
the IOMMU_DMA=n stub. A zero lookup cannot distinguish a hole from PA0.
Reject bounce slots because a second mapping cannot keep them in sync
with writes to the original buffer.

DMABUF_DEBUG currently drops DMA flags from its copy, so the bus-address
check depends on the input retaining that mark.

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/iommu/dma-iommu.c | 131 ++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h     |  12 ++++
 2 files changed, 143 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 58c624513cd4..b9a1f91ec5db 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -38,6 +38,137 @@
 #include "dma-iommu.h"
 #include "iommu-pages.h"
 
+/**
+ * iommu_map_sgtable_dma - map the DMA side of an sg_table into a domain
+ * @domain: domain to map into
+ * @iova: IOVA of the first byte
+ * @dev: device for which @sgt is mapped
+ * @sgt: live DMA-API mapping for @dev, backed by non-bounced RAM
+ * @prot: IOMMU protection flags
+ *
+ * Translate the DMA addresses through @dev's default iommu-dma domain and
+ * map the backing memory into @domain without reading the CPU side of @sgt.
+ * Direct DMA and other DMA backends are not supported. Entries marked as
+ * PCI P2P bus addresses and SWIOTLB bounce buffers are also not supported.
+ *
+ * The caller must keep the source mapping, DMA backend and default domain
+ * unchanged until the target mapping is removed. This function may sleep.
+ * DMA addresses and lengths must be aligned to the smaller of the source
+ * and target domains' minimum page sizes. @iova and the total length must
+ * be aligned to the target domain's minimum page size.
+ *
+ * A zero reverse translation is unsupported: iommu_iova_to_phys() cannot
+ * distinguish an absent mapping from a mapping to physical address zero.
+ *
+ * Return: the number of bytes mapped, -EOPNOTSUPP for unsupported source
+ * mappings or source alignment, or another negative errno on error. Any
+ * target mappings installed by this call are removed on error.
+ */
+ssize_t iommu_map_sgtable_dma(struct iommu_domain *domain, unsigned long iova,
+			      struct device *dev, struct sg_table *sgt,
+			      int prot)
+{
+	struct iommu_domain *dma_domain;
+	size_t len = 0, mapped = 0, total = 0;
+	struct scatterlist *sg;
+	size_t granule, target_granule;
+	phys_addr_t start = 0;
+	unsigned long last_iova;
+	unsigned int i;
+	int ret;
+
+	if (!domain->pgsize_bitmap)
+		return -EINVAL;
+
+	target_granule = 1UL << __ffs(domain->pgsize_bitmap);
+	if (!use_dma_iommu(dev))
+		return -EOPNOTSUPP;
+	dma_domain = iommu_get_dma_domain(dev);
+	if (!dma_domain || !dma_domain->pgsize_bitmap)
+		return -EOPNOTSUPP;
+	granule = min(target_granule,
+		      1UL << __ffs(dma_domain->pgsize_bitmap));
+
+	for_each_sgtable_dma_sg(sgt, sg, i) {
+		dma_addr_t last_dma;
+		size_t dma_len = sg_dma_len(sg);
+
+		if (sg_dma_is_bus_address(sg))
+			return -EOPNOTSUPP;
+		if (!dma_len || !IS_ALIGNED(sg_dma_address(sg), granule) ||
+		    !IS_ALIGNED(dma_len, granule))
+			return -EOPNOTSUPP;
+		if (check_add_overflow(sg_dma_address(sg), dma_len - 1,
+				       &last_dma) ||
+		    check_add_overflow(total, dma_len, &total))
+			return -EOVERFLOW;
+	}
+	if (!total)
+		return 0;
+	if (total > SSIZE_MAX || !IS_ALIGNED(iova, target_granule) ||
+	    !IS_ALIGNED(total, target_granule))
+		return -EINVAL;
+	if (check_add_overflow(iova, total - 1, &last_iova))
+		return -EOVERFLOW;
+
+	for_each_sgtable_dma_sg(sgt, sg, i) {
+		dma_addr_t dma_addr = sg_dma_address(sg);
+		size_t dma_len = sg_dma_len(sg);
+
+		while (dma_len) {
+			phys_addr_t next;
+			phys_addr_t phys;
+
+			phys = iommu_iova_to_phys(dma_domain, dma_addr);
+			if (!phys || swiotlb_find_pool(dev, phys)) {
+				ret = -EOPNOTSUPP;
+				goto out_err;
+			}
+
+			if (len && check_add_overflow(start, len, &next)) {
+				ret = -EOVERFLOW;
+				goto out_err;
+			}
+			if (len && phys != next) {
+				ret = iommu_map_nosync(domain, iova + mapped,
+						       start, len, prot,
+						       GFP_KERNEL);
+				if (ret)
+					goto out_err;
+				mapped += len;
+				len = 0;
+			}
+			if (!len)
+				start = phys;
+			if (check_add_overflow(len, granule, &len)) {
+				ret = -EOVERFLOW;
+				goto out_err;
+			}
+			dma_addr += granule;
+			dma_len -= granule;
+		}
+	}
+
+	if (len) {
+		ret = iommu_map_nosync(domain, iova + mapped, start, len, prot,
+				       GFP_KERNEL);
+		if (ret)
+			goto out_err;
+		mapped += len;
+	}
+
+	ret = iommu_sync_map(domain, iova, mapped);
+	if (ret)
+		goto out_err;
+
+	return mapped;
+
+out_err:
+	iommu_unmap(domain, iova, mapped);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_map_sgtable_dma);
+
 struct iommu_dma_msi_page {
 	struct list_head	list;
 	dma_addr_t		iova;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ac43b8b93f14..95d90c7f953b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1604,8 +1604,20 @@ static inline void iommu_debugfs_setup(void) {}
 #endif
 
 #ifdef CONFIG_IOMMU_DMA
+ssize_t iommu_map_sgtable_dma(struct iommu_domain *domain, unsigned long iova,
+			      struct device *dev, struct sg_table *sgt,
+			      int prot);
 int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
 #else /* CONFIG_IOMMU_DMA */
+static inline ssize_t iommu_map_sgtable_dma(struct iommu_domain *domain,
+					    unsigned long iova,
+					    struct device *dev,
+					    struct sg_table *sgt,
+					    int prot)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
 {
 	return -ENODEV;
-- 
2.53.0

