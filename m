Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20D1CD6E57
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 15:18:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D219610FFF5;
	Wed,  3 Jun 2026 15:18:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="c9wDNKVy";
	dkim-atps=neutral
Received: from out30-110.freemail.mail.aliyun.com
 (out30-110.freemail.mail.aliyun.com [115.124.30.110])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06BF210FFD4
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 15:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780499924; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=5K9kQ+7O2to9AMrCCxHb12XQWSw4xjjz1YrQKtCPM08=;
 b=c9wDNKVyh6CUp50BD1q43dV2vGm9+vjuQod3i5xEQ7UuVXL+7fVS787uSqpSpXjWfUGO0GyHXPuozT300VndBfxM2oh6AY+SauiX/jPVya6YXR/aHjdByi1Za46iXWPyyVnGZ9BhvxSwMU3hUjgUA59OO7IShh0KbLSzcFtwNAQ=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037009110;
 MF=guanghuifeng@linux.alibaba.com; NM=1; PH=DS; RN=28; SR=0;
 TI=SMTPD_---0X47fR1m_1780499922; 
Received: from
 VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com
 fp:SMTPD_---0X47fR1m_1780499922 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 03 Jun 2026 23:18:42 +0800
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
Subject: [PATCH v3 04/32] iommu/io-pgtable-dart: introduce iova_to_phys_length
 in io_pgtable_ops
Date: Wed,  3 Jun 2026 23:17:36 +0800
Message-ID: <20260603151804.1963871-5-guanghuifeng@linux.alibaba.com>
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

Implement iova_to_phys_length in DART backend: returns pgsize from
cfg.pgsize_bitmap (single fixed page size). The old iova_to_phys is kept
as a thin wrapper.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/io-pgtable-dart.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/io-pgtable-dart.c b/drivers/iommu/io-pgtable-dart.c
index cbc5d6aa2daa..2dac21a578a7 100644
--- a/drivers/iommu/io-pgtable-dart.c
+++ b/drivers/iommu/io-pgtable-dart.c
@@ -333,29 +333,46 @@ static size_t dart_unmap_pages(struct io_pgtable_ops *ops, unsigned long iova,
 	return i * pgsize;
 }
 
+static phys_addr_t dart_iova_to_phys_length(struct io_pgtable_ops *ops,
+					    unsigned long iova,
+					    size_t *mapped_length);
+
 static phys_addr_t dart_iova_to_phys(struct io_pgtable_ops *ops,
-					 unsigned long iova)
+				     unsigned long iova)
+{
+	phys_addr_t phys = dart_iova_to_phys_length(ops, iova, NULL);
+
+	return (phys == PHYS_ADDR_MAX) ? 0 : phys;
+}
+
+static phys_addr_t dart_iova_to_phys_length(struct io_pgtable_ops *ops,
+					    unsigned long iova,
+					    size_t *mapped_length)
 {
 	struct dart_io_pgtable *data = io_pgtable_ops_to_data(ops);
 	dart_iopte pte, *ptep;
+	size_t pgsize;
 
 	ptep = dart_get_last(data, iova);
 
 	/* Valid L2 IOPTE pointer? */
 	if (!ptep)
-		return 0;
+		return PHYS_ADDR_MAX;
 
 	ptep += dart_get_last_index(data, iova);
 
 	pte = READ_ONCE(*ptep);
 	/* Found translation */
 	if (pte) {
-		iova &= (data->iop.cfg.pgsize_bitmap - 1);
+		pgsize = data->iop.cfg.pgsize_bitmap;
+		if (mapped_length)
+			*mapped_length = pgsize;
+		iova &= (pgsize - 1);
 		return iopte_to_paddr(pte, data) | iova;
 	}
 
 	/* Ran out of page tables to walk */
-	return 0;
+	return PHYS_ADDR_MAX;
 }
 
 static struct dart_io_pgtable *
@@ -397,9 +414,10 @@ dart_alloc_pgtable(struct io_pgtable_cfg *cfg)
 	data->bits_per_level = bits_per_level;
 
 	data->iop.ops = (struct io_pgtable_ops) {
-		.map_pages	= dart_map_pages,
-		.unmap_pages	= dart_unmap_pages,
-		.iova_to_phys	= dart_iova_to_phys,
+		.map_pages		= dart_map_pages,
+		.unmap_pages		= dart_unmap_pages,
+		.iova_to_phys		= dart_iova_to_phys,
+		.iova_to_phys_length	= dart_iova_to_phys_length,
 	};
 
 	return data;
-- 
2.43.7

