Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48823C5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 21:18:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 018B710F741;
	Fri, 14 Aug 2026 21:18:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hb102ZZN";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011050.outbound.protection.outlook.com
 [40.93.194.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57D3110F71A;
 Fri, 14 Aug 2026 21:18:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVQT6oaXPsP0MwD5mQRQwPLiv14Famp7/44iksIELGT7W8wUu+F/ZmN+VBgYcp/xe7XvkJCXDyNXgpokVvBTW7eV3jJXqKoWV7+Ht+j2GKumMX0DwVR5YGM8SaFd6nknHZnWyzMIEEeQSWXVflffjQC7qK8uJhr+vxwD0H35GOelVjA/MFa5qtOFzi+RGj5tfrcHOwojQZj7xbziiLR/nQGxYvcE4v8ODkdJTseiWvgebmwhDL6AqcrkQ1HUT2bWzj5rCNd88akeRw0Y65isVGoryCRY8IQUgWN02I4ygfmNV6jgw2iY/OuMmPT4odqC6m39x6/L147u54Cni6FZbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYT4BPR5Q9iAJqVTV+Mga0+Suz7er0dk4mrTss0SCrQ=;
 b=qthST2jYQiZz2kbenXE2HaWcN2mVkD99L83rlj4qg2ttri8qdE4zQBs9VL+mEtDfVOXC+c6Z5PAn6fe/euiFOztk6TK6VS/W/M9c7pb0XeAMF/McARoh7c+GFaj+pvl+XlIFzpPzBTgBIkIwgUAUNheSSMCgoQ5kabH9aDTq3PgwfjYZ/765qz7jMQe1L08lDc8okFhCDZRB3fZ6v+MCkK8wUBTIsjLcJ+pDcqaEf8EQ0XsaWKe9mV2xpTeffWkMwaD1I33ONFyz+wQv3CwIOo9m5GHwOX4bVGsxSad10Da0PC5UropIt2cHhozFyrXjKjK09koLFYaWc6SqEoE8Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYT4BPR5Q9iAJqVTV+Mga0+Suz7er0dk4mrTss0SCrQ=;
 b=Hb102ZZN5PwxeMm0206RVY5fbCEKZHhRSW+aOlXhj/gDcc239J3JxJdk8JzZRJBJVDiMn2RWfey/rEEFyMvx9WhhzKg0tfmVZMEkGydGTNSyEUGNnehxdr2dQwI5nAes41n3Aw1HKtC9tmqGXbnSqHY6kKYlDPrIIKZCvsFWdpk=
Received: from CH0PR04CA0100.namprd04.prod.outlook.com (2603:10b6:610:75::15)
 by CY8PR12MB7489.namprd12.prod.outlook.com (2603:10b6:930:90::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:18:20 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::36) by CH0PR04CA0100.outlook.office365.com
 (2603:10b6:610:75::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:18:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:18:20 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:18:20 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:18:19 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>,
 Robert Mader <robert.mader@collabora.com>
Subject: [PATCH v6 03/10] drm/vkms: Add fixed matrix colorop to color pipeline
Date: Fri, 14 Aug 2026 17:18:09 -0400
Message-ID: <20260814211816.1219597-4-harry.wentland@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814211816.1219597-1-harry.wentland@amd.com>
References: <20260814211816.1219597-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|CY8PR12MB7489:EE_
X-MS-Office365-Filtering-Correlation-Id: 92a119f1-928c-4e4f-11dc-08defa499113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|22082099003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: p1A3Ze0roqbaSSfSLYZO5hs+MPfGbYbVcSufAy2EIumlTTfRkEdWoPplYl5czEYVClTLaJ6BIDpJdHWSfT4Qng9JhRH/kj/QHegNlSerlB/mfPCC1MoScD9ZhFmKYHzUoZ21gusPfS0dZdY5WBrf/VkKacYH+lGXKHet6g9ERYtLaiQil+HqcjYiBN7SF5Im9TcFqZdhtSamCvKqRRLWcKtDBQk1kNRerKM4Z3zaXxeZFnQNlspbmmIe1VN0gvGvuw4fdFsTm6T1AqAAWYJ8YlV7jt4qVeK+QEb/mjvTMzp8B6WcIv5K4gXgHBe52oRu/7CEX79ZTcCExQlXBu+JZUoaNFf/J+4NE9v5asE10ioHR5XPzDW0hQLUv9f205RhIOT9Y0OOCBV21BZAGzqb9hRwnSbAL5cTITDsay86A1Lx3SrkxOFQ+DetjOBihWbrigebg8GId9cjDHuGo8Npix6Xv5RyubIMRmqt9ixy/4p45W0EFhZANUdcwr/I5BpKz0Uejgdlft5Jc2qmyuq2fO5ccO0fg2jDQ0MjfT7ah/Rw+acKI8BlAYZUV3qPEWZjouFWigGRj3ZHY/bj9SXduqiErnB2SUD5kitd4qgTLBX7kc9Qp5sqZuJfbFcTMM1YjSRwhJ5SshQFxjq9KKSaPTipe0FZiocD1DMzpbBbp4tuHGKe7RjqcPIVsf4MTf/grEn7QWigx1rh+Bwbw/E/cg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Fflp6S4q20A5rshZY87GGIPsgoKBDOTY/q1WdgqT0FKXyrucph7NprnVap6UTOsXL0816+ltDPGFlL5gf3GugabDXQDahyuSolE0ea4evepYqLNLu3w9O1sfmqBNq4yYG7AfUs/98yKCb+3hY2htsfkU0Kn/tu15BZNXFVt/DU5nkyxdfBiR4R3O5qSRoLSh1q5/5KR5bNNeqbZPu264BiAc7fBHOMyU9p2TKqG1KwawG/wJGnKWXbkYcjzH4YGoPvoDCntHIPwEA4Iu52DIRHvL45lNeYJJNxfi46qeeClXshYb1iEE8NhDs8ybFZsoBpHfn4VxWCNZD/SNnRwyEd2EFHJpcjkyxiudU60lkBWwUPS3Qr1Otf/wKdW4hNSG7ZBSlo6DDZumRSiStBSX7AkGAED7wgV1/7uGSRsCRvHG2k+YopuQ3THwbOvL/wX1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:18:20.6143 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a119f1-928c-4e4f-11dc-08defa499113
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7489
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

