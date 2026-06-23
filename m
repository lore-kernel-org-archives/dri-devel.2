Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBA8CDB47F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 16:48:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E510810EC0F;
	Tue, 23 Jun 2026 16:48:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PVw9WKAv";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012060.outbound.protection.outlook.com [52.101.53.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AAAD10EC12;
 Tue, 23 Jun 2026 16:48:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpUzBqoskybHHS+71E0D7OqjfaXKhMC1JFBdLOtW47KK2CNn7w8UUIh8SvEO0jzHHDCdhZeAax7F/plDjGPGgFK/aRVXIxWUhYHuOorVyM5XihJgUcjKC9a7r7wTWxCiYlJM1FXFkIS67kbo7s/X8h1O0Hs73Gb+HsSITMvQ59Vc3KoM3RroxR5AVRLnHuGlcvgg+h1JrVGpcioVw2b8jlP4SWw4GWrgVDQTZJccFKno3uAulMl3TNZrNIid8puml5L2k9In2oLhpY4ny4iaNfLDLP6ek7Fq/Q3FoB7kDPiDwMBM9769KrbCdigvqY3KB6he26TG9i/8MsEiGyB7JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NirJjDSgUVBrZldDcrtfotaQN/ZPGhysw/KsZcx2DtM=;
 b=B1oi08O/eBkwsuwKH+YHWwW7EWUyNoZWkq3dR7YIQ/3ZX/zTGo7i9S3ve+P8qTsbVhTTZ16qPtpYmAjby+b85JVkYtLGgetcTgCqyobLnBhvAyTW6VR8kkAYbc5plNfWjxspSXZzevxa9fGo7iCHzYzpjsBiR7dmOPya7gEM0sOPk3wg0YV9y/ZHc+0xNlNs/lpU8iy04aPwUEMWVv75IWSIDGqYxUVc8QdTJk5YK2O9iN6YQb9jWBRFDq50g9qpZlUQs44r7IQdpDAEItbtWilAW3dfUGwC9d9cTY6Epm5da1dQh/Q6mt8amUCSIUvnERn5yB6qnmk5asyWxmxvUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NirJjDSgUVBrZldDcrtfotaQN/ZPGhysw/KsZcx2DtM=;
 b=PVw9WKAvbjxPckel7JBCAj1AbqjPAO0jTmAuRPMA8tUnqdf6QZKXJnHBrI3WKQW2EJa0v1SnEtxdEUVm/dc4kcvu8Q9PWnf7QnIBG9FwieS4PL77NGohM93D+9+4e67Mz4tEtyzdbXh2ffWoJg343ioUOl1Bj36UtD0hthsMmSo=
Received: from DS1P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:454::19) by
 IA0PR12MB8715.namprd12.prod.outlook.com (2603:10b6:208:487::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Tue, 23 Jun
 2026 16:48:25 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:8:454:cafe::a4) by DS1P222CA0010.outlook.office365.com
 (2603:10b6:8:454::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Tue,
 23 Jun 2026 16:48:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 16:48:25 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 11:48:21 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 11:48:21 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 23 Jun 2026 11:48:21 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH v3 08/11] drm/amd/display: Check actual state during
 commit_tail
Date: Tue, 23 Jun 2026 12:48:09 -0400
Message-ID: <20260623164812.81110-9-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623164812.81110-1-harry.wentland@amd.com>
References: <20260623164812.81110-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|IA0PR12MB8715:EE_
X-MS-Office365-Filtering-Correlation-Id: dc0fab2c-bc42-4571-460b-08ded1473ead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: M0c2QlcFppz10o8LAD21Sbg2rbH5t4d6f8VrFJiZznhCeWcvlRUU5UdXPnNGOGYULxqhjne+B+cGOkzBBGmcdQkF18Y+GU6XZ5GEPy/SgxibwI97/Tyqtx/dil+ijR9yPR9RQ2R+5kCleP5B5ot0RxZ6mB4/p4yUyUuZzoTCp+Yig2+5GUlM2WYOM02N2sBMet8ADK/k9pZ8XlCGOgJ6uTuXl0dNmi28VhEXNHfJMlIoFd0k/1/CD41rDMzDLbpMHwsRfG2hQv9FgpBbNgRhvDs7mWQeOHJ7hmenCYeps4nnEaKgIwH00oLSE5X9LZ9iahlnU5VgljnuA72PBj1V7c3ejiq+PcctOfa6nb3+nl2KLqPjvAB+a/htRBZ8ByqsgE7jdJ9edenD+JyHHOLcK7DbP/UZc61KSkPNw4j3I9C05mkc6FQCyb8M4ezh/YND0g519Q9nj7KeYFP0IiunkBDcM9veN/l8cB+neM2Jac7HlhwEFfwItrZmHXJDfn7xmQ36R+h/rxeCUzOl5altIpFxdnnGVaVop88G70kOM369CW8LKN/TPI2MpcSAAa8Vxy9D1eKURQ+dcmHgbJVwWRlSqiPGCgzeQx5eqwwMVaLDm2ZalIc6A2gGZgQW+RvpP94yrUu3BfJknFziQvgq9yWBfFEHeWIqyihznyfdkylb+xDfkWSgCZJy/+m34YNoWb/Ndnsp9iyScp8zYs7+VA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: idMRPinouVzgZqoi/8hlFAOd9iCMf9xmj67cE+9XDdAydtW+p1NT5UDaGpawFwuEAdaYmM3Y0d6CbsXZl7PcS3OMnEOopxsZm8Ydwc1cYTwLG1GrN34rnB2n932DFgfPf78stEbPcjKdhbTTkmRBWTJmKtwYjvB4MnYsjuGENTWfQVgBgb7BmQ15YEJCEZP2CwOoTKsTqKod79Dj7EZaDM2G/Jsb9vx57u1WxxvOccL2qr/CDZK06PZ/FqNtRmiPP692QryRCO6bMvppoekjOj+QN5KZsAPg7/vODWztN8I9t11vOa9Qfkip/hDXE4l6ZKfkqgGZvML4s0nGCYQMaMe1Rb574/M1bkR+KqgggK2yJ0KCbasY+yT7Pr7xA3w1YmC9N/mYAUJ+7tEISsdZNhA//3/oQxzY9gxade1ihqTdWRx0YLAk6qhAQ3s9W/Qb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 16:48:25.7191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc0fab2c-bc42-4571-460b-08ded1473ead
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8715
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
index ece581609cf7..6d0e3d699eb1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6270,7 +6270,8 @@ static const struct drm_encoder_funcs amdgpu_dm_encoder_funcs = {
 };
 
 static int
-fill_plane_color_attributes(const struct drm_plane_state *plane_state,
+fill_plane_color_attributes(struct drm_atomic_commit *state,
+			    const struct drm_plane_state *plane_state,
 			    const enum surface_pixel_format format,
 			    enum dc_color_space *color_space)
 {
@@ -6279,7 +6280,7 @@ fill_plane_color_attributes(const struct drm_plane_state *plane_state,
 	*color_space = COLOR_SPACE_SRGB;
 
 	/* Ignore properties when DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE is set */
-	if (plane_state->state && plane_state->state->plane_color_pipeline)
+	if (state && state->plane_color_pipeline)
 		return 0;
 
 	/* DRM color properties only affect non-RGB formats. */
@@ -6319,6 +6320,7 @@ fill_plane_color_attributes(const struct drm_plane_state *plane_state,
 
 static int
 fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
+			    struct drm_atomic_commit *state,
 			    const struct drm_plane_state *plane_state,
 			    const u64 tiling_flags,
 			    struct dc_plane_info *plane_info,
@@ -6412,7 +6414,7 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 
 	plane_info->layer_index = plane_state->normalized_zpos;
 
-	ret = fill_plane_color_attributes(plane_state, plane_info->format,
+	ret = fill_plane_color_attributes(state, plane_state, plane_info->format,
 					  &plane_info->color_space);
 	if (ret)
 		return ret;
@@ -6453,7 +6455,7 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
 	dc_plane_state->clip_rect = scaling_info.clip_rect;
 	dc_plane_state->scaling_quality = scaling_info.scaling_quality;
 
-	ret = fill_dc_plane_info_and_addr(adev, plane_state,
+	ret = fill_dc_plane_info_and_addr(adev, plane_state->state, plane_state,
 					  afb->tiling_flags,
 					  &plane_info,
 					  &dc_plane_state->address,
@@ -10306,7 +10308,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 		}
 
 		fill_dc_plane_info_and_addr(
-			dm->adev, new_plane_state,
+			dm->adev, state, new_plane_state,
 			afb->tiling_flags,
 			&bundle->plane_infos[planes_count],
 			&bundle->flip_addrs[planes_count].address,
-- 
2.54.0

