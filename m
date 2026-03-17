Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413A5FED9EB
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 16:04:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B67C10E703;
	Tue, 17 Mar 2026 16:04:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZjC+bJJD";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013044.outbound.protection.outlook.com
 [40.107.201.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E614710E6EF;
 Tue, 17 Mar 2026 16:04:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzaezkVu92n63cSXA3tWpueMEkjJZ2Pzzn3Wx/kmjfmYEqMORAuuQ1Xciy/zctrTSGMauSKbTSzmTwNpOwDW7chsw9V88+ikvvsYVYLLHV2d8EDWWL3OgANj5jozScArq7KVEmeUu8RomqYFA8tn5qtjWglVnGpsNLyG603J4qWFCrfU6PxLJIgkSHOsPuY0MbXDit6+cz1Is2mKhjjriOG6rlmVIJvC2XK8+8NnbS4tNhzBJAx7XikRImG+EuBLQJ+XGqGvENsUlcvQVd0V1LyEtM+DrDv3/ZOIe8q93thgZGRy4kTwEsubMWnOf62tnFPzrNe6ZYhfTt0MSlMuwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orYil9wOp7jFnmX0lPVFKvgwBKNtsuDLl6uT88/51VM=;
 b=Ru1oTmudSh73eSUfGphmKp9ljy8/tF2ClFNBOAcLBJXUVsmymyHVUWrYsBdVo/YKu2hfx2bnuOJSarwdLBp5c30WjuRGw+tXronxpuJSxazXIHTp1cEuhk1UPzhk+6M4JZIVXJq+d5tRHvj0HLnf+K3KOPAfWhRmC+zpgQsfyaEywgJthYGqklAc/9hIXfBVgdXdsTjk7CL0zvpCkG80eXVGdAvQ3QLkw3lk9xTDD8/QH7jc92smi6EMVyDt6HJnu+UEdPUJInG2QfLvPhFwiRkM9Pz9dFYqCqaGdeL9NZA6r9LHBeGPDpquH1ZMmzq4qoalYiIFTEbgayl9B/7sFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orYil9wOp7jFnmX0lPVFKvgwBKNtsuDLl6uT88/51VM=;
 b=ZjC+bJJDGl+2keUEVFxFfU7biMwEkMSRVDs9tyJmWByR50SQTnUxy1hXQlsXoMpSw+qtUGAzNQlmxoZsuv1j+Nq14HVXa3X1m4/yo0TCAoD1QcVgWRjnaqrPOvHHur8KJ+R7GTrVJIABnoMhOlRetZABGjV5bo3HIN/6QywQ84U=
Received: from BY3PR05CA0018.namprd05.prod.outlook.com (2603:10b6:a03:254::23)
 by SN7PR12MB6837.namprd12.prod.outlook.com (2603:10b6:806:267::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 16:04:18 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::29) by BY3PR05CA0018.outlook.office365.com
 (2603:10b6:a03:254::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Tue,
 17 Mar 2026 16:04:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 16:04:18 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 17 Mar
 2026 11:04:05 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Mar
 2026 11:04:04 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 11:04:04 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [RFC PATCH 07/10] drm/amd/display: Use GAMCOR for first TF if CSC is
 used
Date: Tue, 17 Mar 2026 12:03:47 -0400
Message-ID: <20260317160350.229028-8-harry.wentland@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|SN7PR12MB6837:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a19ce39-3ee7-41d6-6b2e-08de843ed857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: UfrC1Y4Ucw6U0aB4S6JO3c9V7DgGjErYlE18g/nvSBD6dD2dltbddnM2FA7ylqNmpxLEUyuM+z3LBHAmyoEj0qb98uT688gZ9ojzcQ58uw61ldCDfNpnvoygJ4ShG4HhIUaf5KQhyni0V39bng5GegnwdHZ1hq4wPaoP3ZZAgD9WBxKtWhhJWjsl3dmWKWB4v/GZ2TSUsnA9cCwykgY2Zmaim/btxyrxlvrbLzm00bDelejyabtkwc8AOmQZn3GTXXjJkJ/qgzZ+9+FMyPaJ2QJbU1j8Mf0R+8qGtCEdl7ZkYsA8wn2godgv7Q2jDvEni2S6nTEw49dVM/r3295A+sfDvT6qCNGN10LxQHjpYExj5OpxkC7iFPLOO2/WeD/YPp67L68cGcwBKU0g1HJlUBnYo5XQi52i7WsC4dZA5pgsJLuNhRiPYkeEVG5yEEzJFDArLwUy2SA7NBo25YAeFx4SPDgRhi2k1zmYPDiKa7wGYVajhe2qLI6P2vG3bSafoQlRsBtcLbB7NrpKudEpgXKEa2aiyoQ4qeMvAefLveFjvARVJddvwuVEhY/GgFJAZ3ystwSbRouKV4OluTsLFUgZ5WKy8lQDDzaIW8cFKSieaz9sZ6VEuTLOCQ3wcpebChTI4PSfUs50h3D0JGkxhJtUzr0czwayZpGq/mG3eeXN8qk5Fyt4eavmA+kp17/UobHAMExPeQ+P4zDw++ckzjYV5C6aysa1apUEG4rcXzghhwOrYW9mGNvdGttI1yDAMcZPdG9l5NbKAaGzFIGnXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0cvNUavDaKxCUkHzkNaEX+FaxnL8bMHojKRwhgXLyDHZDgUISSD2mL8UDC4rXztr3wi5OJAiFhuYrRq25LHqQmLvhL/T+8tnwlCFsHVgApFePPcqbOt/sXomqhnU74UFJWuG6v6Bv4VLOtw6ayjep2q9XpgbkRvHLmDre1JlSxzC7lXNGQ0wWlCGUMrmJ4I8SaxRv06qmsWCehZMyXKOkIgOZ/YWkkyfJnCyNAR0vXh7l/Jf3Vk4T+6qvl+dWCJt10AbNEdrBYc2qzq4H2y3VtTNq7xdKaT4KOiy1ITTQrXTxJ0NYRigMhcnOQgGJQ1RlHrzuA6Qe/bvP6EV/kqyIqFCtUfSTyhmqBWQLC/ZnSzpzTW0juJ1erdGlif3WfV56qkmdmrQI24dikHbHudESNQHz3aFyUEorbLMz7FcJw6PElVyw2Y3KP34PPzB4eJ3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 16:04:18.4260 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a19ce39-3ee7-41d6-6b2e-08de843ed857
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6837
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

Co-developed by Claude Sonnet 4.5.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 34 ++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index d13b1b2d54cf..0d58eb45552d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1471,6 +1471,8 @@ __set_colorop_in_tf_1d_curve(struct dc_plane_state *dc_plane_state,
 	struct dc_transfer_func *tf = &dc_plane_state->in_transfer_func;
 	struct drm_colorop *colorop = colorop_state->colorop;
 	struct drm_device *drm = colorop->dev;
+	struct dc_color_caps *color_caps = NULL;
+	bool is_subsampled_format;
 
 	if (colorop->type != DRM_COLOROP_1D_CURVE)
 		return -EINVAL;
@@ -1486,9 +1488,39 @@ __set_colorop_in_tf_1d_curve(struct dc_plane_state *dc_plane_state,
 
 	drm_dbg(drm, "Degamma colorop with ID: %d\n", colorop->base.id);
 
-	tf->type = TF_TYPE_PREDEFINED;
+	/* Check if format requires post-scale color processing (subsampled formats) */
+	is_subsampled_format = (dc_plane_state->format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN &&
+				dc_plane_state->format < SURFACE_PIXEL_FORMAT_SUBSAMPLE_END);
+
 	tf->tf = amdgpu_colorop_tf_to_dc_tf(colorop_state->curve_1d_type);
 
+	if (is_subsampled_format) {
+		/*
+		 * For subsampled formats (P010, NV12), we need color processing
+		 * to happen AFTER scaling (to expand UV channels first).
+		 * Convert predefined TF to PWL so DC will use GAMCOR (post-scale)
+		 * instead of PRE_DEGAM (pre-scale).
+		 *
+		 * IMPORTANT: We must pass map_user_ramp=true to force PWL conversion.
+		 * Without it, mod_color_calculate_degamma_params() returns early for
+		 * SRGB/Linear TFs without converting to TF_TYPE_DISTRIBUTED_POINTS.
+		 */
+		tf->type = TF_TYPE_PREDEFINED;
+
+		if (dc_plane_state->ctx && dc_plane_state->ctx->dc)
+			color_caps = &dc_plane_state->ctx->dc->caps.color;
+
+		if (!mod_color_calculate_degamma_params(color_caps, tf, NULL, true)) {
+			drm_err(drm, "Failed to calculate degamma params for subsampled format\n");
+			return -EINVAL;
+		}
+
+		/* mod_color_calculate_degamma_params sets tf->type to TF_TYPE_DISTRIBUTED_POINTS */
+	} else {
+		/* For non-subsampled formats (RGB, XR30), use predefined ROM LUT (PRE_DEGAM) */
+		tf->type = TF_TYPE_PREDEFINED;
+	}
+
 	return 0;
 }
 
-- 
2.53.0

