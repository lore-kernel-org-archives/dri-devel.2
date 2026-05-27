Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7141ACD5BC9
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 10:24:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D827010E76A;
	Wed, 27 May 2026 10:24:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="Dia3mcFj";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7D0B10E76A
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 10:24:00 +0000 (UTC)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64R6hXB11411431; Wed, 27 May 2026 03:23:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=HWCayHTmA6fkxyKnxbcnh2gOZ+Q9k0y58BUHYwbE5n0=; b=Dia3mcFjV163
 OcGNR2GryCFOoihIVfKz75oVUnzouc2XdsWRMFq5GiJlInIwjXhWUUvHDL+JrmJH
 Fd2LTzy/ZxPENThZe/zL7h/6C8Z2BOU4faMNxBgxMtaytxQnKJxt20dmDN83NnWp
 /f8esMtfhZ5lpiHUwGQXiJGZ8MwdhscC1eHV6Jtp+g3IIy5ThcNedDfSPfwtfcek
 rZiesF9MNSTwlgWHhKfLaeqhE7GeMMqQTOWoYiJMNmrLhc1HZDxkYzw4Oe8hUT6D
 ZsxYG7e7NwFecJAApeCH6HwkKFDLSroC6IJkVPMRQMUTddYeP6KlmApNpmz4JfUe
 DznSY5Hb+g==
Received: from mail.thefacebook.com ([163.114.134.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4edujrgwd1-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 27 May 2026 03:23:49 -0700 (PDT)
Received: from localhost (2620:10d:c085:108::150d) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Wed, 27 May
 2026 10:23:47 +0000
From: Matt Evans <mattev@meta.com>
To: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>
CC: Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>, Sumit Semwal
 <sumit.semwal@linaro.org>, Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal
 <ankita@nvidia.com>, Pranjal Shrivastava <praan@google.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linaro-mm-sig@lists.linaro.org>,
 <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v2 5/9] vfio/pci: Provide a user-facing name for BAR mappings
Date: Wed, 27 May 2026 03:23:08 -0700
Message-ID: <20260527102319.100128-6-mattev@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260527102319.100128-1-mattev@meta.com>
References: <20260527102319.100128-1-mattev@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2620:10d:c085:108::150d]
X-Authority-Analysis: v=2.4 cv=J5OaKgnS c=1 sm=1 tr=0 ts=6a16c635 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=JnKecZnUtZousrUlYMGU:22 a=VabnemYjAAAA:8 a=3OuInECnMAfxEXBjkJUA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: 6pUddGDdSoEMjZBf4ZeaFcYBx7g3t3Dh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDEwMCBTYWx0ZWRfX0loea65+K6Sw
 GKEBO2dOXgp0/ZDJ72MpNPgU8ws8ZnweQEaUk+Cqb7QXjFrL1ZK+6h2uaGjG9Y2DlgEsdnsie+p
 hLszdgNqvw0/GEzy6q7grOHZpMP14U7EseQlpPNyjmcLVrPLB9wA2UBeoCigZX4eVE7Pe1flAUH
 phkitdAu/fT1NV1Scsy9rkNpt1yGMVoEO95uHaVb3ZKkmSnIOnbKdTuzuXQQDIGDZaf3mIi84sZ
 JQZqP1s63DEcedkD1lEURfj9Bs/tyF8C//gg39Cml9s8HWhpweNYGb0DzIve/5JC0ORvBvlx+sm
 LYALuPPMb80RCFaqytg7HOZc2z5hhSZm3UFcIdN22FPY/b9WiO8Ap19+GJ7tpmtItin3h08IF0N
 zzjIzYmX24H0UBUYiUxrPb9D1Hj1F605WL98iaMwO9IE/ux74zVaSHh9isw0j1a+nAMjQfXKRZu
 KWyrtkw8AdlM5fx2ZCg==
X-Proofpoint-ORIG-GUID: 6pUddGDdSoEMjZBf4ZeaFcYBx7g3t3Dh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_01,2026-05-26_03,2025-10-01_01
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

Since converting BAR mmap()s to using DMABUFs, we lose the original
device path in /proc/<pid>/maps, lsof, etc.  Generate a debug-oriented
synthetic 'filename' based on the cdev, plus BDF, plus resource index.

This applies only to BAR mappings via the VFIO device fd, as
explicitly-exported DMABUFs are named by userspace via the
DMA_BUF_SET_NAME ioctl.

Signed-off-by: Matt Evans <mattev@meta.com>
---
 drivers/vfio/pci/vfio_pci_dmabuf.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index f7797f58d44b..733607371082 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -4,6 +4,7 @@
 #include <linux/dma-buf-mapping.h>
 #include <linux/pci-p2pdma.h>
 #include <linux/dma-resv.h>
+#include <uapi/linux/dma-buf.h>
 
 #include "vfio_pci_priv.h"
 
@@ -476,6 +477,7 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
 	struct vfio_pci_dma_buf *priv;
 	const unsigned int nr_ranges = 1;
 	unsigned long vma_pgoff = vma->vm_pgoff & (VFIO_PCI_OFFSET_MASK >> PAGE_SHIFT);
+	char *bufname;
 	int ret;
 
 	priv = kzalloc_obj(*priv);
@@ -488,6 +490,20 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
 		goto err_free_priv;
 	}
 
+	bufname = kzalloc(DMA_BUF_NAME_LEN, GFP_KERNEL);
+	if (!bufname) {
+		ret = -ENOMEM;
+		goto err_free_phys;
+	}
+
+	/*
+	 * Maximum size of the friendly debug name is
+	 * vfio1234567890:ffff:ff:3f.7/5 = 30, which fits within
+	 * DMA_BUF_NAME_LEN.
+	 */
+	snprintf(bufname, DMA_BUF_NAME_LEN, "%s:%s/%x",
+		 dev_name(&vdev->vdev.device), pci_name(vdev->pdev), res_index);
+
 	/*
 	 * The DMABUF begins from the mmap()'s BAR offset, i.e. the
 	 * start of the VMA corresponds to byte 0 of the DMABUF and
@@ -506,7 +522,7 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
 	priv->provider = pcim_p2pdma_provider(vdev->pdev, res_index);
 	if (!priv->provider) {
 		ret = -EINVAL;
-		goto err_free_phys;
+		goto err_free_name;
 	}
 
 	priv->phys_vec[0].paddr = phys_start + ((u64)vma_pgoff << PAGE_SHIFT);
@@ -514,7 +530,7 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
 
 	ret = vfio_pci_dmabuf_export(vdev, priv, O_CLOEXEC | O_RDWR);
 	if (ret)
-		goto err_free_phys;
+		goto err_free_name;
 
 	/*
 	 * The VMA gets the DMABUF file so that other users can locate
@@ -526,8 +542,15 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
 	vma->vm_file = priv->dmabuf->file;
 	vma->vm_private_data = priv;
 
+	spin_lock(&priv->dmabuf->name_lock);
+	kfree(priv->dmabuf->name);
+	priv->dmabuf->name = bufname;
+	spin_unlock(&priv->dmabuf->name_lock);
+
 	return 0;
 
+err_free_name:
+	kfree(bufname);
 err_free_phys:
 	kfree(priv->phys_vec);
 err_free_priv:
-- 
2.47.3

