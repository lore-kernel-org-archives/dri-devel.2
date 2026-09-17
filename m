Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A84BC982D1
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 12:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C8C910E3F8;
	Thu, 17 Sep 2026 12:04:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="b0LP64rp";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4C2210E3F8;
 Thu, 17 Sep 2026 12:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=gs4Qd+KMY/RhH/19Tr5sJ3MNG94oFeTViDA1dKLFHu8=; b=b0LP64rpk8jXLFacYIMAITrb3V
 dTLpjo1t0U0JkKpugHu5HFAtB4mTaRMJCHglnQu+F6P3w4ZaVNK1FW5+4okYnJAl5FdhgdNAnWrFM
 REXt76a9IkTFhs2gCIQ5ulz4b4VAJ12BgHz/wv5pp23L1MtO3OIE2PElx8W232UP1sSE/bwJ3een4
 0VU+XEiLlqYIBhMIQ1kUywUujpXhdo8U26QIClOV25OKn2D8psDikzFA9bT2EaLzvLGFKMnVNs80e
 5ZiUYm+ofcECXChcTBd0FNeWs8VxBM+iYlvUxdCuqhRSkqcoH0QQIrHYeGiqd6i5oyUAfl5XSfMyD
 YvHAjyPg==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x7Ar9-003NUO-Sd; Thu, 17 Sep 2026 14:04:47 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Ludovico de Nittis <ludovico.denittis@collabora.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [RFC 2/2] drm/amdgpu: Wire up DRM memory stats reporting
Date: Thu, 17 Sep 2026 13:04:44 +0100
Message-ID: <20260917120444.86471-3-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917120444.86471-1-tvrtko.ursulin@igalia.com>
References: <20260917120444.86471-1-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
core for inspection and remain valid after the callback had exited, the
persistent storage is kept at the device level and updated on each query.

The current list of memory region names as reported for fdinfo memory
stats is exported as a helper in order to achieve standardized names, as
required by the DRM contract.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Maíra Canal <mcanal@igalia.com>
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  6 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 40 +++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 37 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |  3 ++
 5 files changed, 75 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 79b69d74eb2e..8c00f76cfc7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -965,6 +965,9 @@ struct amdgpu_device {
 
 	struct amdgpu_uma_carveout_info uma_info;
 
+	struct drm_memory_info		memory_info;
+	struct drm_memory_region_info	__memory_region_info[2]; /* Storage for memory_info */
+
 	/* KFD
 	 * Must be last --ends in a flexible-array member.
 	 */
@@ -1350,4 +1353,7 @@ void amdgpu_device_set_uid(struct amdgpu_uid *uid_info,
 			   uint64_t uid);
 uint64_t amdgpu_device_get_uid(struct amdgpu_uid *uid_info,
 			       enum amdgpu_uid_type type, uint8_t inst);
+
+const struct drm_memory_info *amdgpu_drm_memory_info(struct drm_device *drm);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 9c5e93cd3ee6..9830497b9ed2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3142,7 +3142,7 @@ static const struct drm_driver amdgpu_kms_driver = {
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
index c509dc45ba19..2336ea1cd008 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -3027,3 +3027,40 @@ void amdgpu_ttm_debugfs_init(struct amdgpu_device *adev)
 
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
index adb6cfae5052..1ed07fb4a755 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -271,4 +271,7 @@ void amdgpu_ttm_mmio_remap_free_sgt(struct device *dev,
 				    enum dma_data_direction dir,
 				    struct sg_table *sgt);
 
+const char *amdgpu_ttm_pl_to_name(unsigned int placement);
+const struct drm_memory_info *amdgpu_drm_memory_info(struct drm_device *drm);
+
 #endif
-- 
2.55.0

