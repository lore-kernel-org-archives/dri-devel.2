Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB741061B0F
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 15:35:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A0B310E68F;
	Mon, 30 Mar 2026 15:35:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HCOJrcsh";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012048.outbound.protection.outlook.com
 [40.107.200.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13C4B10E5C8;
 Mon, 30 Mar 2026 15:35:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CkKAvXyeaIIYvXP9aYNfbnDSf9m7pVN1H7Px/L7KTG5Dp/BD9wfprzGZ1coDHtDvwQy5zN4bv02Gmdv7WdvkOvY2pfkzvapEdGVQ6AkZZuOQktb/6n4HghU2OOk7V8GebHodjsHq8yN35h7Sr1E/vT/1LVBO+Ww37KOJ8zMbpXnw8vXrUSBAuC/xlAEdclSKXlCLMZ347WGeIkQawroLL5Nhv0tL8qovFHxEvWVRkAaGWrcbumCFMPchYbvdsO5H7C2FHumOJD3AZ45rApjDq5xofFOqXKMlocr1fgsbf0glt1bWSo3cmWgpm67SUJTZK2GydqihDRjILma+bTprpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlcLk6dTX1SwJm2dDakqDi1E1p/pmEVqGxx6iwGXg2g=;
 b=ceYdHbgEFtm66RqDRieEug+7vOnzVMEff6f9DgqgqhB4/cOyKRBYWrG7qPcGJO2uqvT0IHCjx7AN1qanznrCND3nzBom8plh370FIGa71zKqURgbGIHHVSzEhD9XmC+UZvhVMQR/qf4/RDLZkcJVoAXn7hfSUvMgFIvHR3Khwe7/9MZvnsH1SEVguIyqG2tWukxLCxQUf33Hf5Er82XDURAD6bDilzysQv9AucwEy9e41z2UyCFeF7avuRohei63W6QbaqajGS7jEaakhNAlL7rKBla1B0fkVHUOQyLzr/EgnooCyvRDkcR5z8h+5hs6Jljg0Gt7WOmT74Ya3fps2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlcLk6dTX1SwJm2dDakqDi1E1p/pmEVqGxx6iwGXg2g=;
 b=HCOJrcshAmEJUk5ITxcgAcpOypfbG+wZLsdR/pu5b8nyYLKsfWJ1Ta7LkJj8m8jwH4xu8LxQpXQaVUpl94f2x1/kNAi3UaDERpnYVvSVauBjB1TPt0WOuoTkkFzAuhKzbSanzD27pvRZ/bzKB63R3nkF4azZO8TxB7CYCftG+zA=
Received: from SJ0PR05CA0064.namprd05.prod.outlook.com (2603:10b6:a03:332::9)
 by PH7PR12MB6489.namprd12.prod.outlook.com (2603:10b6:510:1f7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 15:35:01 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::6a) by SJ0PR05CA0064.outlook.office365.com
 (2603:10b6:a03:332::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.27 via Frontend Transport; Mon,
 30 Mar 2026 15:35:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 15:35:01 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 30 Mar
 2026 10:35:00 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Mar
 2026 10:35:00 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 30 Mar 2026 10:35:00 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [RFC PATCH v2 8/9] drm/amd/display: Check actual state during
 commit_tail
Date: Mon, 30 Mar 2026 11:34:50 -0400
Message-ID: <20260330153451.99472-9-harry.wentland@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|PH7PR12MB6489:EE_
X-MS-Office365-Filtering-Correlation-Id: 0023a0bf-b88d-4e1a-b333-08de8e71e85d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: eoAOAg7CNIkByJIbDwzOvgyvnTtVTuVpdMJv29dBlt/jHXfiJmjwa++LwjoRzJxhA9N2CaFIu9FJZkZBCU8u3L1j/hJCD3luVdYFQZx1JC/QGG0Sjxt4eBp5WNHAGrT7WFWQR+w8O85MkyTjVIhVYi8/2X3PGiVP9PT4AgzZRMOQqkZfgYHkkZlMTJsMBWFZhS9u/EJF3REQHKDXAMqbGX5YdH1tlywxTkUKjkLCEzuabeASAnqoVKYRDeg/npdFbyYb6UyeoCvW0AgEF0FRHXS4ejvh91+xY2v6157yJWIx6yWZm8mPgIWmxtgIwvJkJPZsNlPZLxXApFELKdspCA3dQcdK9AddNUpd9AAZh7Nkw7nSBIsE+n+IZgofhqqYuhzU2/Dpsl9e3kaXy2RUeCyikjps9mJArAj0ZXnbTbYR1DxiEeB7tNRoRJ3MDIqTV7WFoY8Z5HpQGoaTcNohBTYT8ea4CE5pjVUt8PV/LNU/dBGsefNocAeBbuVUTsW4BgFyhUEjDtstRVz0oZdZ+Kji9dnWpwISPnAvsXqT8MDRPwUkgPP8Ce6bWIKkRXqjRiN2L3AF2ULt7ik99vVtffxqEv3+3aKR2k2xM9K4fmV8gPkiWP6vNJhefEgAsTzQgB+zxgk3nvuh0cnmtoydkrZw1TNftVZdcSY4uwkvEWOBHxt1+gc9gUnqQD71LMT2rCEkX+IZJjAOkYv9zAYyHC4WbdS6CcG9EnvMxy/08ZFHPP0S+iaZbgEoG4+MqaW6uv4em2d9BScIWFQZ8Z8U6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YS4msd4fojLAynbgOS6whBxzIuXsrol1eTTR2j8iKqa3APqTjAxYv66NGnlAQ6CP0fnKL3uBQjXn0Kc3TWKQlABbDIRXEA+RNp6cyI1Kdn1RAkz6Lxdb3j5+ukwoNggkMinLjjZ27/XbFhsRk4Hi6BjZMrLBDVjff7AKqe9b9LHp86CG3K4mSJsUhDeAQRIv5DmIGrY4hFHV6KF581LaqXWG3yU7bKPiUJaELHuTe2DR8VZZ21U0GsSdwO+x7x7Gw2EnzfXXDJH0AOGi3q07A3E95JRgeyKxo7ag7EjYuwVr1nRlqYUBZqdcS5xeRUU9QLHiWBt8Bt+trTm6D2Ekzkk7mH9UtRrgP8FgGl414+Ty+NcgZJyCnzPjWr0w4u5jh03AcIOYQ2mbH3/nk0SoMf48Mj8fsYGeRrtZ8kaddnO6DNiiUM/F+7g00phTXZMy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 15:35:01.2743 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0023a0bf-b88d-4e1a-b333-08de8e71e85d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6489
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
index a0d4ab4590e1..c3c6211d15cd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6006,7 +6006,8 @@ static const struct drm_encoder_funcs amdgpu_dm_encoder_funcs = {
 };
 
 static int
-fill_plane_color_attributes(const struct drm_plane_state *plane_state,
+fill_plane_color_attributes(struct drm_atomic_state *state,
+			    const struct drm_plane_state *plane_state,
 			    const enum surface_pixel_format format,
 			    enum dc_color_space *color_space)
 {
@@ -6015,7 +6016,7 @@ fill_plane_color_attributes(const struct drm_plane_state *plane_state,
 	*color_space = COLOR_SPACE_SRGB;
 
 	/* Ignore properties when DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE is set */
-	if (plane_state->state && plane_state->state->plane_color_pipeline)
+	if (state && state->plane_color_pipeline)
 		return 0;
 
 	/* DRM color properties only affect non-RGB formats. */
@@ -6055,6 +6056,7 @@ fill_plane_color_attributes(const struct drm_plane_state *plane_state,
 
 static int
 fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
+			    struct drm_atomic_state *state,
 			    const struct drm_plane_state *plane_state,
 			    const u64 tiling_flags,
 			    struct dc_plane_info *plane_info,
@@ -6148,7 +6150,7 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 
 	plane_info->layer_index = plane_state->normalized_zpos;
 
-	ret = fill_plane_color_attributes(plane_state, plane_info->format,
+	ret = fill_plane_color_attributes(state, plane_state, plane_info->format,
 					  &plane_info->color_space);
 	if (ret)
 		return ret;
@@ -6189,7 +6191,7 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
 	dc_plane_state->clip_rect = scaling_info.clip_rect;
 	dc_plane_state->scaling_quality = scaling_info.scaling_quality;
 
-	ret = fill_dc_plane_info_and_addr(adev, plane_state,
+	ret = fill_dc_plane_info_and_addr(adev, plane_state->state, plane_state,
 					  afb->tiling_flags,
 					  &plane_info,
 					  &dc_plane_state->address,
@@ -9984,7 +9986,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		}
 
 		fill_dc_plane_info_and_addr(
-			dm->adev, new_plane_state,
+			dm->adev, state, new_plane_state,
 			afb->tiling_flags,
 			&bundle->plane_infos[planes_count],
 			&bundle->flip_addrs[planes_count].address,
-- 
2.53.0

