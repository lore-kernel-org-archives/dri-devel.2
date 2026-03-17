Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB57FED9E4
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 16:04:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DEF810E6FA;
	Tue, 17 Mar 2026 16:04:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SLH4xQFJ";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010009.outbound.protection.outlook.com [52.101.61.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 159AC10E6E9;
 Tue, 17 Mar 2026 16:04:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BintfF+HaHiECQ4C43poKpkuJMz+txu7u4TT1PrkLJYXEt3c7bMTL7uNK8IJZ/hTLyXUt/6X2guNwes2HS0MYaSpg3X8zf8oEk6tNuiMgr2WpUiOHqa2a67QeSq3YsDHE0udFzfVmmJQdNVvENI2y38sr4sSoLovC6divCnMiJuSyKL0ESWFQs3U1hTgqMxj+Fhr3vyxyY42KDmyDJISley9h0RED5HUSkDDL3dI6zCqLjBs0Nva1mUNFQbQzAuQxM3a2I4T9Soz/IIPSIDecl6kBgLkTLH7tzwphihOa/2HezNH2knAtdzk0OJpTjeV6vzAQKseCG13SC7YnRr87Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7fY8lN51hiK44RXbiV+6vdGoTt9IMcBeUhQhMbtwJc=;
 b=xv5ZgzhcfIk7o75lN4C00bEDnVD2Zs+hAKtZYqUaPK7H/aOpjwUpSRznYGlGk+bHIRSHNUCTQVNsnUidezVXl8tybgFv8XKxTCVaeWa56E1QfGmsK3nqEAKQUn6uHIgu5H1JsHh+bNc8qUiYAtSaxFY7Pi9XO962sBbcUxGSSfZxxqs4TExQr/9xT+7iz+c8DeYkoGOsVGG2W4+wlSEEg/LYiZsEeIPUJhDK4QTdP/f/sy8qS9AQaDuNoELYHMMUUs7EbpQk8MCgyFNIbg4LMPm+adtMsEw4ei7DpL6tejcGmSP9Oy/qepfmxkgHn2GnZImUDJzS59wEcOXHP58QWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7fY8lN51hiK44RXbiV+6vdGoTt9IMcBeUhQhMbtwJc=;
 b=SLH4xQFJrgNHQqsMhHhHtzmiTNkuw3dpB94faTidln0d5Bu9/PsNS+wijEJWE/RZE0xlaDNeFGhcYmSs9OmbsqwHxrkvJTqLv2F+Zh6bDmdKS6Eg4n1Q+uoMLbRUPT0uLe5azuNb2yNLkwl3oGBxcgf2pKlGVWWiZQGeEg/mmpw=
Received: from BY3PR05CA0028.namprd05.prod.outlook.com (2603:10b6:a03:254::33)
 by DM4PR12MB6086.namprd12.prod.outlook.com (2603:10b6:8:b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 16:04:21 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::b8) by BY3PR05CA0028.outlook.office365.com
 (2603:10b6:a03:254::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Tue,
 17 Mar 2026 16:04:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 16:04:20 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 17 Mar
 2026 11:04:06 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Mar
 2026 11:04:06 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 11:04:05 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [RFC PATCH 09/10] drm/amd/display: Check actual state during
 commit_tail
Date: Tue, 17 Mar 2026 12:03:49 -0400
Message-ID: <20260317160350.229028-10-harry.wentland@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|DM4PR12MB6086:EE_
X-MS-Office365-Filtering-Correlation-Id: 20794581-c2de-4c57-0f40-08de843ed98a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DH58uRNtW504JScRRhmDjUmK1TujYUessY8Ou1teEMUqoKHreUUhzhvxdjrAfGayBAN16XeLlvGyE+nB3QVB3lQW+qbY1MRwqf5ev6JXqfMWZXEd4wS3+yL1EOf+kNCJEJisMeDwwKdXrAyOBK75vkAsRyfNaH7KM4pOSMAJvLiMtEB6brxtVHCMzkhrUSOG+Gqw2TOBepMTla4lKOWqFEQInhI3FBxUEwLrr9hVHaTWQ69lWwqSyxEQQ8qtQBIObgGHOUmmuPHo9q6BURyFRYX0J95W+/BSumqDdJBSXO9qPO65WoMaAm18pIy9wFk4PkZlVhVEqhGF2bgItGrU89MknA73Oqxss6b+YWvrnje0mdZc5T5NblRIX6D05HDDnY42zzUGoCqLjgrvuP67yuTGIP+tOXrHCvPBu9SBiAEVb6MjuYD/VBGtxhW9VndjdqDp01dS24bOuygZutDjiySwL/538wxAhv/P3Un5ij3mrxG9qGmyAFJRP4+Q1PZC636CDEU95DUXD8U9AFyaHoejJPD9kYgoDSG+hB2DI2YDV33dHC/5H7lGewr6R5hOFhJrqx/Dxop0FA622+SiHZHmo2lDtG1fxNHnPxL1R0xxjt+LXbvHGE+AaaE/5g98OJ5EsThknitCZbE1GD5RrxgphQyOFoJ9MtOfrBJqqtKVqtn90nJGM9eG6lhkiqKpEpFlS3FSvwwDyfDz7QsKmScfjicxgmjhVCNwPKQYAsk6mPC/0IVYwFw2Y4JAeKbhi5Fc8qmyjY8bJiZrtmfm8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jeTiTVGpboRAsY3wK2M+QlTOHWA8dyh+ymrDZoVoUROu66azJDvvd6K6HWOXi0FPr+xc/rFmCIN0buRUseeZcrr7IGtOONNyXy9uBDDpyhQeZhPo1CjgC36ewz88FQkzU6kJnqANGRoDzVvS4j3CQ95+m4ixMBkJ9hxOiCWbviPLUq5uAAODsGvI0rnVR5d99fc20GvSKmPRgOlxAkCSPeVPkKizPFrgw1SisDAAdb7owh47ggg7mfRgifkfaSIMMNDlzMVooy7dsQmjHDYIP6hjcgicruh5e5EEctb9xhPVwulnid4pPGNcJJtxRN6ffFvyzpSCOIBg099dk+3lDypHOQdwd5+L1whgSVWcUH9ss6j/P9emDKHVl47s5l7VLky0fitrGYJzWkVqCm6ohpdKpXEMhr2IvHklPoqY7V1e0A3uaNvv2cFlXe5dMXAn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 16:04:20.4717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20794581-c2de-4c57-0f40-08de843ed98a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6086
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
use that code for handling CSC properties, or whether we should
look at legacy plane encoding and range.

The problem is that we also call this during commit_tail, during
which plane_state doesn't have the state backpointer. This meant
that during commit_tail we'd look at the legacy plane COLOR_RANGE
and COLOR_ENCODING values and overwrite what we pulled from the
CSC colorop in atomic_check previously.

Instead pass the drm_atomic_state in explicitly and check that.

Co-developed by Claude Sonnet 4.5.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index dfe95c9b8746..24569633cb4b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6003,7 +6003,8 @@ static const struct drm_encoder_funcs amdgpu_dm_encoder_funcs = {
 };
 
 static int
-fill_plane_color_attributes(const struct drm_plane_state *plane_state,
+fill_plane_color_attributes(struct drm_atomic_state *state,
+			    const struct drm_plane_state *plane_state,
 			    const enum surface_pixel_format format,
 			    enum dc_color_space *color_space)
 {
@@ -6012,7 +6013,7 @@ fill_plane_color_attributes(const struct drm_plane_state *plane_state,
 	*color_space = COLOR_SPACE_SRGB;
 
 	/* Ignore properties when DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE is set */
-	if (plane_state->state && plane_state->state->plane_color_pipeline)
+	if (state && state->plane_color_pipeline)
 		return 0;
 
 	/* DRM color properties only affect non-RGB formats. */
@@ -6052,6 +6053,7 @@ fill_plane_color_attributes(const struct drm_plane_state *plane_state,
 
 static int
 fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
+			    struct drm_atomic_state *state,
 			    const struct drm_plane_state *plane_state,
 			    const u64 tiling_flags,
 			    struct dc_plane_info *plane_info,
@@ -6145,7 +6147,7 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 
 	plane_info->layer_index = plane_state->normalized_zpos;
 
-	ret = fill_plane_color_attributes(plane_state, plane_info->format,
+	ret = fill_plane_color_attributes(state, plane_state, plane_info->format,
 					  &plane_info->color_space);
 	if (ret)
 		return ret;
@@ -6186,7 +6188,7 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
 	dc_plane_state->clip_rect = scaling_info.clip_rect;
 	dc_plane_state->scaling_quality = scaling_info.scaling_quality;
 
-	ret = fill_dc_plane_info_and_addr(adev, plane_state,
+	ret = fill_dc_plane_info_and_addr(adev, plane_state->state, plane_state,
 					  afb->tiling_flags,
 					  &plane_info,
 					  &dc_plane_state->address,
@@ -9981,7 +9983,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		}
 
 		fill_dc_plane_info_and_addr(
-			dm->adev, new_plane_state,
+			dm->adev, state, new_plane_state,
 			afb->tiling_flags,
 			&bundle->plane_infos[planes_count],
 			&bundle->flip_addrs[planes_count].address,
-- 
2.53.0

