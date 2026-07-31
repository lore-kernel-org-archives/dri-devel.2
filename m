Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F2CC55174
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 18:16:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4251A10F39C;
	Fri, 31 Jul 2026 18:16:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q7MC66EE";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011028.outbound.protection.outlook.com
 [40.93.194.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7287D10F399;
 Fri, 31 Jul 2026 18:15:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/1uPnfUpOS2yJYy6hImdLefreRhwOlNijRldq0Hu0jtaUxYRBbjkvoog3GaTGkShUsA1obtFbYtOCA8ob4fCE4FDBmr0/yzO/3LGY+8xvBIQxtd/LfMjArZVd4rehRBybDA0ZraMcfPnvAwvfibBfCmYyLJkBzfDnoufwu4vDGRTbHTjuGS0ohCIwEm2NkdOy/WSDY1VT+2jwLT9D4EUvrJHUghchvBpf/+JO7X90EcrYQptAg6XXPerIfZ+pchtv9nWhPypGdlVLUe7g+hOKzX7p7Sp1YQYn0FUAjIh0TP9uEsPG15YTOP3HgoD7fWI47qcnlxndjb0+kgOkGgVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejmLiuUXvY3fKjtZUKV4jxXyr9WDl9S2gZUz2Han30U=;
 b=w7h/+tybFIrFDjbN4X807M8bLQtijHkzyS3lwxhcc5s86qAh5RWemP+O1boQZ5iBElyPj3vTmuRtTdefOweq4Nq/Eda+NObQNEpg1r+BZUH8iOI1osp5ehDI/K6wLfCMLxkvZXdX+Y43hZWQ0rAZCp/QoOG4fMdzXQm9/RTG83RHMSJUYIzLvMB/Ch+X26IPcEqXOMUo8uBVTV+wYkHKb4KE1US37gKSx0pwulJ1icc6QRcvxwlVzSU7rKSkC+Mt9Bj5NczailAw8VAhewAx+CIvNT+foi5z+XMGeBYW17oWpDe1ppaoAQjFS2loIg8oEkzGAkLgPogYz96GL6MIhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejmLiuUXvY3fKjtZUKV4jxXyr9WDl9S2gZUz2Han30U=;
 b=q7MC66EEox+BBaBSJqexg+roX7GnHo7c+PNce4x6J+nM4fE4a/fOU+b9lPkTDIrk5kyli2SCVMPQEkV1pmi2pUcK+ASHJXa399fVbRN8iGca6pQfBkbzSLTr7ZRuDITiZV6p170ZqXqBmeGA3Vh1qG/7Pr9SjQtvBT862951hp8=
Received: from BLAPR03CA0052.namprd03.prod.outlook.com (2603:10b6:208:32d::27)
 by BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 18:15:34 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:32d:cafe::92) by BLAPR03CA0052.outlook.office365.com
 (2603:10b6:208:32d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.15 via Frontend Transport; Fri,
 31 Jul 2026 18:15:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 18:15:32 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 13:15:32 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 13:15:32 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 13:15:31 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>,
 Robert Mader <robert.mader@collabora.com>
Subject: [PATCH v5 08/10] drm/amd/display: Check actual state during
 commit_tail
Date: Fri, 31 Jul 2026 14:15:19 -0400
Message-ID: <20260731181521.681990-9-harry.wentland@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731181521.681990-1-harry.wentland@amd.com>
References: <20260731181521.681990-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|BL1PR12MB5995:EE_
X-MS-Office365-Filtering-Correlation-Id: 8078a34f-378d-4d12-8981-08deef2fb5e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2OgCZZI/7N1ot2TzBwGug4lmTd2spcT34gjT3a8etlLhZRCdAjlBiaWjnER7Ks0vpONiWuQFtkGYohQOnHP6wJ3ziJEc6EYtj3//T2dHKZmGzpWGXWxIes64Q0Ijs6jDzqOwFNkR9mXCZUijIfZcmIWTLQ6nC7HNJMUNIoOWvJfxBM9/20I/eH6aSSJO/u+DuDijb8xsywNn2zoZaIlJh1YhUdKZa/qWAoWJfwFklwC6iEQerNesvBvl0WZaY3n5S8KCCqIBpuLE75EDU25B77bCyE6Q252mmgb1+GG7wdPuTn1+8CHCoCLzWo9mb1mwZUsrv1vaNa2yyugq4B7+eATIuUil0ayxsyIySfT0Lb/tvAldHPzas2dpDMHW988lDO0UdTTxgaL4IdrLtghbLZQvv2DTor7F8tj3OKhKhdQPTOVG3Dql91FP667VJJh1zPc5FcfPv+H9BZsJx15OxQ3smgaiUHJK8JEdrWou47pHlYCxD/mSJY/b8vxJKBXGD928Ix6mSptkE4JEO3Y+preqNQmmfymWMQrFuFIX+rNqXchJArkS2w2o9pMOYEUUQOjs+/fHMAXi6EkFEh1BRXBJaaeIuhJHwXCtuIa/bZeOGPw+GHFqpbm7BJb2TlS4VBSH9AspjYU4UN7pLT6Q7kp6DGTQRDBRHNCYnkf/eboY3EN4rxWnOPEGq67oBDvYCmIXD986kO7iayKPvxB7pw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rPe81bvp6ple+F5jSrmThEfEFBYrLfqenVS/f0sMluXz85hvRA96G2HQ6yU9MD9YC6i9mphA6otB7pBwAdsgroWn3ymp6GNFAqWi55IJLcZ56JZCNayoLvA93khB0uzGAB/gtIDMLp4eZdpZHEcsiaJod2xnWoqRz4TSUuWxUnOZQbPya8ln2vA+tHi5Yb/FVkgnksWT/SlIwJALgeL70DlhIy6vx6LWZaROr4lTEswypHMFOXp4Fp7euoEL0M2xerkd9tfKkVNiJdQ2fmoKKFr/pdNOOqjQEJLI5ZIIQPHSRBZo3jbfjdhrqSkpIqTsulQTg3T8RqpaNkZ9JD0ABdebYC5YC2JJ3sG2PkdkfIat8TANs7l+1LFT5vvB8lpQSYWsgQLa3lH4HVzy+JdK9oE+E5i57LSu3R7+/WJO8o9Q2l5B+RYFo8Wuw9KiKgz3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 18:15:32.7165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8078a34f-378d-4d12-8981-08deef2fb5e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5995
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
Tested-by: Robert Mader <robert.mader@collabora.com>
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

