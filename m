Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1627F606A326
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 21:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ukEWphyA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94E6110E391;
	Tue,  3 Nov 2026 21:38:25 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011037.outbound.protection.outlook.com
 [40.93.194.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2B8810E1D6;
 Tue,  3 Nov 2026 21:38:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=poUNxBbsywdETh/MkGKPU5YxxHo4mHEOAXF7V2k0G6CrTBwuyCpev7hIhbTXxRXoBq3Y/2dc2lucDWphW9s7oe5TDwFpuWxpVkJ7cx7JeMpyt1e+XeLHS46dvwdkNX3/ydxwdDTn6kEmC8qYZOlwVpwz+D9rUJ/M//hGstfmrgLcAvpLLS0vroBGva5YVXcaplvL0XBhk4SA1ieD2slZ3MNDAQu6a2qFohOtnLwBkzgysES1kk+bBWj5vZek3Jjqew8JEbJDck14lJNAKtUNdUT8N1OwzXg57kSfSeRpvrXQ/YPo3W1FibgDNXp/KlY+sCOD+jOSM3m/MMpQOSm/uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGO1KcJs+Djpm1kcDsRx1j43qRGMPkNq1eTgOv37ZOw=;
 b=dneQ4YpDt7PBADbXVqVg6PqM+FVKFJ6YU6zABIpC7FIOz8dqNWWmxesBPOWeobxvonPgvaDTvYPLVO6LQt/0KFBd2OIdwJeA/H+Tz3vAfV3zRqrnst45ZSje54tuc4BgTJgiB4sr6kKpvqVfFJIXc19LYYH2fIEXKIZfFQl4kLDGPsXLnEEUX7fcrurcQBXVOSmAW+Qz21/YVd/bDwWwk1GawCkrmVlPbk3WGpf+DeNr4ukITwYIQcILzy/RPDe36jbBpBBSty/NknERescsafTCf0mOtF7b4BgsZCWD2SiOeu/8dWs/pbMkWBwhQYp52CmUDS+oZGkVPnwtfx4Xcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGO1KcJs+Djpm1kcDsRx1j43qRGMPkNq1eTgOv37ZOw=;
 b=ukEWphyASLJGY1qIBc2Ew24YCHOZc7Wy1gABIFXs5vYUK10lr5GttxQJp65kAPa3/WGUEUtNBO3GSDI6wTDqkLNVHy0H6OxzRk/+Lq+7L+PBWLpSEYEeKzHwt+qjGdb+rAoqfJN1DMb56MP3mbSoxjy4W5qWczzunD57Vb7w/DQ=
Received: from BN1PR13CA0019.namprd13.prod.outlook.com (2603:10b6:408:e2::24)
 by SJ0PR12MB8138.namprd12.prod.outlook.com (2603:10b6:a03:4e0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 21:38:11 +0000
Received: from BN1PEPF00018071.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::1f) by BN1PR13CA0019.outlook.office365.com
 (2603:10b6:408:e2::24) with Microsoft SMTP Server (version=TLS1_3,
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
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 15:38:08 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 15:38:07 -0600
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 3 Nov 2026 15:38:07 -0600
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v1 11/13] drm/amd/display: derive the DMA 3D LUT pitch from DC
 caps
Date: Tue, 3 Nov 2026 16:37:54 -0500
Message-ID: <20261103213756.618024-12-harry.wentland@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103213756.618024-1-harry.wentland@amd.com>
References: <20261103213756.618024-1-harry.wentland@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018071:EE_|SJ0PR12MB8138:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d9abac-93f8-4e27-565e-08df39f2c1ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|23010399003|1800799024|261026140227099003|261028144727099003|261026121527099003|261009223027099003|261102130727099003|261102123227099003|261021121427099003|261022105027099003|261021123027099003|11063799006|56012099006|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Kt0DVaukOdQQrhagzYNkxHNNgUhmVaN2vPFFLyD/sJ47lSLsPY8Yw6GRuQylQMi1Nqtuck+9RI/I5npzXqD+VyKV684p48FTWG9rg7SKN2fQ2rwrMFP9b69GN9VIpNtm2KrhJejSUj9iAQQXfJ/io7A2E4sSKmr3ZXDnruQpwZ6Z811GyFs41sDnOix4oPpsLgQgD9m/PnKP+6216rZtqeoaiI6OrRE/EdysYkohDvHkiGh2Mrp5gVy8fT2EyEeaaTwHYn70Kl+j3bpbR59s3Wxv6ebJg4h5i0tb7lNIHhZAJh1r6GPCiepRrNK9qi3TXzOI8LkgcfmOdt4Wa2puEkoQCwtMT6VaPZ2e7xp+Q70L6+biNvmSpwngt4gURpXQgU5ZTAcDs1uCChClkIphJM0/wzI9deYpex1Y3tLtt7nef1xnOXNMXEYrMmuzfUdIVyqTtQ6b2kIV/jxTlnf7Ic65pGrdWFvRACGL3xCpW/vltUUJ6rIK7a9ztauHKHL0iJz7CvRmndrdYCwRG1awjIDvfEztSzIbFohaybnIpCMSlgqNLHLKFp3xF2YpvsA/yQEAAiFslZil4zwoUkhppqpdPeoonh2D7R+xzHAuHpotBwUGEI607ZzJBSKDHcW3+2BqL4YMPy5mL5fGIfEBrQE81iSh2fH0tnrX9eDukUshynMHPZsOOeHWaDNQQkqDpepiiHqSz8Vte3VGR/DIrg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(1800799024)(261026140227099003)(261028144727099003)(261026121527099003)(261009223027099003)(261102130727099003)(261102123227099003)(261021121427099003)(261022105027099003)(261021123027099003)(11063799006)(56012099006)(6133799003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: X65Mpxr/YgWIuozKaeU2haORCLJGFZykqXo4CEgnIWdwTeBoeiyqVk8IjUzCIIkGKHX5S0uarihq4YPkgq5You4SuZqk4/uFsZSmiNb5pgXE1hMYQ/aOeHybd83Ek/hdOk6DUCafsereIA9k6J583+Xxivqmcd0vhFIbRGCDdjptbk+w+uh/kZvE6OKFbIPxW8tdqUg0sRymI+Z6j6p1I6gd3KwOdph8yIcsj/fE4Ji4GhkVD+20rr6nbA16vbQEzZcc7GD3968MGbm8fd0I48bO658FBE9/55JPBXWcmB1WlSd/uzVvT+OJt9UmzMpF80KipX7fKcCXMnLJugYIiQn+vovY07OgZIaOT/mD79jb0I/xelEa1clmwzMIoI3GRZcjWxZVXr8TeyA3OG5tbtxrYMZHX725a5HOg6D+hW90MrNEy9cwbHHXG8aJvyCS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 21:38:10.5599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d9abac-93f8-4e27-565e-08df39f2c1ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8138
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The LUT_3D_FORMATS entry of the DMA 3D LUT colorop hard-codes a 256-byte
row pitch. The required pitch depends on the row alignment of the DCN
generation, which DC now reports through the 3D LUT pitch_alignment cap.

Build the advertised mode when the DMA 3D LUT pipeline is created and
compute its pitch by aligning one LUT row to the reported alignment.
Only expose the DMA 3D LUT pipeline when DC reports a pitch alignment.

For the 17x17x17 XBGR16161616 LUT the pitch remains 256 bytes for both
128- and 256-byte alignment, so this has no functional effect on
current hardware.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c | 33 +++++++++----------
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.h |  3 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  1 +
 .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c  |  4 +--
 4 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
index 5e6e40b5fd7d..b737b45fb2f4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
@@ -72,17 +72,6 @@ const u64 amdgpu_dm_supported_fm =
 
 #define LUT3D_SIZE		17
 
-static const struct drm_mode_3dlut_mode amdgpu_dm_3dlut_dma_modes[] = {
-	{
-		.lut_size = LUT3D_SIZE,
-		.format = DRM_FORMAT_XBGR16161616,
-		.modifier = DRM_FORMAT_MOD_LINEAR,
-		.pitch = 256,
-		.traversal_order = DRM_COLOROP_LUT3D_TRAVERSAL_RGB,
-		.interpolation = DRM_COLOROP_LUT3D_INTERPOLATION_TETRAHEDRAL,
-	},
-};
-
 static const struct drm_colorop_funcs dm_colorop_funcs = {
 	.destroy = drm_colorop_destroy,
 };
@@ -210,7 +199,8 @@ static const struct drm_colorop_helper_funcs dm_colorop_helper_funcs = {
 
 STATIC_IFN_KUNIT int
 amdgpu_dm_build_default_pipeline(struct drm_device *dev, struct drm_plane *plane,
-				  bool hw_3d_lut, bool dma_3d_lut,
+				  bool hw_3d_lut,
+				  const struct drm_mode_3dlut_mode *dma_3dlut_mode,
 				  struct drm_prop_enum_list *list)
 {
 	struct drm_colorop *ops[MAX_COLOR_PIPELINE_OPS];
@@ -328,10 +318,9 @@ amdgpu_dm_build_default_pipeline(struct drm_device *dev, struct drm_plane *plane
 			goto cleanup;
 		}
 
-		if (dma_3d_lut) {
+		if (dma_3dlut_mode) {
 			ret = drm_plane_colorop_3dlut_dma_init(dev, ops[i], plane,
-					&dm_colorop_funcs, amdgpu_dm_3dlut_dma_modes,
-					ARRAY_SIZE(amdgpu_dm_3dlut_dma_modes),
+					&dm_colorop_funcs, dma_3dlut_mode, 1,
 					DRM_COLOROP_FLAG_ALLOW_BYPASS);
 			drm_colorop_helper_add(ops[i], &dm_colorop_helper_funcs);
 		} else {
@@ -402,7 +391,7 @@ int amdgpu_dm_initialize_default_pipeline(struct drm_plane *plane, struct drm_pr
 	bool hw_3d_lut = adev->dm.dc->caps.color.dpp.hw_3d_lut ||
 			 adev->dm.dc->caps.color.mpc.preblend;
 
-	return amdgpu_dm_build_default_pipeline(dev, plane, hw_3d_lut, false, list);
+	return amdgpu_dm_build_default_pipeline(dev, plane, hw_3d_lut, NULL, list);
 }
 EXPORT_IF_KUNIT(amdgpu_dm_initialize_default_pipeline);
 
@@ -412,6 +401,16 @@ int amdgpu_dm_initialize_dma_3dlut_pipeline(struct drm_plane *plane, struct drm_
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	bool hw_3d_lut = adev->dm.dc->caps.color.dpp.hw_3d_lut ||
 			 adev->dm.dc->caps.color.mpc.preblend;
+	struct drm_mode_3dlut_mode mode = {
+		.lut_size = LUT3D_SIZE,
+		.format = DRM_FORMAT_XBGR16161616,
+		.modifier = DRM_FORMAT_MOD_LINEAR,
+		.traversal_order = DRM_COLOROP_LUT3D_TRAVERSAL_RGB,
+		.interpolation = DRM_COLOROP_LUT3D_INTERPOLATION_TETRAHEDRAL,
+	};
 
-	return amdgpu_dm_build_default_pipeline(dev, plane, hw_3d_lut, true, list);
+	mode.pitch = ALIGN(mode.lut_size * drm_format_info(mode.format)->cpp[0],
+			   adev->dm.dc->caps.color.mpc.mcm_3d_lut_caps.pitch_alignment);
+
+	return amdgpu_dm_build_default_pipeline(dev, plane, hw_3d_lut, &mode, list);
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h
index 58604773db75..ac0f26ffef32 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h
@@ -67,7 +67,8 @@ struct amdgpu_dm_colorop_kunit_ops {
 };
 
 int amdgpu_dm_build_default_pipeline(struct drm_device *dev, struct drm_plane *plane,
-				      bool hw_3d_lut, bool dma_3d_lut,
+				      bool hw_3d_lut,
+				      const struct drm_mode_3dlut_mode *dma_3dlut_mode,
 				      struct drm_prop_enum_list *list);
 void amdgpu_dm_colorop_kunit_set_ops(const struct amdgpu_dm_colorop_kunit_ops *ops);
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 469041145196..aad146d9c6a7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -2217,6 +2217,7 @@ dm_plane_init_colorops(struct drm_plane *plane)
 		 */
 		if (IS_ENABLED(CONFIG_DRM_AMD_DC_3DLUT_DMA) &&
 		    dc->caps.color.mpc.mcm_3d_lut_caps.dma_3d_lut &&
+		    dc->caps.color.mpc.mcm_3d_lut_caps.pitch_alignment &&
 		    (dc->caps.color.dpp.hw_3d_lut || dc->caps.color.mpc.preblend)) {
 			ret = amdgpu_dm_initialize_dma_3dlut_pipeline(plane, &pipelines[len]);
 			if (ret) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
index 49d1d252a67d..fda30c29a81f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
@@ -208,7 +208,7 @@ static void dm_test_initialize_default_pipeline(struct kunit *test)
 
 	plane = dm_colorop_alloc_plane(test, &drm);
 
-	ret = amdgpu_dm_build_default_pipeline(drm, plane, true, false, &list);
+	ret = amdgpu_dm_build_default_pipeline(drm, plane, true, NULL, &list);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 	kfree(list.name);
 
@@ -430,7 +430,7 @@ static int dm_colorop_build_with_fault(struct kunit *test, struct drm_device **d
 	amdgpu_dm_colorop_kunit_set_ops(&dm_colorop_test_ops);
 	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dm_colorop_test_reset_ops, NULL), 0);
 
-	ret = amdgpu_dm_build_default_pipeline(*drm, plane, true, false, &list);
+	ret = amdgpu_dm_build_default_pipeline(*drm, plane, true, NULL, &list);
 	kfree(list.name);
 
 	return ret;
-- 
2.56.0

