Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD43C5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 21:18:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 984D310F75F;
	Fri, 14 Aug 2026 21:18:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u6rT21U2";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010046.outbound.protection.outlook.com
 [40.93.198.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 394D110F71A;
 Fri, 14 Aug 2026 21:18:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=miSex/qLf1QRE9s528KueSaZtZBYyYOWDXkjdYh5/EwLpCQcHak82JwAnNIQJlnlM4cCtv8hbsQOZEy9KbbtQmxqCbSs6zrmPz1pNNlgE8BrD0s07mULpvgJL2oBqrIW7OF0omLPz3Mo0GImj+uIRdB1TTyvHpxvhxcWJThOGNLZhAZQQJt68C0AH1k/FFnImneN5mijbZtX+v2+5SGAeiKSvw6EMJab6E3C7JwiYYJCtOhPtWt2EC2gDQAmoy+FUs47xVKYPpLrQ9Dmopcn9Z2tHOglNEtvhtpj1QHlJyPqo4Bjefqs8ZZT1NHNCuJmsShQ8xD18ivAkNpKfAsUHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UbZpQtoCuqn20ETZtcQHdAGAcmUnWZk8cadO6gFU9Q=;
 b=ctyHq1dXpRFYzGsiIaj51Pv4Rgogw9SenQEYYg3RlMDxRuAetJnecs67HiNv6PLW8FOYhBQr01tjv/Hk7UnWb/XkBtIDhdgOWFxTHN1PQDe+AmI2tHrcvsxbIJ15QVYc6Jh9Cio8D37B5vSI4UGEYjK7qOFKD55Mlq8jIzXHNoF9U3mbSNUH+0EoPpYz59TdT1OXSPcnpE+6ikKHtynx03RvWbeIbf9jfz+hlHZ+o6139zqR+69gpTg2h8mE4Fw22XIRsvaqHukNxEQvQbf21Yr0iyVvYZ45W1u6r2qiOXrDMhTBetIOY1pBMFoU9LVX7dqFN5MgYI/VtnhXiDmvcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UbZpQtoCuqn20ETZtcQHdAGAcmUnWZk8cadO6gFU9Q=;
 b=u6rT21U2ekXsGmThfjTgCmVaF2Q7dgSP8IX059EH3JYahwChBUYlmoE/064wZYHT5Pv6X4xeh7H46TVjaA5IQfjQSe8NmrESTEThxb8UzINuZDyoto1mQuB4quGbjbOR+gwvKry7pUndfz5im3kr2uErADgmMH4Bc6OFM9ilexE=
Received: from CH0PR04CA0101.namprd04.prod.outlook.com (2603:10b6:610:75::16)
 by LV1PR12MB999279.namprd12.prod.outlook.com (2603:10b6:408:3f7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 14 Aug
 2026 21:18:22 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::21) by CH0PR04CA0101.outlook.office365.com
 (2603:10b6:610:75::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:18:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:18:22 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:18:21 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:18:21 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>,
 Robert Mader <robert.mader@collabora.com>
Subject: [PATCH v6 06/10] drm/amd/display: Implement fixed matrix colorop
 color space mapping
Date: Fri, 14 Aug 2026 17:18:12 -0400
Message-ID: <20260814211816.1219597-7-harry.wentland@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814211816.1219597-1-harry.wentland@amd.com>
References: <20260814211816.1219597-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|LV1PR12MB999279:EE_
X-MS-Office365-Filtering-Correlation-Id: d2bec3a8-a81d-4504-a9bb-08defa4991f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: V+p2RaoMYvOv4rbZIdSYOdA5vB3mjLTsVUhfCDr3gyZx0r7Isefr2uVGChQWEl0FCe2FZFxU2dgGbTW+0Bx8fjyQOg77fRX8gpQWwmrqriRkV+furDPkZ1TDbRRAWrHfyJsQMuI4v+qgfoIiZXtyiqpHW/jEnCNslGcY5kLJIZD16+tc8ggXqoXiMHKUd2grHA9TdvlIix9pNVlTJnJfdOwvnvjiuPxUZLhVblm8880H2FU4+4n48d5231k5TLhWyuf7cQBEH41fIlPjYyMXGm6xYo4VGOPUaniTNPp07ZGhHBBm5OyqHpk5OJwx049/3VtwXvEc+CXxfmjnF3x1tAbcU5N5ohwso2u086Z17X+MY49YNSSXED0nX9G2r20ESgEtatHK4szUjkK7XwH6m1r8sfX2qbveGZxqD/nxLPsgeo0adEfTvAvndDRjC40Sg7gOXNMOsuMGTGnWEg9Mo5OVFjFpSfuVeLqVbO7jZ5b2iPVRLCullyKGD/1NZjhqm0PrfHqlCF+UotzGjnVcf6xNc5CCqX4uxEatrE8dklH03bwITwpa233Rm9j5IlHsHcdasYdsZbTQBgaO8PAxwE8pm2ZLYPfyxANTdQ58h1Jiwm0WTzxGqbNW/uzQ5ChAR5mLpsvyQEVrsku1jPbTEsBdks2auy3JeSOgFCupKiIZTHXQ/XZrguwVYDfl8GVD+sgFjcGPjcpZqARgqjeD1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4bNJMKA6UoxusyIPDLUWae2FcjyIbVckwVujKWG4myQrmClK6BLrclL7M0lucBj0CKpfGeeBar5JFOWwBL5AAlpUXSEKBYAL2VuopBdoR+F1Tn24pl1L72VpTnVF8Kh6vBrspXa39ZfPWSjDQph6qy4ha13tM8g5BDF/XFi+qD0CgpI/Jp9wOVoD2Kp96MFL7CVP5uqTzctV01QC1TXYBuxDWsmzJzojSj7ND5RG5CsgKWJqW0il8hYSB3PCb0Xk3skQ6/NmnpQoifpu6MfY1L3gBkZ2yKAb6zyiJmiAyjec6JRqnCa8fo1UlkEd/yCxA/uQE90K6iz95hpT+b6TmsW1hnt7pwXpDzq15eRjEwXvO27AgDoPp2Xh3DBe3pg8Q1bHdWU7tlDswoW65vPPNECaCNKFbnMnSVE7Qbmt+lnG/i+SI2yTtfNwcs0lIvgO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:18:22.0660 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2bec3a8-a81d-4504-a9bb-08defa4991f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999279
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

