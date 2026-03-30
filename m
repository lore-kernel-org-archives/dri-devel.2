Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D691061B0F
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 15:35:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD80B10E694;
	Mon, 30 Mar 2026 15:35:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c5OFqKGA";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012061.outbound.protection.outlook.com [40.107.209.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3443410E648;
 Mon, 30 Mar 2026 15:35:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+tivQnnwEPvZ4GAG4bdDAmbmAcl25obKmzpgLYPz+RQfgrzJra6g53+ldgeHhrtJhG4hw1eA1leu6S8kONQjmXKte0e2AaMs2lmwWWVyzcuD9MERdFOitOkmScXSUPlmHLczbKV8HjfRVyKlLeGCGbkF4Bh/2+kwmqA3gHEGSNdQrDwkCmiQ+Ltn/MChN47y94OfeaCPwhe0Zd7znq9oRoZSDjKvQBSj4+J5tT1sxRzzza+C011p2RTgnwpgx2HlM5vgrcitswuKeLSe2MYEWUl9z/iwTHPBHAfs5FPsdGCcA5JBO8ojmhTUUBQJm/9Zut0PKVTdjwEyfg90+9oxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1T6VRN0daO9Hnr7WZAG4doa09QxCQfMOkZ1fZjXBU8=;
 b=kmWZWXWYpQrA1PVkqSNcfYCjYE3rEmM3ZWLGczXytRNSpkac9Lpv5HSLHoi/YD0V8KcRK0WqtY8JuP5qOa7yOnqGrbXp7Dj9I8JandnHaqvrMRTcusP5j8SkFaY74f6fLm3tb7GKQ7MM+BZTGijOjygJc5luf+0TlTD3SdaoJ1JdIYvLBxNpGeTB6JdrnEkombadgHSFaqLijJGkYah7vsRdDzC9C1vlO7Z41G2ZkXKJ4Fj6IoWs3HS6jpRfa1jLg/J7gVZNWSx55G8FPpe1zY7VFB012wgRWtC5xb/zvKMsFGVz72gQO8l4W4aAfAk6qhmJMphPI95KrDVWwJbwgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1T6VRN0daO9Hnr7WZAG4doa09QxCQfMOkZ1fZjXBU8=;
 b=c5OFqKGAc+idE+DFH9tBH+bI7VeoMvHBTPnPpUYkGb/LWsKXNJ2NVRRNmjTDoadAFHHhjM0RZZVw5wh5XS9ZspQpknMKyw1SCSkMuLsSXXsZh6wXH6VdYAygmsVgjtUo3NXxfkLCKZR/Yk0v8LYAs7u2UTjZb+HK3Fg2XFoiFmw=
Received: from BY3PR05CA0028.namprd05.prod.outlook.com (2603:10b6:a03:254::33)
 by CY5PR12MB6370.namprd12.prod.outlook.com (2603:10b6:930:20::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.12; Mon, 30 Mar
 2026 15:35:06 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::b5) by BY3PR05CA0028.outlook.office365.com
 (2603:10b6:a03:254::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 15:35:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 15:35:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 30 Mar
 2026 10:35:00 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Mar
 2026 10:35:00 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 30 Mar 2026 10:34:59 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [RFC PATCH v2 7/9] drm/amd/display: Use GAMCOR for first TF if CSC is
 used
Date: Mon, 30 Mar 2026 11:34:49 -0400
Message-ID: <20260330153451.99472-8-harry.wentland@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330153451.99472-1-harry.wentland@amd.com>
References: <20260330153451.99472-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: harry.wentland@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|CY5PR12MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a3009bc-162f-44e2-6a8f-08de8e71eaff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 9UfVOHg/fR4fnuKpnVQUms1OZ0+wKORpHmtqbaoUKsgCCP2MTJ+zudjlKBKMAH2ZiNbM5jbzAyU4OC3QgvAMqezDY9i/FPji8CJi/MTrppTPWDLcoDi/qMEHOFUUOIrrOL4kPiY7C16gk+e0AcFumHQZLfn8BXFQn7tlWa7tajQ7FwTHSLB1sy7oH4WDZ7Cs0pmM4sTNGrwPZB30sr9eLnmvL9tkTzcDLPMQKarVvzOXlUauEUJK3sg8UHID9ByHYGr3cWPhF3oOmyu5bXaAo0F5D+aVuyAIYk0so/jGqZ6Sp13Z6vmNOib7yn7EEvYoen8xclCPTZYZZJdVgFw4iSYWu5wnXWaZ1Met42kwPtSMFrLXPml3XoY2+rwVwYrQ0VYKxTlq6Er6SaGklNdawNXNrCIBU0Xr1fOo8CqarlPaYZVo4OrqXPI5GQUnU1/R5kWkIVh6RdMOWFGsRAarvyUCSb1WONeQzsCOYAMF+9LnJ6jFLHJE0UC9XS7R9SBKiTCR07N63ISytNcsiu61IWI9KkT8d1zHizUOLdh74bL72FcK/QNJFMKXZmnWcUbRGLqcUEDyNds/e4nXavRQUtap6DfEe5Tpc4TXnJUOD2D0q3uIgmllmNVf7gGuOyBZvTguM4Tx1ehvr06Ev3RATOamtdI1OVSBAyRucFM9yh08gvuwbHxAz8hA6aCl7f1aa+6dseD7DPnaVGmQLbqVaz1YpZTL1LjUQxGP0S1vFDsPTVZmEY9WHn6HrJPIMZB9ng4YJmwbmi7tcUWH2JWbJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jPYmnyLxU77FR3eBTWXihzmmN39TDZYLlT3LgNgo1ySKl7pdbw882spyIoYk7O2zJiYzaoRsuKEhSDotk7Q0b4jUOwFJ9MVBG9VpfsGtgIIwlmPo8iMvyWpHf6Jq1S/kkePVjLUSALltTS43xnUJMswVcT0KqkMTGV5KScc1itUITwzX+0Do/9JXsVF8vu5ljHNHSIhqhQV3l9LBJ7Jn3THxxUuwsQs63AnvC38WtR4fLNNHzbDcAAODawswwj2sGplO1ApvJMCYWiGYHjHSgyJFzezDSSmZmMrQEppJEUTig/oZNAWFVdBe7Pyg/Fw/t+kleKHwPoRrTiHGYbUN1syf31pX89jbVgFCKK+9OOCwsSdZi+v8Hl71ntPNWuFOikmMKpTHErAzpul16MqW7EJi9CFh58Hr6dVX4CjZxmRdlzqq1dHaifelp+X0Ow2F
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 15:35:05.7424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a3009bc-162f-44e2-6a8f-08de8e71eaff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6370
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
index d5b4190e635c..6403dfe4ee10 100644
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

