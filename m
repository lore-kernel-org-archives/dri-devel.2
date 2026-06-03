Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23DFCD6E6C
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 15:19:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F91810FFE2;
	Wed,  3 Jun 2026 15:19:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pAaxJILa";
	dkim-atps=neutral
Received: from out30-111.freemail.mail.aliyun.com
 (out30-111.freemail.mail.aliyun.com [115.124.30.111])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9EB310FFED
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 15:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780499949; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=YeBRD/MSt6wsGVdzvt9zKUavpOowrxOrf9yWTOinoZY=;
 b=pAaxJILarWhzgNQrBVSgPEFodchyKdfpgMuboq7jRq8to8tMdmem+yfow8Mxq7uJ8qxkGVJlrHMMHDTII3RKZbf+twbNdEImZH5saRTxXPwguIBx9Y67dM4vR3TDE39otmB8Gqprq8yLaOpXbtrjlW7Ffv2QbT9HnZG+acMONt8=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R951e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045133197;
 MF=guanghuifeng@linux.alibaba.com; NM=1; PH=DS; RN=28; SR=0;
 TI=SMTPD_---0X47fR6h_1780499941; 
Received: from
 VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com
 fp:SMTPD_---0X47fR6h_1780499941 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 03 Jun 2026 23:19:01 +0800
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
Subject: [PATCH v3 23/32] vfio: use iova_to_phys_length for efficient unmap
Date: Wed,  3 Jun 2026 23:17:55 +0800
Message-ID: <20260603151804.1963871-24-guanghuifeng@linux.alibaba.com>
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

Use iommu_iova_to_phys_length() to get PTE page size, allowing
traversal by actual mapping granularity instead of PAGE_SIZE steps.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Acked-by: Shiqiang Zhang <shiyu.zsq@linux.alibaba.com>
Acked-by: Simon Guo <wei.guo.simon@linux.alibaba.com>
---
 drivers/vfio/vfio_iommu_type1.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index c8151ba54de3..115d88d7003e 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1177,25 +1177,42 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
 
 	iommu_iotlb_gather_init(&iotlb_gather);
 	while (pos < dma->size) {
-		size_t unmapped, len;
+		size_t unmapped, len, pgsize;
 		phys_addr_t phys, next;
 		dma_addr_t iova = dma->iova + pos;
 
-		phys = iommu_iova_to_phys(domain->domain, iova);
-		if (WARN_ON(!phys)) {
+		/* Single page table walk returns both phys and PTE size */
+		phys = iommu_iova_to_phys_length(domain->domain, iova,
+						  &pgsize);
+		if (WARN_ON(phys == PHYS_ADDR_MAX)) {
 			pos += PAGE_SIZE;
 			continue;
 		}
+		if (WARN_ON(!pgsize || pgsize < PAGE_SIZE))
+			pgsize = PAGE_SIZE;
 
 		/*
 		 * To optimize for fewer iommu_unmap() calls, each of which
 		 * may require hardware cache flushing, try to find the
 		 * largest contiguous physical memory chunk to unmap.
+		 *
+		 * mapped_length already accounts for contiguous entries
+		 * from iova, then try to join following physically
+		 * contiguous PTEs.
 		 */
-		for (len = PAGE_SIZE; pos + len < dma->size; len += PAGE_SIZE) {
-			next = iommu_iova_to_phys(domain->domain, iova + len);
+		len = min_t(size_t, pgsize, dma->size - pos);
+		for (; pos + len < dma->size; ) {
+			size_t next_pgsize;
+
+			next = iommu_iova_to_phys_length(domain->domain,
+							  iova + len,
+							  &next_pgsize);
 			if (next != phys + len)
 				break;
+			if (WARN_ON(!next_pgsize || next_pgsize < PAGE_SIZE))
+				next_pgsize = PAGE_SIZE;
+			len += min_t(size_t, next_pgsize,
+				     dma->size - pos - len);
 		}
 
 		/*
-- 
2.43.7

