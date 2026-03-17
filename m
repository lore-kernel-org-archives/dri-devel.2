Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E820DFED9E7
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 16:04:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17ECE10E6EE;
	Tue, 17 Mar 2026 16:04:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MVArQ4Jg";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010019.outbound.protection.outlook.com [52.101.61.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 723C110E6E9;
 Tue, 17 Mar 2026 16:04:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMNUyVuj/JmO8xlx9TsuJzk+DXGRdqpzglkGAYl2iC1lVeETHVfVdV2fOExwwxpA6+ifGp36nxAjH9MAOQfgjRQb0fKq465jnyMRJ45/id+4nrDiQMP3IHOPFYqbZ5Rdd2048mPape9ENyQ89UnwxdtaoYvOwqHFNzNKDmGUeeoSOWeOLYpLdK8BFDMhlMgm0D+gc7bFcvrCiuFXwMVjuQ36qcRYMCmHBXc8sAKh+kjQl3fL2WYL1JOSobCUbZNXcTUB0l0JYj//xX/ja36SPTN24j9oef0IGZ4R+dknWv9dWPUemUnUh19KWgFMsnWuRQr1rnTHh/oxZ6KkArwUXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49+AC+UE3RuA8aWN+AQAab/i4qQiVv/G+mlMChjpy8c=;
 b=G/S6skUqv9n803/5WiRNUNT5wVxAMRAcYjD/4nZJLf5Ew1Rh4wACynChQlDn+xMWm6KGVs4ZXIyBM0zcNRrt+8pU039FiKRZ8NyyKsqsAkjrWpqsQ4XKm90OozVI3gEq4CZbLO92X5QVbpUWHoU/5oPQ5b0aua3ZAfz5RgZF7dHDDjr9XxlZGLMlCRE8iqhVwqOtOaDv+aSjdKUxh2KyVE1ZHVssvE+XT3NxxknA9pTWHtFkXroD1iH5ZhlHBACye8llZ/PAzRawZWlIxmAKzEf8RY+GJDd125a5sGkLhH+6CY00XeT0qpKFA0VaCZffFxkoqVMXcaCXYTW+eEeYGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49+AC+UE3RuA8aWN+AQAab/i4qQiVv/G+mlMChjpy8c=;
 b=MVArQ4JgR8+Pq+rjfH8oBWA+GykIgoyIzECu7bMN8wPtxBBdkp9Q5hYDfEC+w68lMhbO1P+F9CW7Kvrf2DYLUnIUMDYLIM4Z9lVwE0s1x1vyeqQb/mUNiFzBPCGTVZ7dTo4Ky1rES956lrSm2HzTfmLVIhnak5wqBeOzltxJIlc=
Received: from BYAPR07CA0099.namprd07.prod.outlook.com (2603:10b6:a03:12b::40)
 by CH3PR12MB8709.namprd12.prod.outlook.com (2603:10b6:610:17c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 16:04:18 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:a03:12b:cafe::e9) by BYAPR07CA0099.outlook.office365.com
 (2603:10b6:a03:12b::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 16:04:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 16:04:17 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 11:04:04 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 11:04:03 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [RFC PATCH 06/10] drm/amd/display: Implement CSC colorop support
Date: Tue, 17 Mar 2026 12:03:46 -0400
Message-ID: <20260317160350.229028-7-harry.wentland@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317160350.229028-1-harry.wentland@amd.com>
References: <20260317160350.229028-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|CH3PR12MB8709:EE_
X-MS-Office365-Filtering-Correlation-Id: 56fcfc33-4db9-4ffc-2556-08de843ed7aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: lyEUl2Loyn+4XzaE1GU2Kp0YUvil0pPzYlifsj3RzzH9sDV7DllJrMRMXFuv4fnDC1GmUi5cPfet2Hs3m2eIwkd+0u22wzBtSkl7M8rzy088CY9ykzZE9O17/dTSJTEkGGCWMW9YMC9sc6RmqxzXYChP3/QabYuJUwofVAOuH6oSvSc6z+Rra9W3m/Y5d02yph4iVgRRDIMdVLN+4qNFxxO/SO1hVVjZLdD3hYHczS/CmQ4EYe26Tng0bfobdLym91URmydVrXW4XfTqRc1bqe8q/i33EjBq9tKGgeZKPhsfAbX8P9RsEm/K3MYHOIvwqtutjF4LI+ictTOfGxRcD+pWC0KyhH2N/Q1aiKdcdPNdf/+/xUu6D9ypkAJ8QR/8dB9LWjYU/iDjv3wx1wdBYrAQ1sDmZ15EjHHAyydXa/Sqx7nmRBfJkcalUiMA8gb5adxSCeYvqRfZRG6cp18TRs4EJZU7MdHgrwtfMNNsvCtQRDr0MCtO7PE/34AiIvqRCfV6sIBU5uYNzIKQ9iKAnthCh66ogMcu1yGF9Y9dQaIygtPJ+grv7VfZj6bIuMPEcx9c7dy7rf5Pz3I9I1QOk7h7BTI/204DZNxtA+SIWIqhJZkitneFZ0KtRAF8Ot6NuxsXCZ67u5SnaOJMYwVQ0slH7QdIiSmSU2WzaKnSDM+4emXuDNIIW/tZfktRtqgNy/cHQKI7EYvjoc31zjcKvlm4kyPC/HagdEu5VZOS2ZZh70/UwfHNTlvxL4a/UPv1OuPzBnGjQJsEZ8yTAr8aaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wzYJgJg2IZL9M+SRqxtc4xZNymfHvFiKn2vDTGKf6vYoa/TEwKWpA09ZYWcgo7ptF1eZW7/fG0MClux3DGG2NJcDSkbj82NgNUGDTD+tLxlTHR/AGvWPPEScD75l599GN+gLjtI4a+jAXf8/oJn8tuurSn1efeAZhBSQVdYZZb0wa0OKjdtne4QWW7hdPHZXJ0Zfhj38ffHRla4KuqmWrzrMeftco6UWj6U1O1UHunpxve1QTy0M9nnv7rUPNvVRc539a7cC3GuML6F7/i6jedl2dpQupNXQ9WhWERXaqAMaVKyJGw9k3ywqTBu3jThbTvM6v2yIfevBawnFNPn56b/WzR0/d4f48MKqIDcdfBsKOdt6VRKFDCU3Lpni4wXjimZ61TMs8eA07Rj7L19eEUeE4ujVKbdSICRBpnXjkQZ0axwRrerM19hhXfA8P6f/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 16:04:17.3545 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56fcfc33-4db9-4ffc-2556-08de843ed7aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8709
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

Add CSC (Color Space Conversion) colorop to the AMDGPU color pipeline
as the first operation, before DEGAM. This colorop handles YUV-to-RGB
conversion with support for:
- BT.601, BT.709, BT.2020 encoding standards
- Limited and full range
- Bypass mode for RGB-only workflows

Implement __set_dm_plane_colorop_csc() which maps the CSC colorop's
COLOR_ENCODING and COLOR_RANGE properties to DC's color_space enum.
This controls which YUV→RGB conversion matrix DC selects from
dpp_input_csc_matrix[] and programs into the DPP hardware.

The implementation forces a full_update to ensure the DPP gets
reprogrammed when the CSC colorop settings change.

Co-developed by Claude Sonnet 4.5.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 75 ++++++++++++++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c | 25 ++++++-
 2 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index cd1e58b8defc..d13b1b2d54cf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1869,6 +1869,65 @@ amdgpu_dm_plane_set_color_properties(struct drm_plane_state *plane_state,
 	return 0;
 }
 
+/**
+ * __set_dm_plane_colorop_csc - Handle CSC colorop for YUV to RGB conversion
+ * @plane_state: DRM plane state
+ * @dc_plane_state: DC plane state to update
+ * @colorop: The CSC colorop
+ *
+ * Reads COLOR_ENCODING and COLOR_RANGE from the CSC colorop state and maps
+ * them to DC's color_space enum, which controls the YUV→RGB conversion matrix.
+ *
+ * Returns:
+ * 0 on success, negative error code on failure
+ */
+static int
+__set_dm_plane_colorop_csc(struct drm_plane_state *plane_state,
+			   struct dc_plane_state *dc_plane_state,
+			   struct drm_colorop *colorop)
+{
+	struct drm_colorop_state *colorop_state;
+	enum drm_color_encoding encoding;
+	enum drm_color_range range;
+	enum dc_color_space dc_color_space;
+	bool full_range;
+
+	if (colorop->type != DRM_COLOROP_CSC)
+		return -EINVAL;
+
+	colorop_state = drm_atomic_get_colorop_state(plane_state->state, colorop);
+	if (IS_ERR(colorop_state))
+		return PTR_ERR(colorop_state);
+
+	encoding = colorop_state->color_encoding;
+	range = colorop_state->color_range;
+	full_range = (range == DRM_COLOR_YCBCR_FULL_RANGE);
+
+	switch (encoding) {
+	case DRM_COLOR_YCBCR_BT601:
+		dc_color_space = full_range ? COLOR_SPACE_YCBCR601
+					    : COLOR_SPACE_YCBCR601_LIMITED;
+		break;
+	case DRM_COLOR_YCBCR_BT709:
+		dc_color_space = full_range ? COLOR_SPACE_YCBCR709
+					    : COLOR_SPACE_YCBCR709_LIMITED;
+		break;
+	case DRM_COLOR_YCBCR_BT2020:
+		dc_color_space = full_range ? COLOR_SPACE_2020_YCBCR_FULL
+					    : COLOR_SPACE_2020_YCBCR_LIMITED;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	dc_plane_state->color_space = dc_color_space;
+
+	/* Force full update to ensure DPP gets reprogrammed with new CSC matrix */
+	dc_plane_state->update_flags.bits.full_update = 1;
+
+	return 0;
+}
+
 static int
 amdgpu_dm_plane_set_colorop_properties(struct drm_plane_state *plane_state,
 				       struct dc_plane_state *dc_plane_state)
@@ -1879,10 +1938,24 @@ amdgpu_dm_plane_set_colorop_properties(struct drm_plane_state *plane_state,
 	bool has_3dlut = adev->dm.dc->caps.color.dpp.hw_3d_lut || adev->dm.dc->caps.color.mpc.preblend;
 	int ret;
 
-	/* 1D Curve - DEGAM TF */
+	/* CSC - Color Space Conversion (YUV to RGB) */
 	if (!colorop)
 		return -EINVAL;
 
+	if (colorop->type == DRM_COLOROP_CSC) {
+		ret = __set_dm_plane_colorop_csc(plane_state, dc_plane_state, colorop);
+		if (ret)
+			return ret;
+
+		/* Move to next colorop */
+		colorop = colorop->next;
+		if (!colorop) {
+			drm_dbg(dev, "no colorop after CSC found\n");
+			return -EINVAL;
+		}
+	}
+
+	/* 1D Curve - DEGAM TF */
 	ret = __set_dm_plane_colorop_degamma(plane_state, dc_plane_state, colorop);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
index 3e05e48a8792..9c24fd1772a6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
@@ -70,6 +70,29 @@ int amdgpu_dm_initialize_default_pipeline(struct drm_plane *plane, struct drm_pr
 
 	memset(ops, 0, sizeof(ops));
 
+	/* CSC - Color Space Conversion (YUV to RGB) */
+	ops[i] = kzalloc(sizeof(struct drm_colorop), GFP_KERNEL);
+	if (!ops[i]) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	ret = drm_plane_colorop_csc_init(dev, ops[i], plane, &dm_colorop_funcs,
+				  BIT(DRM_COLOR_YCBCR_BT601) |
+				  BIT(DRM_COLOR_YCBCR_BT709) |
+				  BIT(DRM_COLOR_YCBCR_BT2020),
+				  BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
+				  BIT(DRM_COLOR_YCBCR_FULL_RANGE),
+				  DRM_COLOR_YCBCR_BT709,
+				  DRM_COLOR_YCBCR_LIMITED_RANGE,
+				  DRM_COLOROP_FLAG_ALLOW_BYPASS);
+	if (ret)
+		goto cleanup;
+
+	list->type = ops[i]->base.id;
+
+	i++;
+
 	/* 1D curve - DEGAM TF */
 	ops[i] = kzalloc_obj(*ops[0]);
 	if (!ops[i]) {
@@ -83,7 +106,7 @@ int amdgpu_dm_initialize_default_pipeline(struct drm_plane *plane, struct drm_pr
 	if (ret)
 		goto cleanup;
 
-	list->type = ops[i]->base.id;
+	drm_colorop_set_next_property(ops[i-1], ops[i]);
 
 	i++;
 
-- 
2.53.0

