Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B69C55174
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 18:15:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 675C910F39B;
	Fri, 31 Jul 2026 18:15:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TvN6MyQv";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011045.outbound.protection.outlook.com [52.101.52.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3C9910F393;
 Fri, 31 Jul 2026 18:15:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nl+rkSI8DXRxZSkLWmg5vEs4JC9jHQ/MubHfSilyxEq0yvdbjr8IkQUsl+V1BWj7ROYJlUdoge6v0wsiqG6daRYMckVKTAiE4tsA3qaUMFATIdpekVj9eoqOAceWyuPr2Hxpk0flZHcRTgreEVAwi3926/ZkMxNyabDUo3EETQ5b+d26fP0rWDopaYA/EXwSYVbpyJd2rU2mDyOYwOAAs88XoE0xYgwNWux7+Yd1nU3qs2pyOoXSVSxNIWUrc9Kx1FfZDNwKPOVDlAFZpClMQ1EzRf1uxy0Ad1TRuyG9QEOVegiX3lNBMTuQzsWnwUl3znL5Sfd0LzVR8VObmG+xzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UbZpQtoCuqn20ETZtcQHdAGAcmUnWZk8cadO6gFU9Q=;
 b=gDcNFz1s14B0Bg5fkbjgRkbRS8QlP1R2+ReKCZAhePyWXQq9tXaqkkNL+YAJVnqNfWB/0Bprk6ma8t0TST+gIxcbhTLhP/yzEPVH+uw0MMlRdx62+o7ZuAgWgoJNssTxw+V+H5NewTbswC1zmy8oEy+gGsCFrDdODWTAM52CWGd0XUY+pujYh40DCnIMQMfxhDahbRX119lLZeR0iG6+g7f6Yra5naTJUDUH4N1XZPEelqsUr/JweIxwOvkxaNkp85q3UTzKNg3CFIXz2yCMNTS0uZ2YnHoQonAnDNJi5XuI6pDzZwK/nYdCz46pJB/4vSG65GJsTZUcv+3u/AcZkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UbZpQtoCuqn20ETZtcQHdAGAcmUnWZk8cadO6gFU9Q=;
 b=TvN6MyQvBjILUoXtz+A56l+TPhY7+dvP9t5J8r4svT83d+eT8uvp2QzbhO4YzeuBEnMT7py5L4MeUE5d/0uz9ua17m9f2p6d5JvApgkxbXKO9ejiP+/ECp+FW8LuZc2M1URL4XRkp/JJF91AtfFYC6Zhnhl1oRMIOHn4kQhNhx8=
Received: from BLAPR03CA0043.namprd03.prod.outlook.com (2603:10b6:208:32d::18)
 by SJ5PPF0AEDE5C3D.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::989) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 18:15:31 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:32d:cafe::73) by BLAPR03CA0043.outlook.office365.com
 (2603:10b6:208:32d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.15 via Frontend Transport; Fri,
 31 Jul 2026 18:15:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 18:15:30 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 13:15:30 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 11:15:30 -0700
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 13:15:29 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>,
 Robert Mader <robert.mader@collabora.com>
Subject: [PATCH v5 06/10] drm/amd/display: Implement fixed matrix colorop
 color space mapping
Date: Fri, 31 Jul 2026 14:15:17 -0400
Message-ID: <20260731181521.681990-7-harry.wentland@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731181521.681990-1-harry.wentland@amd.com>
References: <20260731181521.681990-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|SJ5PPF0AEDE5C3D:EE_
X-MS-Office365-Filtering-Correlation-Id: d660be9f-62db-4e34-e24d-08deef2fb4e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|11063799006|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: PDa6Kk7hyns3pXm9UmqATBexCZVwl4g1ETiET9gEbO6APNuUGN/+fcajnhRgRyahglDw/rUzvZ5rSZa4eaNUDy0kSJ1rjbdN9fZnjiQgAgxevMtrU0pezH+eKxOL2yBEFmE7vkop5WmmdG2nbExHYFByjjGiwwjDCG05oaivmue3ZMXhgQtSee6DDpKADnhjGPRH2Yr5jm+NRq6FQqGlGjkEFZRXU91JHlreYMjTRLgBwan3mp7aRvmCZDkXZUqDrQJvWa015BGwftTifCkBLfcdxr/lhrSNvNOD6mL72AKOkI2I9PD2ydjvP42n62gesjsWRH9EivQQo/3TT/yAZvRLE1fMzHBPvOeifnX+apd+Tj3B++wqpe/OUMUKJNhW0jwCVwOBOC+GR2kXmVMUSjzeVtLynVuWcQ8UB988lh+Q01uKDTQLUfzeCBQhc+E5yEvrbXFuG8pCdSqut83wNuL9zZT9q3lVvoW8URx+ktn3762YpZp3CriwTRmHK3fBQLx5si0uX+S5o8ZP2Jv7KDXFPo3vqCa4PJde6Emgt2VDLkOTkTPt+0FBohyvOY4Ev9MY6TuyspaVVkJe8y1UAciHu6vQR8cxbUP32iSMz/pzH6PFbRBVTIRCiIOcTKCo0XPeB4TQhGAX1ySgdhS4kyjs/rIVg5durDx9OQWoK45xySIv6hIXLMH0XLjH8bv25Nb+Gte7j4ou/CHddt+S8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 70zbfR/wBIpoG4UiDH9G57w0VQ6n5LRQJwY5ZyAYBpk9yicrRH6B0kClnvHxJbRjzfQ8LbNbu2k3XJbKrln2i48mBVu7Dc4SEL1XQ4XEI3moMLhu4Jmr8GjudbOkDRoDqmrMOrm31BCdrjXMWdUq1yuXk6UgcPmxYYqxWAeXDa0rQYv4Cvm8ifIgHrf87ePnAKhWiZLT8VZpBxwbb2duNNpSCpyNFAzxmjNnrwN0IWS4ioeYXWAxI0q1QAXYa4mtn2zIi/YZ762px817P1R77tAVh3w2QOd6gxOHw6w2vt94jb7WgFCMJkfizZ4oI/N1VpIefeWpSOTmWzysuer83Rv96c7H4dnY8LWrsqPuD2loaw4lqaU+xcBHNuDX1uY12CJaqwLTmQqhpOYDPCAXxQ0Mv1mPlJpxSNNfYtF2YDBQspMgCs8409mf3kFTS/n7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 18:15:30.9877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d660be9f-62db-4e34-e24d-08deef2fb4e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0AEDE5C3D
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

Add __set_dm_plane_colorop_fixed_matrix() which maps the fixed matrix
type enum to the appropriate dc_color_space for DC programming:

  YCBCR601_FULL_RGB     -> COLOR_SPACE_YCBCR601
  YCBCR601_LIMITED_RGB  -> COLOR_SPACE_YCBCR601_LIMITED
  YCBCR709_FULL_RGB     -> COLOR_SPACE_YCBCR709
  YCBCR709_LIMITED_RGB  -> COLOR_SPACE_YCBCR709_LIMITED
  YCBCR2020_FULL_RGB_NC -> COLOR_SPACE_2020_YCBCR_FULL
  YCBCR2020_LIMITED_RGB_NC -> COLOR_SPACE_2020_YCBCR_LIMITED

When the fixed matrix is bypassed, color_space is set to
COLOR_SPACE_UNKNOWN.

Update amdgpu_dm_plane_set_colorop_properties() to process the
fixed matrix colorop first (before DEGAM), matching the new pipeline
order.

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Tested-by: Robert Mader <robert.mader@collabora.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 68 ++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 357c7c5c85cf..62791077ceef 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1545,6 +1545,61 @@ __set_colorop_in_tf_1d_curve(struct dc_plane_state *dc_plane_state,
 }
 EXPORT_IF_KUNIT(__set_colorop_in_tf_1d_curve);
 
+static int
+__set_dm_plane_colorop_fixed_matrix(struct drm_plane_state *plane_state,
+				    struct dc_plane_state *dc_plane_state,
+				    struct drm_colorop *colorop)
+{
+	struct drm_colorop *old_colorop;
+	struct drm_colorop_state *colorop_state = NULL, *new_colorop_state;
+	struct drm_atomic_commit *state = plane_state->state;
+	int i = 0;
+
+	old_colorop = colorop;
+
+	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
+		if (new_colorop_state->colorop == old_colorop) {
+			colorop_state = new_colorop_state;
+			break;
+		}
+	}
+
+	if (!colorop_state)
+		return -EINVAL;
+
+	if (colorop_state->bypass) {
+		dc_plane_state->color_space = COLOR_SPACE_SRGB;
+		return 0;
+	}
+
+	switch (colorop_state->fixed_matrix_type) {
+	case DRM_COLOROP_FM_YCBCR601_FULL_RGB:
+		dc_plane_state->color_space = COLOR_SPACE_YCBCR601;
+		break;
+	case DRM_COLOROP_FM_YCBCR601_LIMITED_RGB:
+		dc_plane_state->color_space = COLOR_SPACE_YCBCR601_LIMITED;
+		break;
+	case DRM_COLOROP_FM_YCBCR709_FULL_RGB:
+		dc_plane_state->color_space = COLOR_SPACE_YCBCR709;
+		break;
+	case DRM_COLOROP_FM_YCBCR709_LIMITED_RGB:
+		dc_plane_state->color_space = COLOR_SPACE_YCBCR709_LIMITED;
+		break;
+	case DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB:
+		dc_plane_state->color_space = COLOR_SPACE_2020_YCBCR_FULL;
+		break;
+	case DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB:
+		dc_plane_state->color_space = COLOR_SPACE_2020_YCBCR_LIMITED;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	dc_plane_state->update_bits.full_update = 1;
+
+	return 0;
+}
+
 static int
 __set_dm_plane_colorop_degamma(struct drm_plane_state *plane_state,
 			       struct dc_plane_state *dc_plane_state,
@@ -1946,10 +2001,21 @@ amdgpu_dm_plane_set_colorop_properties(struct drm_plane_state *plane_state,
 	bool has_3dlut = adev->dm.dc->caps.color.dpp.hw_3d_lut || adev->dm.dc->caps.color.mpc.preblend;
 	int ret;
 
-	/* 1D Curve - DEGAM TF */
+	/* Fixed Matrix (YUV to RGB) */
 	if (!colorop)
 		return -EINVAL;
 
+	ret = __set_dm_plane_colorop_fixed_matrix(plane_state, dc_plane_state, colorop);
+	if (ret)
+		return ret;
+
+	/* 1D Curve - DEGAM TF */
+	colorop = colorop->next;
+	if (!colorop) {
+		drm_dbg(dev, "no degamma colorop found\n");
+		return -EINVAL;
+	}
+
 	ret = __set_dm_plane_colorop_degamma(plane_state, dc_plane_state, colorop);
 	if (ret)
 		return ret;
-- 
2.55.0

