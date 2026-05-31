Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD144CD6E5E
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 14:00:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 582C3112B86;
	Sun, 31 May 2026 13:59:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SETuCnPl";
	dkim-atps=neutral
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FA3010E5B7
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 09:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780220515; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=kmQF0o5wICayDWeUP6+TxHOXn7wIJf+lrD/CiJCO3J0=;
 b=SETuCnPlsVJBOtEMTZPC24ucU3QpI2AHFNrr9HUzYRjqQdqYjOE/c2cMttlUXzaDcRYxNcydRomN19M8kpg9f8gZHTHjt88CAMASbgTOPF3HdbVDkh/5DMZO31feMw8UiRP22p/n3DfE2vsyl77nE58g8mqVYcnrFOcYBFe8Bf8=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R911e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045098064;
 MF=guanghuifeng@linux.alibaba.com; NM=1; PH=DS; RN=27; SR=0;
 TI=SMTPD_---0X3tRVqJ_1780220212; 
Received: from
 VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com
 fp:SMTPD_---0X3tRVqJ_1780220212 cluster:ay36) by smtp.aliyun-inc.com;
 Sun, 31 May 2026 17:36:52 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: boris.brezillon@collabora.com, robh@kernel.org, steven.price@arm.com,
 adrian.larumbe@collabora.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 liviu.dudau@arm.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, alex@shazbot.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, jgg@ziepe.ca, kevin.tian@intel.com,
 baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com,
 dwmw2@infradead.org
Cc: xlpang@linux.alibaba.com, oliver.yang@linux.alibaba.com,
 shiyu.zsq@linux.alibaba.com, wei.guo.simon@linux.alibaba.com
Subject: [PATCH 6/9] iommu: direct page-table drivers implement
 iova_to_phys_length
Date: Sun, 31 May 2026 17:36:34 +0800
Message-ID: <20260531093637.3893199-7-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
References: <20260529115116.GR2487554@ziepe.ca>
 <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 31 May 2026 13:58:32 +0000
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

Implement iova_to_phys_length for all IOMMU drivers with direct page
tables. Each returns the actual PTE mapping size.

Also fix mtk_iommu_v1 pre-existing bug: add page offset to PA.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Acked-by: Shiqiang Zhang <shiyu.zsq@linux.alibaba.com>
Acked-by: Simon Guo <wei.guo.simon@linux.alibaba.com>
---
 drivers/iommu/exynos-iommu.c    | 21 ++++++++++++++++-----
 drivers/iommu/fsl_pamu_domain.c | 26 +++++++++++++++++++++++---
 drivers/iommu/msm_iommu.c       | 25 +++++++++++++++++++------
 drivers/iommu/mtk_iommu_v1.c    | 15 +++++++++++++--
 drivers/iommu/omap-iommu.c      | 32 +++++++++++++++++++++++---------
 drivers/iommu/rockchip-iommu.c  | 11 ++++++++---
 drivers/iommu/s390-iommu.c      | 15 +++++++++++----
 drivers/iommu/sprd-iommu.c      | 13 ++++++++++---
 drivers/iommu/sun50i-iommu.c    | 13 ++++++++++---
 drivers/iommu/tegra-smmu.c      | 12 +++++++++---
 drivers/iommu/virtio-iommu.c    | 13 ++++++++++---
 11 files changed, 152 insertions(+), 44 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 874d05f4b396..00ab813ed436 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1372,27 +1372,38 @@ static size_t exynos_iommu_unmap(struct iommu_domain *iommu_domain,
 	return 0;
 }
 
-static phys_addr_t exynos_iommu_iova_to_phys(struct iommu_domain *iommu_domain,
-					  dma_addr_t iova)
+static phys_addr_t exynos_iommu_iova_to_phys_length(struct iommu_domain *iommu_domain,
+						 dma_addr_t iova,
+						 size_t *mapped_length)
 {
 	struct exynos_iommu_domain *domain = to_exynos_domain(iommu_domain);
 	sysmmu_pte_t *entry;
 	unsigned long flags;
 	phys_addr_t phys = 0;
 
+	if (mapped_length)
+		*mapped_length = 0;
+
 	spin_lock_irqsave(&domain->pgtablelock, flags);
 
 	entry = section_entry(domain->pgtable, iova);
 
 	if (lv1ent_section(entry)) {
 		phys = section_phys(entry) + section_offs(iova);
+		if (mapped_length)
+			*mapped_length = SECT_SIZE;
 	} else if (lv1ent_page(entry)) {
 		entry = page_entry(entry, iova);
 
-		if (lv2ent_large(entry))
+		if (lv2ent_large(entry)) {
 			phys = lpage_phys(entry) + lpage_offs(iova);
-		else if (lv2ent_small(entry))
+			if (mapped_length)
+				*mapped_length = LPAGE_SIZE;
+		} else if (lv2ent_small(entry)) {
 			phys = spage_phys(entry) + spage_offs(iova);
+			if (mapped_length)
+				*mapped_length = SPAGE_SIZE;
+		}
 	}
 
 	spin_unlock_irqrestore(&domain->pgtablelock, flags);
@@ -1484,7 +1495,7 @@ static const struct iommu_ops exynos_iommu_ops = {
 		.attach_dev	= exynos_iommu_attach_device,
 		.map_pages	= exynos_iommu_map,
 		.unmap_pages	= exynos_iommu_unmap,
-		.iova_to_phys	= exynos_iommu_iova_to_phys,
+		.iova_to_phys_length	= exynos_iommu_iova_to_phys_length,
 		.free		= exynos_iommu_domain_free,
 	}
 };
diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 9664ef9840d2..48a072074b56 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -169,12 +169,32 @@ static void attach_device(struct fsl_dma_domain *dma_domain, int liodn, struct d
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 }
 
-static phys_addr_t fsl_pamu_iova_to_phys(struct iommu_domain *domain,
-					 dma_addr_t iova)
+static phys_addr_t fsl_pamu_iova_to_phys_length(struct iommu_domain *domain,
+						dma_addr_t iova,
+						size_t *mapped_length)
 {
+	if (mapped_length)
+		*mapped_length = 0;
+
 	if (iova < domain->geometry.aperture_start ||
 	    iova > domain->geometry.aperture_end)
 		return 0;
+
+	/*
+	 * PAMU configures exactly one Primary PAACE entry per LIODN with the
+	 * Multi-Window (MW) bit cleared and ATM = PAACE_ATM_WINDOW_XLATE,
+	 * WBAL/TWBAL = 0. That is, every LIODN is backed by a single hardware
+	 * mapping window of fixed size (1ULL << 36, i.e. 64GB, see
+	 * pamu_config_ppaace()) performing an identity translation. The driver
+	 * does not split this window into SPAACE sub-windows, so the entire
+	 * aperture is one PAACE "PTE" entry. Return that single entry's size
+	 * as mapped_length, matching the iova_to_phys_length contract that
+	 * mapped_length reports the full size of the mapping entry which
+	 * covers iova (not the remaining bytes from iova to its end).
+	 */
+	if (mapped_length)
+		*mapped_length = 1ULL << 36;
+
 	return iova;
 }
 
@@ -435,7 +455,7 @@ static const struct iommu_ops fsl_pamu_ops = {
 	.device_group   = fsl_pamu_device_group,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= fsl_pamu_attach_device,
-		.iova_to_phys	= fsl_pamu_iova_to_phys,
+		.iova_to_phys_length	= fsl_pamu_iova_to_phys_length,
 		.free		= fsl_pamu_domain_free,
 	}
 };
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 0ad5ff431d5b..f36fdbf8076f 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -523,8 +523,9 @@ static size_t msm_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 	return ret;
 }
 
-static phys_addr_t msm_iommu_iova_to_phys(struct iommu_domain *domain,
-					  dma_addr_t va)
+static phys_addr_t msm_iommu_iova_to_phys_length(struct iommu_domain *domain,
+						 dma_addr_t va,
+						 size_t *mapped_length)
 {
 	struct msm_priv *priv;
 	struct msm_iommu_dev *iommu;
@@ -533,6 +534,9 @@ static phys_addr_t msm_iommu_iova_to_phys(struct iommu_domain *domain,
 	unsigned long flags;
 	phys_addr_t ret = 0;
 
+	if (mapped_length)
+		*mapped_length = 0;
+
 	spin_lock_irqsave(&msm_iommu_lock, flags);
 
 	priv = to_msm_priv(domain);
@@ -558,13 +562,22 @@ static phys_addr_t msm_iommu_iova_to_phys(struct iommu_domain *domain,
 	par = GET_PAR(iommu->base, master->num);
 
 	/* We are dealing with a supersection */
-	if (GET_NOFAULT_SS(iommu->base, master->num))
+	if (GET_NOFAULT_SS(iommu->base, master->num)) {
 		ret = (par & 0xFF000000) | (va & 0x00FFFFFF);
-	else	/* Upper 20 bits from PAR, lower 12 from VA */
+		if (mapped_length)
+			*mapped_length = SZ_16M;
+	} else {
+		/* Upper 20 bits from PAR, lower 12 from VA */
 		ret = (par & 0xFFFFF000) | (va & 0x00000FFF);
+		if (mapped_length)
+			*mapped_length = SZ_4K;
+	}
 
-	if (GET_FAULT(iommu->base, master->num))
+	if (GET_FAULT(iommu->base, master->num)) {
 		ret = 0;
+		if (mapped_length)
+			*mapped_length = 0;
+	}
 
 	__disable_clocks(iommu);
 fail:
@@ -706,7 +719,7 @@ static struct iommu_ops msm_iommu_ops = {
 		 */
 		.iotlb_sync	= NULL,
 		.iotlb_sync_map	= msm_iommu_sync_map,
-		.iova_to_phys	= msm_iommu_iova_to_phys,
+		.iova_to_phys_length	= msm_iommu_iova_to_phys_length,
 		.free		= msm_iommu_domain_free,
 	}
 };
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index ac97dd2868d4..a451de7d669e 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -393,17 +393,28 @@ static size_t mtk_iommu_v1_unmap(struct iommu_domain *domain, unsigned long iova
 	return size;
 }
 
-static phys_addr_t mtk_iommu_v1_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
+static phys_addr_t mtk_iommu_v1_iova_to_phys_length(struct iommu_domain *domain,
+						    dma_addr_t iova,
+						    size_t *mapped_length)
 {
 	struct mtk_iommu_v1_domain *dom = to_mtk_domain(domain);
 	unsigned long flags;
 	phys_addr_t pa;
 
+	if (mapped_length)
+		*mapped_length = 0;
+
 	spin_lock_irqsave(&dom->pgtlock, flags);
 	pa = *(dom->pgt_va + (iova >> MT2701_IOMMU_PAGE_SHIFT));
 	pa = pa & (~(MT2701_IOMMU_PAGE_SIZE - 1));
 	spin_unlock_irqrestore(&dom->pgtlock, flags);
 
+	if (pa) {
+		pa |= (iova & (MT2701_IOMMU_PAGE_SIZE - 1));
+		if (mapped_length)
+			*mapped_length = MT2701_IOMMU_PAGE_SIZE;
+	}
+
 	return pa;
 }
 
@@ -590,7 +601,7 @@ static const struct iommu_ops mtk_iommu_v1_ops = {
 		.attach_dev	= mtk_iommu_v1_attach_device,
 		.map_pages	= mtk_iommu_v1_map,
 		.unmap_pages	= mtk_iommu_v1_unmap,
-		.iova_to_phys	= mtk_iommu_v1_iova_to_phys,
+		.iova_to_phys_length = mtk_iommu_v1_iova_to_phys_length,
 		.free		= mtk_iommu_v1_domain_free,
 	}
 };
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 8231d7d6bb6a..91daa69decc9 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1592,8 +1592,9 @@ static void omap_iommu_domain_free(struct iommu_domain *domain)
 	kfree(omap_domain);
 }
 
-static phys_addr_t omap_iommu_iova_to_phys(struct iommu_domain *domain,
-					   dma_addr_t da)
+static phys_addr_t omap_iommu_iova_to_phys_length(struct iommu_domain *domain,
+						  dma_addr_t da,
+						  size_t *mapped_length)
 {
 	struct omap_iommu_domain *omap_domain = to_omap_domain(domain);
 	struct omap_iommu_device *iommu = omap_domain->iommus;
@@ -1602,6 +1603,9 @@ static phys_addr_t omap_iommu_iova_to_phys(struct iommu_domain *domain,
 	u32 *pgd, *pte;
 	phys_addr_t ret = 0;
 
+	if (mapped_length)
+		*mapped_length = 0;
+
 	/*
 	 * all the iommus within the domain will have identical programming,
 	 * so perform the lookup using just the first iommu
@@ -1609,21 +1613,31 @@ static phys_addr_t omap_iommu_iova_to_phys(struct iommu_domain *domain,
 	iopgtable_lookup_entry(oiommu, da, &pgd, &pte);
 
 	if (pte) {
-		if (iopte_is_small(*pte))
+		if (iopte_is_small(*pte)) {
 			ret = omap_iommu_translate(*pte, da, IOPTE_MASK);
-		else if (iopte_is_large(*pte))
+			if (ret && mapped_length)
+				*mapped_length = IOPTE_SIZE;
+		} else if (iopte_is_large(*pte)) {
 			ret = omap_iommu_translate(*pte, da, IOLARGE_MASK);
-		else
+			if (ret && mapped_length)
+				*mapped_length = IOLARGE_SIZE;
+		} else {
 			dev_err(dev, "bogus pte 0x%x, da 0x%llx", *pte,
 				(unsigned long long)da);
+		}
 	} else {
-		if (iopgd_is_section(*pgd))
+		if (iopgd_is_section(*pgd)) {
 			ret = omap_iommu_translate(*pgd, da, IOSECTION_MASK);
-		else if (iopgd_is_super(*pgd))
+			if (ret && mapped_length)
+				*mapped_length = IOSECTION_SIZE;
+		} else if (iopgd_is_super(*pgd)) {
 			ret = omap_iommu_translate(*pgd, da, IOSUPER_MASK);
-		else
+			if (ret && mapped_length)
+				*mapped_length = IOSUPER_SIZE;
+		} else {
 			dev_err(dev, "bogus pgd 0x%x, da 0x%llx", *pgd,
 				(unsigned long long)da);
+		}
 	}
 
 	return ret;
@@ -1723,7 +1737,7 @@ static const struct iommu_ops omap_iommu_ops = {
 		.attach_dev	= omap_iommu_attach_dev,
 		.map_pages	= omap_iommu_map,
 		.unmap_pages	= omap_iommu_unmap,
-		.iova_to_phys	= omap_iommu_iova_to_phys,
+		.iova_to_phys_length	= omap_iommu_iova_to_phys_length,
 		.free		= omap_iommu_domain_free,
 	}
 };
diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 0013cf196c57..dad3ff38fe2c 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -648,8 +648,8 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
 	return ret;
 }
 
-static phys_addr_t rk_iommu_iova_to_phys(struct iommu_domain *domain,
-					 dma_addr_t iova)
+static phys_addr_t rk_iommu_iova_to_phys_length(struct iommu_domain *domain,
+					 dma_addr_t iova, size_t *mapped_length)
 {
 	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
 	unsigned long flags;
@@ -657,6 +657,9 @@ static phys_addr_t rk_iommu_iova_to_phys(struct iommu_domain *domain,
 	u32 dte, pte;
 	u32 *page_table;
 
+	if (mapped_length)
+		*mapped_length = 0;
+
 	spin_lock_irqsave(&rk_domain->dt_lock, flags);
 
 	dte = rk_domain->dt[rk_iova_dte_index(iova)];
@@ -670,6 +673,8 @@ static phys_addr_t rk_iommu_iova_to_phys(struct iommu_domain *domain,
 		goto out;
 
 	phys = rk_ops->pt_address(pte) + rk_iova_page_offset(iova);
+	if (mapped_length)
+		*mapped_length = SPAGE_SIZE;
 out:
 	spin_unlock_irqrestore(&rk_domain->dt_lock, flags);
 
@@ -1187,7 +1192,7 @@ static const struct iommu_ops rk_iommu_ops = {
 		.attach_dev	= rk_iommu_attach_device,
 		.map_pages	= rk_iommu_map,
 		.unmap_pages	= rk_iommu_unmap,
-		.iova_to_phys	= rk_iommu_iova_to_phys,
+		.iova_to_phys_length = rk_iommu_iova_to_phys_length,
 		.free		= rk_iommu_domain_free,
 	}
 };
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index f148f559ac56..8df98aceb5f7 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -986,8 +986,9 @@ static unsigned long *get_rto_from_iova(struct s390_domain *domain,
 	}
 }
 
-static phys_addr_t s390_iommu_iova_to_phys(struct iommu_domain *domain,
-					   dma_addr_t iova)
+static phys_addr_t s390_iommu_iova_to_phys_length(struct iommu_domain *domain,
+						  dma_addr_t iova,
+						  size_t *mapped_length)
 {
 	struct s390_domain *s390_domain = to_s390_domain(domain);
 	unsigned long *rto, *sto, *pto;
@@ -995,6 +996,9 @@ static phys_addr_t s390_iommu_iova_to_phys(struct iommu_domain *domain,
 	unsigned int rtx, sx, px;
 	phys_addr_t phys = 0;
 
+	if (mapped_length)
+		*mapped_length = 0;
+
 	if (iova < domain->geometry.aperture_start ||
 	    iova > domain->geometry.aperture_end)
 		return 0;
@@ -1014,8 +1018,11 @@ static phys_addr_t s390_iommu_iova_to_phys(struct iommu_domain *domain,
 		if (reg_entry_isvalid(ste)) {
 			pto = get_st_pto(ste);
 			pte = READ_ONCE(pto[px]);
-			if (pt_entry_isvalid(pte))
+			if (pt_entry_isvalid(pte)) {
 				phys = pte & ZPCI_PTE_ADDR_MASK;
+				if (mapped_length)
+					*mapped_length = SZ_4K;
+			}
 		}
 	}
 
@@ -1183,7 +1190,7 @@ static struct iommu_domain blocking_domain = {
 		.flush_iotlb_all = s390_iommu_flush_iotlb_all, \
 		.iotlb_sync      = s390_iommu_iotlb_sync, \
 		.iotlb_sync_map  = s390_iommu_iotlb_sync_map, \
-		.iova_to_phys	= s390_iommu_iova_to_phys, \
+		.iova_to_phys_length	= s390_iommu_iova_to_phys_length, \
 		.free		= s390_domain_free, \
 	}
 
diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index c1a34445d244..da14574a6430 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -366,8 +366,9 @@ static void sprd_iommu_sync(struct iommu_domain *domain,
 	sprd_iommu_sync_map(domain, 0, 0);
 }
 
-static phys_addr_t sprd_iommu_iova_to_phys(struct iommu_domain *domain,
-					   dma_addr_t iova)
+static phys_addr_t sprd_iommu_iova_to_phys_length(struct iommu_domain *domain,
+						  dma_addr_t iova,
+						  size_t *mapped_length)
 {
 	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
 	unsigned long flags;
@@ -375,6 +376,9 @@ static phys_addr_t sprd_iommu_iova_to_phys(struct iommu_domain *domain,
 	unsigned long start = domain->geometry.aperture_start;
 	unsigned long end = domain->geometry.aperture_end;
 
+	if (mapped_length)
+		*mapped_length = 0;
+
 	if (WARN_ON(iova < start || iova > end))
 		return 0;
 
@@ -383,6 +387,9 @@ static phys_addr_t sprd_iommu_iova_to_phys(struct iommu_domain *domain,
 	pa = (pa << SPRD_IOMMU_PAGE_SHIFT) + ((iova - start) & (SPRD_IOMMU_PAGE_SIZE - 1));
 	spin_unlock_irqrestore(&dom->pgtlock, flags);
 
+	if (pa && mapped_length)
+		*mapped_length = SPRD_IOMMU_PAGE_SIZE;
+
 	return pa;
 }
 
@@ -420,7 +427,7 @@ static const struct iommu_ops sprd_iommu_ops = {
 		.unmap_pages	= sprd_iommu_unmap,
 		.iotlb_sync_map	= sprd_iommu_sync_map,
 		.iotlb_sync	= sprd_iommu_sync,
-		.iova_to_phys	= sprd_iommu_iova_to_phys,
+		.iova_to_phys_length	= sprd_iommu_iova_to_phys_length,
 		.free		= sprd_iommu_domain_free,
 	}
 };
diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index be3f1ce696ba..66c354baaca1 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -659,14 +659,18 @@ static size_t sun50i_iommu_unmap(struct iommu_domain *domain, unsigned long iova
 	return SZ_4K;
 }
 
-static phys_addr_t sun50i_iommu_iova_to_phys(struct iommu_domain *domain,
-					     dma_addr_t iova)
+static phys_addr_t sun50i_iommu_iova_to_phys_length(struct iommu_domain *domain,
+						    dma_addr_t iova,
+						    size_t *mapped_length)
 {
 	struct sun50i_iommu_domain *sun50i_domain = to_sun50i_domain(domain);
 	phys_addr_t pt_phys;
 	u32 *page_table;
 	u32 dte, pte;
 
+	if (mapped_length)
+		*mapped_length = 0;
+
 	dte = sun50i_domain->dt[sun50i_iova_get_dte_index(iova)];
 	if (!sun50i_dte_is_pt_valid(dte))
 		return 0;
@@ -677,6 +681,9 @@ static phys_addr_t sun50i_iommu_iova_to_phys(struct iommu_domain *domain,
 	if (!sun50i_pte_is_page_valid(pte))
 		return 0;
 
+	if (mapped_length)
+		*mapped_length = SZ_4K;
+
 	return sun50i_pte_get_page_address(pte) +
 		sun50i_iova_get_page_offset(iova);
 }
@@ -857,7 +864,7 @@ static const struct iommu_ops sun50i_iommu_ops = {
 		.flush_iotlb_all = sun50i_iommu_flush_iotlb_all,
 		.iotlb_sync_map = sun50i_iommu_iotlb_sync_map,
 		.iotlb_sync	= sun50i_iommu_iotlb_sync,
-		.iova_to_phys	= sun50i_iommu_iova_to_phys,
+		.iova_to_phys_length	= sun50i_iommu_iova_to_phys_length,
 		.map_pages	= sun50i_iommu_map,
 		.unmap_pages	= sun50i_iommu_unmap,
 		.free		= sun50i_iommu_domain_free,
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 67e7a7b925f0..c2545d577fdc 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -803,20 +803,26 @@ static size_t tegra_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
 	return size;
 }
 
-static phys_addr_t tegra_smmu_iova_to_phys(struct iommu_domain *domain,
-					   dma_addr_t iova)
+static phys_addr_t tegra_smmu_iova_to_phys_length(struct iommu_domain *domain,
+					   dma_addr_t iova, size_t *mapped_length)
 {
 	struct tegra_smmu_as *as = to_smmu_as(domain);
 	unsigned long pfn;
 	dma_addr_t pte_dma;
 	u32 *pte;
 
+	if (mapped_length)
+		*mapped_length = 0;
+
 	pte = tegra_smmu_pte_lookup(as, iova, &pte_dma);
 	if (!pte || !*pte)
 		return 0;
 
 	pfn = *pte & as->smmu->pfn_mask;
 
+	if (mapped_length)
+		*mapped_length = SZ_4K;
+
 	return SMMU_PFN_PHYS(pfn) + SMMU_OFFSET_IN_PAGE(iova);
 }
 
@@ -1007,7 +1013,7 @@ static const struct iommu_ops tegra_smmu_ops = {
 		.attach_dev	= tegra_smmu_attach_dev,
 		.map_pages	= tegra_smmu_map,
 		.unmap_pages	= tegra_smmu_unmap,
-		.iova_to_phys	= tegra_smmu_iova_to_phys,
+		.iova_to_phys_length = tegra_smmu_iova_to_phys_length,
 		.free		= tegra_smmu_domain_free,
 	}
 };
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 587fc13197f1..80c9c06a1380 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -912,8 +912,9 @@ static size_t viommu_unmap_pages(struct iommu_domain *domain, unsigned long iova
 	return ret ? 0 : unmapped;
 }
 
-static phys_addr_t viommu_iova_to_phys(struct iommu_domain *domain,
-				       dma_addr_t iova)
+static phys_addr_t viommu_iova_to_phys_length(struct iommu_domain *domain,
+					      dma_addr_t iova,
+					      size_t *mapped_length)
 {
 	u64 paddr = 0;
 	unsigned long flags;
@@ -921,11 +922,17 @@ static phys_addr_t viommu_iova_to_phys(struct iommu_domain *domain,
 	struct interval_tree_node *node;
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
 
+	if (mapped_length)
+		*mapped_length = 0;
+
 	spin_lock_irqsave(&vdomain->mappings_lock, flags);
 	node = interval_tree_iter_first(&vdomain->mappings, iova, iova);
 	if (node) {
 		mapping = container_of(node, struct viommu_mapping, iova);
 		paddr = mapping->paddr + (iova - mapping->iova.start);
+		if (mapped_length)
+			*mapped_length = mapping->iova.last -
+					 mapping->iova.start + 1;
 	}
 	spin_unlock_irqrestore(&vdomain->mappings_lock, flags);
 
@@ -1102,7 +1109,7 @@ static const struct iommu_ops viommu_ops = {
 		.attach_dev		= viommu_attach_dev,
 		.map_pages		= viommu_map_pages,
 		.unmap_pages		= viommu_unmap_pages,
-		.iova_to_phys		= viommu_iova_to_phys,
+		.iova_to_phys_length	= viommu_iova_to_phys_length,
 		.flush_iotlb_all	= viommu_flush_iotlb_all,
 		.iotlb_sync		= viommu_iotlb_sync,
 		.iotlb_sync_map		= viommu_iotlb_sync_map,
-- 
2.43.7

