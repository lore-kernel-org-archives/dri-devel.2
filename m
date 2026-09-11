Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A59CAC88E53
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 21:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09B1010E40F;
	Fri, 11 Sep 2026 21:42:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="n7LFis2S";
	dkim-atps=neutral
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75A3610E40F
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 21:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
 s=201707; t=1789162941;
 bh=wYX7sVfn/jIz1d7rDgCW0XYymt2OtnurD+VDcymRpr8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=n7LFis2SsWkUCJW1yKDHL4Wg0hhLZP0y0HPKpyW6YHDTVXU6XLA0RzinMrO4SMxpQ
 mONMqWpSlcq+W+/znn3IO6Neb+FBuVZpmAQU2z2mx2BkFZhox7stS/FK6T6D8M0s8G
 EkxLjXgkJ/2QydoJ9N69IWzBynZomr+SvXWw3fkyuOIvpWiri3qhWlyoDLRNwQgY4T
 gAVEhElvyOhdTodh+wnukUjWmorGRj/nRE9oRL+wxllOcMvZ602Ko1YRM+tHR0imVi
 29zfnJe7NdC+UowFP6OBW+YbDdb9fVdhNAoEy4TWhc3AVlmIv3XcQQd5t8kFif9vMz
 +3WfildXmPU8Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4hhSgc2dD7z4wbr;
 Sat, 12 Sep 2026 07:42:19 +1000 (AEST)
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
Subject: [PATCH v6 4/9] vfio/pci: Add a helper to look up PFNs for DMABUFs
Date: Fri, 11 Sep 2026 22:41:52 +0100
Message-ID: <20260911214200.33793-5-matt@ozlabs.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260911214200.33793-1-matt@ozlabs.org>
References: <20260911214200.33793-1-matt@ozlabs.org>
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

Add vfio_pci_dma_buf_find_pfn(), which a VMA fault handler can use to
find a PFN.

This supports multi-range DMABUFs, which typically would be used to
represent scattered spans but might even represent overlapping or
aliasing spans of PFNs.

Because this is intended to be used in vfio_pci_core.c, we also need
to expose the struct vfio_pci_dma_buf in the vfio_pci_priv.h header.

This move also adds a new member, vma_pgoff_adjust; this is consumed
by vfio_pci_dma_buf_find_pfn(), but will be set in a future commit.
Add it now to reduce the number of functions touched by later commits.

Signed-off-by: Matt Evans <matt@ozlabs.org>
---
 drivers/vfio/pci/vfio_pci_dmabuf.c | 166 ++++++++++++++++++++++++++---
 drivers/vfio/pci/vfio_pci_priv.h   |  21 ++++
 2 files changed, 174 insertions(+), 13 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index 847ee5cc78e7..9f10b10fc436 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -9,19 +9,6 @@
 
 MODULE_IMPORT_NS("DMA_BUF");
 
-struct vfio_pci_dma_buf {
-	struct dma_buf *dmabuf;
-	struct vfio_pci_core_device *vdev;
-	struct list_head dmabufs_elm;
-	size_t size;
-	struct phys_vec *phys_vec;
-	struct p2pdma_provider *provider;
-	u32 nr_ranges;
-	struct kref kref;
-	struct completion comp;
-	u8 revoked : 1;
-};
-
 static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
 				   struct dma_buf_attachment *attachment)
 {
@@ -106,6 +93,159 @@ static const struct dma_buf_ops vfio_pci_dmabuf_ops = {
 	.release = vfio_pci_dma_buf_release,
 };
 
+int vfio_pci_dma_buf_find_pfn(struct vfio_pci_core_device *vdev,
+			      struct vfio_pci_dma_buf *priv,
+			      struct vm_area_struct *vma,
+			      unsigned long fault_addr,
+			      unsigned int order,
+			      unsigned long *out_pfn)
+{
+	/*
+	 * Given a VMA (start, end, pgoffs) and a fault address,
+	 * search the corresponding DMABUF's phys_vec[] to find the
+	 * range representing the address's offset into the VMA, and
+	 * its PFN.  vdev must be the device that the DMABUF priv was
+	 * exported from; vdev->dmabuf_lock must be held, and priv
+	 * must not be revoked.
+	 *
+	 * The phys_vec[] ranges represent contiguous spans of VAs
+	 * upwards from the buffer offset 0; the actual PFNs might be
+	 * in any order, overlap/alias, etc.  Calculate an offset of
+	 * the desired page given VMA start/pgoff and address, then
+	 * search upwards from 0 to find which span contains it.
+	 *
+	 * On success, a valid PFN for a page sized by 'order' is
+	 * returned into out_pfn.
+	 *
+	 * Failure occurs if:
+	 * - A hugepage would cross the edge of the VMA,
+	 * - A hugepage isn't entirely contained within a range
+	 *   (including where it straddles the boundary between
+	 *   ranges),
+	 * - We find a range, but the final PFN isn't aligned to the
+	 *   requested order.
+	 *
+	 * Upon failure, -ERANGE is returned and the caller is
+	 * expected to try again with a smaller order, which will
+	 * eventually succeed.
+	 *
+	 * It's suboptimal if DMABUFs are created with neighbouring
+	 * ranges that are physically contiguous, since hugepages
+	 * can't straddle range boundaries.  (The construction of the
+	 * ranges should merge them in this case.)
+	 *
+	 * Finally, vma_pgoff_adjust is used with a DMABUF created for
+	 * a VFIO BAR mmap: a BAR mapped with vm_pgoff > 0 creates a
+	 * DMABUF such that byte 0 of the VMA corresponds to byte 0 of
+	 * the DMABUF and byte 'vm_pgoff << PAGE_SHIFT' into the BAR.
+	 * To avoid double-offsetting in this scenario, subtracting
+	 * vma_pgoff_adjust from this (non-zero) vm_pgoff generates
+	 * the effective offset.  This also removes the VFIO region
+	 * index encoded in vm_pgoff for VFIO BAR mmaps.
+	 */
+
+	const unsigned long pagesize = PAGE_SIZE << order;
+	unsigned long vma_off = (vma->vm_pgoff - priv->vma_pgoff_adjust) <<
+				 PAGE_SHIFT;
+	unsigned long rounded_page_addr = ALIGN_DOWN(fault_addr, pagesize);
+	unsigned long rounded_page_end = rounded_page_addr + pagesize;
+	unsigned long fault_offset;
+	unsigned long fault_offset_end;
+	unsigned long range_start_offset = 0;
+	unsigned int i;
+	int ret;
+
+	if (unlikely(!vdev))
+		return -ENODEV;
+
+	/* This prevents the dmabuf revocation state from changing under us */
+	lockdep_assert_held(&vdev->dmabuf_lock);
+
+	if (unlikely(priv->vdev != vdev || priv->revoked))
+		return -ENODEV;
+
+	if (rounded_page_addr < vma->vm_start || rounded_page_end > vma->vm_end) {
+		if (order > 0)
+			return -ERANGE;
+
+		/* A fault address outside of the VMA is absurd. */
+		dev_warn_ratelimited(
+			&vdev->pdev->dev,
+			"Fault addr 0x%lx outside VMA 0x%lx-0x%lx\n",
+			fault_addr, vma->vm_start, vma->vm_end);
+		return -EFAULT;
+	}
+
+	/*
+	 * fault_offset[_end] is the span within the DMABUF
+	 * corresponding to the faulting page:
+	 */
+	if (unlikely(check_add_overflow(rounded_page_addr - vma->vm_start,
+					vma_off, &fault_offset) ||
+		     check_add_overflow(fault_offset, pagesize,
+					&fault_offset_end)))
+		return -EFAULT;
+
+	/*
+	 * Iterate over ranges in the buffer, summing their lengths:
+	 * range_start_offset represents the current range's starting
+	 * offset in the buffer (from 0 upwards).
+	 *
+	 * A failure for order == 0 is unexpected, and triggers a
+	 * fault/warn.
+	 */
+	ret = (order == 0) ? -EFAULT : -ERANGE;
+
+	for (i = 0; i < priv->nr_ranges; i++) {
+		size_t range_len = priv->phys_vec[i].len;
+
+		/* Early exit if range starts after the page end */
+		if (fault_offset_end <= range_start_offset)
+			break;
+
+		if (fault_offset >= range_start_offset &&
+		    fault_offset_end <= range_start_offset + range_len) {
+			/*
+			 * The faulting page is wholly contained
+			 * within the span represented by this range,
+			 * so validate PFN alignment for the order.
+			 * The if() condition ensures the pfn
+			 * arithmetic won't overflow.
+			 */
+			unsigned long pfn =
+				((fault_offset - range_start_offset) +
+				 priv->phys_vec[i].paddr) >> PAGE_SHIFT;
+
+			if (IS_ALIGNED(pfn, 1 << order)) {
+				*out_pfn = pfn;
+				ret = 0;
+			}
+			/*
+			 * Else order > 0; ERANGE retries with smaller
+			 * order
+			 */
+			break;
+		}
+		range_start_offset += range_len;
+	}
+
+	if (order == 0 && ret != 0)
+		/*
+		 * The address fell outside of the span represented by
+		 * the (concatenated) ranges.  As setup of a mapping
+		 * ensures that the VMA is <= the total size of the
+		 * ranges this should never happen.  If it does, warn
+		 * and SIGBUS.
+		 */
+		dev_warn_ratelimited(
+			&vdev->pdev->dev,
+			"No range for addr 0x%lx, order %d: VMA 0x%lx-0x%lx pgoff 0x%lx, %u ranges, size 0x%zx\n",
+			fault_addr, order, vma->vm_start, vma->vm_end,
+			vma->vm_pgoff, priv->nr_ranges, priv->size);
+
+	return ret;
+}
+
 /*
  * This is a temporary "private interconnect" between VFIO DMABUF and iommufd.
  * It allows the two co-operating drivers to exchange the physical address of
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index fca9d0dfac90..48d9f574a3df 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -23,6 +23,20 @@ struct vfio_pci_ioeventfd {
 	bool			test_mem;
 };
 
+struct vfio_pci_dma_buf {
+	struct dma_buf *dmabuf;
+	struct vfio_pci_core_device *vdev;
+	struct list_head dmabufs_elm;
+	size_t size;
+	struct phys_vec *phys_vec;
+	struct p2pdma_provider *provider;
+	u32 nr_ranges;
+	struct kref kref;
+	struct completion comp;
+	unsigned long vma_pgoff_adjust;
+	u8 revoked : 1;
+};
+
 bool vfio_pci_intx_mask(struct vfio_pci_core_device *vdev);
 void vfio_pci_intx_unmask(struct vfio_pci_core_device *vdev);
 
@@ -114,6 +128,13 @@ static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
 	return (pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA;
 }
 
+int vfio_pci_dma_buf_find_pfn(struct vfio_pci_core_device *vdev,
+			      struct vfio_pci_dma_buf *priv,
+			      struct vm_area_struct *vma,
+			      unsigned long address,
+			      unsigned int order,
+			      unsigned long *out_pfn);
+
 #ifdef CONFIG_VFIO_PCI_DMABUF
 int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 				  struct vfio_device_feature_dma_buf __user *arg,
-- 
2.50.1 (Apple Git-155)

