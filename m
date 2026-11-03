Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D998606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 21:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=e+j3qbNf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70EF010F896;
	Tue,  3 Nov 2026 21:38:32 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010031.outbound.protection.outlook.com [52.101.201.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A1CB10E1C6;
 Tue,  3 Nov 2026 21:38:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqdr7TochMlJCNDeoAPb/CrALqK+6FnZjYSYiIa6dlA6nEsPxs7vWwqw2iElzX+KYT5MqQHABfo34fpt+v7bVZPmtyWlZ3OLtdvQqcV3N48cR41kGMRrxiMBRXtqBbS1Pf37C6gUkrBo8CEd9sRzgNSavdQ4iY01SRCxRkl4/iw5lku9uT1bDvUgc693BXEZ7uiER/XLTI7Gs7yjq4nQ0Ho1vGFiNwwSZq6Ud/HB83TZCD36FoFaudPh3wEnvGTzodRPv0AA3hICC6Z53YztEmn54Hv4ifGv3w84GuN3G0YIoXguGY+SSUzSXhdDTN+SjyPMAU0ubnS5u+OtvwNzeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IqoR6KtVJtAZNq69gX2R/Ylv0sMddwRxQmLmHngpcc=;
 b=UGUCF6iaas4H6/yLXbLEipjJvLHa7UOCDjD7VeVPaVnwHIpWCShgd3JVF+TzIaop7GIfDKk3jxGPFczImryNnfEnHT4+UT/9BxLrPQIJFwTIVwZ9kTWFbFKelzvoRQBovcON56Rg1SxMxyFhuMt9ntlcc4cB802ZPx50oTBlBrcjKsO4xTUqBcU5OepIb8MeqE+THvQgi8XkoP9a8HTp/TW54EbcrYtR0vDUcIzSi0SaBpaIY+hX2aedaO7DxMd0hDsiytYcjPzUevU06EwuGkOFVNXzjGzzlDhdvw7kOBbAzbvuOxk8w87fnqS/FHRCliN4CI+E0HqbymOoM+WEqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IqoR6KtVJtAZNq69gX2R/Ylv0sMddwRxQmLmHngpcc=;
 b=e+j3qbNfHTRf4KTeyCMfQsnFkRs3CY0YZHtmWQS56M7VdE7NQ9LD+rJ2oo1mfzZPrxf81bUbgE8vntEWQ1P5g7t6MbK16EktmPg2tZXG6cnTi2U4dozSCIIdqe0FvxsMBMialxLp8dei8JJqRqzDimgQ2257drEvXK4bnLl9g4c=
Received: from BN1PR13CA0002.namprd13.prod.outlook.com (2603:10b6:408:e2::7)
 by PH7PR12MB7332.namprd12.prod.outlook.com (2603:10b6:510:20f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 21:38:11 +0000
Received: from BN1PEPF00018071.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::4) by BN1PR13CA0002.outlook.office365.com
 (2603:10b6:408:e2::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 21:38:11 +0000
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
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 21:38:11 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 15:38:08 -0600
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 3 Nov 2026 15:38:08 -0600
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v1 13/13] drm/amd/display: add KUnit tests for the DMA 3D LUT
 colorop
Date: Tue, 3 Nov 2026 16:37:56 -0500
Message-ID: <20261103213756.618024-14-harry.wentland@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103213756.618024-1-harry.wentland@amd.com>
References: <20261103213756.618024-1-harry.wentland@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018071:EE_|PH7PR12MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e0d75a3-9d8f-4099-4a39-08df39f2c252
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|261102123227099003|11063799006|261022105027099003|56012099006|261009223027099003|261021121427099003|261102130727099003|261026121527099003|261028144727099003|261026140227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: VeZkd5E61FDrodWD7ImaIHDh1lRIqVFvwJ3BfO8d8xM+NAMSgEzrd4Vtf6hMELgHGOxP3KzLE7RtbtIkV+MdZeN1CygEUdIM2BOWq2gdx16gXSpKCN6k5Y8PPOwWIRRNo7LPcl4fSBieHUQ3k2sXucVm6dIctoG9E9ftl2MIEM9gxmBYVNeuA+0PTT4dlq/7nXfxZafMVb8E3VRTyOHo/xF1hFVS4D47p+MjBJMYumAgEk1h6ZaNAm/SmP+MituzJJp6e0W+D620bpsUJprrqHsmTpRxSJg5haO7cBTaed8LezrDPiarQj/LrkQj0aLFDTBQuvfLAKbJaXeF3ReMvjStMer7hkyDISEsVSxkA4oJBFhJaNV+RZ0cgW2VPIfktoRKIBPemmFMWIsL2BvsLwhM2eoaFqr5KL4q9hjKGYTYysXx7GJ+EwYYCaFy8UrVsbg4+vDo+P89Mt4GfPr5ZS9eRgenqcDv0LM+PRaYV4fCm/7VkhFD1sRRVzFtXy5I9732H1LLOfyna6DLd6RHcLdPHp7+oetL5j3GMNlkhyNl8FAI925mp81DeqkrAcHkYM6eMdj0yjchEPGjcrn1lGNbL0tYIuS/nRPdtDsTPwJb8RhUF8mgFEe4sTdsg5W6N+BCyZx9zptncUY+tzAeFiVqCYRggHnt/AvzS6ePprhXhjE/+L7QSAzWIq0FDHOq4vAWVnAhFTVSGaTEy/C8Qg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(261102123227099003)(11063799006)(261022105027099003)(56012099006)(261009223027099003)(261021121427099003)(261102130727099003)(261026121527099003)(261028144727099003)(261026140227099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8oNuZ2EOBTgBx6gR2Zt8yDiivUFFdtLR0qn4snod8i8B2OckdTaptWuXdSbZwBOY8hCXRHgD76K7KkW2/PK10HFVXPc0n1SMfKNbWCR2NEUvygNcPkfYNKkLMAQLvHpZmVdhtyA0gFcXyfGZl8U1Ve1GP6iYluR0U5iw3kl+PgGF3sAAJC6M9d4tZnBilzyoOCvEgxR1aio6yMEWw1BYAaVWO9fOBQqmYWx4BppAUueH6NIeRBYnH7VHq/y3uk0At6c73RSLdszIwzkJjfHjZk4HA+FC/TyAqlWDZgPl9ZRJ3w1sO720fnpiC8RR/zSIRVSQFuRFV+y8XnSvoQhEi7Cf87RZoFCEBpETx+ti4rEQh0FSV8SyTgwqF/TGSkJTCVwYH/ce5SMYrnNjL0lgeH9Tn9d2KODXqZj/p1mY2k6nWOLOrL8LOe5ywUieGpbu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 21:38:11.4491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0d75a3-9d8f-4099-4a39-08df39f2c252
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7332
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

The DMA 3D LUT pipeline is not covered by the colorop tests, which
always build the pipeline with a host-loaded 3D LUT.

Export amdgpu_dm_colorop_dma_3dlut_active() and
amdgpu_dm_initialize_dma_3dlut_pipeline() for KUnit and test that:

- the 3D LUT slot becomes a bypassable DMA 3D LUT colorop advertising
  the given mode, and only it has prepare_fb and cleanup_fb hooks;
- no DMA 3D LUT colorop is created without 3D LUT hardware;
- the advertised mode is a 17-point XBGR16161616 linear LUT, and its
  pitch follows the DC pitch alignment;
- the LUT is only active when not bypassed and a framebuffer is set;
- prepare_fb and cleanup_fb do not touch the framebuffer of an
  inactive LUT.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c |   2 +
 .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c  | 282 ++++++++++++++++++
 2 files changed, 284 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
index b737b45fb2f4..f42339a98549 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
@@ -123,6 +123,7 @@ bool amdgpu_dm_colorop_dma_3dlut_active(const struct drm_colorop *colorop,
 	return colorop->type == DRM_COLOROP_3D_LUT_DMA && colorop_state &&
 	       !colorop_state->bypass && colorop_state->fb;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_colorop_dma_3dlut_active);
 
 /* Pinned while its colorop state is current, since DC re-fetches the LUT */
 static int dm_colorop_prepare_fb(struct drm_colorop *colorop,
@@ -414,3 +415,4 @@ int amdgpu_dm_initialize_dma_3dlut_pipeline(struct drm_plane *plane, struct drm_
 
 	return amdgpu_dm_build_default_pipeline(dev, plane, hw_3d_lut, &mode, list);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_initialize_dma_3dlut_pipeline);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
index fda30c29a81f..fadeb690b8f0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
@@ -7,7 +7,11 @@
 
 #include <kunit/test.h>
 #include <drm/drm_colorop.h>
+#include <drm/drm_fourcc.h>
+#include <drm/drm_framebuffer.h>
 #include <drm/drm_kunit_helpers.h>
+#include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_property.h>
 
 #include "dc.h"
 #include "amdgpu.h"
@@ -310,6 +314,277 @@ static void dm_test_initialize_default_pipeline_no_3d_lut(struct kunit *test)
 						 expected, ARRAY_SIZE(expected));
 }
 
+/* Tests for the DMA (fast-loading) 3D LUT pipeline */
+
+static const enum drm_colorop_type dm_dma_3dlut_pipeline[] = {
+	DRM_COLOROP_1D_CURVE,	/* degam TF */
+	DRM_COLOROP_MULTIPLIER,
+	DRM_COLOROP_CTM_3X4,
+	DRM_COLOROP_1D_CURVE,	/* shaper TF */
+	DRM_COLOROP_1D_LUT,	/* shaper LUT */
+	DRM_COLOROP_3D_LUT_DMA,
+	DRM_COLOROP_1D_CURVE,	/* blnd TF */
+	DRM_COLOROP_1D_LUT,	/* blnd LUT */
+};
+
+static const struct drm_mode_3dlut_mode dm_dma_3dlut_test_mode = {
+	.lut_size = 17,
+	.format = DRM_FORMAT_XBGR16161616,
+	.modifier = DRM_FORMAT_MOD_LINEAR,
+	.pitch = 256,
+	.traversal_order = DRM_COLOROP_LUT3D_TRAVERSAL_RGB,
+	.interpolation = DRM_COLOROP_LUT3D_INTERPOLATION_TETRAHEDRAL,
+};
+
+static struct drm_colorop *dm_find_dma_3dlut_colorop(struct kunit *test,
+						     struct drm_device *drm)
+{
+	struct drm_colorop *op;
+
+	drm_for_each_colorop(op, drm)
+		if (op->type == DRM_COLOROP_3D_LUT_DMA)
+			return op;
+
+	KUNIT_FAIL_AND_ABORT(test, "no DMA 3D LUT colorop\n");
+	return NULL;
+}
+
+static const struct drm_mode_3dlut_mode *
+dm_expect_dma_3dlut_formats(struct kunit *test, struct drm_colorop *op)
+{
+	struct drm_property_blob *blob = op->lut_3d_formats_blob;
+
+	KUNIT_ASSERT_NOT_NULL(test, blob);
+	KUNIT_ASSERT_EQ(test, blob->length, sizeof(struct drm_mode_3dlut_mode));
+
+	return blob->data;
+}
+
+/**
+ * dm_test_build_dma_3dlut_pipeline() - Verify the 3D LUT slot becomes a DMA
+ *   3D LUT colorop advertising the given mode, and only it pins framebuffers.
+ * @test: KUnit test context.
+ */
+static void dm_test_build_dma_3dlut_pipeline(struct kunit *test)
+{
+	const struct drm_colorop_helper_funcs *funcs;
+	const struct drm_mode_3dlut_mode *mode;
+	struct drm_prop_enum_list list = {};
+	struct drm_colorop *op;
+	struct drm_device *drm;
+	struct drm_plane *plane;
+	int ret;
+
+	plane = dm_colorop_alloc_plane(test, &drm);
+
+	ret = amdgpu_dm_build_default_pipeline(drm, plane, true,
+					       &dm_dma_3dlut_test_mode, &list);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	kfree(list.name);
+
+	dm_expect_colorop_pipeline(test, drm, &list, dm_dma_3dlut_pipeline,
+				   ARRAY_SIZE(dm_dma_3dlut_pipeline));
+
+	drm_for_each_colorop(op, drm) {
+		if (op->type == DRM_COLOROP_3D_LUT_DMA)
+			continue;
+		KUNIT_EXPECT_NULL(test, op->helper_private);
+	}
+
+	op = dm_find_dma_3dlut_colorop(test, drm);
+	KUNIT_EXPECT_NOT_NULL(test, op->fb_property);
+	KUNIT_EXPECT_NOT_NULL(test, op->lut_3d_format_property);
+	KUNIT_EXPECT_NOT_NULL(test, op->lut_3d_formats_property);
+
+	funcs = op->helper_private;
+	KUNIT_ASSERT_NOT_NULL(test, funcs);
+	KUNIT_EXPECT_NOT_NULL(test, funcs->prepare_fb);
+	KUNIT_EXPECT_NOT_NULL(test, funcs->cleanup_fb);
+
+	mode = dm_expect_dma_3dlut_formats(test, op);
+	KUNIT_EXPECT_MEMEQ(test, mode, &dm_dma_3dlut_test_mode, sizeof(*mode));
+}
+
+/**
+ * dm_test_build_dma_3dlut_pipeline_no_3d_lut() - Verify no DMA 3D LUT colorop
+ *   is created without 3D LUT hardware.
+ * @test: KUnit test context.
+ */
+static void dm_test_build_dma_3dlut_pipeline_no_3d_lut(struct kunit *test)
+{
+	static const enum drm_colorop_type expected[] = {
+		DRM_COLOROP_1D_CURVE,
+		DRM_COLOROP_MULTIPLIER,
+		DRM_COLOROP_CTM_3X4,
+		DRM_COLOROP_1D_CURVE,
+		DRM_COLOROP_1D_LUT,
+	};
+	struct drm_prop_enum_list list = {};
+	struct drm_device *drm;
+	struct drm_plane *plane;
+	int ret;
+
+	plane = dm_colorop_alloc_plane(test, &drm);
+
+	ret = amdgpu_dm_build_default_pipeline(drm, plane, false,
+					       &dm_dma_3dlut_test_mode, &list);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	kfree(list.name);
+
+	dm_expect_colorop_pipeline(test, drm, &list, expected, ARRAY_SIZE(expected));
+}
+
+struct dm_dma_3dlut_pitch_param {
+	const char *name;
+	u32 pitch_alignment;
+	u32 pitch;
+};
+
+/* A 17-entry row of XBGR16161616 is 136 bytes. */
+static const struct dm_dma_3dlut_pitch_param dm_dma_3dlut_pitch_params[] = {
+	{ "align_1",	1,	136 },
+	{ "align_64",	64,	192 },
+	{ "align_256",	256,	256 },
+};
+
+KUNIT_ARRAY_PARAM_DESC(dm_dma_3dlut_pitch, dm_dma_3dlut_pitch_params, name);
+
+/**
+ * dm_test_initialize_dma_3dlut_pipeline() - Verify the advertised DMA 3D LUT
+ *   mode, and that its pitch follows the DC pitch alignment.
+ * @test: KUnit test context.
+ */
+static void dm_test_initialize_dma_3dlut_pipeline(struct kunit *test)
+{
+	const struct dm_dma_3dlut_pitch_param *param = test->param_value;
+	const struct drm_mode_3dlut_mode *mode;
+	struct drm_prop_enum_list list = {};
+	struct amdgpu_device *adev;
+	struct drm_device *drm;
+	struct drm_plane *plane;
+	struct dc *dc;
+	int ret;
+
+	adev = dm_kunit_alloc_adev(test);
+	drm = &adev->ddev;
+
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
+	adev->dm.dc = dc;
+	dc->caps.color.mpc.preblend = true;
+	dc->caps.color.mpc.mcm_3d_lut_caps.pitch_alignment = param->pitch_alignment;
+
+	plane = drm_kunit_helper_create_primary_plane(test, drm, NULL, NULL,
+						      NULL, 0, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane);
+
+	kunit_add_action(test, kunit_colorop_pipeline_destroy, drm);
+
+	ret = amdgpu_dm_initialize_dma_3dlut_pipeline(plane, &list);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	kfree(list.name);
+
+	dm_expect_colorop_pipeline(test, drm, &list, dm_dma_3dlut_pipeline,
+				   ARRAY_SIZE(dm_dma_3dlut_pipeline));
+
+	mode = dm_expect_dma_3dlut_formats(test, dm_find_dma_3dlut_colorop(test, drm));
+	KUNIT_EXPECT_EQ(test, mode->lut_size, 17);
+	KUNIT_EXPECT_EQ(test, mode->format, DRM_FORMAT_XBGR16161616);
+	KUNIT_EXPECT_EQ(test, mode->modifier, DRM_FORMAT_MOD_LINEAR);
+	KUNIT_EXPECT_EQ(test, mode->pitch, param->pitch);
+	KUNIT_EXPECT_EQ(test, mode->traversal_order, DRM_COLOROP_LUT3D_TRAVERSAL_RGB);
+	KUNIT_EXPECT_EQ(test, mode->interpolation,
+			DRM_COLOROP_LUT3D_INTERPOLATION_TETRAHEDRAL);
+	KUNIT_EXPECT_EQ(test, mode->flags, 0);
+}
+
+/**
+ * dm_test_colorop_dma_3dlut_active() - Verify the DMA 3D LUT is only active
+ *   when not bypassed and a framebuffer is set.
+ * @test: KUnit test context.
+ */
+static void dm_test_colorop_dma_3dlut_active(struct kunit *test)
+{
+	struct drm_colorop_state *state;
+	struct drm_framebuffer *fb;
+	struct drm_colorop *op;
+
+	op = kunit_kzalloc(test, sizeof(*op), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, op);
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state);
+	fb = kunit_kzalloc(test, sizeof(*fb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fb);
+
+	op->type = DRM_COLOROP_3D_LUT_DMA;
+	state->colorop = op;
+	state->bypass = false;
+	state->fb = fb;
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_colorop_dma_3dlut_active(op, state));
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_colorop_dma_3dlut_active(op, NULL));
+
+	state->bypass = true;
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_colorop_dma_3dlut_active(op, state));
+
+	state->bypass = false;
+	state->fb = NULL;
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_colorop_dma_3dlut_active(op, state));
+
+	state->fb = fb;
+	op->type = DRM_COLOROP_3D_LUT;
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_colorop_dma_3dlut_active(op, state));
+}
+
+/**
+ * dm_test_dma_3dlut_inactive_prepare_cleanup() - Verify prepare_fb and
+ *   cleanup_fb leave a bypassed or framebuffer-less DMA 3D LUT alone.
+ * @test: KUnit test context.
+ *
+ * The framebuffer has no GEM object, so any attempt to pin it would fail or
+ * crash.
+ */
+static void dm_test_dma_3dlut_inactive_prepare_cleanup(struct kunit *test)
+{
+	const struct drm_colorop_helper_funcs *funcs;
+	struct drm_prop_enum_list list = {};
+	struct drm_colorop_state *state;
+	struct drm_framebuffer *fb;
+	struct drm_colorop *op;
+	struct drm_device *drm;
+	struct drm_plane *plane;
+	int ret;
+
+	plane = dm_colorop_alloc_plane(test, &drm);
+
+	ret = amdgpu_dm_build_default_pipeline(drm, plane, true,
+					       &dm_dma_3dlut_test_mode, &list);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	kfree(list.name);
+
+	op = dm_find_dma_3dlut_colorop(test, drm);
+	funcs = op->helper_private;
+	KUNIT_ASSERT_NOT_NULL(test, funcs);
+
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state);
+	fb = kunit_kzalloc(test, sizeof(*fb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fb);
+	state->colorop = op;
+
+	/* Bypassed, but still pointing at a framebuffer */
+	state->bypass = true;
+	state->fb = fb;
+	KUNIT_EXPECT_EQ(test, funcs->prepare_fb(op, state), 0);
+	funcs->cleanup_fb(op, state);
+
+	/* Enabled without a framebuffer */
+	state->bypass = false;
+	state->fb = NULL;
+	KUNIT_EXPECT_EQ(test, funcs->prepare_fb(op, state), 0);
+	funcs->cleanup_fb(op, state);
+}
+
 /* Failure paths of amdgpu_dm_build_default_pipeline() */
 
 /*
@@ -517,6 +792,13 @@ static struct kunit_case dm_colorop_test_cases[] = {
 	KUNIT_CASE(dm_test_initialize_default_pipeline_dpp_3d_lut),
 	KUNIT_CASE(dm_test_initialize_default_pipeline_mpc_preblend),
 	KUNIT_CASE(dm_test_initialize_default_pipeline_no_3d_lut),
+	/* DMA 3D LUT */
+	KUNIT_CASE(dm_test_build_dma_3dlut_pipeline),
+	KUNIT_CASE(dm_test_build_dma_3dlut_pipeline_no_3d_lut),
+	KUNIT_CASE_PARAM(dm_test_initialize_dma_3dlut_pipeline,
+			 dm_dma_3dlut_pitch_gen_params),
+	KUNIT_CASE(dm_test_colorop_dma_3dlut_active),
+	KUNIT_CASE(dm_test_dma_3dlut_inactive_prepare_cleanup),
 	/* amdgpu_dm_build_default_pipeline failure paths */
 	KUNIT_CASE_PARAM(dm_test_build_pipeline_alloc_fail, dm_colorop_step_gen_params),
 	KUNIT_CASE_PARAM(dm_test_build_pipeline_init_fail, dm_colorop_step_gen_params),
-- 
2.56.0

