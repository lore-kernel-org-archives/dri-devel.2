Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E3EC9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:22:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D43010F658;
	Thu, 24 Sep 2026 15:22:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="dQoBAIHy";
	dkim-atps=neutral
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A62CF10F656
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 15:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
 s=201707; t=1790263339;
 bh=LAyOPh0+5DSd9RRdLTI2XnNlhdTHBFCpe8W4FwHJugQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dQoBAIHycFGcDBe0onCTOPzHGEtVtCErP4Q+nADp6zl3c0c6lhY+VYN1pIu5SaoPR
 EsVQixyZiyWMdVhE2LVNVB2ZR12PqChnwIhuxEPP+r3Ch4hhhGGWFCL7KnNmRFra2T
 7+80DCrgDJTZPsntoN/2gujpMwGYCpqLDUx5nOH0Fn4/RjGSjgkScleRPktkWrn+Zt
 e+fseS++OCJHo+W05hvkX86C2zCSM7GBE15KNy9Xjz06tCwO49Th1XkEgV97E0FUJ9
 XU4RnZt0palF6cb3EhsrDI+qYvj1GnMTbOdu2qZG6H6w8sSWhWSAfu5/y8obdne9XF
 gJ8KG21lbqzSQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4hrHd618nkz4wFP;
 Fri, 25 Sep 2026 01:22:17 +1000 (AEST)
From: Matt Evans <matt@ozlabs.org>
To: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Kevin Tian <kevin.tian@intel.com>, Pranjal Shrivastava <praan@google.com>,
 Longfang Liu <liulongfang@huawei.com>
Cc: Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
Subject: [PATCH v7 6/9] vfio/pci: Convert BAR mmap() to use a DMABUF
Date: Thu, 24 Sep 2026 16:21:49 +0100
Message-ID: <20260924152159.49702-7-matt@ozlabs.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260924152159.49702-1-matt@ozlabs.org>
References: <20260924152159.49702-1-matt@ozlabs.org>
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

Convert the VFIO device fd fops->mmap to create a DMABUF representing
the BAR mapping, and make the VMA fault handler look up PFNs from the
corresponding DMABUF.  This supports future code mmap()ing BAR
DMABUFs, and iommufd work to support Type1 P2P.

First, vfio_pci_core_mmap() uses the new
vfio_pci_core_mmap_prep_dmabuf() helper to export a DMABUF
representing a single BAR range.  Then, the vfio_pci_mmap_huge_fault()
callback is updated to understand revoked buffers, and uses the new
vfio_pci_dma_buf_find_pfn() helper to determine the PFN for a given
fault address.

Now that the VFIO DMABUFs can be mmap()ed, vfio_pci_dma_buf_move()
zaps PTEs (used on the revocation and cleanup paths).

CONFIG_VFIO_PCI_CORE now unconditionally selects
CONFIG_DMA_SHARED_BUFFER.  The CONFIG_VFIO_PCI_DMABUF feature
conditionally includes support for VFIO_DEVICE_FEATURE_DMA_BUF,
depending on the availability of CONFIG_PCI_P2PDMA.

When the DMABUF feature is not present, DMABUFs are used internally
for the BAR mappings.  In this case, DMABUF attach is prohibited (and
the requirement for a P2PDMA provider is relaxed).

Signed-off-by: Matt Evans <matt@ozlabs.org>
---
 drivers/vfio/pci/Kconfig           |  4 +-
 drivers/vfio/pci/Makefile          |  3 +-
 drivers/vfio/pci/vfio_pci_core.c   | 71 ++++++++++++++++++------------
 drivers/vfio/pci/vfio_pci_dmabuf.c | 24 +++++++++-
 drivers/vfio/pci/vfio_pci_priv.h   | 11 +----
 5 files changed, 73 insertions(+), 40 deletions(-)

diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
index 296bf01e185e..c6d6fb09af86 100644
--- a/drivers/vfio/pci/Kconfig
+++ b/drivers/vfio/pci/Kconfig
@@ -6,6 +6,7 @@ config VFIO_PCI_CORE
 	tristate
 	select VFIO_VIRQFD
 	select IRQ_BYPASS_MANAGER
+	select DMA_SHARED_BUFFER
 
 config VFIO_PCI_INTX
 	def_bool y if !S390
@@ -56,7 +57,8 @@ config VFIO_PCI_ZDEV_KVM
 	  To enable s390x KVM vfio-pci extensions, say Y.
 
 config VFIO_PCI_DMABUF
-	def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUFFER
+	def_bool y if PCI_P2PDMA
+	depends on VFIO_PCI_CORE
 
 source "drivers/vfio/pci/mlx5/Kconfig"
 
diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
index 6138f1bf241d..881452ea89be 100644
--- a/drivers/vfio/pci/Makefile
+++ b/drivers/vfio/pci/Makefile
@@ -1,8 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-vfio-pci-core-y := vfio_pci_core.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
+vfio-pci-core-y := vfio_pci_core.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o vfio_pci_dmabuf.o
 vfio-pci-core-$(CONFIG_VFIO_PCI_ZDEV_KVM) += vfio_pci_zdev.o
-vfio-pci-core-$(CONFIG_VFIO_PCI_DMABUF) += vfio_pci_dmabuf.o
 obj-$(CONFIG_VFIO_PCI_CORE) += vfio-pci-core.o
 
 vfio-pci-y := vfio_pci.o
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index e170cdc7ac92..cb0e4865d110 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1748,18 +1748,6 @@ void vfio_pci_memory_unlock_and_restore(struct vfio_pci_core_device *vdev, u16 c
 	up_write(&vdev->memory_lock);
 }
 
-static unsigned long vma_to_pfn(struct vm_area_struct *vma)
-{
-	struct vfio_pci_core_device *vdev = vma->vm_private_data;
-	int index = vma->vm_pgoff >> (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT);
-	u64 pgoff;
-
-	pgoff = vma->vm_pgoff &
-		((1U << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
-
-	return (pci_resource_start(vdev->pdev, index) >> PAGE_SHIFT) + pgoff;
-}
-
 vm_fault_t vfio_pci_vmf_insert_pfn(struct vfio_pci_core_device *vdev,
 				   struct vm_fault *vmf,
 				   unsigned long pfn,
@@ -1787,23 +1775,46 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
 					   unsigned int order)
 {
 	struct vm_area_struct *vma = vmf->vma;
-	struct vfio_pci_core_device *vdev = vma->vm_private_data;
-	unsigned long addr = vmf->address & ~((PAGE_SIZE << order) - 1);
-	unsigned long pgoff = linear_page_delta(vma, addr);
-	unsigned long pfn = vma_to_pfn(vma) + pgoff;
-	vm_fault_t ret = VM_FAULT_FALLBACK;
-
-	if (is_aligned_for_order(vma, addr, pfn, order)) {
-		scoped_guard(rwsem_read, &vdev->memory_lock)
-			ret = vfio_pci_vmf_insert_pfn(vdev, vmf, pfn, order);
+	struct vfio_pci_dma_buf *priv = vma->vm_private_data;
+	struct vfio_pci_core_device *vdev;
+	unsigned long pfn = 0;
+	vm_fault_t ret = VM_FAULT_SIGBUS;
+
+	/*
+	 * We can rely on the existence of both a DMABUF (priv) and
+	 * the VFIO device it was exported from (vdev).  This fault's
+	 * VMA was established using vfio_pci_core_mmap_prep_dmabuf()
+	 * which transfers ownership of the VFIO device fd to the
+	 * DMABUF, and so the VFIO device is held open because the
+	 * VMA's vm_file (DMABUF) is open.
+	 *
+	 * Since vfio_pci_dma_buf_cleanup() cannot have happened,
+	 * vdev must be valid; we can take vdev locks.
+	 */
+	vdev = priv->vdev;
+
+	/* memory_lock for vfio_pci_vmf_insert_pfn() */
+	down_read(&vdev->memory_lock);
+	/* Test revocation status under dmabuf_lock */
+	down_read(&vdev->dmabuf_lock);
+	if (!priv->revoked) {
+		int pres = vfio_pci_dma_buf_find_pfn(vdev, priv, vma,
+						     vmf->address,
+						     order, &pfn);
+
+		if (pres == 0)
+			ret = vfio_pci_vmf_insert_pfn(vdev, vmf,
+						      pfn, order);
+		else if (pres == -ERANGE)
+			ret = VM_FAULT_FALLBACK;
 	}
+	up_read(&vdev->dmabuf_lock);
+	up_read(&vdev->memory_lock);
 
 	dev_dbg_ratelimited(&vdev->pdev->dev,
-			   "%s(,order = %d) BAR %ld page offset 0x%lx: 0x%x\n",
-			    __func__, order,
-			    vma->vm_pgoff >>
-				(VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT),
-			    pgoff, (unsigned int)ret);
+			    "%s(order = %d) PFN 0x%lx, VA 0x%lx, pgoff 0x%lx: 0x%x\n",
+			    __func__, order, pfn, vmf->address,
+			    vma->vm_pgoff, (unsigned int)ret);
 
 	return ret;
 }
@@ -1828,6 +1839,7 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
 	unsigned int index;
 	u64 phys_len, req_len, pgoff, req_start;
 	void __iomem *bar_io;
+	int ret;
 
 	index = vma->vm_pgoff >> (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT);
 
@@ -1867,7 +1879,12 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
 	if (IS_ERR(bar_io))
 		return PTR_ERR(bar_io);
 
-	vma->vm_private_data = vdev;
+	ret = vfio_pci_core_mmap_prep_dmabuf(vdev, vma,
+					     pci_resource_start(pdev, index),
+					     req_len, index);
+	if (ret)
+		return ret;
+
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
 
diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index fd3ee2f5c5e8..617afb7de00f 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -10,6 +10,7 @@
 
 MODULE_IMPORT_NS("DMA_BUF");
 
+#ifdef CONFIG_VFIO_PCI_DMABUF
 static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
 				   struct dma_buf_attachment *attachment)
 {
@@ -26,6 +27,18 @@ static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
 
 	return 0;
 }
+#else
+static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
+				   struct dma_buf_attachment *attachment)
+{
+	/*
+	 * Explicit export can't occur without the DMABUF feature, but
+	 * DMABUFs are implicitly created for BAR mappings.  An
+	 * .attach that fails prevents dma_buf_attach().
+	 */
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_VFIO_PCI_DMABUF */
 
 static void vfio_pci_dma_buf_done(struct kref *kref)
 {
@@ -364,8 +377,13 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
 	priv->nr_ranges = 1;
 	priv->vma_pgoff_adjust = vma->vm_pgoff;
 
+	/*
+	 * The provider can be NULL _iff_ the DMABUF feature isn't
+	 * supported, because it's only used by DMABUF import and
+	 * attach is prohibited if the feature isn't present.
+	 */
 	priv->provider = pcim_p2pdma_provider(vdev->pdev, res_index);
-	if (!priv->provider) {
+	if (IS_ENABLED(CONFIG_VFIO_PCI_DMABUF) && !priv->provider) {
 		ret = -EINVAL;
 		goto err_free_name;
 	}
@@ -408,6 +426,7 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
 	return ret;
 }
 
+#ifdef CONFIG_VFIO_PCI_DMABUF
 /*
  * This is a temporary "private interconnect" between VFIO DMABUF and iommufd.
  * It allows the two co-operating drivers to exchange the physical address of
@@ -606,6 +625,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 	kfree(dma_ranges);
 	return ret;
 }
+#endif /* CONFIG_VFIO_PCI_DMABUF */
 
 void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
 {
@@ -632,6 +652,8 @@ void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
 			if (revoked) {
 				kref_put(&priv->kref, vfio_pci_dma_buf_done);
 				wait_for_completion(&priv->comp);
+				unmap_mapping_range(priv->dmabuf->file->f_mapping,
+						    0, 0, true);
 				/*
 				 * Re-arm the registered kref reference and the
 				 * completion so the post-revoke state matches the
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 66a5ae19082d..ef6aabb9f5a4 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -148,13 +148,13 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
 				   struct vm_area_struct *vma,
 				   u64 phys_start, u64 req_len,
 				   unsigned int res_index);
+void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev);
+void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked);
 
 #ifdef CONFIG_VFIO_PCI_DMABUF
 int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 				  struct vfio_device_feature_dma_buf __user *arg,
 				  size_t argsz);
-void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev);
-void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked);
 #else
 static inline int
 vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
@@ -163,13 +163,6 @@ vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 {
 	return -ENOTTY;
 }
-static inline void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev)
-{
-}
-static inline void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev,
-					 bool revoked)
-{
-}
 #endif
 
 #endif
-- 
2.50.1 (Apple Git-155)

