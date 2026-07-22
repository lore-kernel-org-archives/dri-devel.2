Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE5EBC44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:46:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E559C10EDE5;
	Wed, 22 Jul 2026 13:46:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t9Wk/eYL";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012043.outbound.protection.outlook.com
 [40.93.195.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAD2010EDE5;
 Wed, 22 Jul 2026 13:46:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWVXQBnb26732uagPfZzAmgczpTVWBEBDA/G7RGtQmvoPrCeYaxnQd66yqoBZX3k1bAqlqEOtBSubqVIQcnJIcYAsIG42DjX7/91cxX28lpPLwZFZreXMySb0aWa20qcCit+ZFxHkP5rqgHOeotf0NGlugixtu6QIch6VlxisrJ9Sf98mOCASJv5PR69gB9ihyxshLS0g7rf/jMVwdSoeuEeZ8bput2Lfe9QaoB0zgORRxA36fOV+qItn5T+s6u+o0kMSh88prKw28iByiJfrqbY4DE/KSrf2i+CqGPpVeU7nsySYuYnOL4TdKwo6DeuCFz9l2c4Wox32Zkx9ymWSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFVzo/fWpEWneVwfQdM8EhqV2qm82BJmmJWKLFApmBs=;
 b=hBGF5LH7OnDcK0nGFCSWrOs3NJBKDRZzimPVNdS7ntueLpmkICQc1ljbFqdW+Z6QlNyGeNxxnIpxsj/8/UFdVD9raQhsRJepX2nbigr7jzOkYGbFSRsf99Snhbs4NzA5MAujKqxHXu7xGwlvOyMpSc9SvQwo1N68QgvJ8uhAJ+RnHt5+X9j5O0h4niYpKpBaeHJAMZOW1Nnof+MbYAe1S977KGyVeSUeT1oFvKgVRX+SbVpq1qKweTb0ZdsR4zHnTCFhzEwrhKxs26YPadHaZh5qa2j00BMcFqYRl6aCIxEypmoAkqKQAi2Sl6FkZAOiIzMjkZ6QVXbSip3iPaHlCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFVzo/fWpEWneVwfQdM8EhqV2qm82BJmmJWKLFApmBs=;
 b=t9Wk/eYLzNgrYYoKZ/CkQkdH1BRM34hdZByXIFI6rRC+YI+kt6qkDYquvXyxMTp//8FfXyf4TQwfVf5TbOlKytCtf1cYJl6oB5PvfhfpKA80tS2AzaW9DxAU2gBTDBda7qhSu5/7fMkIuqjoACVQqloxZ4ryGssvYEUbd7Ttleg=
Received: from BY3PR10CA0025.namprd10.prod.outlook.com (2603:10b6:a03:255::30)
 by SN7PR12MB7347.namprd12.prod.outlook.com (2603:10b6:806:29a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 13:46:20 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::87) by BY3PR10CA0025.outlook.office365.com
 (2603:10b6:a03:255::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 13:46:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 13:46:20 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 08:46:20 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 08:46:20 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 22 Jul 2026 08:46:19 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH v4 07/11] drm/amd/display: Implement fixed matrix colorop
 color space mapping
Date: Wed, 22 Jul 2026 09:46:03 -0400
Message-ID: <20260722134607.136293-8-harry.wentland@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722134607.136293-1-harry.wentland@amd.com>
References: <20260722134607.136293-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|SN7PR12MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: 31bc82c8-5227-4fc9-df29-08dee7f79cb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: B4yTptegxJAJXK2YYjG8jf1jFJ45eqrEDXbNG+pF/VdL6WBI5RSV2Tu5jKmyrd+v60GAkGeow9Y4a5gXJjMnIWA8aV8jEuZZMcqHSgStYmUXVcuQdwxtvA9JJAkoe0c9Z7Rkzc+CxgwpoiUDwkXEJ4GSV/Lc8LhW2Y2Til/FPTnCMVDqb+xlxtiJfCIyQTIKm/MM4JqgyEP2tRVdMLGxzA0WRhdSFFFGgPvgtURgznotZXudZNzefNTXeF6m4O5z5C0Uo5MLGe0MAachbJ8DqQdlemVtD3hv7mL7OacD9/10AGYTAs7hDWlHY8Oc2Ee4DiaczvdkfgbLBqcnjneHYn5e/r425h4ywGx+BJKRJMP7AXoS94iZKwiZ9lFuhcblYmoFxhjbeNo0qF6vSykljO1aSyDHTkdXFBo+oVVVXFyBFbICPtiKXSsFY25KccQ1N4/TCjn6qDpktePYCHtYr2HHJA9BeEy3a2WRvZNXa8iRJXv5JE83exaov61M+Dfsgeax/zJC7qfJAWHHvaNdiasQOHZQRm+1nYjSbHxNKRHJGyr/BTBy68qHlL8GpRDm4+cBVD8Xd3U5vCa2KjpQE7kmn7uPjsh53NXVz7hjfP2gUbFD0+6zf5li6ro/WpwdWSK3bmqTbc6o3RPB4qkhIj+FawTtvHAh+vFRbQ69FzYtfTgl7dBal2yfe43/KC7QhYZzhHcj50YgXRik76Qmiw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MCpyrFb6FT5c4OOtA6ndjWrLf9Xw6OqkbZQeS/W9nmyXDnwMZ7BI35ZBTbsgQos1uxsvYMvtfLURaAKZ7qlAL1+ILUMOXt2WAEpFbrD7FdcVAqtLteqe9ixoI03RFhJy2DDmjGmwl4Eto/x2Ksl+dFWlHVo/EEi7U0nHhjsiu8Io4GBiXzAT+Gjfy/IypnQrakXmoLB4DGGMDZSlgM0x8DQ31nyNM+bty8VH/ZZuiiAV5iyLVkVFyJi9vJfDMNYrTN8y/kW8g0FoOeKS7naH/xotPqFrKzw7bTHK12JzaqOIMTccoeSXFqjuFehPqFVrVmw2/rb33o4rThnJgiysw6168PtGATX2SD70dauuOtcQTxSvvHDrJPDlYiQjd+e3ip2HOkk1g7U9lFhpP49+F9uL3Dmsb/ukxGGP4V3p96dPlZmQrJx93+MZUu7XrFuB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 13:46:20.3624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31bc82c8-5227-4fc9-df29-08dee7f79cb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7347
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

