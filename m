Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4149A1061B16
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 15:35:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C3EF10E62D;
	Mon, 30 Mar 2026 15:35:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ip0uo53h";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010006.outbound.protection.outlook.com [52.101.85.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E84710E235;
 Mon, 30 Mar 2026 15:35:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3GjsWh2A6y8nEvmqVR95fEDljT1xj9GM8gM4Jo4WZfFhd/MDnmtKwRVFYvQU1pX7UvzYiWFUnq8qd3NjKKMpJupmQDw38NQbho0vBir95LvtGQ+vEU27nG53X08Wb+WENyKjPJ6W6tlramSR22DOTfpCgljbudKoXsnFDzoegImvop30DmRdS1wcvQb0mlQtz/93s0Vba0gg9QYZF3uI5h6IyFltDx/18Jy6pt8+PsJ47htHxal+lZVicj4Uj/pXOb5X84PlMfS/nTEADsi8ARWUEKF1CZFhi4u3AxwgTW9adsiASiVua6rv8DQDlcB4uNaa5/9KFoPWe5+Mw0X9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9o3Qz4A4OFK1HAFvvLNCFlUoVca5vzKFhxoKLJSX50U=;
 b=eUdWR4si2rX4z9wk9y0vyZ1jAmHVk17qFY5cYaO6tBp01IDyJoFoYugjC1iWD334SQQMm5fbsk00Cqd67w7bonjJ7gAVJDm16+tvsXNLKd9Zpd+qrIVPqEGap7uGXeoFLIQ1FeaVKHfqOuaAWyHeEGQvbNzwSa843iXwoVM3A8URoJpQsQhFlVx/kNgRuPjN1Dxsg2hEbdpI8XASd1zDvCXZaTXM28QIYQfXWtO/mCdyhXna+lRBMcONQQdFT2TvxLHj8Udfhhd+gvuZdySrerF9nrYjBeJq5PpOck9ODtS6ZVt169OYtk5JFEHKqAEk4JCl13knS6rE6Y6Gt9WRBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9o3Qz4A4OFK1HAFvvLNCFlUoVca5vzKFhxoKLJSX50U=;
 b=Ip0uo53hPTsDJLYlWK+6AdhZeNVDt6WFoE/0OAWDdqjR/LrJ/gcTv0W253nY1j9azbIyDuaCO0aV3P2T6DpEhidUT145GWg7L91VwfFXSSwujsCBASObz3i+kBYQjU8RhKqNkorfeEs4co9mQ+EYTqP9eTklW105ey/zy5PxJ4Y=
Received: from SJ0PR03CA0022.namprd03.prod.outlook.com (2603:10b6:a03:33a::27)
 by MN0PR12MB5931.namprd12.prod.outlook.com (2603:10b6:208:37e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 15:34:58 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::9) by SJ0PR03CA0022.outlook.office365.com
 (2603:10b6:a03:33a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 15:34:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 15:34:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 10:34:57 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 10:34:57 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 30 Mar 2026 10:34:56 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [RFC PATCH v2 3/9] drm/vkms: Add CSC FF colorop to color pipeline
Date: Mon, 30 Mar 2026 11:34:45 -0400
Message-ID: <20260330153451.99472-4-harry.wentland@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330153451.99472-1-harry.wentland@amd.com>
References: <20260330153451.99472-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|MN0PR12MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: c89c9298-cb66-48fd-2b20-08de8e71e669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: hQcSOAsvmrHgOVSgg97fZKOuooXGuwk9626sAbjzoyaUs7EHOfYtQh7NTEbTHvieM1RNdkNhEZu9VmuJrpyE+IcNiMXDIrghFE8NWlNElYAr4MRE+bKIs3TKeQgAmroM7v6h09fvh1/NFgLMiCg1udYQNT1AGevBQ34siiYg9gakCcXp42xnSgbNLfX5RU+sGukGL2nI6WlcgtWuM8BiGLUeuuVKIINejkAA4u/5VOPhd+oVkWVtMwi+j8nyCN3YKWr0YdTRmBRe5ZddYoU5tGVn09IZKIc79G8JDsvywq2t9rqH74TO0DnkF0Jur5mbskyboYYChfYDxqYnR2KHw0itMVAf/4gunfSqU9F1TVqsb3NqDhPH1Sflnc2Sgmb3ZnyT/CSgB18fOzm2dXTRcBys7wxgcBtylP5SfbKjpCVCyOMREpoPz+1bn3ieJhQKuXQvp1HUvekaVPPIsIyqxknEyJo/rLF/jNpzCYzs4jDaziuxqW0Bf5uM9JrFSfhQwRwVaxL6iNjQIs6CkTBqPmLKabViCD7Ye6cD0CRRezLFPDmtJ8tmjA4qoQn6wiR4FR+sDljWdBAKxP7kX585svMNNw17eZYqkO1tpg6IPMfByAb4HXw1ezQwdQXaEKtDPimv4dZh0XJXxB4neZ+xOlLNEsN/P4f0QPbXzHEDo2RGLU9OfM4vjOAATKJaBD1LcTGQNQ9FEI87gPykTke5tBNzj3OSVD/XHrfBLvyu816u9Pw5yFMOJNfXK+Fklf5zfQ3KTEHjWd/MXdJEPnEScA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wnYMhFT+It0kdps3byDemrREXoa0ZZxudLjv8/C9pMH19gkwEw5j8yQRb/VTWG3XXdYXyXmWwlZgYhq29K/uLaNdJ694H0fo21vyM73cg98lYV/amPK6xCscyouSnXvPLs9ZUCYseLWC8osii42ge4EI6sX5zICe1p7IMUemf8cyAl+aM2zm1zjoLac2iMuHHNsHew9j4QKjMSg0NhHWx0XLpGtdAT0XqTJ6I12EuveKUz6YcK1SweDF5m8Qg+4OqB7ObRauQF/asj6PyFG83GxjeZsG0Ffvs7OkvMBvGWDb7PgN3sNMs38AUm1fmUIbCZ7+/nrS6lLNPnKhuP3nOqoTpdNE2FXYgqGjCRCV3VkNgiXPIjWcBgd70Ao+j85CR/XKnxz+HPUHYVKI6MKnFlKHSx+k+Il/90Zzh+LZ+nR/u+lFuz8743ecGpqO7XbQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 15:34:57.9945 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c89c9298-cb66-48fd-2b20-08de8e71e669
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5931
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

Insert a CSC Fixed-Function colorop as the first operation in the
VKMS color pipeline, before the existing 1D curve. This allows
userspace to select YUV-to-RGB conversion via the color pipeline
for YCbCr framebuffers.

The CSC FF colorop advertises support for all six YUV-to-RGB
conversion presets:
  - YUV601/709/2020 full-range to RGB
  - YUV601/709/2020 limited-range to RGB

Bump MAX_COLOR_PIPELINE_OPS from 4 to 5 to accommodate the new op.

Assisted-by Claude:claude-opus-4.6

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/vkms/vkms_colorop.c | 66 ++++++++++++++++++++---------
 1 file changed, 46 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_colorop.c b/drivers/gpu/drm/vkms/vkms_colorop.c
index 071f3a8d2e7c..fa78ac7be36e 100644
--- a/drivers/gpu/drm/vkms/vkms_colorop.c
+++ b/drivers/gpu/drm/vkms/vkms_colorop.c
@@ -12,11 +12,19 @@ static const u64 supported_tfs =
 	BIT(DRM_COLOROP_1D_CURVE_SRGB_EOTF) |
 	BIT(DRM_COLOROP_1D_CURVE_SRGB_INV_EOTF);
 
+static const u64 supported_csc_ff =
+	BIT(DRM_COLOROP_CSC_FF_YUV601_RGB601) |
+	BIT(DRM_COLOROP_CSC_FF_YUV601_LIMITED_RGB601) |
+	BIT(DRM_COLOROP_CSC_FF_YUV709_RGB709) |
+	BIT(DRM_COLOROP_CSC_FF_YUV709_LIMITED_RGB709) |
+	BIT(DRM_COLOROP_CSC_FF_YUV2020_RGB2020) |
+	BIT(DRM_COLOROP_CSC_FF_YUV2020_LIMITED_RGB2020);
+
 static const struct drm_colorop_funcs vkms_colorop_funcs = {
 	.destroy = drm_colorop_destroy,
 };
 
-#define MAX_COLOR_PIPELINE_OPS 4
+#define MAX_COLOR_PIPELINE_OPS 5
 
 static int vkms_initialize_color_pipeline(struct drm_plane *plane, struct drm_prop_enum_list *list)
 {
@@ -27,7 +35,25 @@ static int vkms_initialize_color_pipeline(struct drm_plane *plane, struct drm_pr
 
 	memset(ops, 0, sizeof(ops));
 
-	/* 1st op: 1d curve */
+	/* 1st op: CSC Fixed-Function (YUV to RGB) */
+	ops[i] = kzalloc_obj(*ops[i]);
+	if (!ops[i]) {
+		drm_err(dev, "KMS: Failed to allocate colorop\n");
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	ret = drm_plane_colorop_csc_ff_init(dev, ops[i], plane, &vkms_colorop_funcs,
+					    supported_csc_ff,
+					    DRM_COLOROP_FLAG_ALLOW_BYPASS);
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
@@ -41,23 +67,6 @@ static int vkms_initialize_color_pipeline(struct drm_plane *plane, struct drm_pr
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
@@ -79,7 +88,24 @@ static int vkms_initialize_color_pipeline(struct drm_plane *plane, struct drm_pr
 
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
-- 
2.53.0

