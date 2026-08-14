Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97112C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 21:18:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EA4010F761;
	Fri, 14 Aug 2026 21:18:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lZs650wQ";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010065.outbound.protection.outlook.com [52.101.56.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E59510F757;
 Fri, 14 Aug 2026 21:18:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVq1sRF30ndcmMXnny4wtjau1NXUbh/tRvlynNyhv9XgagkCtX61eileIse9cjapEHaFPYOq0HxTsvrR9wfLa341utzZDSu0yi/mHXfaOc3Fr/94kgYwjk8e9tDdyJvfFG6JTv3pquoj3yPtRAi5mho6hTte5Qr39Ekq25OkeWG7gw5ec26it/j8wjsQ+lm3Cw+GlxSbNK44repjKy0UVJYicOGk09eDtE9A+qdQLkeMi0PNwU9jZG2xmdj8SH8oZAhM3fP5W7K4x0AP1iLRo73kjQF0J6TkWyKrRn25HtUYJe/XCYQb/FLhFVTuIl5XkCZZm5QrzWkGmDbCM+1vmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pw7KQbGchnWLnnCYbymFNWfMx/A0RsJ5NbDQ8eKG5Q=;
 b=Y5isHwLvI+k24d5qQ9Ihf5EA6YM0IgV73DtkLr4LyCCJYoPp4SWKGilDtDvtyYOrl6WrXNvR4aXCyT6/4rlOey1SI0D0iQ8OI5h8kMagQA2t9TVQyU1PiaeexJ/gRGlN2cwTRQyZ8AoKl6biXCLpnbSW0d7r4s3gVaWi64bi4QgUnq72wWOVUxVvHTtRr2nZmfRStOZqs1n4JyXNEp8HjkHbc52cBeDKS9QLrjSOWB/wd+yGGhy/Oi4aTjDQSXqn0S3fkF59NrY+v3gAISOm/xC4K0qPzOYIfA9MSVdMGb4fGYLt6Nm7unJAcSy4mJa2uENx+aJB4rnhkJAM/wbu8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pw7KQbGchnWLnnCYbymFNWfMx/A0RsJ5NbDQ8eKG5Q=;
 b=lZs650wQlMieLISmydASm4TpYjgky4+0Wzr9ycG/ZPlqr0Yv0ZUxdgrCbZCnsCybBE7Pa1JDY4DTYxD36j1CRc1apI0SWE1UPlIvwRsN53uxs1Dn5QmLmghyspbNaONc7nrTSKWS3B67BHG3fAkJD20b6CQ0qj7FlmgXxZsHDDU=
Received: from CH0PR04CA0115.namprd04.prod.outlook.com (2603:10b6:610:75::30)
 by CH3PR12MB9316.namprd12.prod.outlook.com (2603:10b6:610:1ce::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Fri, 14 Aug
 2026 21:18:23 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::89) by CH0PR04CA0115.outlook.office365.com
 (2603:10b6:610:75::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:18:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:18:23 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:18:22 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:18:22 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>,
 Robert Mader <robert.mader@collabora.com>
Subject: [PATCH v6 08/10] drm/amd/display: Check actual state during
 commit_tail
Date: Fri, 14 Aug 2026 17:18:14 -0400
Message-ID: <20260814211816.1219597-9-harry.wentland@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814211816.1219597-1-harry.wentland@amd.com>
References: <20260814211816.1219597-1-harry.wentland@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|CH3PR12MB9316:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d4f8f56-2cca-412c-2747-08defa4992b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|18002099003|56012099006|10067099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: L222/CkN/543Ar2RjcAnLhoWmh6IhJ43BVCezBVwmYCrChgo/0DPzx/qMkqLlMJojrsTNpCcExLEOvbvPevQr+dlbyQsesPf+pAJnNXyFxfT0MVk7ZHZUG1xtBHykz0V5FkGrj8BuASbe5gAzIeb+BU4GeGtEV0w819AEnIj9z7+U/nzbjhkjlEjIbxEG+NsMoWnsTdX6lKWLdK1qRjFFz0g/JR33tzKRze1NwBFxEn383gZQ69tnRz0z35P4uiKV5F/sLHBcpdg/lmUFAvrQKY1PMdP5ISeGorFIZRqzplPWwYkJ39JT7vETGWfMFDku1b0Ec9kvOQPeZgnka1XiIzCwOeRIMAzzUfOAJ97993DwNEM/b8HLoNQVwwrnf/jWJ4Z68RnXU2VJ6CdxoS6xL5wEcnWB/arKPmZ5doisaK3Kv2Vf/AKOvGkUl4pQ1aFFYWJMQYNS488zEPse38Ltm0GoOpq7vsWHClR+sXGunBdnYzUlN4Bh9HIffdOiWfrfIQulZy5Nify9ZaE/sOVDFyFmYkAvuY+fjgjC+zYQmFQWL2uUa63BspgKPeMeETAliZTLqXZpho6LkKA3Z7t4o4wl0NhykKSOkWXsoBhhvzeOEr55yjt14U6Z40xmDnNHfmDg0Y/eEswJmIu9xuJ3oi7hUNrZAcTVX/br++15rD5RWCGLtFOwNZq8iJB5btDCGHtr6yACxw0fddjiHhzVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(18002099003)(56012099006)(10067099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yKTYl4EPwuC8kNAGb/9WDDsqleuZGo3qlAl+jXwzNOd5W/E3syZa+k4KBW09VbFNKMBnsOVytAIJwrgnZtphMBytxY7tGXFuwD8HV1A8HAV4Pdq+P30OY+81YhTtjgqj7+fKmhvkoEbY4tk7gCj5jTVgI5si+WMI16Jont7ZFsetUnducd5b06ooSmvHVUjoCUBN/L8bwwdkU/60d08nrQu4ZZsTZNjxjjmjXwwElkTjfZyJfTRmaQeYtM39upYv9e37ZPCcKZa8oNqXmm9J1tR4rjHVrHJbbCnfHBuGRoEgJ6eeB9wYeRA1FdLilg/yHyrMhKX7cAWO3C2YOIfNlUSMxSh80rOM4QfPygKw9XWQwOsCHBEIqvYFnPs8OPMPcULfbMbz83TjL4tpTmtI+QX9uvwhlhiqICsWAq5e3XiEvTwxstGVDCDo9iIk/nXr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:18:23.3207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4f8f56-2cca-412c-2747-08defa4992b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9316
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
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 12 +++++++-----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h    |  7 ++++---
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_test.c | 16 ++++++++--------
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 38cffe127989..48d2d5dc9eb5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2983,7 +2983,8 @@ STATIC_IFN_KUNIT bool modereset_required(struct drm_crtc_state *crtc_state)
 EXPORT_IF_KUNIT(modereset_required);
 
 STATIC_IFN_KUNIT int
-fill_plane_color_attributes(const struct drm_plane_state *plane_state,
+fill_plane_color_attributes(struct drm_atomic_commit *state,
+			    const struct drm_plane_state *plane_state,
 			    const enum surface_pixel_format format,
 			    enum dc_color_space *color_space)
 {
@@ -2992,7 +2993,7 @@ fill_plane_color_attributes(const struct drm_plane_state *plane_state,
 	*color_space = COLOR_SPACE_SRGB;
 
 	/* Ignore properties when DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE is set */
-	if (plane_state->state && plane_state->state->plane_color_pipeline)
+	if (state && state->plane_color_pipeline)
 		return 0;
 
 	/* DRM color properties only affect non-RGB formats. */
@@ -3033,6 +3034,7 @@ EXPORT_IF_KUNIT(fill_plane_color_attributes);
 
 static int
 fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
+			    struct drm_atomic_commit *state,
 			    const struct drm_plane_state *plane_state,
 			    const u64 tiling_flags,
 			    struct dc_plane_info *plane_info,
@@ -3126,7 +3128,7 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 
 	plane_info->layer_index = plane_state->normalized_zpos;
 
-	ret = fill_plane_color_attributes(plane_state, plane_info->format,
+	ret = fill_plane_color_attributes(state, plane_state, plane_info->format,
 					  &plane_info->color_space);
 	if (ret)
 		return ret;
@@ -3167,7 +3169,7 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
 	dc_plane_state->clip_rect = scaling_info.clip_rect;
 	dc_plane_state->scaling_quality = scaling_info.scaling_quality;
 
-	ret = fill_dc_plane_info_and_addr(adev, plane_state,
+	ret = fill_dc_plane_info_and_addr(adev, plane_state->state, plane_state,
 					  afb->tiling_flags,
 					  &plane_info,
 					  &dc_plane_state->address,
@@ -4225,7 +4227,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 		}
 
 		fill_dc_plane_info_and_addr(
-			dm->adev, new_plane_state,
+			dm->adev, state, new_plane_state,
 			afb->tiling_flags,
 			&bundle->plane_infos[planes_count],
 			&bundle->flip_addrs[planes_count].address,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 91affbdb2d6c..67c5b4bdf715 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1130,9 +1130,10 @@ void amdgpu_dm_apply_delay_after_dpcd_poweroff(struct amdgpu_device *adev,
 
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 int dm_plane_layer_index_cmp(const void *a, const void *b);
-int fill_plane_color_attributes(const struct drm_plane_state *plane_state,
-				const enum surface_pixel_format format,
-				enum dc_color_space *color_space);
+int fill_plane_color_attributes(struct drm_atomic_commit *state,
+			    const struct drm_plane_state *plane_state,
+			    const enum surface_pixel_format format,
+			    enum dc_color_space *color_space);
 bool modereset_required(struct drm_crtc_state *crtc_state);
 void dm_get_oriented_plane_size(struct drm_plane_state *plane_state,
 				int *src_w, int *src_h);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 0b29bf0a7d04..670a88da4424 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -100,7 +100,7 @@ static void dm_test_fill_color_attr_rgb_format(struct kunit *test)
 	plane_state.color_encoding = DRM_COLOR_YCBCR_BT709;
 	plane_state.color_range = DRM_COLOR_YCBCR_FULL_RANGE;
 
-	ret = fill_plane_color_attributes(&plane_state,
+	ret = fill_plane_color_attributes(NULL, &plane_state,
 					  SURFACE_PIXEL_FORMAT_GRPH_ARGB8888,
 					  &color_space);
 	KUNIT_EXPECT_EQ(test, ret, 0);
@@ -120,7 +120,7 @@ static void dm_test_fill_color_attr_bt601_full(struct kunit *test)
 	plane_state.color_encoding = DRM_COLOR_YCBCR_BT601;
 	plane_state.color_range = DRM_COLOR_YCBCR_FULL_RANGE;
 
-	ret = fill_plane_color_attributes(&plane_state,
+	ret = fill_plane_color_attributes(NULL, &plane_state,
 					  SURFACE_PIXEL_FORMAT_VIDEO_420_YCbCr,
 					  &color_space);
 	KUNIT_EXPECT_EQ(test, ret, 0);
@@ -140,7 +140,7 @@ static void dm_test_fill_color_attr_bt601_limited(struct kunit *test)
 	plane_state.color_encoding = DRM_COLOR_YCBCR_BT601;
 	plane_state.color_range = DRM_COLOR_YCBCR_LIMITED_RANGE;
 
-	ret = fill_plane_color_attributes(&plane_state,
+	ret = fill_plane_color_attributes(NULL, &plane_state,
 					  SURFACE_PIXEL_FORMAT_VIDEO_420_YCbCr,
 					  &color_space);
 	KUNIT_EXPECT_EQ(test, ret, 0);
@@ -161,7 +161,7 @@ static void dm_test_fill_color_attr_bt709_full(struct kunit *test)
 	plane_state.color_encoding = DRM_COLOR_YCBCR_BT709;
 	plane_state.color_range = DRM_COLOR_YCBCR_FULL_RANGE;
 
-	ret = fill_plane_color_attributes(&plane_state,
+	ret = fill_plane_color_attributes(NULL, &plane_state,
 					  SURFACE_PIXEL_FORMAT_VIDEO_420_YCbCr,
 					  &color_space);
 	KUNIT_EXPECT_EQ(test, ret, 0);
@@ -181,7 +181,7 @@ static void dm_test_fill_color_attr_bt709_limited(struct kunit *test)
 	plane_state.color_encoding = DRM_COLOR_YCBCR_BT709;
 	plane_state.color_range = DRM_COLOR_YCBCR_LIMITED_RANGE;
 
-	ret = fill_plane_color_attributes(&plane_state,
+	ret = fill_plane_color_attributes(NULL, &plane_state,
 					  SURFACE_PIXEL_FORMAT_VIDEO_420_YCbCr,
 					  &color_space);
 	KUNIT_EXPECT_EQ(test, ret, 0);
@@ -202,7 +202,7 @@ static void dm_test_fill_color_attr_bt2020_full(struct kunit *test)
 	plane_state.color_encoding = DRM_COLOR_YCBCR_BT2020;
 	plane_state.color_range = DRM_COLOR_YCBCR_FULL_RANGE;
 
-	ret = fill_plane_color_attributes(&plane_state,
+	ret = fill_plane_color_attributes(NULL, &plane_state,
 					  SURFACE_PIXEL_FORMAT_VIDEO_420_YCbCr,
 					  &color_space);
 	KUNIT_EXPECT_EQ(test, ret, 0);
@@ -223,7 +223,7 @@ static void dm_test_fill_color_attr_bt2020_limited(struct kunit *test)
 	plane_state.color_encoding = DRM_COLOR_YCBCR_BT2020;
 	plane_state.color_range = DRM_COLOR_YCBCR_LIMITED_RANGE;
 
-	ret = fill_plane_color_attributes(&plane_state,
+	ret = fill_plane_color_attributes(NULL, &plane_state,
 					  SURFACE_PIXEL_FORMAT_VIDEO_420_YCbCr,
 					  &color_space);
 	KUNIT_EXPECT_EQ(test, ret, 0);
@@ -244,7 +244,7 @@ static void dm_test_fill_color_attr_invalid_encoding(struct kunit *test)
 	plane_state.color_encoding = 99;
 	plane_state.color_range = DRM_COLOR_YCBCR_FULL_RANGE;
 
-	ret = fill_plane_color_attributes(&plane_state,
+	ret = fill_plane_color_attributes(NULL, &plane_state,
 					  SURFACE_PIXEL_FORMAT_VIDEO_420_YCbCr,
 					  &color_space);
 	KUNIT_EXPECT_EQ(test, ret, -EINVAL);
-- 
2.55.0

