Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0AACF8E49D
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 07:06:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4684910E965;
	Fri, 17 Apr 2026 07:06:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="fgKuowTf";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3295110E1E7
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 13:19:05 +0000 (UTC)
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63GDClxn292577; Thu, 16 Apr 2026 06:18:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=OnXpacRUCWVmj2ZhEhbENFViXZJLK6k7he2hDqU0XWA=; b=fgKuowTfbhMc
 LpD6qO8c8yeBGBeIuAN712xR/ZRGjstUM7BrwY/5k7kWAfKarMPtnsx5R52+WMfk
 69BEruQpJbj/30yDaTt0XB52tbIGNLgz7CNAvsZkMeNh8+qryBSDCKYNLapa76VW
 2FDAb/s9iwN+60V98bPHo5x9nQVMIj1W++67kQ4NNIs8qUWykeIn+qJfd9GD2pxg
 0LLf32QaC3zYOrjwNqvXO3RNH0Y0bfLRgtMoeNQuySGS+mYnaRN/sDGM786SJAxu
 dfvouwvFsogFBqgu7bpMxuFYt8V95Nu3HbXJIbUxUIg21YsqP0he7VP/0pTPv+8J
 cxXt1OafpQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dh84tt06k-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Thu, 16 Apr 2026 06:18:55 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:fe::f072) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.37; Thu, 16 Apr
 2026 13:18:54 +0000
From: Matt Evans <mattev@meta.com>
To: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
CC: Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>, Sumit Semwal
 <sumit.semwal@linaro.org>, Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal
 <ankita@nvidia.com>, Pranjal Shrivastava <praan@google.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linaro-mm-sig@lists.linaro.org>,
 <kvm@vger.kernel.org>
Subject: [PATCH 9/9] vfio/pci: Add mmap() attributes to DMABUF feature
Date: Thu, 16 Apr 2026 06:17:52 -0700
Message-ID: <20260416131815.2729131-10-mattev@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260416131815.2729131-1-mattev@meta.com>
References: <20260416131815.2729131-1-mattev@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2620:10d:c0a8:fe::f072]
X-Authority-Analysis: v=2.4 cv=DeknbPtW c=1 sm=1 tr=0 ts=69e0e1bf cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=GbPsI2Ihf5RTnMjR_gZv:22 a=VabnemYjAAAA:8 a=ZZip-zt6qTTd7FoaoeoA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDEyNiBTYWx0ZWRfX+tFyEUII+htx
 zqwYV0dvl9D+Yw505382/FK3ILPMyAC418PRnZqUDx+oll9uXnun/Z+BrsRoSzzs2WlaYS2W9dh
 gt2K/IopaUAFYYMziA/d9FPa/C9LQH5wdyC0sSi3ntjiA4/s8UbH9ERH7uM2Z9bWNkPZgFbQvI0
 Kxb4/vjYaXCqT4Qjs0npsBl8qcX/6PFfOdd/xZYLSqfx/2Dmzs3VR2hTBgWd3WEF4oE6swai/Bi
 8MsxvROtCG+xdthlcWrgCmCWhQZSdHVRyj+pv3d9KJyFJ/0U8N1DBSht0fL8TJc51Y4b29jrb8a
 F1thlt0Jz/aIP8oEaiHLYBfPcBJYCE7ov0bI6WZ8NQ5ImrzE3dwRhUjt0qpD2pjStgYI00w5Slv
 JSX088HrUF78v9dWd/U7btiZexNZHznyZF/KvPghTxYTWW2/3klJC9VdG34NbNq488M5weruVde
 mtD87JYknNYlzwyZOxw==
X-Proofpoint-GUID: G5a8D1fswKo3D1yySENReTX4evzXtV9I
X-Proofpoint-ORIG-GUID: G5a8D1fswKo3D1yySENReTX4evzXtV9I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_02,2025-10-01_01
X-Mailman-Approved-At: Fri, 17 Apr 2026 07:06:15 +0000
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

A new field is reserved in vfio_device_feature_dma_buf.flags to
request CPU-facing memory type attributes for mmap()s of the buffer.
Add a flag VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_WC, which results in WC
PTEs for the DMABUF's BAR region.

Signed-off-by: Matt Evans <mattev@meta.com>
---
 drivers/vfio/pci/vfio_pci_dmabuf.c | 15 +++++++++++++--
 drivers/vfio/pci/vfio_pci_priv.h   |  1 +
 include/uapi/linux/vfio.h          | 12 +++++++++---
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index 48ec4da2db8b..00cedfe3a57d 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -43,7 +43,10 @@ static int vfio_pci_dma_buf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *
 	if (req_start + req_len > priv->size)
 		return -EINVAL;
 
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	if (priv->attrs == VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_WC)
+		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+	else
+		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
 
 	/* See comments in vfio_pci_core_mmap() re VM_ALLOW_ANY_UNCACHED. */
@@ -370,6 +373,12 @@ static int validate_dmabuf_input(struct vfio_device_feature_dma_buf *dma_buf,
 	size_t length = 0;
 	u32 i;
 
+	if ((dma_buf->flags != 0) &&
+	    ((dma_buf->flags & ~VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_MASK) ||
+	     ((dma_buf->flags & VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_MASK) !=
+	      VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_WC)))
+		return -EINVAL;
+
 	for (i = 0; i < dma_buf->nr_ranges; i++) {
 		u64 offset = dma_ranges[i].offset;
 		u64 len = dma_ranges[i].length;
@@ -413,7 +422,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 	if (copy_from_user(&get_dma_buf, arg, sizeof(get_dma_buf)))
 		return -EFAULT;
 
-	if (!get_dma_buf.nr_ranges || get_dma_buf.flags)
+	if (!get_dma_buf.nr_ranges)
 		return -EINVAL;
 
 	/*
@@ -457,6 +466,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 	priv->vdev = vdev;
 	priv->nr_ranges = get_dma_buf.nr_ranges;
 	priv->size = length;
+	priv->attrs = get_dma_buf.flags & VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_MASK;
 	ret = vdev->pci_ops->get_dmabuf_phys(vdev, &priv->provider,
 					     get_dma_buf.region_index,
 					     priv->phys_vec, dma_ranges,
@@ -542,6 +552,7 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
 	 */
 	priv->vdev = vdev;
 	priv->nr_ranges = nr_ranges;
+	priv->attrs = 0;
 	priv->size = (vma->vm_pgoff << PAGE_SHIFT) + req_len;
 	priv->provider = pcim_p2pdma_provider(vdev->pdev, res_index);
 	if (!priv->provider) {
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index eac5606ca161..aeffd9f7f3b5 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -40,6 +40,7 @@ struct vfio_pci_dma_buf {
 	u32 nr_ranges;
 	struct kref kref;
 	struct completion comp;
+	u32 attrs;
 	enum vfio_pci_dma_buf_status status;
 };
 
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 77225ed8115f..93eef95dc7f3 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1535,7 +1535,9 @@ struct vfio_device_feature_bus_master {
  * etc. offset/length specify a slice of the region to create the dmabuf from.
  * nr_ranges is the total number of (P2P DMA) ranges that comprise the dmabuf.
  *
- * flags should be 0.
+ * flags contains:
+ * - A field for userspace mapping attribute: by default, suitable for regular
+ *   MMIO. Alternate attributes (such as WC) can be selected.
  *
  * Return: The fd number on success, -1 and errno is set on failure.
  */
@@ -1549,8 +1551,12 @@ struct vfio_region_dma_range {
 struct vfio_device_feature_dma_buf {
 	__u32	region_index;
 	__u32	open_flags;
-	__u32   flags;
-	__u32   nr_ranges;
+	__u32	flags;
+	/* Flags sub-field reserved for attribute enum */
+#define VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_MASK		(0xfU << 28)
+#define VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_UC		(0 << 28)
+#define VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_WC		(1 << 28)
+	__u32	nr_ranges;
 	struct vfio_region_dma_range dma_ranges[] __counted_by(nr_ranges);
 };
 
-- 
2.47.3

