Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80C5606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 21:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mbehlgU3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D326910F893;
	Tue,  3 Nov 2026 21:38:24 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010032.outbound.protection.outlook.com [52.101.56.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D333810E391;
 Tue,  3 Nov 2026 21:38:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQJx+hWow+oUPGMDYpUnjPex1KXC3KXQMVDL2Dno1MA0WTIXRRBKqmJvkeQQhySPi+fLQtoXJ79meh9Juh/+Hc/j2e0tNKW/JCSU74xmt0DhtzBmuvE3OVstYAA8kEo5wqSnAXybfu3Ojpot/YXYt5eC1njUrvrrlA5j/xYFjACT7sOeN+/4mDrpoJN+/Wm0obg69mXuKchAhPNh+NCXjukg9YyriRlga2Gs40NP+Fxg88xFm3UaXjuaMo+MNeUQ6a4kZHWj0eza02ET+MGTIQSc+e2qosc79QTuaO6eg/yW5Tmiw4MvSgKaEfW0/N/QdZF4z7IOzf0+AHOnYqC1MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9GnaKErrv14/qgaQFqn91lXgKL4eOMMyRQXxkYQ5o4=;
 b=tz5EIznIRYs5gObPQx4QKYNUWupc2T8AqWO+SGQLfpTmu86dDX1/bHCH7sc3Fnh4VSAOvGjWo/ht4lmbcAFMVwiLNcKtmheBY9JirV7Zsq0nKOJUlqMMs4E0Mqsl2l946f8YmP1tVfVfjQ0yw7CfL+cUyDIYem11bNrR7f9LBJ1/tOyEUCUH8kAyy8x+qvL+9y1mUCbXaMFkfDVs8cFXOXHJgi/BWOQJI9pEe5j/PgM8ebZxLWv9UyWQl12wILGztcDM+iZevy3h9frQqJTunJMPqjZ8vtoe8IRJxmLggg2Bjd4dzy1GKsdWoGhRKArEcbaC1nIBriCNzNXnB90ZAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9GnaKErrv14/qgaQFqn91lXgKL4eOMMyRQXxkYQ5o4=;
 b=mbehlgU3n2slsN18JCC4EYM4mB3xYle6JmNmCyF4TlpZHEUvarV8W15nT75kfGNTQ2O1oob7uXgMRMqXWqawJfIXNKjK79XSvwcRJ6JhNt86wGktZNq2S9ohl4cCjdbzWSt8hlyCSRLtvoJBAKukLRLAH4ABNwSFDRyL82XYKAc=
Received: from BN1PR13CA0024.namprd13.prod.outlook.com (2603:10b6:408:e2::29)
 by SJ2PR12MB8874.namprd12.prod.outlook.com (2603:10b6:a03:540::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 21:38:09 +0000
Received: from BN1PEPF00018071.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::6d) by BN1PR13CA0024.outlook.office365.com
 (2603:10b6:408:e2::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.9 via Frontend Transport; Tue, 3
 Nov 2026 21:38:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00018071.mail.protection.outlook.com (10.167.245.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 21:38:09 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 15:38:07 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 15:38:06 -0600
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 3 Nov 2026 15:38:06 -0600
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v1 08/13] drm/amd/display: pin the DMA 3D LUT framebuffer
Date: Tue, 3 Nov 2026 16:37:51 -0500
Message-ID: <20261103213756.618024-9-harry.wentland@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103213756.618024-1-harry.wentland@amd.com>
References: <20261103213756.618024-1-harry.wentland@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018071:EE_|SJ2PR12MB8874:EE_
X-MS-Office365-Filtering-Correlation-Id: 72165e5c-a083-4944-f086-08df39f2c14b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|10067099003|18002099003|22082099003|261102123227099003|261102130727099003|56012099006|11063799006|261022105027099003|261026121527099003|261021121427099003|261026140227099003|261009221227099003|261009223027099003|261028144727099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: RiaA24NplUFSXfPBxjg0x7ZDlP6pt395/Wrm+1XLVqXruJVoPqyQFCwzaRBy7bCuEH8OvAVzP6b5xwtTkxq+JIKJ7o/sd5Aax/kmHKO8lnJWoGV1Q9ooBO4iDFFylBFSViyo6vDIUptxnIDZbF0acPTzOly43x5U/OPUe9Z7tLpF+XEjdEP7PWIeg1vCvIuNUtUDdb70Wj2JY31rdSGSUgn1//CwtPMVRbiaP/rXUf2lLNlaZMvqLNzGVlSlOhBYjdr4+zOyeBwcX7wJrydXiiFaTEJMsgwu7UAmcslWcev+fRPXAuUWK2he71bLfAQpgB4wWApvoUmKrXjMNbMdkDaX/xIHisnUWbYfJDeu12cVGrGvt/IYAKVTboEMzLWlPDSRz7VEIl4FPcUxVO4aE1ocHb4KMerA+xQDOLUV2wEwAsYEHDM2xPGsa4tbBv3CdRqR0BKGmTLHAJdswNBFdHZy0OFJ96n18h7UsoBBQ3f92Obnkn8AhBbat1fiw6zt+kdDvlElS/ZTXviwvNP5oo+hQx8bWJNy/031766vt8kkbUQQklqb6RzHCmLTo03hanpr0bYdSif91qPUNzr5dEcNv/hsb6g5eKap1JiNqpaZn30ijclsVG5TcsQPMaj+WS2lCI+IidFsRm/76raHqIe9k68lp9Tv6/C7sRGQy04DpMFAXphHXSveJXEGpgyMj9AF4C/PiCPvXfgJy9looA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(10067099003)(18002099003)(22082099003)(261102123227099003)(261102130727099003)(56012099006)(11063799006)(261022105027099003)(261026121527099003)(261021121427099003)(261026140227099003)(261009221227099003)(261009223027099003)(261028144727099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lmc21vdETcOq55ElGQqBdHQsVDjvHw3nq1i7OB2DgDybDllvGXqAsH7tAu3L9YRFzwgY8nkSiocYusWv5CRF6NVyr1b4+E6uIvYmNpCOAVZeS3IWpfV1Nlp+szsKjw7DYKITQ7Q4lROYrhmlPzoFlIQGY4k6LNVYhO3K+AjoRO7Ekm/AeYhnPX0MnUAMrmaOBMxGKDwns+CpXiR+5EQzxZbLm/V4vN86zQ6Qff2DcecVjj3pOuDOR6e1tcNhbrtMdXc81eqngb338DlMBTiVQQyWGjExgzInfyAiUPTHybFakk+jsZ9nharhn9p93ezDP+zq1pgJeQMdk2+j2V0YWj4mqJ0dFz+MSf+0YKzOAzbvV4fNqE5NyV4Fh4ywzT713/xdnDsUi3U+4CjjeqUQVVNXhR97t8YMzOKldD/55COD+a0zmdUslHNyhKkLMZd0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 21:38:09.7345 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72165e5c-a083-4944-f086-08df39f2c14b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8874
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

Add prepare_fb and cleanup_fb colorop helper hooks for the DMA 3D LUT
colorop to pin and unpin its framebuffer, tying the pin to the colorop
state. prepare_fb calls drm_gem_colorop_helper_prepare_fb() to handle
implicit fencing.

A plane-only update does not necessarily carry the colorop states, so
call drm_atomic_add_affected_colorops() in atomic_check. The plane's
prepare_fb can then take the pinned framebuffer from the new colorop
state and write the LUT address into a newly created dc_plane_state.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c | 91 ++++++++++++++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.h |  3 +
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 39 +++++++-
 3 files changed, 129 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
index 9d7720a9bd2e..5e6e40b5fd7d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
@@ -29,8 +29,12 @@
 #include <drm/drm_property.h>
 #include <drm/drm_colorop.h>
 #include <drm/drm_fourcc.h>
+#include <drm/drm_gem_atomic_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_modeset_helper_vtables.h>
 
 #include "amdgpu.h"
+#include "amdgpu_display.h"
 #include "amdgpu_dm_colorop.h"
 #include "dm_helpers.h"
 #include "dc.h"
@@ -122,9 +126,88 @@ EXPORT_IF_KUNIT(amdgpu_dm_colorop_kunit_set_ops);
 #define colorop_ctm_3x4_init		drm_plane_colorop_ctm_3x4_init
 #define colorop_mult_init		drm_plane_colorop_mult_init
 #define colorop_3dlut_init		drm_plane_colorop_3dlut_init
-
 #endif
 
+bool amdgpu_dm_colorop_dma_3dlut_active(const struct drm_colorop *colorop,
+					const struct drm_colorop_state *colorop_state)
+{
+	return colorop->type == DRM_COLOROP_3D_LUT_DMA && colorop_state &&
+	       !colorop_state->bypass && colorop_state->fb;
+}
+
+/* Pinned while its colorop state is current, since DC re-fetches the LUT */
+static int dm_colorop_prepare_fb(struct drm_colorop *colorop,
+				 struct drm_colorop_state *new_state)
+{
+	struct drm_framebuffer *fb = new_state->fb;
+	struct amdgpu_framebuffer *afb;
+	struct amdgpu_device *adev;
+	struct amdgpu_bo *rbo;
+	uint32_t domain;
+	int r;
+
+	if (!amdgpu_dm_colorop_dma_3dlut_active(colorop, new_state))
+		return 0;
+
+	r = drm_gem_colorop_helper_prepare_fb(colorop, new_state);
+	if (r)
+		return r;
+
+	afb = to_amdgpu_framebuffer(fb);
+	rbo = gem_to_amdgpu_bo(drm_gem_fb_get_obj(fb, 0));
+	adev = amdgpu_ttm_adev(rbo->tbo.bdev);
+
+	r = amdgpu_bo_reserve(rbo, true);
+	if (r) {
+		drm_err(adev_to_drm(adev), "fail to reserve 3D LUT bo (%d)\n", r);
+		return r;
+	}
+
+	domain = amdgpu_display_supported_domains(adev, rbo->flags);
+	rbo->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
+	r = amdgpu_bo_pin(rbo, domain);
+	if (r) {
+		if (r != -ERESTARTSYS)
+			drm_err(adev_to_drm(adev), "Failed to pin 3D LUT bo (%d)\n", r);
+		amdgpu_bo_unreserve(rbo);
+		return r;
+	}
+
+	r = amdgpu_ttm_alloc_gart(&rbo->tbo);
+	if (r) {
+		amdgpu_bo_unpin(rbo);
+		amdgpu_bo_unreserve(rbo);
+		return r;
+	}
+
+	amdgpu_bo_unreserve(rbo);
+	afb->address = amdgpu_bo_gpu_offset(rbo);
+	amdgpu_bo_ref(rbo);
+
+	return 0;
+}
+
+static void dm_colorop_cleanup_fb(struct drm_colorop *colorop,
+				  struct drm_colorop_state *old_state)
+{
+	struct amdgpu_bo *rbo;
+
+	if (!amdgpu_dm_colorop_dma_3dlut_active(colorop, old_state))
+		return;
+
+	rbo = gem_to_amdgpu_bo(drm_gem_fb_get_obj(old_state->fb, 0));
+	if (amdgpu_bo_reserve(rbo, false))
+		return;
+	amdgpu_bo_unpin(rbo);
+	amdgpu_bo_unreserve(rbo);
+	amdgpu_bo_unref(&rbo);
+}
+
+static const struct drm_colorop_helper_funcs dm_colorop_helper_funcs = {
+	.prepare_fb = dm_colorop_prepare_fb,
+	.cleanup_fb = dm_colorop_cleanup_fb,
+};
+
 STATIC_IFN_KUNIT int
 amdgpu_dm_build_default_pipeline(struct drm_device *dev, struct drm_plane *plane,
 				  bool hw_3d_lut, bool dma_3d_lut,
@@ -245,16 +328,18 @@ amdgpu_dm_build_default_pipeline(struct drm_device *dev, struct drm_plane *plane
 			goto cleanup;
 		}
 
-		if (dma_3d_lut)
+		if (dma_3d_lut) {
 			ret = drm_plane_colorop_3dlut_dma_init(dev, ops[i], plane,
 					&dm_colorop_funcs, amdgpu_dm_3dlut_dma_modes,
 					ARRAY_SIZE(amdgpu_dm_3dlut_dma_modes),
 					DRM_COLOROP_FLAG_ALLOW_BYPASS);
-		else
+			drm_colorop_helper_add(ops[i], &dm_colorop_helper_funcs);
+		} else {
 			ret = colorop_3dlut_init(dev, ops[i], plane,
 					&dm_colorop_funcs, LUT3D_SIZE,
 					DRM_COLOROP_LUT3D_INTERPOLATION_TETRAHEDRAL,
 					DRM_COLOROP_FLAG_ALLOW_BYPASS);
+		}
 		if (ret)
 			goto cleanup;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h
index 510c367f8ca5..58604773db75 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.h
@@ -35,6 +35,9 @@ extern const u64 amdgpu_dm_supported_fm;
 int amdgpu_dm_initialize_default_pipeline(struct drm_plane *plane, struct drm_prop_enum_list *list);
 int amdgpu_dm_initialize_dma_3dlut_pipeline(struct drm_plane *plane, struct drm_prop_enum_list *list);
 
+bool amdgpu_dm_colorop_dma_3dlut_active(const struct drm_colorop *colorop,
+					const struct drm_colorop_state *colorop_state);
+
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 #include <drm/drm_colorop.h>
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 21fe005fe583..469041145196 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -32,6 +32,7 @@
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_fourcc.h>
+#include <drm/drm_colorop.h>
 
 #include "amdgpu.h"
 #include "dc.h"
@@ -1208,6 +1209,23 @@ int amdgpu_dm_plane_fill_plane_buffer_attributes(struct amdgpu_device *adev,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_plane_buffer_attributes);
 
+/* Pinned by the colorop's prepare_fb, which runs before the plane's */
+static struct drm_framebuffer *
+dm_plane_lut3d_dma_fb(struct drm_plane_state *plane_state)
+{
+	struct drm_colorop *colorop;
+
+	for (colorop = plane_state->color_pipeline; colorop; colorop = colorop->next) {
+		struct drm_colorop_state *cs =
+			drm_atomic_get_new_colorop_state(plane_state->state, colorop);
+
+		if (amdgpu_dm_colorop_dma_3dlut_active(colorop, cs))
+			return cs->fb;
+	}
+
+	return NULL;
+}
+
 STATIC_IFN_KUNIT int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane,
 						       struct drm_plane_state *new_state)
 {
@@ -1216,6 +1234,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane,
 	struct amdgpu_device *adev;
 	struct amdgpu_bo *rbo;
 	struct dm_plane_state *dm_plane_state_new, *dm_plane_state_old;
+	struct drm_framebuffer *lut_fb;
 	uint32_t domain;
 	int r;
 
@@ -1295,6 +1314,15 @@ STATIC_IFN_KUNIT int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane,
 			&plane_state->tiling_info, &plane_state->plane_size,
 			&plane_state->dcc, &plane_state->address,
 			afb->tmz_surface);
+
+		lut_fb = dm_plane_lut3d_dma_fb(new_state);
+		if (lut_fb) {
+			uint64_t addr = to_amdgpu_framebuffer(lut_fb)->address +
+					lut_fb->offsets[0];
+
+			plane_state->cm.lut3d_dma.addr.grph.addr.low_part = lower_32_bits(addr);
+			plane_state->cm.lut3d_dma.addr.grph.addr.high_part = upper_32_bits(addr);
+		}
 	}
 
 	return 0;
@@ -1533,6 +1561,16 @@ STATIC_IFN_KUNIT int amdgpu_dm_plane_atomic_check(struct drm_plane *plane,
 
 	dm_plane_state = to_dm_plane_state(new_plane_state);
 
+	/*
+	 * Pull the plane's colorops into the atomic state so the checks below
+	 * see them, even on a plane-only update that does not touch color.
+	 */
+	if (new_plane_state->color_pipeline) {
+		ret = drm_atomic_add_affected_colorops(state, plane);
+		if (ret)
+			return ret;
+	}
+
 	if (!dm_plane_state->dc_state)
 		return 0;
 
@@ -2375,4 +2413,3 @@ bool amdgpu_dm_plane_is_video_format(uint32_t format)
 	return false;
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_is_video_format);
-
-- 
2.56.0

