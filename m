Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E14EC531C8
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:46:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 058C210EDEF;
	Wed, 22 Jul 2026 13:46:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZA+Mrzfm";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011045.outbound.protection.outlook.com [40.107.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53B5B10EDEC;
 Wed, 22 Jul 2026 13:46:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5EOOs3SLnGrSE4CZ3nSffp94TtQapPitkgMgvAviHfrbB2/8VVgIzLEIhVcwJprqWI0tPMCZWLOW+5vspz7NWg38LLanOQEoPeLktCcx17kFZdLrhTSfjzP+gAKrR6n8OIrAftZ+eViQsFcVlKQ86AU/0L2OAbhwcp0a1prkH1yRInRUchgp0RxUKYm8QFzs1wxQN2ma/CaOEEn9QYcxi+woXQ5WJj3XTWXpAVIm3TLVMl+KO2EvLcQo/ZrEVac9pCdeBor026yfK0OuxwRNtFKLN7kCaPIRF4WvaLMmQL0cVCAdOOcBQ4bmK1eBAnxPH4OBx7Ne/gsGiRLj4CdlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYU+ZnRDOdfdGc6sQuTbR1TIimlTbNyDICDQxOU6p4I=;
 b=SvyKzUepX8mvbel+GIqP92mZ9axc1lQi/GVr5hPuRAUayYZ45abRhZ53jR60USlFNobQztBBm5fINhrFLVXzuGks+VzrFtcFHbXFTKYpubuG+/PiNSqsy/ib7d7nFhd8Cndno8kGwCRilR2x5GrX/TBKngBZCDsWCRiuAExUkHtAO1ZlydeSsI6sxdJufebKROwxz25+9nFZAPiPqA6jSonPGvWNWcTj/zAzcU4DPbR3Dl/RHxgRBvZBbo7NtNcJKkuv5ZxOcbVS3epkEAgGSVqGO6fGqrMPxoeRMSUoaT9U6MZF21j6S3vOp+1uNISX9uOm7NE2IH4eQfufMghb+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYU+ZnRDOdfdGc6sQuTbR1TIimlTbNyDICDQxOU6p4I=;
 b=ZA+MrzfmkKcuHcCn+OtzLAb6PYE5LfmjZMYvzVqfWdtEx6PScds8TfSOS1rpdLdSC80a5nxx5Wo3q8GYfVYjio6cVSKfkek1ipIoMD1vIWpxLpzqKdeWjRHGD89fTjnEfx7nJJ/BdAfBDe+bk6kWWsLAJKoZlFTJ3tZq/2fM6Rk=
Received: from SJ0PR03CA0381.namprd03.prod.outlook.com (2603:10b6:a03:3a1::26)
 by SN7PR12MB8171.namprd12.prod.outlook.com (2603:10b6:806:322::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 13:46:23 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::3) by SJ0PR03CA0381.outlook.office365.com
 (2603:10b6:a03:3a1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 13:46:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 13:46:23 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 08:46:21 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 22 Jul 2026 08:46:20 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH v4 09/11] drm/amd/display: Check actual state during
 commit_tail
Date: Wed, 22 Jul 2026 09:46:05 -0400
Message-ID: <20260722134607.136293-10-harry.wentland@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722134607.136293-1-harry.wentland@amd.com>
References: <20260722134607.136293-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|SN7PR12MB8171:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c6dfaa-1241-4232-f1e2-08dee7f79e6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XzeLcSf16ENn9C/a46zXJjirR0xmOQUnDAwt+pZzrLH7dN1wLKOTerpaHjfIV8RTtiKdfLmBHUp9FmU3VF9mt5kKeIVhwn2i/Pa1MI1jYGC/zjreJmfok/vSxRZsIGk7Gp3Fw25UGUl2l4T2w1GZypCoe3jb224YGVOqu1OMGzZykWTm0/k4lZIUV+M4ya50xCnxScBTvFAaqKbMz0ZsiREvPMPAx34NbNdaeqKsQchITjAa6AYxWh0k7r05lYBZaJeHFJkRSBr9lzv56jdyI1f1iVU/IzVJHn1KO4W2Md/P1wxitkVG1kX+HaLsRaON44h1twH82/7lj8SCCRlLWaVQ6d7SBkBsJvjxAR914QOjUoRwRt2z0cYoZZMp8sOu+7zgBI+JKgTbOX8cYkhCWe6oWV78Ir2rM+f7PGWjfPv0KUUCxGbEnTkNfORjx76mo8yZzjnGlRe9eUAxRkheAkdOzZMjCgKmE/mNC9s/5bGER1UXF9vUDFgbGT0NW7uccwhP3ne86o0Q05edXgt61ISXI+lLC3Slhgx7IJu1mx9RSFo12W9PF/rqu3MFr4BhBQ1WgetlwD1ZipfazL4O1l/oLvndSvdPL4Hu/LIuljB5JldYU8QWpDqiIUpo4mQxquA1zoHm0cOLohFdlvfqO30F7F5ZuVv7fti8YbbNflWM4n9Onw3mcKpyS9d4wZCqSnUYtKDFzxKbq9nyyGxtmQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jFiFBn2itBf8seOGK0qOa98xAqcK7xtF6KbsxuXehhfVWaiqGAMEhqkeKObenoI2+1AkOGU3VuKkuotDclY2/KIi2Iz+9eHhAXC2T/Ld6CaqEAo1vXOBwy5fsd58nLXPpSVDbj2z5Exlu0lbhebJKqN4ZC9RPM3iG/R+L1y0he3j4jbTXQfxCFmntfgRDAZI8bHzfVHCLJCnq9oHKuJF9DtxP6eHEfGbNmUoPouyn8+WT5AKQQ6YlKxFg4xPv2tf7mSjGJmsdwyCVQcHWS9w/dVWzt0W2aUiI427vgU1QcAYe5uoTfHc+dC5EgIo57BOELvyUrg8aCzghp25nXp+GEKP15A/fG9n3Wng89/OZbcCUImSXFLhD/TXYz/15Lk3CX+djsX5AQCnJLAzN5mDlJbYDxvWNqPkzjOv/w0XFLyRxbd6NBHcj9Y3ChI13el0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 13:46:23.2585 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c6dfaa-1241-4232-f1e2-08dee7f79e6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8171
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

Previously we checked the plane_state->state's plane_color_pipeline
client config when determining whether fill_plane_color_attributes
should run, i.e., whether we had a plane color pipeline and should
use that code for handling fixed matrix properties, or whether we
should look at legacy plane encoding and range.

The problem is that we also call this during commit_tail, during
which plane_state doesn't have the state backpointer. This meant
that during commit_tail we'd look at the legacy plane COLOR_RANGE
and COLOR_ENCODING values and overwrite what we pulled from the
fixed matrix colorop in atomic_check previously.

Instead pass the drm_atomic_state in explicitly and check that.

Assisted-by:Claude:claude-sonnet-4.5
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 67b825cbb88f..b7d815997753 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2984,7 +2984,8 @@ STATIC_IFN_KUNIT bool modereset_required(struct drm_crtc_state *crtc_state)
 EXPORT_IF_KUNIT(modereset_required);
 
 STATIC_IFN_KUNIT int
-fill_plane_color_attributes(const struct drm_plane_state *plane_state,
+fill_plane_color_attributes(struct drm_atomic_commit *state,
+			    const struct drm_plane_state *plane_state,
 			    const enum surface_pixel_format format,
 			    enum dc_color_space *color_space)
 {
@@ -2993,7 +2994,7 @@ fill_plane_color_attributes(const struct drm_plane_state *plane_state,
 	*color_space = COLOR_SPACE_SRGB;
 
 	/* Ignore properties when DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE is set */
-	if (plane_state->state && plane_state->state->plane_color_pipeline)
+	if (state && state->plane_color_pipeline)
 		return 0;
 
 	/* DRM color properties only affect non-RGB formats. */
@@ -3034,6 +3035,7 @@ EXPORT_IF_KUNIT(fill_plane_color_attributes);
 
 static int
 fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
+			    struct drm_atomic_commit *state,
 			    const struct drm_plane_state *plane_state,
 			    const u64 tiling_flags,
 			    struct dc_plane_info *plane_info,
@@ -3127,7 +3129,7 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 
 	plane_info->layer_index = plane_state->normalized_zpos;
 
-	ret = fill_plane_color_attributes(plane_state, plane_info->format,
+	ret = fill_plane_color_attributes(state, plane_state, plane_info->format,
 					  &plane_info->color_space);
 	if (ret)
 		return ret;
@@ -3168,7 +3170,7 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
 	dc_plane_state->clip_rect = scaling_info.clip_rect;
 	dc_plane_state->scaling_quality = scaling_info.scaling_quality;
 
-	ret = fill_dc_plane_info_and_addr(adev, plane_state,
+	ret = fill_dc_plane_info_and_addr(adev, plane_state->state, plane_state,
 					  afb->tiling_flags,
 					  &plane_info,
 					  &dc_plane_state->address,
@@ -4226,7 +4228,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 		}
 
 		fill_dc_plane_info_and_addr(
-			dm->adev, new_plane_state,
+			dm->adev, state, new_plane_state,
 			afb->tiling_flags,
 			&bundle->plane_infos[planes_count],
 			&bundle->flip_addrs[planes_count].address,
-- 
2.55.0

