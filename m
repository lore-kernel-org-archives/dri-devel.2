Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8469F8E4B4
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 07:06:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E748710E969;
	Fri, 17 Apr 2026 07:06:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="NXqox/Fq";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3C4D10E1D7
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 13:18:56 +0000 (UTC)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G3t62K2770074; Thu, 16 Apr 2026 06:18:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=lshZxh7nH27kspEDqtsBaSxImoGtUZtyrZMu3Gs/EqI=; b=NXqox/Fq1AiL
 Yr6K1CVeGCbkTfusLATx7xZeiRruLoHjvLZf39g9Th1SCvunXKX36tjgxCn0rLl3
 MZINtJAGQAt/hiUA/lUX6nmOtjLX7nRv+MV2jXys0zoB/OPl7OOctPysLbsAV9Qm
 xgjZC4N711G07o+i3kg0qP8q7lejeEOIZDcP0lpRL214SEo/cS9+aosmrK7DtHcw
 xIAQJEFaXOP6ddg8rlSsHHAuuJ8enQk5HrLtXMVwWrGsyrJfLqCkMz2rIEN2oZTr
 KJeJUivj+ybTnGCikrNlwck3Ya5TQpplXiW/AFDrcSdoaPuXaE32J0F+X6m0epge
 9X1m82IOyg==
Received: from maileast.thefacebook.com ([163.114.135.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dh84v1ydq-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Thu, 16 Apr 2026 06:18:47 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1b::2d) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.37; Thu, 16 Apr
 2026 13:18:46 +0000
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
Subject: [PATCH 6/9] vfio/pci: Clean up BAR zap and revocation
Date: Thu, 16 Apr 2026 06:17:49 -0700
Message-ID: <20260416131815.2729131-7-mattev@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260416131815.2729131-1-mattev@meta.com>
References: <20260416131815.2729131-1-mattev@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2620:10d:c0a8:1b::2d]
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDEyNyBTYWx0ZWRfXxfzGQe7TMxfc
 6Sb7ce7ON/CawW+jFMEJNneiz+idXOXjg9Va2nOEruzXG2mLaQ2X4Crb/Y1kGldJQKE5xc/7VY1
 rMPDJ2/Dxac83vAwg4LV0piLz63DAnSPy9EagNmbFQjSisC2N4Tvtz8rFW4JRn+caYeOS/Qik9E
 A/zFHjyaDtgxC9qCaj0N0CDrGtRK0EUiFntRto0KY+nEy5vqRacNWt+9CxVHrCk+vHuD5+hqtbz
 iFkAwDXnvk+ny5qTn4Lwi9tshxVZd78/DzFhhtc7D6XMVSG7aL2l6adUEKgpn0WTUChLwanNzJQ
 Ks6ZDLzQkpavy5SnFWzmrSiH6/e+u3LNgeNhmiiP8EQQujjDvcKY2UkwNL5PLzEsf45fTLJf3L3
 DeVfnCbIDHWauQyOuioLp7Ys99can+aKIobj8o8bzJm9uLy147NS07O2T4WtBW1WM94k02i16wD
 UhvWT3twKntM3Idi+FQ==
X-Proofpoint-GUID: sFH0ApgAOq6UN1Ugul8bC7lSe2FepIIz
X-Authority-Analysis: v=2.4 cv=NfLWEWD4 c=1 sm=1 tr=0 ts=69e0e1b7 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=JnKecZnUtZousrUlYMGU:22 a=VabnemYjAAAA:8 a=c4k9Xcs0TiChc187yiQA:9
 a=O8hF6Hzn-FEA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: sFH0ApgAOq6UN1Ugul8bC7lSe2FepIIz
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

Previously, vfio_pci_zap_bars() (and the wrapper
vfio_pci_zap_and_down_write_memory_lock()) calls were paired with
calls of vfio_pci_dma_buf_move().

This commit replaces them a unified new function,
vfio_pci_zap_revoke_bars() containing both the vfio_pci_dma_buf_move()
and the unmap_mapping_range(), making it harder for callers to omit
one.  It adds a wrapper, vfio_pci_lock_zap_revoke_bars(), which takes
the write memory_lock before zapping, and adds a new
vfio_pci_unrevoke_bars() for the re-enable path.

However, as of "vfio/pci: Convert BAR mmap() to use a DMABUF" the
unmap_mapping_range() to zap is entirely redundant for plain vfio-pci,
since the DMABUFs used for BAR mappings already zap PTEs when the
vfio_pci_dma_buf_move() occurs.

One exception remains as a FIXME: in nvgrace-gpu, some BAR VMAs
conditionally use custom vm_ops, which have not moved to be backed by
DMABUFs.  If these BARs are mmap()ed, the vdev enables the existing
behaviour of unmap_mapping_range() for the device fd address space.

Signed-off-by: Matt Evans <mattev@meta.com>
---
 drivers/vfio/pci/nvgrace-gpu/main.c |  5 +++
 drivers/vfio/pci/vfio_pci_config.c  | 30 ++++++--------
 drivers/vfio/pci/vfio_pci_core.c    | 62 +++++++++++++++++++----------
 drivers/vfio/pci/vfio_pci_priv.h    |  3 +-
 include/linux/vfio_pci_core.h       |  1 +
 5 files changed, 62 insertions(+), 39 deletions(-)

diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
index c1df437754f9..5304d15b9a2b 100644
--- a/drivers/vfio/pci/nvgrace-gpu/main.c
+++ b/drivers/vfio/pci/nvgrace-gpu/main.c
@@ -358,6 +358,8 @@ static int nvgrace_gpu_mmap(struct vfio_device *core_vdev,
 	struct nvgrace_gpu_pci_core_device *nvdev =
 		container_of(core_vdev, struct nvgrace_gpu_pci_core_device,
 			     core_device.vdev);
+	struct vfio_pci_core_device *vdev =
+		container_of(core_vdev, struct vfio_pci_core_device, vdev);
 	struct mem_region *memregion;
 	u64 req_len, pgoff, end;
 	unsigned int index;
@@ -368,6 +370,9 @@ static int nvgrace_gpu_mmap(struct vfio_device *core_vdev,
 	if (!memregion)
 		return vfio_pci_core_mmap(core_vdev, vma);
 
+	/* Non-DMABUF BAR mappings need an extra zap */
+	vdev->bar_needs_zap = true;
+
 	/*
 	 * Request to mmap the BAR. Map to the CPU accessible memory on the
 	 * GPU using the memory information gathered from the system ACPI
diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index a10ed733f0e3..8bfab0da481c 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -590,12 +590,10 @@ static int vfio_basic_config_write(struct vfio_pci_core_device *vdev, int pos,
 		virt_mem = !!(le16_to_cpu(*virt_cmd) & PCI_COMMAND_MEMORY);
 		new_mem = !!(new_cmd & PCI_COMMAND_MEMORY);
 
-		if (!new_mem) {
-			vfio_pci_zap_and_down_write_memory_lock(vdev);
-			vfio_pci_dma_buf_move(vdev, true);
-		} else {
+		if (!new_mem)
+			vfio_pci_lock_zap_revoke_bars(vdev);
+		else
 			down_write(&vdev->memory_lock);
-		}
 
 		/*
 		 * If the user is writing mem/io enable (new_mem/io) and we
@@ -631,7 +629,7 @@ static int vfio_basic_config_write(struct vfio_pci_core_device *vdev, int pos,
 		*virt_cmd |= cpu_to_le16(new_cmd & mask);
 
 		if (__vfio_pci_memory_enabled(vdev))
-			vfio_pci_dma_buf_move(vdev, false);
+			vfio_pci_unrevoke_bars(vdev);
 		up_write(&vdev->memory_lock);
 	}
 
@@ -712,16 +710,14 @@ static int __init init_pci_cap_basic_perm(struct perm_bits *perm)
 static void vfio_lock_and_set_power_state(struct vfio_pci_core_device *vdev,
 					  pci_power_t state)
 {
-	if (state >= PCI_D3hot) {
-		vfio_pci_zap_and_down_write_memory_lock(vdev);
-		vfio_pci_dma_buf_move(vdev, true);
-	} else {
+	if (state >= PCI_D3hot)
+		vfio_pci_lock_zap_revoke_bars(vdev);
+	else
 		down_write(&vdev->memory_lock);
-	}
 
 	vfio_pci_set_power_state(vdev, state);
 	if (__vfio_pci_memory_enabled(vdev))
-		vfio_pci_dma_buf_move(vdev, false);
+		vfio_pci_unrevoke_bars(vdev);
 	up_write(&vdev->memory_lock);
 }
 
@@ -908,11 +904,10 @@ static int vfio_exp_config_write(struct vfio_pci_core_device *vdev, int pos,
 						 &cap);
 
 		if (!ret && (cap & PCI_EXP_DEVCAP_FLR)) {
-			vfio_pci_zap_and_down_write_memory_lock(vdev);
-			vfio_pci_dma_buf_move(vdev, true);
+			vfio_pci_lock_zap_revoke_bars(vdev);
 			pci_try_reset_function(vdev->pdev);
 			if (__vfio_pci_memory_enabled(vdev))
-				vfio_pci_dma_buf_move(vdev, false);
+				vfio_pci_unrevoke_bars(vdev);
 			up_write(&vdev->memory_lock);
 		}
 	}
@@ -993,11 +988,10 @@ static int vfio_af_config_write(struct vfio_pci_core_device *vdev, int pos,
 						&cap);
 
 		if (!ret && (cap & PCI_AF_CAP_FLR) && (cap & PCI_AF_CAP_TP)) {
-			vfio_pci_zap_and_down_write_memory_lock(vdev);
-			vfio_pci_dma_buf_move(vdev, true);
+			vfio_pci_lock_zap_revoke_bars(vdev);
 			pci_try_reset_function(vdev->pdev);
 			if (__vfio_pci_memory_enabled(vdev))
-				vfio_pci_dma_buf_move(vdev, false);
+				vfio_pci_unrevoke_bars(vdev);
 			up_write(&vdev->memory_lock);
 		}
 	}
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index c00a61d61250..464b63585bef 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -319,8 +319,7 @@ static int vfio_pci_runtime_pm_entry(struct vfio_pci_core_device *vdev,
 	 * The vdev power related flags are protected with 'memory_lock'
 	 * semaphore.
 	 */
-	vfio_pci_zap_and_down_write_memory_lock(vdev);
-	vfio_pci_dma_buf_move(vdev, true);
+	vfio_pci_lock_zap_revoke_bars(vdev);
 
 	if (vdev->pm_runtime_engaged) {
 		up_write(&vdev->memory_lock);
@@ -406,7 +405,7 @@ static void vfio_pci_runtime_pm_exit(struct vfio_pci_core_device *vdev)
 	down_write(&vdev->memory_lock);
 	__vfio_pci_runtime_pm_exit(vdev);
 	if (__vfio_pci_memory_enabled(vdev))
-		vfio_pci_dma_buf_move(vdev, false);
+		vfio_pci_unrevoke_bars(vdev);
 	up_write(&vdev->memory_lock);
 }
 
@@ -1229,7 +1228,7 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
 	if (!vdev->reset_works)
 		return -EINVAL;
 
-	vfio_pci_zap_and_down_write_memory_lock(vdev);
+	vfio_pci_lock_zap_revoke_bars(vdev);
 
 	/*
 	 * This function can be invoked while the power state is non-D0. If
@@ -1242,10 +1241,9 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
 	 */
 	vfio_pci_set_power_state(vdev, PCI_D0);
 
-	vfio_pci_dma_buf_move(vdev, true);
 	ret = pci_try_reset_function(vdev->pdev);
 	if (__vfio_pci_memory_enabled(vdev))
-		vfio_pci_dma_buf_move(vdev, false);
+		vfio_pci_unrevoke_bars(vdev);
 	up_write(&vdev->memory_lock);
 
 	return ret;
@@ -1613,20 +1611,44 @@ ssize_t vfio_pci_core_write(struct vfio_device *core_vdev, const char __user *bu
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_write);
 
-static void vfio_pci_zap_bars(struct vfio_pci_core_device *vdev)
+static void vfio_pci_zap_revoke_bars(struct vfio_pci_core_device *vdev)
 {
-	struct vfio_device *core_vdev = &vdev->vdev;
-	loff_t start = VFIO_PCI_INDEX_TO_OFFSET(VFIO_PCI_BAR0_REGION_INDEX);
-	loff_t end = VFIO_PCI_INDEX_TO_OFFSET(VFIO_PCI_ROM_REGION_INDEX);
-	loff_t len = end - start;
+	lockdep_assert_held_write(&vdev->memory_lock);
+	vfio_pci_dma_buf_move(vdev, true);
 
-	unmap_mapping_range(core_vdev->inode->i_mapping, start, len, true);
+	/*
+	 * All VFIO PCI BARs are backed by DMABUFs, with the current
+	 * exception of the nvgrace-gpu device which uses its own
+	 * vm_ops for a subset of BARs.  For this, BAR mappings are
+	 * still made in the vdev's address_space, and a zap is
+	 * required.  The tracking is crude, and will (harmlessly)
+	 * continue to zap if the special BAR is unmapped, but that
+	 * behaviour isn't the common case.
+	 *
+	 * FIXME: This can go away if the special nvgrace-gpu mapping
+	 * is converted to use DMABUF.
+	 */
+	if (vdev->bar_needs_zap) {
+		struct vfio_device *core_vdev = &vdev->vdev;
+		loff_t start = VFIO_PCI_INDEX_TO_OFFSET(VFIO_PCI_BAR0_REGION_INDEX);
+		loff_t end = VFIO_PCI_INDEX_TO_OFFSET(VFIO_PCI_ROM_REGION_INDEX);
+		loff_t len = end - start;
+
+		unmap_mapping_range(core_vdev->inode->i_mapping,
+				    start, len, true);
+	}
 }
 
-void vfio_pci_zap_and_down_write_memory_lock(struct vfio_pci_core_device *vdev)
+void vfio_pci_lock_zap_revoke_bars(struct vfio_pci_core_device *vdev)
 {
 	down_write(&vdev->memory_lock);
-	vfio_pci_zap_bars(vdev);
+	vfio_pci_zap_revoke_bars(vdev);
+}
+
+void vfio_pci_unrevoke_bars(struct vfio_pci_core_device *vdev)
+{
+	lockdep_assert_held_write(&vdev->memory_lock);
+	vfio_pci_dma_buf_move(vdev, false);
 }
 
 u16 vfio_pci_memory_lock_and_enable(struct vfio_pci_core_device *vdev)
@@ -2480,9 +2502,10 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
 		}
 
 		/*
-		 * Take the memory write lock for each device and zap BAR
-		 * mappings to prevent the user accessing the device while in
-		 * reset.  Locking multiple devices is prone to deadlock,
+		 * Take the memory write lock for each device and
+		 * zap/revoke BAR mappings to prevent the user (or
+		 * peers) accessing the device while in reset.
+		 * Locking multiple devices is prone to deadlock,
 		 * runaway and unwind if we hit contention.
 		 */
 		if (!down_write_trylock(&vdev->memory_lock)) {
@@ -2490,8 +2513,7 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
 			break;
 		}
 
-		vfio_pci_dma_buf_move(vdev, true);
-		vfio_pci_zap_bars(vdev);
+		vfio_pci_zap_revoke_bars(vdev);
 	}
 
 	if (!list_entry_is_head(vdev,
@@ -2521,7 +2543,7 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
 	list_for_each_entry_from_reverse(vdev, &dev_set->device_list,
 					 vdev.dev_set_list) {
 		if (vdev->vdev.open_count && __vfio_pci_memory_enabled(vdev))
-			vfio_pci_dma_buf_move(vdev, false);
+			vfio_pci_unrevoke_bars(vdev);
 		up_write(&vdev->memory_lock);
 	}
 
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 868a54ba482c..a8edbee6ce56 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -82,7 +82,8 @@ void vfio_config_free(struct vfio_pci_core_device *vdev);
 int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev,
 			     pci_power_t state);
 
-void vfio_pci_zap_and_down_write_memory_lock(struct vfio_pci_core_device *vdev);
+void vfio_pci_lock_zap_revoke_bars(struct vfio_pci_core_device *vdev);
+void vfio_pci_unrevoke_bars(struct vfio_pci_core_device *vdev);
 u16 vfio_pci_memory_lock_and_enable(struct vfio_pci_core_device *vdev);
 void vfio_pci_memory_unlock_and_restore(struct vfio_pci_core_device *vdev,
 					u16 cmd);
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 2ea4e773c121..c1cd67741125 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -127,6 +127,7 @@ struct vfio_pci_core_device {
 	bool			needs_pm_restore:1;
 	bool			pm_intx_masked:1;
 	bool			pm_runtime_engaged:1;
+	bool			bar_needs_zap:1;
 	struct pci_saved_state	*pci_saved_state;
 	struct pci_saved_state	*pm_save;
 	int			ioeventfds_nr;
-- 
2.47.3

