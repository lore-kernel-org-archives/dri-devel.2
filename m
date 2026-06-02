Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D3FCD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 10:46:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71C8E10EEC8;
	Tue,  2 Jun 2026 10:46:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EdryZJ5Y";
	dkim-atps=neutral
Received: from out30-110.freemail.mail.aliyun.com
 (out30-110.freemail.mail.aliyun.com [115.124.30.110])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0460710EEC8
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 10:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780397211; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=bNxex+pO0MrYJpvCBggj4Mk1SXXB71J1utBey15cQ0s=;
 b=EdryZJ5Yf8keWfsUIDz5pM1NDPqSwSWl/neeWcMpmg3TE3ixUNILdWluVFh+29NttSlcdOD6+g0a/5Y3+3j3twzS3YDee+45l7tZGWs30ETpGvK4xMmN9LJw39PW+q4gW4p8T0fvGlstIP53ZSfyPxL/AZTII7iJK0GTS1VpOpQ=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam011083073210;
 MF=guanghuifeng@linux.alibaba.com; NM=1; PH=DS; RN=28; SR=0;
 TI=SMTPD_---0X44E92F_1780397208; 
Received: from
 VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com
 fp:SMTPD_---0X44E92F_1780397208 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 02 Jun 2026 18:46:49 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: adrian.larumbe@collabora.com, airlied@gmail.com, alex@shazbot.org,
 baolu.lu@linux.intel.com, boris.brezillon@collabora.com,
 dri-devel@lists.freedesktop.org, dwmw2@infradead.org,
 iommu@lists.linux.dev, jgg@ziepe.ca, joro@8bytes.org, kevin.tian@intel.com,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, liviu.dudau@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 oliver.yang@linux.alibaba.com, robh@kernel.org, robin.murphy@arm.com,
 shiyu.zsq@linux.alibaba.com, steven.price@arm.com,
 suravee.suthikulpanit@amd.com, tzimmermann@suse.de,
 wei.guo.simon@linux.alibaba.com, will@kernel.org, xlpang@linux.alibaba.com
Cc: alikernel-developer@linux.alibaba.com
Subject: [PATCH v2 02/30] iommu/io-pgtable-arm: introduce iova_to_phys_length
 in io_pgtable_ops
Date: Tue,  2 Jun 2026 18:46:09 +0800
Message-ID: <20260602104637.1219810-3-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
References: <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
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

Add iova_to_phys_length to struct io_pgtable_ops alongside iova_to_phys.
Implement in ARM LPAE backend: returns ARM_LPAE_BLOCK_SIZE at the resolved level.
The old iova_to_phys is kept as a thin wrapper for backward compat.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/io-pgtable-arm.c | 23 +++++++++++++++++++++--
 include/linux/io-pgtable.h     |  7 +++++++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 0208e5897c29..f33a86fa0f6c 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -731,8 +731,21 @@ static int visit_iova_to_phys(struct io_pgtable_walk_data *walk_data, int lvl,
 	return 0;
 }
 
+static phys_addr_t arm_lpae_iova_to_phys_length(struct io_pgtable_ops *ops,
+						 unsigned long iova,
+						 size_t *mapped_length);
+
 static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
 					 unsigned long iova)
+{
+	phys_addr_t phys = arm_lpae_iova_to_phys_length(ops, iova, NULL);
+
+	return (phys == PHYS_ADDR_MAX) ? 0 : phys;
+}
+
+static phys_addr_t arm_lpae_iova_to_phys_length(struct io_pgtable_ops *ops,
+						 unsigned long iova,
+						 size_t *mapped_length)
 {
 	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
 	struct iova_to_phys_data d;
@@ -742,13 +755,18 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
 		.addr = iova,
 		.end = iova + 1,
 	};
+	size_t block_size;
 	int ret;
 
 	ret = __arm_lpae_iopte_walk(data, &walk_data, data->pgd, data->start_level);
 	if (ret)
-		return 0;
+		return PHYS_ADDR_MAX;
+
+	block_size = ARM_LPAE_BLOCK_SIZE(d.lvl, data);
+	if (mapped_length)
+		*mapped_length = block_size;
 
-	iova &= (ARM_LPAE_BLOCK_SIZE(d.lvl, data) - 1);
+	iova &= (block_size - 1);
 	return iopte_to_paddr(d.pte, data) | iova;
 }
 
@@ -948,6 +966,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 		.map_pages	= arm_lpae_map_pages,
 		.unmap_pages	= arm_lpae_unmap_pages,
 		.iova_to_phys	= arm_lpae_iova_to_phys,
+		.iova_to_phys_length	= arm_lpae_iova_to_phys_length,
 		.read_and_clear_dirty = arm_lpae_read_and_clear_dirty,
 		.pgtable_walk	= arm_lpae_pgtable_walk,
 	};
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index e19872e37e06..42bcdd309b88 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -203,6 +203,10 @@ struct arm_lpae_io_pgtable_walk_data {
  * @map_pages:    Map a physically contiguous range of pages of the same size.
  * @unmap_pages:  Unmap a range of virtually contiguous pages of the same size.
  * @iova_to_phys: Translate iova to physical address.
+ * @iova_to_phys_length: Translate iova to physical address and return the
+ *			  remaining mapped length from iova to the end of the
+ *			  mapping entry via @mapped_length. If @mapped_length is
+ *			  NULL, only the physical address is returned.
  * @pgtable_walk: (optional) Perform a page table walk for a given iova.
  * @read_and_clear_dirty: Record dirty info per IOVA. If an IOVA is dirty,
  *			  clear its dirty state from the PTE unless the
@@ -220,6 +224,9 @@ struct io_pgtable_ops {
 			      struct iommu_iotlb_gather *gather);
 	phys_addr_t (*iova_to_phys)(struct io_pgtable_ops *ops,
 				    unsigned long iova);
+	phys_addr_t (*iova_to_phys_length)(struct io_pgtable_ops *ops,
+					   unsigned long iova,
+					   size_t *mapped_length);
 	int (*pgtable_walk)(struct io_pgtable_ops *ops, unsigned long iova, void *wd);
 	int (*read_and_clear_dirty)(struct io_pgtable_ops *ops,
 				    unsigned long iova, size_t size,
-- 
2.43.7

