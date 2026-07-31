Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 638D4C55173
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 18:15:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C46F410F391;
	Fri, 31 Jul 2026 18:15:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S6pz7mzs";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012026.outbound.protection.outlook.com
 [40.93.195.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EC2C10F388;
 Fri, 31 Jul 2026 18:15:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fp+96nKJU73TWqLN8eL1O5R/DPzmxedFZuieDAfQhXPhIbPc5sZJyFaT+mrWwadIQay4lDMID4LzfV3VlpWgFzKRITd+gFVx2QzpEy9/q3zSbd152vikVK0JqyrxaXKhMWHXvyZWrBNqBWrTNy8VZPxfKvzfo7Tg+o4JWR5wuixxN0cH94H4E6K8To0InY1IRzFHL47HBZAM7exWudDpyucW70HUeRtgJIW0KZlyTWz+zTyxCXCSqsZ83B8fo+a7LUoLQHIb9qpAhJzmdOg7CBCDZhVQUpVhAyKwfMFj7eKv0Sxwb+hwTdGc9KOXnWFZQidYvht7fRGCUmSshBk1IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYT4BPR5Q9iAJqVTV+Mga0+Suz7er0dk4mrTss0SCrQ=;
 b=aIif4vqvyH4B+ufcs86C9Dgj9uKYCfX+VcEf2AhjnarNKufGDG3NRGdEJCtttezh17dsKCnPyvE63itLhcy2WeuhNKJIW9yBEKN8vtZ205RBU4DthMEuZKmccOsdFSbJr0XIL5T0l4eohn89NZ3KwNuBTIVr0+M5b2n2KrdKlUr3NBte20zIvZqghnBUuK6d+BpgenxaPQzhdVhghTR9Gqq27oXbIpHB94U/5XPR+FW4DkLItpwCzb7pCn/ydcDhVUvFH6CiuUe9gn8PTZuzWBGWZLCZp23P5t+nopHBE/TZWxVcW9JqvH3rcRvvCrhzQAe+nJOksWO2O0AmvVBOYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYT4BPR5Q9iAJqVTV+Mga0+Suz7er0dk4mrTss0SCrQ=;
 b=S6pz7mzsnJPo9hKbfo+43zqfS3WWg/zA+PT+Q+G0DaSRPO8U/UzkqSlwSOVM6naavK4l7X7dc0X2p58J8xafR3txTLQx6r2rDrBuFR7amqUxEkCYMxLm4inhU/Om4h8HmspS4U/NhzooLLEE4pGmszzfw7bucQnD/Kamb/XzFrI=
Received: from MN2PR05CA0063.namprd05.prod.outlook.com (2603:10b6:208:236::32)
 by IA0PR12MB9010.namprd12.prod.outlook.com (2603:10b6:208:48e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 18:15:29 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:208:236:cafe::8e) by MN2PR05CA0063.outlook.office365.com
 (2603:10b6:208:236::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.11 via Frontend Transport; Fri,
 31 Jul 2026 18:15:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 18:15:29 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 13:15:27 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 13:15:27 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>,
 Robert Mader <robert.mader@collabora.com>
Subject: [PATCH v5 03/10] drm/vkms: Add fixed matrix colorop to color pipeline
Date: Fri, 31 Jul 2026 14:15:14 -0400
Message-ID: <20260731181521.681990-4-harry.wentland@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731181521.681990-1-harry.wentland@amd.com>
References: <20260731181521.681990-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|IA0PR12MB9010:EE_
X-MS-Office365-Filtering-Correlation-Id: a0638984-5c75-4836-a93a-08deef2fb3cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6OqNtQP5y0YWiedput6+lsVHi5YbIIOysnXJXdOLo4fQfgZNFN0rfmyknxzBupDQMen2YRfERTk7smLl6CaTPOTjZ7dkRyXO3reBEmUJjoARAStzVGVBI17Fp878bfX8CXL2Z+SlCPN2fHeVubR5cl7t1zDRGjL2rIuc73eBb1kV1opVTkyBL1c2B0OVDHwymcNpTnDpagec01G2L5Y/Zeh+ffydvv2bJ0r6ZOciFgGPkpdqch6/Pr+J4AFvJrWzhviB5fCLWcTcZyA6L1Ax728RN5YdQJZhw/EfEikv2L9M6WB5rSDET4vAlBoAXYulA/lYIDrLQGhyH2z9AdT76S4fBE48vRZojtwfBnERqnc0hTq5PoWTW8prNVJ02MXDZQqD7PnqTRH41s7VW9BWNcwdUDmZcHHvxVeX+PXvgtANQFEdjyGMWZOrdcw1MTctigwdZs0IAFwEz/GP1Api/UirAxJDr2Uk1jihngp9iFVwY99N0ak0u1b3D8EIwYm1PXegXncBq640qULGSecoWz83F1s3FA3Z/ItiRE7xD3DXnGFkiadTUt69BtMY9lN+4rO8TXPyv1Y7k70jFUFHzDaMRNIzt/hophKwRimgYj3EMLIwMtIycT5whFMqDkLpYTMmZWV5LHLtcXkYemgfvDE0IbfCnWjtPGJHO8ZOKU8LYkaizj3xNTXCbjQB+Td30HTL2NK7ZRKsuK8Y6Eeq4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: X6tlCfs1zKOM3xsXsD2DtymzQytcJIZSA3u3II7unvk2V4FKbVjjl6Q9U5+DJms8ZfLG6JEgu7Eye14rdU3R1DQal6F0l5tBIF8HKYbOEA5e+Sri/L7/PMuwtyNhyG1WtXnDVpEaMrTF3zDEkJlZyU3tgFYIh5pKr2vPpqIwCQO662mEPr4CTH1XsvU6RrmoUhRVqU2KNyKJ+UoAyEd9fkj683qtT8rPjpb3F+abtKLAbWRu6oLzwUnrWkRgWoqE0GYrr63Mb98v3RpcL1cOKcappWtoJoMTW2eSr7EmhRC6s1lvfOLugtEE6MWst6jsDYwApR4m7f3UXfUnC3usRG8Mc2V8XBpx7ovhspJo77HSG6ysY0TftwrgQ+9qGMgY5dGGahl0+slBdH+4+Rcpex0Aml5LlZxs6pv8TW0zowaKvQrhVTuXkPo5MyHBqGP2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 18:15:29.1992 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0638984-5c75-4836-a93a-08deef2fb3cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9010
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

