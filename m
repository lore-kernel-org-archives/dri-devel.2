Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6C3606A32E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i6mTklMm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 888BB10E964;
	Mon, 23 Nov 2026 09:00:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E01810EB29
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 09:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795424400; x=1826960400;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=rTlSmiwzBWb3c1hhLuhH+kxfd37ebCQWQotUR90Lbxk=;
 b=i6mTklMmt2STDEEATn/FDkMu8WLNa0qK215eIyl46NBx8OdqwrvC7yL4
 VMlBF5ZEUrs40KUBZVvQnb8CJrAHacSEfFH1jXuZQOomwqhDuPDEC+qP6
 Jcux3worfNhGdUBR+KrGZyX5BP8EGH7nTGBMACoNFb66mh80Fw8B0Uaro
 AoGPii9DGpw36T3PBZVN/NAyYZvahijlDkyyrAk29nGyuzMPjGZe7oyNc
 GLL4LLvb06a3QKC+ifBh9Dx14GbO2MyO/lIOgz8eIO8ZrmiAj2HXziyoQ
 4c9wkpuHh5XzWAgwpH+pE0PnCDM409Uyq64tXtTdkYg+o/ntn6FabT4Ur g==;
X-CSE-ConnectionGUID: Q3Zz0bNLSme/5WBzKuZjiA==
X-CSE-MsgGUID: cr667c6ITOeD2AOihPrzQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4061988"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4061988"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 00:59:44 -0800
X-CSE-ConnectionGUID: WUXiuVL/SIi/otTwbD2ztw==
X-CSE-MsgGUID: CFikCgcWQGStXJV56+SQcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; d="scan'208";a="11343408"
Received: from pl-npu-pc-kwachow.igk.intel.com ([10.91.220.239])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 00:59:42 -0800
From: Karol Wachowski <karol.wachowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: apopple@nvidia.com,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 dawid.osuchowski@linux.intel.com, christian.koenig@amd.com,
 sumit.semwal@linaro.org, Karol Wachowski <karol.wachowski@linux.intel.com>
Subject: [PATCH] accel/ivpu: Allocate a scatterlist per userptr dma-buf mapping
Date: Mon, 23 Nov 2026 09:59:35 +0100
Message-ID: <20261123085935.623564-1-karol.wachowski@linux.intel.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The userptr dma-buf DMA maps the same sg_table on every map_dma_buf(),
so a second mapping would overwrite the DMA addresses of the first one.
It only works today because ivpu is the only importer.

Build a new sg_table from the pinned pages on each map instead.

Fixes: c0b3fef87069 ("accel/ivpu: Add support for userptr buffer objects")
Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
---
Alistair, your DMA-buf mapping types series [1] noted this as a
pre-existing issue in "[PATCH v3 15/24] accel/ivpu: Convert the userptr
exporter to the SGT mapping type" [2]. With this patch applied first,
ivpu becomes an exporter that allocates a table per map, so its
conversion reduces to the same pattern as "[PATCH v3 07/24] dma-buf:
Convert exporters allocating a table per map to the SGT mapping type"
(e.g. amdxdna_ubuf), without the shared header copy.

[1] https://lore.kernel.org/r/20261120-dma_mapping_type_v4-v3-0-c0183a409bdf@nvidia.com
[2] https://lore.kernel.org/r/20261120-dma_mapping_type_v4-v3-15-c0183a409bdf@nvidia.com

 drivers/accel/ivpu/ivpu_gem_userptr.c | 65 ++++++++++++++++-----------
 1 file changed, 38 insertions(+), 27 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_gem_userptr.c b/drivers/accel/ivpu/ivpu_gem_userptr.c
index 7cbf3a4cdc73..cfb2894b572d 100644
--- a/drivers/accel/ivpu/ivpu_gem_userptr.c
+++ b/drivers/accel/ivpu/ivpu_gem_userptr.c
@@ -19,18 +19,39 @@
 #include "ivpu_drv.h"
 #include "ivpu_gem.h"
 
+struct ivpu_userptr {
+	struct page **pages;
+	unsigned long nr_pages;
+};
+
 static struct sg_table *
 ivpu_gem_userptr_dmabuf_map(struct dma_buf_attachment *attachment,
 			    enum dma_data_direction direction)
 {
-	struct sg_table *sgt = attachment->dmabuf->priv;
+	struct ivpu_userptr *userptr = attachment->dmabuf->priv;
+	struct sg_table *sgt;
 	int ret;
 
+	sgt = kmalloc_obj(*sgt);
+	if (!sgt)
+		return ERR_PTR(-ENOMEM);
+
+	ret = sg_alloc_table_from_pages(sgt, userptr->pages, userptr->nr_pages, 0,
+					attachment->dmabuf->size, GFP_KERNEL);
+	if (ret)
+		goto free_sgt;
+
 	ret = dma_map_sgtable(attachment->dev, sgt, direction, DMA_ATTR_SKIP_CPU_SYNC);
 	if (ret)
-		return ERR_PTR(ret);
+		goto free_table;
 
 	return sgt;
+
+free_table:
+	sg_free_table(sgt);
+free_sgt:
+	kfree(sgt);
+	return ERR_PTR(ret);
 }
 
 static void ivpu_gem_userptr_dmabuf_unmap(struct dma_buf_attachment *attachment,
@@ -38,21 +59,17 @@ static void ivpu_gem_userptr_dmabuf_unmap(struct dma_buf_attachment *attachment,
 					  enum dma_data_direction direction)
 {
 	dma_unmap_sgtable(attachment->dev, sgt, direction, DMA_ATTR_SKIP_CPU_SYNC);
+	sg_free_table(sgt);
+	kfree(sgt);
 }
 
 static void ivpu_gem_userptr_dmabuf_release(struct dma_buf *dma_buf)
 {
-	struct sg_table *sgt = dma_buf->priv;
-	struct sg_page_iter page_iter;
-	struct page *page;
-
-	for_each_sgtable_page(sgt, &page_iter, 0) {
-		page = sg_page_iter_page(&page_iter);
-		unpin_user_page(page);
-	}
+	struct ivpu_userptr *userptr = dma_buf->priv;
 
-	sg_free_table(sgt);
-	kfree(sgt);
+	unpin_user_pages(userptr->pages, userptr->nr_pages);
+	kvfree(userptr->pages);
+	kfree(userptr);
 }
 
 static const struct dma_buf_ops ivpu_gem_userptr_dmabuf_ops = {
@@ -67,7 +84,7 @@ ivpu_create_userptr_dmabuf(struct ivpu_device *vdev, void __user *user_ptr,
 {
 	struct dma_buf_export_info exp_info = {};
 	struct dma_buf *dma_buf;
-	struct sg_table *sgt;
+	struct ivpu_userptr *userptr;
 	struct page **pages;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 	unsigned int gup_flags = FOLL_LONGTERM;
@@ -94,39 +111,33 @@ ivpu_create_userptr_dmabuf(struct ivpu_device *vdev, void __user *user_ptr,
 		goto unpin_pages;
 	}
 
-	sgt = kmalloc_obj(*sgt);
-	if (!sgt) {
+	userptr = kmalloc_obj(*userptr);
+	if (!userptr) {
 		ret = -ENOMEM;
 		goto unpin_pages;
 	}
 
-	ret = sg_alloc_table_from_pages(sgt, pages, nr_pages, 0, size, GFP_KERNEL);
-	if (ret) {
-		ivpu_dbg(vdev, IOCTL, "Failed to create sg table: %d\n", ret);
-		goto free_sgt;
-	}
+	userptr->pages = pages;
+	userptr->nr_pages = nr_pages;
 
 	exp_info.exp_name = "ivpu_userptr_dmabuf";
 	exp_info.owner = THIS_MODULE;
 	exp_info.ops = &ivpu_gem_userptr_dmabuf_ops;
 	exp_info.size = size;
 	exp_info.flags = O_RDWR | O_CLOEXEC;
-	exp_info.priv = sgt;
+	exp_info.priv = userptr;
 
 	dma_buf = dma_buf_export(&exp_info);
 	if (IS_ERR(dma_buf)) {
 		ret = PTR_ERR(dma_buf);
 		ivpu_dbg(vdev, IOCTL, "Failed to export userptr dma-buf: %d\n", ret);
-		goto free_sg_table;
+		goto free_userptr;
 	}
 
-	kvfree(pages);
 	return dma_buf;
 
-free_sg_table:
-	sg_free_table(sgt);
-free_sgt:
-	kfree(sgt);
+free_userptr:
+	kfree(userptr);
 unpin_pages:
 	for (i = 0; i < pinned; i++)
 		unpin_user_page(pages[i]);

base-commit: 5ffdc8f8361387a1b11553e5c95cd589c67a51f2
-- 
2.43.0

