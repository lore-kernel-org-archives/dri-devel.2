Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A646CA5FFC
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 08:08:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7114A10E036;
	Tue,  6 Oct 2026 08:08:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="J1D6Ke8o";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BCF210E01F;
 Tue,  6 Oct 2026 08:08:38 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6966cs9W1414851; Tue, 6 Oct 2026 09:08:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=zZJ2SmIPhTQl/7XrvycHTSJ
 fZqlI79g1FTmuSaaV2V8=; b=J1D6Ke8oQQCP5cHoGuaPFrB5q9hSMdPRVoSeLkJ
 W304sJPgEPK2XAqbw9pT1mTb6B9yqlwK1/Bxa4XoKo028XpvkcAE//RDSc5cl3pA
 gPlbi3ktXrIUOaUjW+rgLU7EEtybmgxQnP9F6E1ZEiCPG9kPKUp9BHrml2j5Pfve
 EixRTE3TOnQPI1J6oN8cFFtBF3c3hOmuG8/U9I6awQxQXCl6M4BaBmS9rldJFvsr
 ZxCPTbbIfEsMIAp64ywryHrxK+0As3/V4jpw31Wb/z7TCUXfaew20TKgrRk7CgCf
 KipSkeEaSaNT7kLiO/jiR6i81wahwbC6t2ZKZAVRNnToaOg==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4h4brugq9y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 09:08:24 +0100 (BST)
Received: from [127.0.1.1] (172.25.5.23) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 09:08:18 +0100
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Tue, 6 Oct 2026 11:08:06 +0300
Subject: [PATCH] drm/imagination: Check virtual address space size only
 once
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261006-b4-check-virtual-addr-space-size-once-v1-1-677687e661d1@imgtec.com>
X-B4-Tracking: v=1; b=H4sIAGWsxGoC/yXNQQ6CMBCF4auQWTtJKaULr2JclOkgg6aQDhAi4
 e5W3b1v878DlLOwwrU6IPMmKlMqqC8V0BDSg1FiMVhjfW2Mx84hDUxP3CQva3hhiDGjzoEYVd6
 MUyrLOGd9S9z0oYHSmjP3sv9+bve/de1GpuUbh/P8ALdhINGJAAAA
X-Change-ID: 20261006-b4-check-virtual-addr-space-size-once-044265ce3fa3
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Alexandru Dadu <alexandru.dadu@imgtec.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791274103; l=6094;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=dmuwqQOKOOoNQ0Mo+Q18LUSH8EPSFoiUImyyUVnraGk=;
 b=cAmOuzjmLD9d1ekpcb3FND+4AnShgy7q9AxCeSHugQxSZvJ5jaOGPKmfjRrXrlPfw/7+ta2B7
 +HyQKguAd6pAKaYvY8iEongiJUGsDHgsNvKASYo9YF1Y08vLfawUjGk
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Originating-IP: [172.25.5.23]
X-Authority-Analysis: v=2.4 cv=FNOOVOos c=1 sm=1 tr=0 ts=6ac4ac78 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=Vfs-8JXWiL0A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=vv4RTzrVeQxDHaVKDvsA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzMiBTYWx0ZWRfX0+XjXtpx3hmr
 A51RC22V7x/nlgL0VTfmg8Zsxjp7ShZZjGuXCpv6OUj+eMIG/2lfwAESnQKfXmyV1PbZ5/B9Itq
 9xP4xBmlwoivOO/Q1RXXehwh1ma9dDY=
X-Proofpoint-ORIG-GUID: bS6WK1UDIV1epBB7CgmZfEI34gYq35aJ
X-Proofpoint-GUID: bS6WK1UDIV1epBB7CgmZfEI34gYq35aJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzMiBTYWx0ZWRfX57XbWzfOO90F
 WZfEE8z/JnfrtCICRhvBHrwY8MyAQKX54Zyxwj785qk+cHLHwIUu+f69sExuVt9MHx0IXZ2XF6e
 q89DP8xOYteSpmSIrqhysJ3bkmb9gy8uOtGiGU+qRm7IFTPyocz4nPfSfZr8apX98oOSdX9G0pp
 w6yJVMeEbVeC3SwtZi6Ftq2E6Bv2KCd6IPmp4U7b77rEfmtYRPJeN9WWg5uRW6AiRcgvBr1/zFR
 nYxWFEkDri4L7ZqA8e1W3RPB0K536x+a1lE3NWhqfP/XPXzzE8VcWnE0ENL0O3uKXzBcUN1ySbD
 SiTCOGYbFtj+rp9ZEUij9gRxv3UUnj96m/iZc/2egil1SwwTuX3UDS3zqLoOUXauYr5iGwn0s/d
 VYye4UWlVzYcBFBmpIlY67d7Exk2ZJLEc+ZfHU4CvlYax0SmcBJ5/eYNYcpNWtcDOsrzPxyeqvM
 FUWnSlhF9Uaqoo+nwbA==
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

From: Alessio Belle <alessio.belle@imgtec.com>

Every time a virtual memory context is created, the driver reads the
size of the virtual address space, as reported by the firmware binary,
and compares it against a define for the same, but both values are fixed
on a given core, and on top of that, all known Imagination GPU cores use
the same 40-bit virtual address space.

Move the check above to a new function for GPU device info validation
code, so it's performed only once.
This also allows other areas of the driver to reference the relevant
defines without having to perform other checks at runtime, as long as
all cores keep using the same virtual address space.

Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>
Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_device.c | 43 +++++++++++++++++++++++++++++---
 drivers/gpu/drm/imagination/pvr_mmu.h    |  2 +-
 drivers/gpu/drm/imagination/pvr_vm.c     | 22 +---------------
 3 files changed, 42 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_device.c b/drivers/gpu/drm/imagination/pvr_device.c
index 35eaa54f75ed..992509d95d28 100644
--- a/drivers/gpu/drm/imagination/pvr_device.c
+++ b/drivers/gpu/drm/imagination/pvr_device.c
@@ -5,6 +5,7 @@
 #include "pvr_device_info.h"
 
 #include "pvr_fw.h"
+#include "pvr_mmu.h"
 #include "pvr_power.h"
 #include "pvr_queue.h"
 #include "pvr_rogue_cr_defs.h"
@@ -646,6 +647,36 @@ pvr_set_dma_info(struct pvr_device *pvr_dev)
 	return 0;
 }
 
+/**
+ * pvr_device_info_validate() - Validate PowerVR device information, read from
+ * the firmware binary, against what is supported by the driver.
+ * @pvr_dev: Target PowerVR device.
+ *
+ * Returns:
+ *  * 0 on success, or
+ *  * -%EINVAL if the validation failed.
+ */
+static int
+pvr_device_info_validate(struct pvr_device *pvr_dev)
+{
+	struct drm_device *drm_dev = from_pvr_device(pvr_dev);
+	u16 device_addr_bits;
+	int err;
+
+	err = PVR_FEATURE_VALUE(pvr_dev, virtual_address_space_bits, &device_addr_bits);
+	if (err) {
+		drm_err(drm_dev, "Failed to get device virtual address space bits\n");
+		return err;
+	}
+
+	if (device_addr_bits != PVR_PAGE_TABLE_ADDR_BITS) {
+		drm_err(drm_dev, "Device has unsupported virtual address space size\n");
+		return -EINVAL;
+	}
+
+	return err;
+}
+
 /**
  * pvr_device_gpu_init() - GPU-specific initialization for a PowerVR device
  * @pvr_dev: Target PowerVR device.
@@ -661,9 +692,11 @@ pvr_set_dma_info(struct pvr_device *pvr_dev)
  * Return:
  *  * 0 on success,
  *  * -%ENODEV if the GPU is not supported,
- *  * Any error returned by pvr_set_dma_info(),
- *  * Any error returned by pvr_memory_context_init(), or
- *  * Any error returned by pvr_request_firmware().
+ *  * Any error returned by pvr_request_firmware(),
+ *  * Any error returned by pvr_fw_validate_init_device_info(),
+ *  * Any error returned by pvr_device_info_validate(),
+ *  * Any error returned by pvr_set_dma_info(), or
+ *  * Any error returned by pvr_fw_init().
  */
 static int
 pvr_device_gpu_init(struct pvr_device *pvr_dev)
@@ -691,6 +724,10 @@ pvr_device_gpu_init(struct pvr_device *pvr_dev)
 	else
 		return -EINVAL;
 
+	err = pvr_device_info_validate(pvr_dev);
+	if (err)
+		return err;
+
 	pvr_stream_create_musthave_masks(pvr_dev);
 
 	err = pvr_set_dma_info(pvr_dev);
diff --git a/drivers/gpu/drm/imagination/pvr_mmu.h b/drivers/gpu/drm/imagination/pvr_mmu.h
index a8ecd460168d..1f9ae00a8b17 100644
--- a/drivers/gpu/drm/imagination/pvr_mmu.h
+++ b/drivers/gpu/drm/imagination/pvr_mmu.h
@@ -62,7 +62,7 @@ struct sg_table;
  *
  *    This value is checked at runtime against
  *    &pvr_device_features.virtual_address_space_bits by
- *    pvr_vm_create_context(), which will return an error if the feature value
+ *    pvr_device_info_validate(), which will return an error if the feature value
  *    does not match this constant.
  *
  *    .. admonition:: Future work
diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagination/pvr_vm.c
index ceb78694cd98..304d0743c5aa 100644
--- a/drivers/gpu/drm/imagination/pvr_vm.c
+++ b/drivers/gpu/drm/imagination/pvr_vm.c
@@ -535,8 +535,6 @@ fw_mem_context_init(void *cpu_ptr, void *priv)
  *
  * Return:
  *  * A handle to the newly-minted VM context on success,
- *  * -%EINVAL if the feature "virtual address space bits" on @pvr_dev is
- *    missing or has an unsupported value,
  *  * -%ENOMEM if allocation of the structure behind the opaque handle fails,
  *    or
  *  * Any error encountered while setting up internal structures.
@@ -544,27 +542,9 @@ fw_mem_context_init(void *cpu_ptr, void *priv)
 struct pvr_vm_context *
 pvr_vm_create_context(struct pvr_device *pvr_dev, bool is_userspace_context)
 {
-	struct drm_device *drm_dev = from_pvr_device(pvr_dev);
-
 	struct pvr_vm_context *vm_ctx;
-	u16 device_addr_bits;
-
 	int err;
 
-	err = PVR_FEATURE_VALUE(pvr_dev, virtual_address_space_bits,
-				&device_addr_bits);
-	if (err) {
-		drm_err(drm_dev,
-			"Failed to get device virtual address space bits\n");
-		return ERR_PTR(err);
-	}
-
-	if (device_addr_bits != PVR_PAGE_TABLE_ADDR_BITS) {
-		drm_err(drm_dev,
-			"Device has unsupported virtual address space size\n");
-		return ERR_PTR(-EINVAL);
-	}
-
 	vm_ctx = kzalloc_obj(*vm_ctx);
 	if (!vm_ctx)
 		return ERR_PTR(-ENOMEM);
@@ -589,7 +569,7 @@ pvr_vm_create_context(struct pvr_device *pvr_dev, bool is_userspace_context)
 	drm_gpuvm_init(&vm_ctx->gpuvm_mgr,
 		       is_userspace_context ? "PowerVR-user-VM" : "PowerVR-FW-VM",
 		       0, &pvr_dev->base, &vm_ctx->dummy_gem,
-		       0, 1ULL << device_addr_bits, 0, 0, &pvr_vm_gpuva_ops);
+		       0, PVR_PAGE_TABLE_ADDR_SPACE_SIZE, 0, 0, &pvr_vm_gpuva_ops);
 
 	mutex_init(&vm_ctx->lock);
 	kref_init(&vm_ctx->ref_count);

---
base-commit: 6e375de99d0c420169481fcd36064177ab55b09d
change-id: 20261006-b4-check-virtual-addr-space-size-once-044265ce3fa3

Best regards,
--  
Alexandru Dadu <alexandru.dadu@imgtec.com>

