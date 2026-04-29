Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9A7FF8877
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 13:07:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCAAC10EFED;
	Wed, 29 Apr 2026 13:07:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="petG/QiB";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8615B10E3D1;
 Wed, 29 Apr 2026 13:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=U15y+TfzRWZWdZcKULVBgo3XI8PC08rXu4Ucxe0F7OY=; b=petG/QiBpO5c6zcXeAG9HVDcdV
 XsXXhpoxsyG7ueH2SKRRGNOEdomK4h+LMyR4VXZlq7Mdg/Ur/v/xvhqhPB+tonnLva8sUeEpHVg1V
 Xz/H7cZqWf8BrWZRug0CWxyp8KiUAqcEqY38BDPPZ5J91b1Lsckso1fZsW2uL7FRUSgr9jIP9O4O6
 mjU94krOilwm7VoQyq3VuRruJjbFwj8I2Fxpx2c7HNHMzUBL0zydtbroG1vzmUcXJB4xdDiiNk/P9
 q35Owiy/hLT3WWjTEdarV6Qbv+DBSla41YPBt5eybVnotOtVPwCndjGSqVo3HYpwzX1vFLb70CZCI
 9nd7Quow==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wI4d5-003wVB-Gg; Wed, 29 Apr 2026 15:07:02 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 2/2] drm/amdgpu: Wire up DRM memory stats reporting
Date: Wed, 29 Apr 2026 14:06:53 +0100
Message-ID: <20260429130653.73854-3-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260429130653.73854-1-tvrtko.ursulin@igalia.com>
References: <20260429130653.73854-1-tvrtko.ursulin@igalia.com>
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

Wire up the driver agnostic DRM memory reporting for the VRAM and GTT
memory regions.

As the list of regions and their stats needs to be returned to the DRM
core for inspection and remain valid after the callback had existed, the
persistent storage is kept at the device level and updated on each query.

The current list of memory region names as reported for fdinfo memory
stats is exported as a helper in order to achieve standardized names, as
required by the DRM contract.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  6 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 40 +++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 37 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |  3 ++
 5 files changed, 75 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 8bc591deb546..03a77cf649ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1195,6 +1195,9 @@ struct amdgpu_device {
 
 	struct amdgpu_uma_carveout_info uma_info;
 
+	struct drm_memory_info		memory_info;
+	struct drm_memory_region_info	__memory_region_info[2]; /* Storage for memory_info */
+
 	/* KFD
 	 * Must be last --ends in a flexible-array member.
 	 */
@@ -1665,4 +1668,7 @@ void amdgpu_device_set_uid(struct amdgpu_uid *uid_info,
 			   uint64_t uid);
 uint64_t amdgpu_device_get_uid(struct amdgpu_uid *uid_info,
 			       enum amdgpu_uid_type type, uint8_t inst);
+
+const struct drm_memory_info *amdgpu_drm_memory_info(struct drm_device *drm);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 1ec5ba3ab0ed..e0e192558098 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3085,7 +3085,7 @@ static const struct drm_driver amdgpu_kms_driver = {
 #ifdef CONFIG_PROC_FS
 	.show_fdinfo = amdgpu_show_fdinfo,
 #endif
-
+	.get_memory_info = amdgpu_drm_memory_info,
 	.gem_prime_import = amdgpu_gem_prime_import,
 
 	.name = DRIVER_NAME,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
index b349bb3676d5..3bbd053cd9f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
@@ -55,14 +55,9 @@ static const char *amdgpu_ip_name[AMDGPU_HW_IP_NUM] = {
 	[AMDGPU_HW_IP_VPE]	=	"vpe",
 };
 
-void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
+const char *amdgpu_ttm_pl_to_name(unsigned int placement)
 {
-	struct amdgpu_fpriv *fpriv = file->driver_priv;
-	struct amdgpu_vm *vm = &fpriv->vm;
-
-	struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM];
-	ktime_t usage[AMDGPU_HW_IP_NUM];
-	const char *pl_name[] = {
+	static const char *names[] = {
 		[TTM_PL_VRAM] = "vram",
 		[TTM_PL_TT] = "gtt",
 		[TTM_PL_SYSTEM] = "cpu",
@@ -72,6 +67,30 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 		[AMDGPU_PL_DOORBELL] = "doorbell",
 		[AMDGPU_PL_MMIO_REMAP] = "mmioremap",
 	};
+
+	if (WARN_ON_ONCE(placement >= ARRAY_SIZE(names)))
+		return "unknown";
+
+	return names[placement];
+}
+
+void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
+{
+	struct amdgpu_fpriv *fpriv = file->driver_priv;
+	struct amdgpu_vm *vm = &fpriv->vm;
+
+	struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM];
+	ktime_t usage[AMDGPU_HW_IP_NUM];
+	static const unsigned int regions[] = {
+		TTM_PL_VRAM,
+		TTM_PL_TT,
+		TTM_PL_SYSTEM,
+		AMDGPU_PL_GDS,
+		AMDGPU_PL_GWS,
+		AMDGPU_PL_OA,
+		AMDGPU_PL_DOORBELL,
+		AMDGPU_PL_MMIO_REMAP,
+	};
 	unsigned int hw_ip, i;
 
 	amdgpu_vm_get_memory(vm, stats);
@@ -85,15 +104,12 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 
 	drm_printf(p, "pasid:\t%u\n", fpriv->vm.pasid);
 
-	for (i = 0; i < ARRAY_SIZE(pl_name); i++) {
-		if (!pl_name[i])
-			continue;
-
+	for (i = 0; i < ARRAY_SIZE(regions); i++) {
 		drm_print_memory_stats(p,
 				       &stats[i].drm,
 				       DRM_GEM_OBJECT_RESIDENT |
 				       DRM_GEM_OBJECT_PURGEABLE,
-				       pl_name[i]);
+				       amdgpu_ttm_pl_to_name(regions[i]));
 	}
 
 	/* Legacy amdgpu keys, alias to drm-resident-memory-: */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 0dc68fb9d88e..bff3101e7e0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2917,3 +2917,40 @@ void amdgpu_ttm_debugfs_init(struct amdgpu_device *adev)
 
 #endif
 }
+
+const struct drm_memory_info *amdgpu_drm_memory_info(struct drm_device *drm)
+{
+	struct amdgpu_device *adev = drm_to_adev(drm);
+	struct drm_memory_info *info = &adev->memory_info;
+	static const unsigned int regions[] = {
+		TTM_PL_VRAM,
+		TTM_PL_TT,
+	};
+	struct drm_memory_region_info *region;
+	struct ttm_resource_manager *man;
+	unsigned int i;
+
+	if (WARN_ON_ONCE(ARRAY_SIZE(adev->__memory_region_info) !=
+			 ARRAY_SIZE(regions)))
+		return NULL;
+
+	if (!info->num_regions) {
+		for (i = 0; i < ARRAY_SIZE(regions); i++) {
+			region = &info->region[i];
+			strscpy(region->name,
+				amdgpu_ttm_pl_to_name(regions[i]),
+				sizeof(region->name));
+			man = ttm_manager_type(&adev->mman.bdev, regions[i]);
+			region->total_mb = man->size >> 20;
+			info->num_regions++;
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(regions); i++) {
+		region = &info->region[i];
+		man = ttm_manager_type(&adev->mman.bdev, regions[i]);
+		region->used_mb = ttm_resource_manager_usage(man) >> 20;
+	}
+
+	return &adev->memory_info;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index f2f23a42b3cc..91fc807ee1be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -269,4 +269,7 @@ void amdgpu_ttm_mmio_remap_free_sgt(struct device *dev,
 				    enum dma_data_direction dir,
 				    struct sg_table *sgt);
 
+const char *amdgpu_ttm_pl_to_name(unsigned int placement);
+const struct drm_memory_info *amdgpu_drm_memory_info(struct drm_device *drm);
+
 #endif
-- 
2.52.0

