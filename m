Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB97606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 21:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=V7qDF4rr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 830DD10F87A;
	Tue,  3 Nov 2026 21:38:23 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013031.outbound.protection.outlook.com
 [40.93.196.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1435D10E834;
 Tue,  3 Nov 2026 21:38:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RosAfjqvt2nP1o2nvjeOSw518jsa+XAUoDP64zwozTE4qm93IUjfSP1Kxadv2dm1UTyNeC286X4pqEiWJp/v9eQLZ2rFUHqFm24xUxRtj9QJP+pXNYXeo5dLvlF+u28xL3M6WYLaIMUhrG4mlII4vpi1tSU2fDwRu5htjYSZMdUBf+Sbl7xdMXCnWU4ijRczyyiwLhP+Dg1gUB9/zzVPu2QXiD3cqGuJCWQYZswaPB9T9nymsKIpQqgGQPAaMui47YQDE4YrnkbfdCVErvyu5m+bO34q6e0EyRRmwhthyTITL+RkZi8ad8z1GwJbNRa1hNY01aMkbDb7bRwno5K+2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2FnimAkUPkUZXFrjxXNDUydBYHFg/g097vUnefNnW4=;
 b=SbGkysjN3a4BwFn6ByhQOMW3gvfbR7DMIVSPtkXnfPIqQQFsZzCF/8ot3Ht3tTIGU/WoLxtkLJmvHKDGB5HQ20ku2FeqIyLX+X8KMUmCjdFUXPnC4rkNisCnIBumr2WXOb2hp4w0pofxIP3nV8bTVCYVxnVb+fCAC2sRMKj/1a3OeMEleWVs5Q1GxElr3xj+nke3fkl9U2S2kuLsHqJOXWJBBC4rTRi+Smz18bYRBl5yy0nHDApvLkxIir5vFxVEFTc4qvIb20lkfap65NojEJBLmvxur3cefB595wLLRE2gJRVNX5V3VOy2OKI76glqvyiIhKTLL0LdG7bQjHWBXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2FnimAkUPkUZXFrjxXNDUydBYHFg/g097vUnefNnW4=;
 b=V7qDF4rr9h7zsBlIJM4/I4Bu4s0CjT+g5MHC6skIj8CWDQo9Goj+3HzEWZBai1Fl+URSg9nOVqYv2D4zob4QxLAxv4DKfgxZqq8wMq3d5aE0TP3diEnqCH7N+m1amSQuqFPcyPGi3W9mrrpMO9pQn29qSSG+/FP0vkjHCQT43Ow=
Received: from BN1PR13CA0003.namprd13.prod.outlook.com (2603:10b6:408:e2::8)
 by FT1PR12MB268176.namprd12.prod.outlook.com (2603:10b6:170:3b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 21:38:10 +0000
Received: from BN1PEPF00018071.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::2a) by BN1PR13CA0003.outlook.office365.com
 (2603:10b6:408:e2::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 21:38:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018071.mail.protection.outlook.com (10.167.245.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 21:38:10 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 15:38:06 -0600
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 3 Nov 2026 15:38:06 -0600
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v1 07/13] drm/amd/display: advertise a DMA 3D LUT color
 pipeline
Date: Tue, 3 Nov 2026 16:37:50 -0500
Message-ID: <20261103213756.618024-8-harry.wentland@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103213756.618024-1-harry.wentland@amd.com>
References: <20261103213756.618024-1-harry.wentland@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018071:EE_|FT1PR12MB268176:EE_
X-MS-Office365-Filtering-Correlation-Id: 36639477-3967-47ac-3d2a-08df39f2c17e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|6133799003|10067099003|22082099003|18002099003|261102123227099003|261102130727099003|261009223027099003|56012099006|261028144727099003|11063799006|261022105027099003|261026140227099003|261026121527099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: D5efaR49xb6nfQrYGLCCgRAI4KpYDGT2K1537hnGajelgU0l24OHr0h/hKLcpNmO8Gpdv9mwJMrgTTneQCSJPf5bgl4+a2TEO4NAWa2ePaLDsjyHFnsyjMGQ8uXqzB7zD47/Qj636OHyJnzCNBomjvuV57ZmtrHd0CkHzx7ockTD2uSjj9mwNVwchOL0wCsJxicIWXnVeXtCg3m6buWoWfkpDTHQPHvm9xbG8lY/PvoG9eZnOHfJ6g0tV53CzgiULD7f2ni0kiFlyCqyfblB3y5WXulpZWYfRKuPPs5OEoeaTEkktnMpFc+z4MRzPD5qzTi1zV0ta1amChd6GM6KrZkEUHJO6o98/Zfea9McOpHrHz3mCpoGCfQaA7U/LZatv/ghbyFVr5n+vZY2qp7FMYqlRJLMsNGD1LBvaI4PRQ53gx6OUIU7HCI6Quxj8Lp0jBdcJBCH9naqhLgLGeO1jpQ27azHyH1Oavt5bs+z/GTx/PkMjZL1DRnSq2o4PC9IJqq7nx2y+Y/7yYu5826rGcUK8rleMWGIzQ9yQ4hsq5DFSbx8BnYC1fmWvhzNbbrgoyXvva28UBZYI/xpSY/D5a3oZEOVKxLKq0DSLbKXL5txoLoQPBus2LGB3SpTuVlYWPmJ1Z1TyhYQr9mwbbuqxb9SrbfhQs4SxR9o4AGe38QuYyrx2rnDeDqZ0gNf24HygGuyaH+jil3p6OWIS9wXXg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(6133799003)(10067099003)(22082099003)(18002099003)(261102123227099003)(261102130727099003)(261009223027099003)(56012099006)(261028144727099003)(11063799006)(261022105027099003)(261026140227099003)(261026121527099003)(261021121427099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w9+JzVhgqQtYVi6Q6a94bQxb5CWSwfltRlP3ulDEDEL/H0Q8KHsR1s8WuIuW7FlidBagKN4Ktyk8te3G7jPh2bX6XAc1JsJkRxpvM2fo34oAmPRN2VxbLgEAZSslUG8Gd1RzW7nXcMsEhMv7z4eVnwkCfUek9qBCHvMD+ksPsJsD1jLLIIMkD3THggyw9qK4qJOnWZ3IBz3EJRVmLB95C0uxFT2W/yMIPZ22jAomu58aJrMe+BOSMYqVkxxCiKuWxl51Xp2Ti7zLg95MawViQmquCRL0xs5kY0jPwHNBGxWjW/tamMulpkfDPEAt1h2Ys4ebM/1Izfn2rLzR4WQRTJorkiTyHPuPjM+RGIaOOXpI2P5kLZ10/xWwA/v7fZrClBccLP92ubBxnrCxiDdU7dVYlzyBIYbipv0fRuBnpsNcc78wq9SDKOmvro5ZUlQW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 21:38:10.0658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36639477-3967-47ac-3d2a-08df39f2c17e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB268176
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The DMA (fast-load) 3D LUT and the legacy inline 3D LUT map to the same
MCM 3D LUT HW block, so rather than adding a second 3D LUT op to the
existing pipeline, advertise a second color pipeline that is identical to
the default one except the inline DRM_COLOROP_3D_LUT is replaced by a
DRM_COLOROP_3D_LUT_DMA.

amdgpu_dm_build_default_pipeline() gains a dma_3d_lut argument that selects
the 3D LUT variant; amdgpu_dm_initialize_dma_3dlut_pipeline() builds the
DMA variant, and dm_plane_init_colorops() advertises it as a second
pipeline when mcm_3d_lut_caps.dma_3d_lut is set. The advertised format is
a 17^3 XBGR16161616 LINEAR cube with the DCN-derived 256-byte pitch.

Keep it behind an experimental KConfig for now.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/Kconfig           | 13 ++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c | 43 ++++++++++++++++---
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.h |  4 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 17 ++++++++
 .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c  |  4 +-
 5 files changed, 71 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index a319680c329b..e62efe422aeb 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -65,6 +65,19 @@ config DRM_AMD_SECURE_DISPLAY
 	  This option enables the calculation of crc of specific region via
 	  debugfs. Cooperate with specific DMCU FW.
 
+config DRM_AMD_DC_3DLUT_DMA
+	bool "Expose the DMA 3D LUT color pipeline (EXPERIMENTAL)"
+	depends on DRM_AMD_DC
+	default n
+	help
+	  Advertise a color pipeline with a DRM_COLOROP_3D_LUT_DMA colorop
+	  when the display hardware supports fast-loading the 3D LUT from a
+	  framebuffer.
+
+	  This is experimental.
+
+	  If unsure, say N.
+
 config DRM_AMD_DC_KUNIT_TEST
 	tristate "KUnit tests for the AMD DC display driver" if !KUNIT_ALL_TESTS
 	depends on DRM_AMD_DC && KUNIT && DEBUG_FS
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
index 47d90b67120e..9d7720a9bd2e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
@@ -28,6 +28,7 @@
 #include <drm/drm_plane.h>
 #include <drm/drm_property.h>
 #include <drm/drm_colorop.h>
+#include <drm/drm_fourcc.h>
 
 #include "amdgpu.h"
 #include "amdgpu_dm_colorop.h"
@@ -67,6 +68,17 @@ const u64 amdgpu_dm_supported_fm =
 
 #define LUT3D_SIZE		17
 
+static const struct drm_mode_3dlut_mode amdgpu_dm_3dlut_dma_modes[] = {
+	{
+		.lut_size = LUT3D_SIZE,
+		.format = DRM_FORMAT_XBGR16161616,
+		.modifier = DRM_FORMAT_MOD_LINEAR,
+		.pitch = 256,
+		.traversal_order = DRM_COLOROP_LUT3D_TRAVERSAL_RGB,
+		.interpolation = DRM_COLOROP_LUT3D_INTERPOLATION_TETRAHEDRAL,
+	},
+};
+
 static const struct drm_colorop_funcs dm_colorop_funcs = {
 	.destroy = drm_colorop_destroy,
 };
@@ -115,7 +127,8 @@ EXPORT_IF_KUNIT(amdgpu_dm_colorop_kunit_set_ops);
 
 STATIC_IFN_KUNIT int
 amdgpu_dm_build_default_pipeline(struct drm_device *dev, struct drm_plane *plane,
-				  bool hw_3d_lut, struct drm_prop_enum_list *list)
+				  bool hw_3d_lut, bool dma_3d_lut,
+				  struct drm_prop_enum_list *list)
 {
 	struct drm_colorop *ops[MAX_COLOR_PIPELINE_OPS];
 	int ret;
@@ -225,17 +238,23 @@ amdgpu_dm_build_default_pipeline(struct drm_device *dev, struct drm_plane *plane
 
 		i++;
 
-		/* 3D LUT */
+		/* 3D LUT - host loading, or DMA (fast-loading) */
 		ops[i] = colorop_kzalloc_obj();
 		if (!ops[i]) {
 			ret = -ENOMEM;
 			goto cleanup;
 		}
 
-		ret = colorop_3dlut_init(dev, ops[i], plane, &dm_colorop_funcs,
-					 LUT3D_SIZE,
-					 DRM_COLOROP_LUT3D_INTERPOLATION_TETRAHEDRAL,
-					 DRM_COLOROP_FLAG_ALLOW_BYPASS);
+		if (dma_3d_lut)
+			ret = drm_plane_colorop_3dlut_dma_init(dev, ops[i], plane,
+					&dm_colorop_funcs, amdgpu_dm_3dlut_dma_modes,
+					ARRAY_SIZE(amdgpu_dm_3dlut_dma_modes),
+					DRM_COLOROP_FLAG_ALLOW_BYPASS);
+		else
+			ret = colorop_3dlut_init(dev, ops[i], plane,
+					&dm_colorop_funcs, LUT3D_SIZE,
+					DRM_COLOROP_LUT3D_INTERPOLATION_TETRAHEDRAL,
+					DRM_COLOROP_FLAG_ALLOW_BYPASS);
 		if (ret)
 			goto cleanup;
 
@@ -298,6 +317,16 @@ int amdgpu_dm_initialize_default_pipeline(struct drm_plane *plane, struct drm_pr
 	bool hw_3d_lut = adev->dm.dc->caps.color.dpp.hw_3d_lut ||
 			 adev->dm.dc->caps.color.mpc.preblend;
 
-	return amdgpu_dm_build_default_pipeline(dev, plane, hw_3d_lut, list);
+	return amdgpu_dm_build_default_pipeline(dev, plane, hw_3d_lut, false, list);
 }
 EXPORT_IF_KUNIT(amdgpu_dm_initialize_default_pipeline);
+
+int amdgpu_dm_initialize_dma_3dlut_pipeline(struct drm_plane *plane, struct drm_prop_enum_list *list)
+{
+	struct drm_device *dev = plane->dev;
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	bool hw_3d_lut = adev->dm.dc->caps.color.dpp.hw_3d_lut ||
+			 adev->dm.dc->caps.color.mpc.preblend;
+
+	return amdgpu_dm_build_default_pipeline(dev, plane, hw_3d_lut, true, list);
+}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h
index edf7df7c19e9..510c367f8ca5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h
@@ -33,6 +33,7 @@ extern const u64 amdgpu_dm_supported_blnd_tfs;
 extern const u64 amdgpu_dm_supported_fm;
 
 int amdgpu_dm_initialize_default_pipeline(struct drm_plane *plane, struct drm_prop_enum_list *list);
+int amdgpu_dm_initialize_dma_3dlut_pipeline(struct drm_plane *plane, struct drm_prop_enum_list *list);
 
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 #include <drm/drm_colorop.h>
@@ -63,7 +64,8 @@ struct amdgpu_dm_colorop_kunit_ops {
 };
 
 int amdgpu_dm_build_default_pipeline(struct drm_device *dev, struct drm_plane *plane,
-				      bool hw_3d_lut, struct drm_prop_enum_list *list);
+				      bool hw_3d_lut, bool dma_3d_lut,
+				      struct drm_prop_enum_list *list);
 void amdgpu_dm_colorop_kunit_set_ops(const struct amdgpu_dm_colorop_kunit_ops *ops);
 #endif
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 91398230d408..21fe005fe583 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -2172,6 +2172,23 @@ dm_plane_init_colorops(struct drm_plane *plane)
 
 	/* initialize pipeline */
 	if (dc->ctx->dce_version >= DCN_VERSION_3_0) {
+		/*
+		 * Advertise the DMA (fast-load) 3D LUT pipeline first
+		 * so that userspace which understands it prefers it
+		 * over the host-loading 3D LUT pipeline.
+		 */
+		if (IS_ENABLED(CONFIG_DRM_AMD_DC_3DLUT_DMA) &&
+		    dc->caps.color.mpc.mcm_3d_lut_caps.dma_3d_lut &&
+		    (dc->caps.color.dpp.hw_3d_lut || dc->caps.color.mpc.preblend)) {
+			ret = amdgpu_dm_initialize_dma_3dlut_pipeline(plane, &pipelines[len]);
+			if (ret) {
+				drm_err(plane->dev, "Failed to create DMA 3D LUT pipeline for plane %d: %d\n",
+					plane->base.id, ret);
+				goto out;
+			}
+			len++;
+		}
+
 		ret = amdgpu_dm_initialize_default_pipeline(plane, &pipelines[len]);
 		if (ret) {
 			drm_err(plane->dev, "Failed to create color pipeline for plane %d: %pe\n",
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
index 90cc5592ef5d..49d1d252a67d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
@@ -208,7 +208,7 @@ static void dm_test_initialize_default_pipeline(struct kunit *test)
 
 	plane = dm_colorop_alloc_plane(test, &drm);
 
-	ret = amdgpu_dm_build_default_pipeline(drm, plane, true, &list);
+	ret = amdgpu_dm_build_default_pipeline(drm, plane, true, false, &list);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 	kfree(list.name);
 
@@ -430,7 +430,7 @@ static int dm_colorop_build_with_fault(struct kunit *test, struct drm_device **d
 	amdgpu_dm_colorop_kunit_set_ops(&dm_colorop_test_ops);
 	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dm_colorop_test_reset_ops, NULL), 0);
 
-	ret = amdgpu_dm_build_default_pipeline(*drm, plane, true, &list);
+	ret = amdgpu_dm_build_default_pipeline(*drm, plane, true, false, &list);
 	kfree(list.name);
 
 	return ret;
-- 
2.56.0

