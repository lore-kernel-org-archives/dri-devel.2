Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0969CD6E57
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 15:19:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32C0A10FFDE;
	Wed,  3 Jun 2026 15:19:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TsknmRJl";
	dkim-atps=neutral
Received: from out30-119.freemail.mail.aliyun.com
 (out30-119.freemail.mail.aliyun.com [115.124.30.119])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FCDB10FFE3
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 15:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780499939; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=8M26HlFHL4LQgXZJUjqBP1yhFIjw3xr29kGlk8DF+os=;
 b=TsknmRJlx1H6dc/s+ttArt6ygZ43a/jVIW51D1PcoVstRNqddZV9fIZLNDudqzU8AdWT9CycxU7X+ZsevpmCTkTw383BWwuS2hX3H+PMvhUWkCqVROca6xnTpa/Q/gTt49WLqDVVOXj2k3NYx9V+5EJli0lN0wzucE+WZPVsCQ8=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037026112;
 MF=guanghuifeng@linux.alibaba.com; NM=1; PH=DS; RN=28; SR=0;
 TI=SMTPD_---0X47fR4V_1780499933; 
Received: from
 VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com
 fp:SMTPD_---0X47fR4V_1780499933 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 03 Jun 2026 23:18:53 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: jgg@ziepe.ca
Cc: adrian.larumbe@collabora.com, airlied@gmail.com, alex@shazbot.org,
 alikernel-developer@linux.alibaba.com, baolu.lu@linux.intel.com,
 boris.brezillon@collabora.com, dri-devel@lists.freedesktop.org,
 dwmw2@infradead.org, iommu@lists.linux.dev, joro@8bytes.org,
 kevin.tian@intel.com, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 oliver.yang@linux.alibaba.com, robh@kernel.org, robin.murphy@arm.com,
 shiyu.zsq@linux.alibaba.com, steven.price@arm.com,
 suravee.suthikulpanit@amd.com, tzimmermann@suse.de,
 wei.guo.simon@linux.alibaba.com, will@kernel.org, xlpang@linux.alibaba.com
Subject: [PATCH v3 15/32] iommu/mtk_v1: implement iova_to_phys_length
Date: Wed,  3 Jun 2026 23:17:47 +0800
Message-ID: <20260603151804.1963871-16-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260603151804.1963871-1-guanghuifeng@linux.alibaba.com>
References: <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
 <20260603151804.1963871-1-guanghuifeng@linux.alibaba.com>
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

Implement iova_to_phys_length for MediaTek v1 IOMMU driver,
returning the actual PTE mapping size.
Also fix pre-existing bug: add page offset to physical address.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/mtk_iommu_v1.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index ac97dd2868d4..da41dda7620b 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -393,7 +393,9 @@ static size_t mtk_iommu_v1_unmap(struct iommu_domain *domain, unsigned long iova
 	return size;
 }
 
-static phys_addr_t mtk_iommu_v1_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
+static phys_addr_t mtk_iommu_v1_iova_to_phys_length(struct iommu_domain *domain,
+						    dma_addr_t iova,
+						    size_t *mapped_length)
 {
 	struct mtk_iommu_v1_domain *dom = to_mtk_domain(domain);
 	unsigned long flags;
@@ -404,6 +406,13 @@ static phys_addr_t mtk_iommu_v1_iova_to_phys(struct iommu_domain *domain, dma_ad
 	pa = pa & (~(MT2701_IOMMU_PAGE_SIZE - 1));
 	spin_unlock_irqrestore(&dom->pgtlock, flags);
 
+	if (!pa)
+		return PHYS_ADDR_MAX;
+
+	pa |= (iova & (MT2701_IOMMU_PAGE_SIZE - 1));
+	if (mapped_length)
+		*mapped_length = MT2701_IOMMU_PAGE_SIZE;
+
 	return pa;
 }
 
@@ -590,7 +599,7 @@ static const struct iommu_ops mtk_iommu_v1_ops = {
 		.attach_dev	= mtk_iommu_v1_attach_device,
 		.map_pages	= mtk_iommu_v1_map,
 		.unmap_pages	= mtk_iommu_v1_unmap,
-		.iova_to_phys	= mtk_iommu_v1_iova_to_phys,
+		.iova_to_phys_length = mtk_iommu_v1_iova_to_phys_length,
 		.free		= mtk_iommu_v1_domain_free,
 	}
 };
-- 
2.43.7

