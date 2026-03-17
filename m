Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BCDFED9EA
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 16:04:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB4FF10E6E3;
	Tue, 17 Mar 2026 16:04:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5KQlqASm";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012036.outbound.protection.outlook.com [52.101.43.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DF0F10E587;
 Tue, 17 Mar 2026 16:04:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofzfnW6JTxBmV7p/Y2g1HP+GLMjVtm4+JMYZC/7uYD0BHkmUr4Bw2GOVCfietfIst6EGXL1dG/Pwby4mx7hjqs0IsdqU23QqgFLquvkMAx0oiwbGVN6B4vlv50DCm4FZmhSC5bjn+L2zVJ4iAfcTs1IE8Pr43ltSSF/E8LjFrf113A+c0GVziqoeoK6cHP8qXYp0sTYCuumXTWcPrHkOaB9H/byDeTMK08CMMUhQseZBwoN79IPIH0C37eg0t6B9wPjfqm1dB5znBoQlQ3LtXhet7ri8+og6Ds6DQYq5hEjBl+FzTuV7D2doN7Q+gBF3ZyALtEV6Lo3T/5UR7VXTaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdsnV+4E0mAjOV5b7yuDU1mAEyldq7U7U+idMnhzY94=;
 b=kErI3VCq7cLlxghGZdi64i/iyiaOZ4K6UgqjuQSaf2ALGsHiIMwgUBZrEZv7Ok9ZuiABoT8BD6WIADPMeqyJ4oO5+1jtijEYkGFVI2YUetWkbCG45biaOTF64JOtT3tB7wHI0SP0mI6rMstWyeg1GJC/aUvV7lQwweymOinSekZmGozzlSd1w2NKtdyx5rvYqZgSc6qdokfdJx2La8IXNClhDevH1GZzsA5mgmnSsUoW5t05iFM3n50b8u+qxy6V8esmVvRossALRM0JPhCFfiY6AIh4cC2zgHrPoc3nz4Z7B1J2nT279hnZPE4pZnAQu9odIClNtsV2UMlU+5Zh+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdsnV+4E0mAjOV5b7yuDU1mAEyldq7U7U+idMnhzY94=;
 b=5KQlqASmokSHuS0te7lhx2MyCG/VNzk66aHq9DAeVc6sV85U/e2owkIfo41GJTTrMQOZr4utDWbzBmh1z2N9NV4Zgjk9MTyOUtOWtT54VBB/B7bCC2lCGvS4GIHNiCYCb5GLHJBQUW/sGN5eQfl+217HNn6uvEsZ+55FAxI4ye8=
Received: from BY3PR05CA0029.namprd05.prod.outlook.com (2603:10b6:a03:254::34)
 by BY5PR12MB4050.namprd12.prod.outlook.com (2603:10b6:a03:207::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 16:04:15 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::22) by BY3PR05CA0029.outlook.office365.com
 (2603:10b6:a03:254::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Tue,
 17 Mar 2026 16:04:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 16:04:15 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 17 Mar
 2026 11:04:03 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Mar
 2026 11:04:02 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 11:04:02 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [RFC PATCH 04/10] drm/vkms: Add CSC colorop support
Date: Tue, 17 Mar 2026 12:03:44 -0400
Message-ID: <20260317160350.229028-5-harry.wentland@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317160350.229028-1-harry.wentland@amd.com>
References: <20260317160350.229028-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: harry.wentland@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|BY5PR12MB4050:EE_
X-MS-Office365-Filtering-Correlation-Id: cf1888a6-16ef-459a-23fb-08de843ed661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: LBsA8HqOkiGe6g8g6hjav4Q1gm0G/34G6wivFJvh6j083Yw5wOqQyCmKuCjls5hFomXFMKjQkhdJrR/XPP8WNj4LnKaeS1wi80fiSoEjePTmWWLt+skUCmNteTy5m4QsHIGl5NIx1orbzupMhs6jfwQmZxM4wWuiVZLxmPfVUYK6SPNDS9w+kqV+F7zYMuP6VF07AWblW4B5Koa2bZH8QHg0zBT7AT/kTVLAuAVv1Vn+NTu3J30Z619SvLCwpSLB2srLpbIPzt2BLlorMm88i+OlW8auFN/j0q2uriRGLZ6Ns9fudJBWKKbcefj5XOsC4q1Z4COa0x9OUJgagPI9DTIuCXm7mJGXg6GGSyUAgJwpVn/eQXtIFQ8Nlg38N0Y/un6PvcPTFAC3TXK/5IQnvxfJnjpV1JdWud2Jxr2HwIaJ1v6l7sFPEe8565bss2yrRXtTTzAPT2UNnlk19iB+e45B6rivZEiZ7dyTb4xGcZJFfKbyB5u62U8hjzNpiNMqZW98PpkhoJkSejG12FjB30K/YTLL30FmHdhS545GEUl2uDxgmq6kc7TWYDx30II5j7R3K1QcJYe0dcL0x0gthjwFrV8bAMg3K4UBmLCkycSyNCZHod5wdxUNcAPiCymjykZW5m9Vo1eR0s4RcLyEzun3igEl2EM1/+ofxh/SGf6NqtEV3QF0uiLvPqjMDgr+NQLo8ksnd0MlVTP2iOCNwgEzNCOYJD/S0wFBvYeSvzeGpqir7LhFbnAUtSn3imsVs2kGot+t+APn6FdNwNzCFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XIpYF3S3QnxU+B4LR95cdCNPvaz7uc1CpBWnJjmB8BmqZCqifyar5/QcCfz/16n3E0rl2G3lW1wKXvisbsO/FiYShsWNNHD02dXhUP3mZmJJQ28owrAchcmZLzsY55pA6asa2vl4QK9Xr9S1t5fC3TjoHjILErzzb7U4QQLxKJamZyNFOIHCqrBI+RkVom3G7b4mmKBmOqWHTj/Wn4KilxJzvTlOMNaLEJ07yZtNHv1sJdLb/hRoq+ay1frxNi0Z/PG2TAi6utQfGYc1r7tCjRi1RXNDgXZOk+hHFjtiTyzieAaTKBjuF0ICKwURaPeLSvaWYKqzgxERo0440F8Ync7RY6NENTekRIPKe3UuxMPqYfTNK+9HAKemlCu9uAg+FjTiRspkjIyWru9Fsezl0un/r0m0MgpddW5BLoFUNnWmaMhJVL7hWWSK3Vg65BPN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 16:04:15.1575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1888a6-16ef-459a-23fb-08de843ed661
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4050
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

Add CSC (Color Space Conversion) colorop as the first operation in the
VKMS color pipeline. This colorop handles YUV-to-RGB conversion with
support for BT.601, BT.709, and BT.2020 encoding standards and both
limited and full range.

The CSC colorop supports bypass mode for RGB-only workflows. The actual
YUV conversion is performed by the existing conversion_matrix path in
the format reading functions, so the CSC colorop in the compositor is
a no-op that just validates the configuration.

Increase MAX_COLOR_PIPELINE_OPS from 4 to 5 to accommodate the new
CSC colorop at the front of the pipeline.

Co-developed by Claude Sonnet 4.5.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/vkms/vkms_colorop.c  | 64 +++++++++++++++++++---------
 drivers/gpu/drm/vkms/vkms_composer.c |  5 +++
 2 files changed, 49 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_colorop.c b/drivers/gpu/drm/vkms/vkms_colorop.c
index 071f3a8d2e7c..429491581008 100644
--- a/drivers/gpu/drm/vkms/vkms_colorop.c
+++ b/drivers/gpu/drm/vkms/vkms_colorop.c
@@ -16,7 +16,7 @@ static const struct drm_colorop_funcs vkms_colorop_funcs = {
 	.destroy = drm_colorop_destroy,
 };
 
-#define MAX_COLOR_PIPELINE_OPS 4
+#define MAX_COLOR_PIPELINE_OPS 5
 
 static int vkms_initialize_color_pipeline(struct drm_plane *plane, struct drm_prop_enum_list *list)
 {
@@ -27,7 +27,31 @@ static int vkms_initialize_color_pipeline(struct drm_plane *plane, struct drm_pr
 
 	memset(ops, 0, sizeof(ops));
 
-	/* 1st op: 1d curve */
+	/* 1st op: CSC (YUV to RGB conversion) */
+	ops[i] = kzalloc_obj(*ops[i]);
+	if (!ops[i]) {
+		drm_err(dev, "KMS: Failed to allocate colorop\n");
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	ret = drm_plane_colorop_csc_init(dev, ops[i], plane, &vkms_colorop_funcs,
+					 BIT(DRM_COLOR_YCBCR_BT601) |
+					 BIT(DRM_COLOR_YCBCR_BT709) |
+					 BIT(DRM_COLOR_YCBCR_BT2020),
+					 BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
+					 BIT(DRM_COLOR_YCBCR_FULL_RANGE),
+					 DRM_COLOR_YCBCR_BT709,
+					 DRM_COLOR_YCBCR_LIMITED_RANGE,
+					 DRM_COLOROP_FLAG_ALLOW_BYPASS);
+	if (ret)
+		goto cleanup;
+
+	list->type = ops[i]->base.id;
+
+	i++;
+
+	/* 2nd op: 1d curve */
 	ops[i] = kzalloc_obj(*ops[i]);
 	if (!ops[i]) {
 		drm_err(dev, "KMS: Failed to allocate colorop\n");
@@ -41,23 +65,6 @@ static int vkms_initialize_color_pipeline(struct drm_plane *plane, struct drm_pr
 	if (ret)
 		goto cleanup;
 
-	list->type = ops[i]->base.id;
-
-	i++;
-
-	/* 2nd op: 3x4 matrix */
-	ops[i] = kzalloc_obj(*ops[i]);
-	if (!ops[i]) {
-		drm_err(dev, "KMS: Failed to allocate colorop\n");
-		ret = -ENOMEM;
-		goto cleanup;
-	}
-
-	ret = drm_plane_colorop_ctm_3x4_init(dev, ops[i], plane, &vkms_colorop_funcs,
-					     DRM_COLOROP_FLAG_ALLOW_BYPASS);
-	if (ret)
-		goto cleanup;
-
 	drm_colorop_set_next_property(ops[i - 1], ops[i]);
 
 	i++;
@@ -79,7 +86,24 @@ static int vkms_initialize_color_pipeline(struct drm_plane *plane, struct drm_pr
 
 	i++;
 
-	/* 4th op: 1d curve */
+	/* 4th op: 3x4 matrix */
+	ops[i] = kzalloc_obj(*ops[i]);
+	if (!ops[i]) {
+		drm_err(dev, "KMS: Failed to allocate colorop\n");
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	ret = drm_plane_colorop_ctm_3x4_init(dev, ops[i], plane, &vkms_colorop_funcs,
+					     DRM_COLOROP_FLAG_ALLOW_BYPASS);
+	if (ret)
+		goto cleanup;
+
+	drm_colorop_set_next_property(ops[i - 1], ops[i]);
+
+	i++;
+
+	/* 5th op: 1d curve */
 	ops[i] = kzalloc_obj(*ops[i]);
 	if (!ops[i]) {
 		drm_err(dev, "KMS: Failed to allocate colorop\n");
diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index cd85de4ffd03..1c7dba35dc3f 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -15,6 +15,7 @@
 #include <kunit/visibility.h>
 
 #include "vkms_composer.h"
+#include "vkms_formats.h"
 #include "vkms_luts.h"
 
 static u16 pre_mul_blend_channel(u16 src, u16 dst, u16 alpha)
@@ -187,6 +188,10 @@ static void apply_colorop(struct pixel_argb_s32 *pixel, struct drm_colorop *colo
 		if (colorop_state->data)
 			apply_3x4_matrix(pixel,
 					 (struct drm_color_ctm_3x4 *)colorop_state->data->data);
+	} else if (colorop->type == DRM_COLOROP_CSC) {
+		/* CSC conversion already handled by YUV read functions via conversion_matrix.
+		 * By the time we reach this colorop, pixels are already in RGB.
+		 */
 	}
 }
 
-- 
2.53.0

