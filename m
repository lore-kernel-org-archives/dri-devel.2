Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C00CDB479
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 16:48:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC82B10EC13;
	Tue, 23 Jun 2026 16:48:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k1LG6ueN";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010038.outbound.protection.outlook.com [52.101.61.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21F2510EC10;
 Tue, 23 Jun 2026 16:48:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=svC5kR0I3z010iuJo+JE1YeIgXp6XmE6+C119QYnXVxxeKEVhXv2oUmdjGu7LDxQpnf6m9YvacwvQ40XJJ4VvUIhJMnryIHR01s+pPxx09OYD5VEcW/Z5PVXLa176YmXFkbwC+6vEKa4rpE1NEp/Jewu0NCSUG0nfHGaDPwgtZHY71zrLbTl4TvLCjnPXBMjt9ZjES82t/EmKskpLD5TK2WP9zSGPTJsxttqtHywsK3iARCobSxFjyA0CL6dBoNCTIdwek36kDwoZjaW8ZtUDCrwxRLqO7HVcpSrCMX991kOURMOsCxoc4xRXTcuMEwjBt/gB9c8u7Giv1pYmYOcag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQEon0qmtblZygQfHmnZXaMNTQKi1yAfxolLpgdrbCo=;
 b=VMjijt88sJRH1hlmRqFMlPfdleKOfbe7iIggm5D8c3szP3m7pzXVmOHGVswzTL3TUhPBVr19GBya15uEOaUo3lG40/pXRkHvfunlcmy+nJCNDk+hTpUMYUVEMRUjjEOGcCmavFvG6brZzHaYG4hkDYCFXaD+v6wDWSShTaKrWHE/utBfyor008yLZRrGMuo97QCs267Fyo7sgv9aLVHcrkS7xiSheMFPJSSgVkdjtR+4huAAgJ/kS5gDY3W42bE2/zRZ05mwG9clLtORxZEcDyhztvfnLA/1zlFoL2H2gVj7bkP5W76Q/kBVjD8qCJWU4OVWyZlMl9nJXKkfQoLR+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQEon0qmtblZygQfHmnZXaMNTQKi1yAfxolLpgdrbCo=;
 b=k1LG6ueNo+XLq5q4K3Qb4ExYj+n/VcUmyrXN6pju+E9R6d25AeCXkCb71bKQhgwij8sa9FLN1143p3RI/FIjOTGpcv3E05zMdFhECXZ9zNeiixcebaMxNncI/ruZ6LpkMJwuvvyVPLC9JPEy+xPEVnuEVuwP58ImEmbNlwBuJ2A=
Received: from SJ0PR05CA0181.namprd05.prod.outlook.com (2603:10b6:a03:330::6)
 by MW3PR12MB4377.namprd12.prod.outlook.com (2603:10b6:303:55::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Tue, 23 Jun
 2026 16:48:27 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::2f) by SJ0PR05CA0181.outlook.office365.com
 (2603:10b6:a03:330::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.8 via Frontend Transport; Tue, 23
 Jun 2026 16:48:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 16:48:26 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 11:48:21 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 11:48:21 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 23 Jun 2026 11:48:20 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v3 07/11] drm/amd/display: Use GAMCOR for first TF if YUV
 conversion is needed
Date: Tue, 23 Jun 2026 12:48:08 -0400
Message-ID: <20260623164812.81110-8-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623164812.81110-1-harry.wentland@amd.com>
References: <20260623164812.81110-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|MW3PR12MB4377:EE_
X-MS-Office365-Filtering-Correlation-Id: 936495b6-1e66-4bd0-6784-08ded1473f45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 1oL4cQVlnR1EGV7PdoHDPrshnN/we1990vvitWpDOF1ibvZeSKRd48xg1QZlLb7RXLvlQ0LAlyU5fKqxYXmOr7Y6L5rERNtaibEj0Mihj2dP1GoWudvuBXslgBD3CjG/5eBmL7OCNFhq5ydVC009To8NCXsmjOk8YTTMsrSQr+MBw2Muek90U3lp7/RuGYiqo27q1OnOIMXER+nt385SVqGAgyQxCHnQyZoMJLwTZNa4W17xs4Se56AIYUo5eVnhgothfEy1ZtSM+BojWhHXJAwuh0VQ5lY1pKQ3/dxgZ3PnH2eQf6SH93qbxSoOG64PgGVqZriLGhPLiKouhOSZrM9M+2fdbu8Lsx/8UJvH0vbCHNlMs9M3Nypc1K0PRFgqKJhgRKveT7rOGnqrr9GzHj8eUyO6hce2eTafLV3N8+knm3V8n/LS3Ihhu9GHN6jCwaHS917epewnmkbgQxrYahZf9LHug0Ke4hZ0qRlTiFfu6aulibf2MQ2bQeJO/4N9a77CgzI7++F4KoctFbzB3BmRkbukm3yJcZcQWzRhmCAOIau5X7dgO/zxXqpEX/v3Gd+M85CrKP1vHeU0crt+zkyQWcf5TdLipVts9ydk5xzHp1pyfXKBHTDQ/8BrGaTlZnFuytP2VDp7LyAieCQGAqXgAlHZyWVFckUBgq/gt9yNHfmCE+z2PG4tSNgzfdYxgIifWnHZ+V18ib0DE5Z51g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: H8bLzGI/9fB39S9xLxZAkXAQUmRaykDGrHCKN6Xv+gxx+PArR6T8IZsgH4dw01/cDcYC1UYVSszaLJlBzhwUyZboV8sfm25Z9V4vAEaUiPkvs4CAPQhkOqM/5b7PaL+WT1ZJyHDlTL3wnsDjOJ/lHOqwTfGjxLcgQZCGa05O9kA98ma3zq51TjX92dFCrH1tpLVkcoqTI1eWMZ717HArGCv8KIcRN5imBLqVXfHUPVjn/UujLB4JwdhI2i81X+DllDcwawWdIE09BXkkTqF+gr5A2QOUk3i+bWSgA+jfBJ0BZtf+aop4/LgWlISe2t91gI1s899TQ497hKYrS7m9DjDTyTJOOwV2wPiG16Z/i0YeTlsMxxAcKsCw9Xb8xaZmTkV9KkC4tUoe9+kd56G04N+g17vJWyOmLcp2j/D9FlmnmShry5A436rTakOzOWrD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 16:48:26.6813 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 936495b6-1e66-4bd0-6784-08ded1473f45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4377
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

For subsampled formats we need to use GAMCOR instead of
the DEGAM block. The color module can create a LUT for
that if we set map_user_ramp to true. So do that when
we have subsampled formats.

Assisted-by: Claude:claude-sonnet-4.5
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 23 +++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index c54ca5188f68..561ee9a2e749 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1454,11 +1454,15 @@ __set_dm_plane_degamma(struct drm_plane_state *plane_state,
 		if (ret)
 			return ret;
        } else {
+		bool is_subsampled =
+			dc_plane_state->format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN &&
+			dc_plane_state->format < SURFACE_PIXEL_FORMAT_SUBSAMPLE_END;
+
 		dc_plane_state->in_transfer_func.type =
 			TF_TYPE_PREDEFINED;
 
 		if (!mod_color_calculate_degamma_params(color_caps,
-		    &dc_plane_state->in_transfer_func, NULL, false))
+		    &dc_plane_state->in_transfer_func, NULL, is_subsampled))
 			return -ENOMEM;
 	}
 	return 0;
@@ -1471,6 +1475,8 @@ __set_colorop_in_tf_1d_curve(struct dc_plane_state *dc_plane_state,
 	struct dc_transfer_func *tf = &dc_plane_state->in_transfer_func;
 	struct drm_colorop *colorop = colorop_state->colorop;
 	struct drm_device *drm = colorop->dev;
+	struct dc_color_caps *color_caps = NULL;
+	bool is_subsampled_format;
 
 	if (colorop->type != DRM_COLOROP_1D_CURVE)
 		return -EINVAL;
@@ -1485,10 +1491,23 @@ __set_colorop_in_tf_1d_curve(struct dc_plane_state *dc_plane_state,
 	}
 
 	drm_dbg(drm, "Degamma colorop with ID: %d\n", colorop->base.id);
-
 	tf->type = TF_TYPE_PREDEFINED;
+
+	/* Check if format requires post-scale color processing (subsampled formats) */
+	is_subsampled_format = (dc_plane_state->format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN &&
+				dc_plane_state->format < SURFACE_PIXEL_FORMAT_SUBSAMPLE_END);
+
 	tf->tf = amdgpu_colorop_tf_to_dc_tf(colorop_state->curve_1d_type);
 
+	if (dc_plane_state->ctx && dc_plane_state->ctx->dc)
+		color_caps = &dc_plane_state->ctx->dc->caps.color;
+
+	if (!mod_color_calculate_degamma_params(color_caps, tf, NULL,
+						is_subsampled_format)) {
+		drm_err(drm, "Failed to calculate degamma params\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.54.0

