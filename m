Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65527C44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:47:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B078B10EDF3;
	Wed, 22 Jul 2026 13:47:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jMPmbLcc";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010022.outbound.protection.outlook.com [52.101.56.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD63C10EDE8;
 Wed, 22 Jul 2026 13:46:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lnARHvFXNKBEdbsW5eqtIx0xiO26CCOLC2XA/huZbzGd5vArp8eKI9xecsF7pSV2XjeaLmuY9RDhPrOqslDoFX+eaPD3kqF3VQTscQOd6kCApt4kuSHFBtGhhGDwsbLoKTpjRX8kzyRZY8Q+/DSVL0c8d6y5dk843f0vmA2fR4J9/FXo+7YYa6gErQO8GLDpPxicC8BW7Ta8QorYYRrOCUM6fG/2vNhlYUq1SJs8kOfAo/pG3Bx8baW3rWlOpwBasdP718hMwXOdeZjgtQZ44mZmrcIFhfCXWSNdfU19asgFCJbQJ0KrOFDcukGMyk1rU0ybilLfVqUuPquuJvlTcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYT4BPR5Q9iAJqVTV+Mga0+Suz7er0dk4mrTss0SCrQ=;
 b=wiRjj77yUUoL/Lfo2kA8m858k/4BP37SbLwwo8IDzhPoAo0eJe0SWmkBaKinu7IVfKK/pt/Hwc0iVf9kprttun5waR3r5lfjPPJnjN7DDtME4Q240wUsWbYmOoVKTcRds6mFHA7mTIhV3cuCGSFxA5ik/pNYgcNqGm5Ju4HETLpV2Sfv/j0xtVOQul8y/i1szA8Z2iYyvlVJhq1lEpptePT+rkflM59ac2MTrWegsyjVxVyfn6CoOAS+cG+OC0IEJPG1iLoTYlI0MSkrXfyjdwCPSTsa9gh6gKa1NLWT0YmRKD0OBV5uLXld5KshdsREARqRg4qISHjNbvPt9Eg9xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYT4BPR5Q9iAJqVTV+Mga0+Suz7er0dk4mrTss0SCrQ=;
 b=jMPmbLccyez6kWwHFxybjHB6ChGFq9Q7xMh/E0E/sySBYDbNloLPRflR7idgm06LqhnYaNVlrqzVqaW8ZR9+p0DxhpmWGLZNbIGffQuz13oN9NPFEsfnctb09sRlNlS0co84Sa0ZAWcrFEVxfs4vJ8WrBLf3UrVfSuBtKb/B9XQ=
Received: from SJ0PR05CA0208.namprd05.prod.outlook.com (2603:10b6:a03:330::33)
 by DS5PPF7B9F1F8E0.namprd12.prod.outlook.com (2603:10b6:f:fc00::656)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Wed, 22 Jul
 2026 13:46:20 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::75) by SJ0PR05CA0208.outlook.office365.com
 (2603:10b6:a03:330::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.6 via Frontend Transport; Wed, 22
 Jul 2026 13:46:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 13:46:19 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 08:46:17 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 22 Jul 2026 08:46:17 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>,
 Robert Mader <robert.mader@collabora.com>
Subject: [PATCH v4 04/11] drm/vkms: Add fixed matrix colorop to color pipeline
Date: Wed, 22 Jul 2026 09:46:00 -0400
Message-ID: <20260722134607.136293-5-harry.wentland@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722134607.136293-1-harry.wentland@amd.com>
References: <20260722134607.136293-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|DS5PPF7B9F1F8E0:EE_
X-MS-Office365-Filtering-Correlation-Id: 061e8de5-a35f-4bbd-f450-08dee7f79c00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: oVq7NvjlCqV+5BiNezaU1l0FfEdmW2L5yUl8PUhWe7pk9z4edMf9AQY/bdRyaTAnwZ/ioMXb3GOPPVnrfzn4XYFFUf+eAU4SLS7BMFs3ES0cEBZgJwQmy42FACQch5CFFtsd08M8R8P49MIwcCOX/44ItqTM0zeJJfCmuJDZeb82FFoNumeymATfESaioW0cwpZ7Ap3fGMpNVa06VzqGI1Lf+RkZR0sQjQapVfF0Bzu0vm9aTOrldEqaPbLqcnaCj6u3I1P6rEoxNKRNd5hPwKwaYkWOB0aANIxbVAPMcUnlf8I5KqjXP9Ih39T5bWp0I6QHG5wTsoHGVXwOoHr6QXqosqXy4xxJ2BALXyzlVwHrJN4BmSwQsyqANbV0zuOJcgrgw84ffCJvFxaFo/atmGpyWNlEUzW61JVsLXvMlfyINanmlbk7A69ryRlLxR4tSIk+mw7WQ8/HjEXNgYZyrIAkGULaLc8jX8otvhXBv4jkgqoyHVFqDCtjBx248v3GZ/dIeQv4kqc9r/j1PEgO2u6+sTsGW1V774w05149e8LQ+1Ov5eHMtkhmPX3nQiGWfyzOXK2kZNRAd3yZXwwwFEhXjjh7dV3W9nUE5mk5WJKlw9pUxF20g79nlCPCsIaj9j9xrrsN+rXR6DLFn3hji1iGHgZbJjG3f6jVrQ4X1FdhymJezHKpK9LSsdDoSmZNzXJQiteMJmT7teK5Zpka5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yfCYz99BB6QEbr7CmN9VIeWjxL2TPze87ngqXMcQH4RgCZqx9vxq2+gd+U+SLc5TUX+NBLOPLFeIhbrRWp0BX349YFBCdWXWk1qOSo482CgMUSV18oHuXSe10jxfc5j7nnvB/CDu1HdmigM6pQor2U14DBJFE2jl/hyli/9182HJlZUXUFqGmo7FF+uYH6TrvFgDnYUKgDEtddDQUmpw1t6cGCci6O3inplbFqK35FdG6UCKHhkrzJs3wbT43y/DKnqmXtt1Ox3vH6K7EbugK08ncxRnCNs8h0VbYv+jyAxed8AL55Q1CgugClGXW8Tlw/kUgjBhOL2ZEjzBSa/HeZr0cl3hR9QSTTHKA6iI2TaHCPyyniC//KQzbD575PXiyodg8dGMi2occcdqUriolrP5o9OVr9ZWT7z/sc/Kc4rbrQUSWaiphVyQEx368aF7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 13:46:19.2611 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 061e8de5-a35f-4bbd-f450-08dee7f79c00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF7B9F1F8E0
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

Insert a fixed matrix colorop as the first operation in the
VKMS color pipeline, before the existing 1D curve. This allows
userspace to select YUV-to-RGB conversion via the color pipeline
for YCbCr framebuffers.

The CSC Fixed Matrix colorop advertises support for all six
YUV-to-RGB conversion presets:
  - YUV601/709/2020 full-range to RGB
  - YUV601/709/2020 limited-range to RGB

Bump MAX_COLOR_PIPELINE_OPS from 4 to 5 to accommodate the new op.

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Robert Mader <robert.mader@collabora.com>
---
 drivers/gpu/drm/vkms/vkms_colorop.c | 66 ++++++++++++++++++++---------
 1 file changed, 46 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_colorop.c b/drivers/gpu/drm/vkms/vkms_colorop.c
index 071f3a8d2e7c..9424b1994239 100644
--- a/drivers/gpu/drm/vkms/vkms_colorop.c
+++ b/drivers/gpu/drm/vkms/vkms_colorop.c
@@ -12,11 +12,19 @@ static const u64 supported_tfs =
 	BIT(DRM_COLOROP_1D_CURVE_SRGB_EOTF) |
 	BIT(DRM_COLOROP_1D_CURVE_SRGB_INV_EOTF);
 
+static const u64 supported_fm =
+	BIT(DRM_COLOROP_FM_YCBCR601_FULL_RGB) |
+	BIT(DRM_COLOROP_FM_YCBCR601_LIMITED_RGB) |
+	BIT(DRM_COLOROP_FM_YCBCR709_FULL_RGB) |
+	BIT(DRM_COLOROP_FM_YCBCR709_LIMITED_RGB) |
+	BIT(DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB) |
+	BIT(DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB);
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
+	/* 1st op: Fixed Matrix (YUV to RGB) */
+	ops[i] = kzalloc_obj(*ops[i]);
+	if (!ops[i]) {
+		drm_err(dev, "KMS: Failed to allocate colorop\n");
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	ret = drm_plane_colorop_fixed_matrix_init(dev, ops[i], plane, &vkms_colorop_funcs,
+						  supported_fm,
+						  DRM_COLOROP_FLAG_ALLOW_BYPASS);
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
2.55.0

