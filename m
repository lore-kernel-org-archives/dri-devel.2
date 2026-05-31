Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C1DCD6E61
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 13:58:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AEB710E4AF;
	Sun, 31 May 2026 13:58:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RsUlA8Wu";
	dkim-atps=neutral
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAE1310E5B7
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 09:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780220517; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=9GYfPp1sU1WLVHRudSCocbfBnHaSnI+DlgtBGa8tOy0=;
 b=RsUlA8Wu7vuY6UL/XseYcPYeVLFNoiyQsb2MkyKzAF+BdUg9HG//AtwrvSrwt7wOAwMTX5N2VYZWrgeonGbqY22aDml/D1+a/GAwTZH4XiT2O2O6h02vJ/NQvx0ldxf5yW/i9lWTngCyC8IAq5oDfLXRltxke874fKGtkeGc1GA=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032089153;
 MF=guanghuifeng@linux.alibaba.com; NM=1; PH=DS; RN=27; SR=0;
 TI=SMTPD_---0X3tRVqi_1780220213; 
Received: from
 VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com
 fp:SMTPD_---0X3tRVqi_1780220213 cluster:ay36) by smtp.aliyun-inc.com;
 Sun, 31 May 2026 17:36:53 +0800
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
Subject: [PATCH 7/9] vfio/iommufd: use iova_to_phys_length for efficient unmap
Date: Sun, 31 May 2026 17:36:35 +0800
Message-ID: <20260531093637.3893199-8-guanghuifeng@linux.alibaba.com>
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

Use iommu_iova_to_phys_length() to get PTE page size, allowing
traversal by actual mapping granularity instead of PAGE_SIZE steps.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Acked-by: Shiqiang Zhang <shiyu.zsq@linux.alibaba.com>
Acked-by: Simon Guo <wei.guo.simon@linux.alibaba.com>
---
 drivers/iommu/iommufd/pages.c    | 71 ++++++++++++++++++++++++++------
 drivers/iommu/iommufd/selftest.c |  2 +-
 drivers/vfio/vfio_iommu_type1.c  | 24 +++++++++--
 3 files changed, 80 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 9bdb2945afe1..d67e564035b4 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -417,17 +417,42 @@ static void batch_from_domain(struct pfn_batch *batch,
 	if (start_index == iopt_area_index(area))
 		page_offset = area->page_offset;
 	while (start_index <= last_index) {
+		size_t pgsize;
+		unsigned long npages;
+		unsigned long i;
+
 		/*
-		 * This is pretty slow, it would be nice to get the page size
-		 * back from the driver, or have the driver directly fill the
-		 * batch.
+		 * Use iova_to_phys_length to get both the physical address
+		 * and the PTE page size in a single page table walk, allowing
+		 * us to skip ahead by the contiguous region size instead of
+		 * walking the page tables for every PAGE_SIZE step.
 		 */
-		phys = iommu_iova_to_phys(domain, iova) - page_offset;
-		if (!batch_add_pfn(batch, PHYS_PFN(phys)))
-			return;
-		iova += PAGE_SIZE - page_offset;
+		phys = iommu_iova_to_phys_length(domain, iova, &pgsize) -
+		       page_offset;
+		if (!pgsize || pgsize < PAGE_SIZE)
+			pgsize = PAGE_SIZE;
+
+		/*
+		 * Calculate contiguous pages within this PTE from our
+		 * position. phys points to the page-aligned start (backed
+		 * up by page_offset), so pages available = bytes from phys
+		 * to PTE end divided by PAGE_SIZE.
+		 */
+		npages = (pgsize - (iova & (pgsize - 1)) + page_offset) /
+			 PAGE_SIZE;
+		npages = min_t(unsigned long, npages,
+			       last_index - start_index + 1);
+		if (!npages)
+			npages = 1;
+
+		for (i = 0; i < npages; i++) {
+			if (!batch_add_pfn(batch, PHYS_PFN(phys) + i))
+				return;
+		}
+
+		iova += npages * PAGE_SIZE - page_offset;
 		page_offset = 0;
-		start_index++;
+		start_index += npages;
 	}
 }
 
@@ -445,11 +470,33 @@ static struct page **raw_pages_from_domain(struct iommu_domain *domain,
 	if (start_index == iopt_area_index(area))
 		page_offset = area->page_offset;
 	while (start_index <= last_index) {
-		phys = iommu_iova_to_phys(domain, iova) - page_offset;
-		*(out_pages++) = pfn_to_page(PHYS_PFN(phys));
-		iova += PAGE_SIZE - page_offset;
+		size_t pgsize;
+		unsigned long npages;
+		unsigned long i;
+
+		/*
+		 * Resolve the PTE page size together with the physical
+		 * address so we can fill multiple struct page pointers per
+		 * page table walk when the IOMMU uses large pages.
+		 */
+		phys = iommu_iova_to_phys_length(domain, iova, &pgsize) -
+		       page_offset;
+		if (!pgsize || pgsize < PAGE_SIZE)
+			pgsize = PAGE_SIZE;
+
+		npages = (pgsize - (iova & (pgsize - 1)) + page_offset) /
+			 PAGE_SIZE;
+		npages = min_t(unsigned long, npages,
+			       last_index - start_index + 1);
+		if (!npages)
+			npages = 1;
+
+		for (i = 0; i < npages; i++)
+			*(out_pages++) = pfn_to_page(PHYS_PFN(phys) + i);
+
+		iova += npages * PAGE_SIZE - page_offset;
 		page_offset = 0;
-		start_index++;
+		start_index += npages;
 	}
 	return out_pages;
 }
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index af07c642a526..4b9c3ffc9523 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -1214,7 +1214,7 @@ static int iommufd_test_md_check_pa(struct iommufd_ucmd *ucmd,
 		pfn = page_to_pfn(pages[0]);
 		put_page(pages[0]);
 
-		io_phys = mock->domain.ops->iova_to_phys(&mock->domain, iova);
+		io_phys = iommu_iova_to_phys(&mock->domain, iova);
 		if (io_phys !=
 		    pfn * PAGE_SIZE + ((uintptr_t)uptr % PAGE_SIZE)) {
 			rc = -EINVAL;
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index c8151ba54de3..393f9e8f1511 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -1177,25 +1177,41 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
 
 	iommu_iotlb_gather_init(&iotlb_gather);
 	while (pos < dma->size) {
-		size_t unmapped, len;
+		size_t unmapped, len, pgsize;
 		phys_addr_t phys, next;
 		dma_addr_t iova = dma->iova + pos;
 
-		phys = iommu_iova_to_phys(domain->domain, iova);
+		/* Single page table walk returns both phys and PTE size */
+		phys = iommu_iova_to_phys_length(domain->domain, iova,
+						  &pgsize);
 		if (WARN_ON(!phys)) {
 			pos += PAGE_SIZE;
 			continue;
 		}
+		if (!pgsize || pgsize < PAGE_SIZE)
+			pgsize = PAGE_SIZE;
 
 		/*
 		 * To optimize for fewer iommu_unmap() calls, each of which
 		 * may require hardware cache flushing, try to find the
 		 * largest contiguous physical memory chunk to unmap.
+		 *
+		 * Calculate remaining contiguous bytes within this PTE from
+		 * our position, then try to join following physically
+		 * contiguous PTEs.
 		 */
-		for (len = PAGE_SIZE; pos + len < dma->size; len += PAGE_SIZE) {
-			next = iommu_iova_to_phys(domain->domain, iova + len);
+		len = pgsize - (iova & (pgsize - 1));
+		for (; pos + len < dma->size; ) {
+			size_t next_pgsize;
+
+			next = iommu_iova_to_phys_length(domain->domain,
+							  iova + len,
+							  &next_pgsize);
 			if (next != phys + len)
 				break;
+			if (!next_pgsize || next_pgsize < PAGE_SIZE)
+				next_pgsize = PAGE_SIZE;
+			len += next_pgsize;
 		}
 
 		/*
-- 
2.43.7

