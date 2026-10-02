Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A35BCA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 13:40:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 992FE10F857;
	Fri,  2 Oct 2026 13:40:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PWGDKfag";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011056.outbound.protection.outlook.com [52.101.52.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3179F10F852;
 Fri,  2 Oct 2026 13:40:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CH9DWra+xEKRFm0XjtYPiUDlfDHX9280jiCEynZ5dTKlIad9lAEp/FXMcURVYTDyZx0ShotcMDnMU8EL7GRCAuRAmhW1j8BzSd4yHnw4DRDctxxAc5l4+YMCVvOzKtPI0vZ7MpewEbK0EOqvoqVni77ogCT+s1kyB1HeFSEvoxXoJm2ZIDkRUu48+BuGrS5175Bc25dULXdVpRx/jRzSLSahwNTT/vUFY0qzeKiKQXOFh7aRLkhX6Q9IF7hLeJsaEUJ9+YqVhy09BbujuAgqqtmFnz5dfN2jSu8foHvhJ/0nGqoWUXDVbeswRumnWEpCjCCAIXLGs/X9N7iQTC+63w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sR2NfFCHUg6HlesqvxYATmSqNKn36rJfwsstA3GrqCk=;
 b=wT56PuusLJg0sDpUeoF69BHltx/FL1IQvnIo+frML4iQTJU+5cY+zyIQH4Zc5OdRuXMpFNnTFJReo8uNCBRkCY9NVPkc11WzKiLrvudYa/2yzDobyg4oDhbmeGORZiaH5Qh0Hli/UPK1stpCzIG7hgZd2lDuxmESmlTgC2Cm0DctcalZVaIwQeD47cTPTPRQwYUDMnpD8rRF3i+2mWAlH/yeMQAA0qTq1iI7VyxjACKyW2K7jUoqCh0HPH0o43VVroIxvxwIbmnoscoZVXOyAQaYJ15sLX5DDzIapNvKzPVLuYSv6FikEjifpzEs60+wtdovGC0+EpSpjBz/n1Fm1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sR2NfFCHUg6HlesqvxYATmSqNKn36rJfwsstA3GrqCk=;
 b=PWGDKfaghK9mu/CB0B+ah+/mVJ1OW6tw4jvmY8omVgGQ/763qsDwR1rFm+X4MK26iq/x+LeehfZuJoSwjD6LCrWhmFdikduVoxVVDvR/GAQwC+B6byxGq6rIzZudc0Jk6hncTDegAi4MsP6eywukWvIZToId+oRn0iybwPjujMU=
Received: from CH2PR17CA0010.namprd17.prod.outlook.com (2603:10b6:610:53::20)
 by DM4PR12MB6470.namprd12.prod.outlook.com (2603:10b6:8:b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 13:39:53 +0000
Received: from BN5PEPF0004698A.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::35) by CH2PR17CA0010.outlook.office365.com
 (2603:10b6:610:53::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.18 via Frontend Transport; Fri, 2
 Oct 2026 13:39:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN5PEPF0004698A.mail.protection.outlook.com (10.167.245.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 13:39:52 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 08:39:37 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 2 Oct 2026 08:39:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <aesteve@redhat.com>,
 <harry.wentland@amd.com>, <sunpeng.li@amd.com>, <corbet@lwn.net>,
 <skhan@linuxfoundation.org>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <siqueira@igalia.com>, <rdunlap@infradead.org>
CC: <dri-devel@lists.freedesktop.org>, <mripard@kernel.org>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 3/3] Revert "drm/amd/display: replace STATIC_IFN_KUNIT with
 VISIBLE_IF_KUNIT"
Date: Fri, 2 Oct 2026 09:39:25 -0400
Message-ID: <20261002133925.2356834-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002133925.2356834-1-alexander.deucher@amd.com>
References: <20261002133925.2356834-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF0004698A:EE_|DM4PR12MB6470:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cdae4d0-30e3-4d96-56b5-08df208aa311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|36860700016|1800799024|23010399003|10067099003|56012099006|3023799007|22082099003|18002099003|6133799003|11063799006|5023799004|921020;
X-Microsoft-Antispam-Message-Info: nPvIt44/dmTc1ddIsRLnrbERC5d39AjAcfUH+0+yl72NtK4EF1psIbVfSU/y7TeNJNR6AEXeYFiQTev66PJqr46nq8E/Q+whjz/QrCPhBEP19TP2vIbPMj5HKfhsCcYzTv7R0fRNIYmlE5nHHJzCX1zfa46frhOs04mnjXjMS8dqx9H9eJIWHYdr7TYV93onyxy8Rlc8pqUcHkUMRde5ZEDyMktdH0dmpGNd9+NnPdsWVUEXmDQfkTeCRIgMyUb0X5NOHec1zHHIv0w/h5rrVzVlWJg0iKlq7YJrQEKqedEKXS684D8cx8X2LIdXmebQzp5EWDYBFRsRXhez5DCCgum4DnNg2s+bjHtKC3hoh0vxn+UH/UZyBhB//QXNs5nhlQTEpIgp4Rl13emxauMQcscomTn8YaYxQC3KgJm3Bq0hvi1qriZcfGBam0YOxDhY4Hu8ZUIscEdSDCh4bP07M5ICrWYkOG7YcKf8En2AcyrDQ7mbw9ALzUM4TRd2rBk7AgtczUrwGIe/wDKKr2yRioZsLE9BMuoJYGeYiWDYQnn6cSYs55rRr69fNbVTmRUEetydROCHnjueTJJV0TxDQUiJEt26OYwHjBFr8TVJYUHVSxyGK2TuaNaxTh/ptt0JT59BWpOVdjX7wugWYgvPr0XF2s8sRHuPV9Npig793vVmrCYo2R1VCC+vTeFLj3mYXL0Pl8mlyPUxqsxKlflIU7zoBFakHz7qd/cJusY/+b9KFHJuAzLtmGFNTa9nTv+e
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(10067099003)(56012099006)(3023799007)(22082099003)(18002099003)(6133799003)(11063799006)(5023799004)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: q8Se5xxwy01QDHMtsgQh6y4Lg8vZzzOMxUuG0oxc4iZRiu3uveIrkTQ9AjoZKVeRNuD2/tFUFkZJxf667adhtyDvZ6COhOUgJn+dWpm1Arlu2K/DABA2lKWd1aAvU94nNPA/2JhXTALdoCDm0N0fDx4obx1/g4ibah+CQGoHhMRkW+JK/TzdmpmkAz2n1iRT0Y7OAt6iTaSDDV0+dVtoq7KLVUJfXbAxSJ+RY8a00+GJ68iUMs3+I4SPTf7OFUqZozWqptI1DYU8JCK429ePUC3S1jRqkcWg0Pa9z94DChGURO3w2So0xrdVjM70OeA87q6Qh1bY+BRhXCJGKi79w3cC3Y1GuZ4jBZ+VZre5yFuq9sUE1O4yRVtYKILG6QWVpue46+NX75eXJWQ/pTqYguMh2l003gnz8rCGjRtLlcWYWN4ckq6G6wQcV/NFHLmq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 13:39:52.2890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cdae4d0-30e3-4d96-56b5-08df208aa311
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN5PEPF0004698A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6470
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

This reverts commit 7e9fca772695c65f97493272e2e7cd475f202965.

This series breaks the build when CONFIG_KUNIT=y and
CONFIG_DRM_AMD_DC_KUNIT_TEST=n. When CONFIG_KUNIT=y,
the functions are not static, but when CONFIG_DRM_AMD_DC_KUNIT_TEST=n,
they should be.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 129 +++++++++---------
 .../amd/display/amdgpu_dm/amdgpu_dm_audio.c   |   6 +-
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   |  26 ++--
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  60 ++++----
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c |   2 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  84 ++++++------
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |  14 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  24 ++--
 .../amd/display/amdgpu_dm/amdgpu_dm_cursor.c  |   8 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |   8 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |  49 ++++---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  30 ++--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |  56 ++++----
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c |  14 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  52 +++----
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  66 +++++----
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  |  50 +++----
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |   4 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c  |   8 +-
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   4 +-
 20 files changed, 342 insertions(+), 352 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index db991a81f69b..d7b594b10ce4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -140,10 +140,9 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev);
 /* removes and deallocates the drm structures, created by the above function */
 static void amdgpu_dm_destroy_drm_device(struct amdgpu_display_manager *dm);
 
-VISIBLE_IF_KUNIT int amdgpu_dm_atomic_setup_commit(struct drm_atomic_commit *state);
+STATIC_IFN_KUNIT int amdgpu_dm_atomic_setup_commit(struct drm_atomic_commit *state);
 static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state);
-VISIBLE_IF_KUNIT void dm_enable_per_frame_crtc_master_sync(
-	struct dc_state *context);
+STATIC_IFN_KUNIT void dm_enable_per_frame_crtc_master_sync(struct dc_state *context);
 
 #if !IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 static int amdgpu_dm_atomic_check(struct drm_device *dev,
@@ -169,7 +168,7 @@ static inline void amdgpu_dm_exit_ips_for_hw_access(struct dc *dc)
  * @return
  * Counter for vertical blanks
  */
-VISIBLE_IF_KUNIT u32 dm_vblank_get_counter(struct amdgpu_device *adev, int crtc)
+STATIC_IFN_KUNIT u32 dm_vblank_get_counter(struct amdgpu_device *adev, int crtc)
 {
 	struct amdgpu_crtc *acrtc = NULL;
 
@@ -188,7 +187,7 @@ VISIBLE_IF_KUNIT u32 dm_vblank_get_counter(struct amdgpu_device *adev, int crtc)
 }
 EXPORT_IF_KUNIT(dm_vblank_get_counter);
 
-VISIBLE_IF_KUNIT int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
+STATIC_IFN_KUNIT int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
 					    u32 *vbl, u32 *position)
 {
 	u32 v_blank_start = 0, v_blank_end = 0, h_position = 0, v_position = 0;
@@ -226,7 +225,7 @@ VISIBLE_IF_KUNIT int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc
 }
 EXPORT_IF_KUNIT(dm_crtc_get_scanoutpos);
 
-VISIBLE_IF_KUNIT int dm_wait_for_idle(struct amdgpu_ip_block *ip_block)
+STATIC_IFN_KUNIT int dm_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	/* XXX todo */
 	return 0;
@@ -238,7 +237,7 @@ EXPORT_IF_KUNIT(dm_wait_for_idle);
  * in the dc_surface_updates array. This comparator is used to sort them
  * by descending zpos.
  */
-VISIBLE_IF_KUNIT int dm_plane_layer_index_cmp(const void *a, const void *b)
+STATIC_IFN_KUNIT int dm_plane_layer_index_cmp(const void *a, const void *b)
 {
 	const struct dc_surface_update *sa = (struct dc_surface_update *)a;
 	const struct dc_surface_update *sb = (struct dc_surface_update *)b;
@@ -274,7 +273,7 @@ static const struct amdgpu_dm_kunit_ops *amdgpu_dm_ops;
  * @array_of_surface_update: dc surface update pointer
  *
  */
-VISIBLE_IF_KUNIT INLINE_IFN_KUNIT
+STATIC_IFN_KUNIT INLINE_IFN_KUNIT
 bool update_planes_and_stream_adapter(struct dc *dc,
 				      int planes_count,
 				      struct dc_stream_state *stream,
@@ -297,14 +296,14 @@ bool update_planes_and_stream_adapter(struct dc *dc,
 }
 EXPORT_IF_KUNIT(update_planes_and_stream_adapter);
 
-VISIBLE_IF_KUNIT int dm_set_clockgating_state(struct amdgpu_ip_block *ip_block,
+STATIC_IFN_KUNIT int dm_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 					      enum amd_clockgating_state state)
 {
 	return 0;
 }
 EXPORT_IF_KUNIT(dm_set_clockgating_state);
 
-VISIBLE_IF_KUNIT int dm_set_powergating_state(struct amdgpu_ip_block *ip_block,
+STATIC_IFN_KUNIT int dm_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					      enum amd_powergating_state state)
 {
 	return 0;
@@ -312,7 +311,7 @@ VISIBLE_IF_KUNIT int dm_set_powergating_state(struct amdgpu_ip_block *ip_block,
 EXPORT_IF_KUNIT(dm_set_powergating_state);
 
 /* Prototypes of private functions */
-VISIBLE_IF_KUNIT int dm_early_init(struct amdgpu_ip_block *ip_block);
+STATIC_IFN_KUNIT int dm_early_init(struct amdgpu_ip_block *ip_block);
 
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 static const struct amdgpu_dm_kunit_ops amdgpu_dm_default_ops = {
@@ -338,7 +337,7 @@ EXPORT_IF_KUNIT(amdgpu_dm_kunit_set_ops);
 #endif
 
 /* Allocate memory for FBC compressed data  */
-VISIBLE_IF_KUNIT void mmhub_read_system_context(struct amdgpu_device *adev,
+STATIC_IFN_KUNIT void mmhub_read_system_context(struct amdgpu_device *adev,
 						struct dc_phy_addr_space_config *pa_config)
 {
 	u64 pt_base;
@@ -417,7 +416,7 @@ VISIBLE_IF_KUNIT void mmhub_read_system_context(struct amdgpu_device *adev,
 }
 EXPORT_IF_KUNIT(mmhub_read_system_context);
 
-VISIBLE_IF_KUNIT int amdgpu_dm_init_power_module(struct amdgpu_display_manager *dm)
+STATIC_IFN_KUNIT int amdgpu_dm_init_power_module(struct amdgpu_display_manager *dm)
 {
 	struct mod_power_init_params init_data[MAX_NUM_EDP];
 
@@ -869,7 +868,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	return -EINVAL;
 }
 
-VISIBLE_IF_KUNIT int amdgpu_dm_early_fini(struct amdgpu_ip_block *ip_block)
+STATIC_IFN_KUNIT int amdgpu_dm_early_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
@@ -985,7 +984,7 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 	mutex_destroy(&adev->dm.dpia_aux_lock);
 }
 
-VISIBLE_IF_KUNIT int load_dmcu_fw(struct amdgpu_device *adev)
+STATIC_IFN_KUNIT int load_dmcu_fw(struct amdgpu_device *adev)
 {
 	const char *fw_name_dmcu = NULL;
 	int r;
@@ -1097,7 +1096,7 @@ VISIBLE_IF_KUNIT int load_dmcu_fw(struct amdgpu_device *adev)
 }
 EXPORT_IF_KUNIT(load_dmcu_fw);
 
-VISIBLE_IF_KUNIT int dm_sw_init(struct amdgpu_ip_block *ip_block)
+STATIC_IFN_KUNIT int dm_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	int r;
@@ -1120,7 +1119,7 @@ VISIBLE_IF_KUNIT int dm_sw_init(struct amdgpu_ip_block *ip_block)
 }
 EXPORT_IF_KUNIT(dm_sw_init);
 
-VISIBLE_IF_KUNIT int dm_sw_fini(struct amdgpu_ip_block *ip_block)
+STATIC_IFN_KUNIT int dm_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	struct dal_allocation *da;
@@ -1201,7 +1200,7 @@ static void amdgpu_dm_boot_time_crc_init(struct amdgpu_device *adev)
 	}
 }
 
-VISIBLE_IF_KUNIT int dm_late_init(struct amdgpu_ip_block *ip_block)
+STATIC_IFN_KUNIT int dm_late_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
@@ -1253,7 +1252,7 @@ VISIBLE_IF_KUNIT int dm_late_init(struct amdgpu_ip_block *ip_block)
 }
 EXPORT_IF_KUNIT(dm_late_init);
 
-VISIBLE_IF_KUNIT void resume_mst_branch_status(struct drm_dp_mst_topology_mgr *mgr)
+STATIC_IFN_KUNIT void resume_mst_branch_status(struct drm_dp_mst_topology_mgr *mgr)
 {
 	u8 buf[UUID_SIZE];
 	guid_t guid;
@@ -1305,7 +1304,7 @@ VISIBLE_IF_KUNIT void resume_mst_branch_status(struct drm_dp_mst_topology_mgr *m
 }
 EXPORT_IF_KUNIT(resume_mst_branch_status);
 
-VISIBLE_IF_KUNIT void s3_handle_mst(struct drm_device *dev, bool suspend)
+STATIC_IFN_KUNIT void s3_handle_mst(struct drm_device *dev, bool suspend)
 {
 	struct amdgpu_dm_connector *aconnector;
 	struct drm_connector *connector;
@@ -1348,7 +1347,7 @@ VISIBLE_IF_KUNIT void s3_handle_mst(struct drm_device *dev, bool suspend)
 }
 EXPORT_IF_KUNIT(s3_handle_mst);
 
-VISIBLE_IF_KUNIT int dm_oem_i2c_hw_init(struct amdgpu_device *adev)
+STATIC_IFN_KUNIT int dm_oem_i2c_hw_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_display_manager *dm = &adev->dm;
 	struct amdgpu_i2c_adapter *oem_i2c;
@@ -1445,7 +1444,7 @@ static int dm_hw_fini(struct amdgpu_ip_block *ip_block)
 }
 
 
-VISIBLE_IF_KUNIT void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
+STATIC_IFN_KUNIT void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
 						    struct dc_state *state, bool enable)
 {
 	enum dc_irq_source irq_source;
@@ -1501,7 +1500,7 @@ EXPORT_IF_KUNIT(dm_gpureset_toggle_interrupts);
 
 DEFINE_FREE(state_release, struct dc_state *, dc_state_release(_T))
 
-VISIBLE_IF_KUNIT enum dc_status amdgpu_dm_commit_zero_streams(struct dc *dc)
+STATIC_IFN_KUNIT enum dc_status amdgpu_dm_commit_zero_streams(struct dc *dc)
 {
 	struct dc_state *context __free(state_release) = NULL;
 	int i;
@@ -1541,7 +1540,7 @@ VISIBLE_IF_KUNIT enum dc_status amdgpu_dm_commit_zero_streams(struct dc *dc)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_commit_zero_streams);
 
-VISIBLE_IF_KUNIT int dm_cache_state(struct amdgpu_device *adev)
+STATIC_IFN_KUNIT int dm_cache_state(struct amdgpu_device *adev)
 {
 	int r;
 
@@ -1555,7 +1554,7 @@ VISIBLE_IF_KUNIT int dm_cache_state(struct amdgpu_device *adev)
 }
 EXPORT_IF_KUNIT(dm_cache_state);
 
-VISIBLE_IF_KUNIT void dm_destroy_cached_state(struct amdgpu_device *adev)
+STATIC_IFN_KUNIT void dm_destroy_cached_state(struct amdgpu_device *adev)
 {
 	struct amdgpu_display_manager *dm = &adev->dm;
 	struct drm_device *ddev = adev_to_drm(adev);
@@ -1768,7 +1767,7 @@ void amdgpu_dm_emulated_link_detect(struct dc_link *link)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_emulated_link_detect);
 
-VISIBLE_IF_KUNIT void dm_gpureset_commit_state(struct dc_state *dc_state,
+STATIC_IFN_KUNIT void dm_gpureset_commit_state(struct dc_state *dc_state,
 					       struct amdgpu_display_manager *dm)
 {
 	struct {
@@ -1833,7 +1832,7 @@ EXPORT_IF_KUNIT(amdgpu_dm_apply_delay_after_dpcd_poweroff);
  * (MST) sinks. Should be called after connector detection is complete to see
  * the final state of all links.
  */
-VISIBLE_IF_KUNIT void amdgpu_dm_dump_links_and_sinks(struct amdgpu_device *adev)
+STATIC_IFN_KUNIT void amdgpu_dm_dump_links_and_sinks(struct amdgpu_device *adev)
 {
 	struct dc *dc = adev->dm.dc;
 	struct drm_device *dev = adev_to_drm(adev);
@@ -2199,7 +2198,7 @@ int dm_atomic_get_state(struct drm_atomic_commit *state,
 }
 EXPORT_IF_KUNIT(dm_atomic_get_state);
 
-VISIBLE_IF_KUNIT struct dm_atomic_state *
+STATIC_IFN_KUNIT struct dm_atomic_state *
 dm_atomic_get_new_state(struct drm_atomic_commit *state)
 {
 	struct drm_device *dev = state->dev;
@@ -2218,7 +2217,7 @@ dm_atomic_get_new_state(struct drm_atomic_commit *state)
 }
 EXPORT_IF_KUNIT(dm_atomic_get_new_state);
 
-VISIBLE_IF_KUNIT struct drm_private_state *
+STATIC_IFN_KUNIT struct drm_private_state *
 dm_atomic_duplicate_state(struct drm_private_obj *obj)
 {
 	struct dm_atomic_state *old_state, *new_state;
@@ -2243,7 +2242,7 @@ dm_atomic_duplicate_state(struct drm_private_obj *obj)
 }
 EXPORT_IF_KUNIT(dm_atomic_duplicate_state);
 
-VISIBLE_IF_KUNIT void dm_atomic_destroy_state(struct drm_private_obj *obj,
+STATIC_IFN_KUNIT void dm_atomic_destroy_state(struct drm_private_obj *obj,
 					      struct drm_private_state *state)
 {
 	struct dm_atomic_state *dm_state = to_dm_atomic_state(state);
@@ -2284,7 +2283,7 @@ static struct drm_private_state_funcs dm_atomic_state_funcs = {
 	.atomic_destroy_state = dm_atomic_destroy_state,
 };
 
-VISIBLE_IF_KUNIT int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
+STATIC_IFN_KUNIT int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
 {
 	int r;
 
@@ -2326,7 +2325,7 @@ VISIBLE_IF_KUNIT int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_mode_config_init);
 
-VISIBLE_IF_KUNIT int initialize_plane(struct amdgpu_display_manager *dm,
+STATIC_IFN_KUNIT int initialize_plane(struct amdgpu_display_manager *dm,
 				      struct amdgpu_mode_info *mode_info, int plane_id,
 				      enum drm_plane_type plane_type,
 				      const struct dc_plane_cap *plane_cap)
@@ -2728,7 +2727,7 @@ static void amdgpu_dm_destroy_drm_device(struct amdgpu_display_manager *dm)
  *
  * Calculate and program the display watermarks and line buffer allocation.
  */
-VISIBLE_IF_KUNIT void dm_bandwidth_update(struct amdgpu_device *adev)
+STATIC_IFN_KUNIT void dm_bandwidth_update(struct amdgpu_device *adev)
 {
 	/* TODO: implement later */
 }
@@ -2782,7 +2781,7 @@ DEVICE_ATTR_WO(s3_debug);
 
 #endif
 
-VISIBLE_IF_KUNIT int dm_early_init(struct amdgpu_ip_block *ip_block)
+STATIC_IFN_KUNIT int dm_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_mode_info *mode_info = &adev->mode_info;
@@ -2934,13 +2933,13 @@ VISIBLE_IF_KUNIT int dm_early_init(struct amdgpu_ip_block *ip_block)
 }
 EXPORT_IF_KUNIT(dm_early_init);
 
-VISIBLE_IF_KUNIT bool modereset_required(struct drm_crtc_state *crtc_state)
+STATIC_IFN_KUNIT bool modereset_required(struct drm_crtc_state *crtc_state)
 {
 	return !crtc_state->active && drm_atomic_crtc_needs_modeset(crtc_state);
 }
 EXPORT_IF_KUNIT(modereset_required);
 
-VISIBLE_IF_KUNIT int
+STATIC_IFN_KUNIT int
 fill_plane_color_attributes(struct drm_atomic_commit *state,
 			    const struct drm_plane_state *plane_state,
 			    const enum surface_pixel_format format,
@@ -2990,7 +2989,7 @@ fill_plane_color_attributes(struct drm_atomic_commit *state,
 }
 EXPORT_IF_KUNIT(fill_plane_color_attributes);
 
-VISIBLE_IF_KUNIT int
+STATIC_IFN_KUNIT int
 fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 			    struct drm_atomic_commit *state,
 			    const struct drm_plane_state *plane_state,
@@ -3107,7 +3106,7 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 }
 EXPORT_IF_KUNIT(fill_dc_plane_info_and_addr);
 
-VISIBLE_IF_KUNIT int fill_dc_plane_attributes(struct amdgpu_device *adev,
+STATIC_IFN_KUNIT int fill_dc_plane_attributes(struct amdgpu_device *adev,
 					      struct dc_plane_state *dc_plane_state,
 					      struct drm_plane_state *plane_state,
 					      struct drm_crtc_state *crtc_state)
@@ -3215,7 +3214,7 @@ static inline void fill_dc_dirty_rect(struct drm_plane *plane,
  * implicitly provide damage clips without any client support via the plane
  * bounds.
  */
-VISIBLE_IF_KUNIT void fill_dc_dirty_rects(struct drm_plane *plane,
+STATIC_IFN_KUNIT void fill_dc_dirty_rects(struct drm_plane *plane,
 					  struct drm_plane_state *old_plane_state,
 					  struct drm_plane_state *new_plane_state,
 					  struct drm_crtc_state *crtc_state,
@@ -3329,7 +3328,7 @@ VISIBLE_IF_KUNIT void fill_dc_dirty_rects(struct drm_plane *plane,
 }
 EXPORT_IF_KUNIT(fill_dc_dirty_rects);
 
-VISIBLE_IF_KUNIT int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_commit *state,
+STATIC_IFN_KUNIT int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_commit *state,
 						      struct dc_state *dc_state,
 						      struct dsc_mst_fairness_vars *vars)
 {
@@ -3407,7 +3406,7 @@ VISIBLE_IF_KUNIT int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_commit *
 }
 EXPORT_IF_KUNIT(dm_update_mst_vcpi_slots_for_dsc);
 
-VISIBLE_IF_KUNIT void manage_dm_interrupts(struct amdgpu_device *adev,
+STATIC_IFN_KUNIT void manage_dm_interrupts(struct amdgpu_device *adev,
 					   struct amdgpu_crtc *acrtc,
 					   struct dm_crtc_state *acrtc_state)
 {	/*
@@ -3490,7 +3489,7 @@ VISIBLE_IF_KUNIT void manage_dm_interrupts(struct amdgpu_device *adev,
 }
 EXPORT_IF_KUNIT(manage_dm_interrupts);
 
-VISIBLE_IF_KUNIT void dm_update_pflip_irq_state(struct amdgpu_device *adev,
+STATIC_IFN_KUNIT void dm_update_pflip_irq_state(struct amdgpu_device *adev,
 						struct amdgpu_crtc *acrtc)
 {
 	int irq_type =
@@ -3508,7 +3507,7 @@ VISIBLE_IF_KUNIT void dm_update_pflip_irq_state(struct amdgpu_device *adev,
 }
 EXPORT_IF_KUNIT(dm_update_pflip_irq_state);
 
-VISIBLE_IF_KUNIT bool
+STATIC_IFN_KUNIT bool
 is_scaling_state_different(const struct dm_connector_state *dm_state,
 			   const struct dm_connector_state *old_dm_state)
 {
@@ -3527,7 +3526,7 @@ is_scaling_state_different(const struct dm_connector_state *dm_state,
 }
 EXPORT_IF_KUNIT(is_scaling_state_different);
 
-VISIBLE_IF_KUNIT bool
+STATIC_IFN_KUNIT bool
 is_content_protection_different(struct drm_crtc_state *new_crtc_state,
 				struct drm_crtc_state *old_crtc_state,
 				struct drm_connector_state *new_conn_state,
@@ -3659,7 +3658,7 @@ static void remove_stream(struct amdgpu_device *adev,
 	acrtc->enabled = false;
 }
 
-VISIBLE_IF_KUNIT void amdgpu_dm_commit_cursors(struct drm_atomic_commit *state)
+STATIC_IFN_KUNIT void amdgpu_dm_commit_cursors(struct drm_atomic_commit *state)
 {
 	struct drm_plane *plane;
 	struct drm_plane_state *old_plane_state;
@@ -3682,7 +3681,7 @@ static inline uint32_t get_mem_type(struct drm_framebuffer *fb)
 	return abo->tbo.resource ? abo->tbo.resource->mem_type : 0;
 }
 
-VISIBLE_IF_KUNIT void amdgpu_dm_update_cursor(struct drm_plane *plane,
+STATIC_IFN_KUNIT void amdgpu_dm_update_cursor(struct drm_plane *plane,
 					      struct drm_plane_state *old_plane_state,
 					      struct dc_stream_update *update)
 {
@@ -3755,7 +3754,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_update_cursor(struct drm_plane *plane,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_update_cursor);
 
-VISIBLE_IF_KUNIT void amdgpu_dm_enable_self_refresh(struct amdgpu_display_manager *dm,
+STATIC_IFN_KUNIT void amdgpu_dm_enable_self_refresh(struct amdgpu_display_manager *dm,
 						    struct amdgpu_crtc *acrtc_attach,
 						    const struct dm_crtc_state *acrtc_state,
 						    const u64 current_ts)
@@ -3796,7 +3795,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_enable_self_refresh(struct amdgpu_display_manage
 }
 EXPORT_IF_KUNIT(amdgpu_dm_enable_self_refresh);
 
-VISIBLE_IF_KUNIT void dm_arm_vblank_event(struct amdgpu_crtc *acrtc,
+STATIC_IFN_KUNIT void dm_arm_vblank_event(struct amdgpu_crtc *acrtc,
 					  struct dm_crtc_state *acrtc_state,
 					  bool pflip_update,
 					  bool cursor_update)
@@ -3835,7 +3834,7 @@ EXPORT_IF_KUNIT(dm_arm_vblank_event);
  * be programmed. Do this before programming so the HW is not in any
  * idle-optimized state (such as PSR).
  */
-VISIBLE_IF_KUNIT void dm_arm_vblank_event_pre_programming(struct amdgpu_crtc *acrtc,
+STATIC_IFN_KUNIT void dm_arm_vblank_event_pre_programming(struct amdgpu_crtc *acrtc,
 							  struct dm_crtc_state *acrtc_state,
 							  bool pflip_update,
 							  bool cursor_update)
@@ -4424,7 +4423,7 @@ bool amdgpu_dm_crtc_complete_writeback(struct amdgpu_crtc *acrtc)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_crtc_complete_writeback);
 
-VISIBLE_IF_KUNIT void dm_clear_writeback(struct amdgpu_display_manager *dm,
+STATIC_IFN_KUNIT void dm_clear_writeback(struct amdgpu_display_manager *dm,
 					 struct amdgpu_crtc *acrtc,
 					 struct dm_crtc_state *crtc_state)
 {
@@ -4449,7 +4448,7 @@ EXPORT_IF_KUNIT(dm_clear_writeback);
  * in preparation for hardware programming. See also
  * amdgpu_dm_mod_power_setup_streams() for post-modeset mod_power setup.
  */
-VISIBLE_IF_KUNIT void amdgpu_dm_mod_power_update_streams(struct drm_atomic_commit *state,
+STATIC_IFN_KUNIT void amdgpu_dm_mod_power_update_streams(struct drm_atomic_commit *state,
 							struct amdgpu_display_manager *dm)
 {
 	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
@@ -4513,7 +4512,7 @@ EXPORT_IF_KUNIT(amdgpu_dm_mod_power_update_streams);
  * Notify mod_power of mode_change. This needs to be done after dc_stream
  * updates have been committed, and VRR parameters have been updated.
  */
-VISIBLE_IF_KUNIT void amdgpu_dm_mod_power_setup_streams(struct drm_atomic_commit *state,
+STATIC_IFN_KUNIT void amdgpu_dm_mod_power_setup_streams(struct drm_atomic_commit *state,
 						       struct amdgpu_display_manager *dm)
 {
 	struct dm_crtc_state *dm_new_crtc_state;
@@ -4779,7 +4778,7 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_commit *state,
 	}
 }
 
-VISIBLE_IF_KUNIT void
+STATIC_IFN_KUNIT void
 dm_set_writeback(struct amdgpu_display_manager *dm,
 		 struct dm_crtc_state *crtc_state,
 		 struct drm_connector *connector,
@@ -4902,7 +4901,7 @@ dm_set_writeback(struct amdgpu_display_manager *dm,
 }
 EXPORT_IF_KUNIT(dm_set_writeback);
 
-VISIBLE_IF_KUNIT void amdgpu_dm_update_hdcp(struct drm_atomic_commit *state)
+STATIC_IFN_KUNIT void amdgpu_dm_update_hdcp(struct drm_atomic_commit *state)
 {
 	struct drm_connector_state *old_con_state, *new_con_state;
 	struct drm_device *dev = state->dev;
@@ -5018,7 +5017,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_update_hdcp(struct drm_atomic_commit *state)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_update_hdcp);
 
-VISIBLE_IF_KUNIT int amdgpu_dm_atomic_setup_commit(struct drm_atomic_commit *state)
+STATIC_IFN_KUNIT int amdgpu_dm_atomic_setup_commit(struct drm_atomic_commit *state)
 {
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
@@ -5052,7 +5051,7 @@ VISIBLE_IF_KUNIT int amdgpu_dm_atomic_setup_commit(struct drm_atomic_commit *sta
 }
 EXPORT_IF_KUNIT(amdgpu_dm_atomic_setup_commit);
 
-VISIBLE_IF_KUNIT void set_multisync_trigger_params(
+STATIC_IFN_KUNIT void set_multisync_trigger_params(
 		struct dc_stream_state *stream)
 {
 	struct dc_stream_state *master = NULL;
@@ -5067,7 +5066,7 @@ VISIBLE_IF_KUNIT void set_multisync_trigger_params(
 }
 EXPORT_IF_KUNIT(set_multisync_trigger_params);
 
-VISIBLE_IF_KUNIT void set_master_stream(struct dc_stream_state *stream_set[],
+STATIC_IFN_KUNIT void set_master_stream(struct dc_stream_state *stream_set[],
 					int stream_count)
 {
 	int j, highest_rfr = 0, master_stream = 0;
@@ -5091,7 +5090,7 @@ VISIBLE_IF_KUNIT void set_master_stream(struct dc_stream_state *stream_set[],
 }
 EXPORT_IF_KUNIT(set_master_stream);
 
-VISIBLE_IF_KUNIT void dm_enable_per_frame_crtc_master_sync(struct dc_state *context)
+STATIC_IFN_KUNIT void dm_enable_per_frame_crtc_master_sync(struct dc_state *context)
 {
 	int i = 0;
 	struct dc_stream_state *stream;
@@ -5436,7 +5435,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
  * Grabs all modesetting locks to serialize against any blocking commits,
  * Waits for completion of all non blocking commits.
  */
-VISIBLE_IF_KUNIT int do_aquire_global_lock(struct drm_device *dev,
+STATIC_IFN_KUNIT int do_aquire_global_lock(struct drm_device *dev,
 					   struct drm_atomic_commit *state)
 {
 	struct drm_crtc *crtc;
@@ -5484,7 +5483,7 @@ VISIBLE_IF_KUNIT int do_aquire_global_lock(struct drm_device *dev,
 }
 EXPORT_IF_KUNIT(do_aquire_global_lock);
 
-VISIBLE_IF_KUNIT int dm_update_crtc_state(struct amdgpu_display_manager *dm,
+STATIC_IFN_KUNIT int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 					  struct drm_atomic_commit *state,
 					  struct drm_crtc *crtc,
 					  struct drm_crtc_state *old_crtc_state,
@@ -5763,7 +5762,7 @@ VISIBLE_IF_KUNIT int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 }
 EXPORT_IF_KUNIT(dm_update_crtc_state);
 
-VISIBLE_IF_KUNIT bool should_reset_plane(struct drm_atomic_commit *state,
+STATIC_IFN_KUNIT bool should_reset_plane(struct drm_atomic_commit *state,
 					 struct drm_plane *plane,
 					 struct drm_plane_state *old_plane_state,
 					 struct drm_plane_state *new_plane_state)
@@ -5928,7 +5927,7 @@ VISIBLE_IF_KUNIT bool should_reset_plane(struct drm_atomic_commit *state,
 }
 EXPORT_IF_KUNIT(should_reset_plane);
 
-VISIBLE_IF_KUNIT int
+STATIC_IFN_KUNIT int
 dm_update_plane_state(struct dc *dc,
 		      struct drm_atomic_commit *state,
 		      struct drm_plane *plane,
@@ -6160,7 +6159,7 @@ struct __drm_planes_state *amdgpu_dm_get_next_zpos(
 	return &state->planes[highest_i];
 }
 
-VISIBLE_IF_KUNIT int add_affected_mst_dsc_crtcs(struct drm_atomic_commit *state,
+STATIC_IFN_KUNIT int add_affected_mst_dsc_crtcs(struct drm_atomic_commit *state,
 						struct drm_crtc *crtc)
 {
 	struct drm_connector *connector;
@@ -6192,7 +6191,7 @@ VISIBLE_IF_KUNIT int add_affected_mst_dsc_crtcs(struct drm_atomic_commit *state,
 }
 EXPORT_IF_KUNIT(add_affected_mst_dsc_crtcs);
 
-VISIBLE_IF_KUNIT bool amdgpu_dm_crtc_mem_type_changed(struct drm_device *dev,
+STATIC_IFN_KUNIT bool amdgpu_dm_crtc_mem_type_changed(struct drm_device *dev,
 						      struct drm_atomic_commit *state,
 						      struct drm_crtc_state *crtc_state)
 {
@@ -6240,7 +6239,7 @@ EXPORT_IF_KUNIT(amdgpu_dm_crtc_mem_type_changed);
  *
  * Return: -Error code if validation failed.
  */
-VISIBLE_IF_KUNIT int amdgpu_dm_atomic_check(struct drm_device *dev,
+STATIC_IFN_KUNIT int amdgpu_dm_atomic_check(struct drm_device *dev,
 					    struct drm_atomic_commit *state)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c
index 1b331e783220..199f339839b2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c
@@ -84,7 +84,7 @@ static const struct drm_audio_component_ops amdgpu_dm_audio_component_ops = {
 	.get_eld = amdgpu_dm_audio_component_get_eld,
 };
 
-VISIBLE_IF_KUNIT int amdgpu_dm_audio_component_bind(struct device *kdev,
+STATIC_IFN_KUNIT int amdgpu_dm_audio_component_bind(struct device *kdev,
 				       struct device *hda_kdev, void *data)
 {
 	struct drm_device *dev = dev_get_drvdata(kdev);
@@ -99,7 +99,7 @@ VISIBLE_IF_KUNIT int amdgpu_dm_audio_component_bind(struct device *kdev,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_audio_component_bind);
 
-VISIBLE_IF_KUNIT void amdgpu_dm_audio_component_unbind(struct device *kdev,
+STATIC_IFN_KUNIT void amdgpu_dm_audio_component_unbind(struct device *kdev,
 					  struct device *hda_kdev, void *data)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev_get_drvdata(kdev));
@@ -116,7 +116,7 @@ static const struct component_ops amdgpu_dm_audio_component_bind_ops = {
 	.unbind	= amdgpu_dm_audio_component_unbind,
 };
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 void amdgpu_dm_audio_init_pins(struct amdgpu_device *adev, int audio_count,
 			       const unsigned int *inst_array)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index a1aeb1cd0fce..27546febf90d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -51,7 +51,7 @@
 #include "dm_helpers.h"
 
 #if defined(CONFIG_ACPI) || IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 void amdgpu_dm_validate_backlight_caps(struct amdgpu_display_manager *dm, int bl_idx)
 {
 	struct amdgpu_dm_backlight_caps *caps = &dm->backlight_caps[bl_idx];
@@ -96,7 +96,7 @@ void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_update_backlight_caps);
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
 			 unsigned int *min, unsigned int *max)
 {
@@ -190,7 +190,7 @@ static u32 convert_brightness_to_millipercent(const struct amdgpu_dm_backlight_c
 	return min_t(u32, luminance * 1000, 100000);
 }
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
 			       unsigned int min, unsigned int max,
 			       uint32_t *user_brightness)
@@ -257,7 +257,7 @@ void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
 
 EXPORT_IF_KUNIT(convert_custom_brightness);
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
 				uint32_t brightness)
 {
@@ -274,7 +274,7 @@ u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
 
 EXPORT_IF_KUNIT(convert_brightness_from_user);
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *caps,
 			      uint32_t brightness)
 {
@@ -291,7 +291,7 @@ u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *caps,
 }
 EXPORT_IF_KUNIT(convert_brightness_to_user);
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 struct dc_stream_state *dm_find_stream_with_link(
 	struct amdgpu_display_manager *dm,
 	struct dc_link *link)
@@ -310,7 +310,7 @@ struct dc_stream_state *dm_find_stream_with_link(
 }
 EXPORT_IF_KUNIT(dm_find_stream_with_link);
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 int amdgpu_dm_backlight_get_device_index(struct amdgpu_display_manager *dm,
 					 struct backlight_device *bd)
 {
@@ -425,7 +425,7 @@ void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_backlight_set_level);
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
 {
 	struct amdgpu_display_manager *dm = bl_get_data(bd);
@@ -437,7 +437,7 @@ int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_backlight_update_status);
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm, int bl_idx)
 {
 	int ret;
@@ -464,7 +464,7 @@ u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm, int bl_idx)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_backlight_get_level);
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
 {
 	struct amdgpu_display_manager *dm = bl_get_data(bd);
@@ -480,7 +480,7 @@ static const struct backlight_ops amdgpu_dm_backlight_ops = {
 	.update_status	= amdgpu_dm_backlight_update_status,
 };
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 void amdgpu_dm_backlight_fill_props(const struct amdgpu_dm_backlight_caps *caps,
 				    bool is_system_supplied,
 				    bool custom_curve_enabled,
@@ -693,7 +693,7 @@ EXPORT_IF_KUNIT(amdgpu_dm_setup_backlight_device);
  * carefully.
  */
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 ssize_t panel_power_savings_show(struct device *device,
 				 struct device_attribute *attr,
 				 char *buf)
@@ -712,7 +712,7 @@ ssize_t panel_power_savings_show(struct device *device,
 }
 EXPORT_IF_KUNIT(panel_power_savings_show);
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 ssize_t panel_power_savings_store(struct device *device,
 				 struct device_attribute *attr,
 				 const char *buf, size_t count)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 793518b1582c..1125ebac6ccb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -174,7 +174,7 @@ void amdgpu_dm_init_color_mod(void)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_init_color_mod);
 
-VISIBLE_IF_KUNIT INLINE_IFN_KUNIT
+STATIC_IFN_KUNIT INLINE_IFN_KUNIT
 struct fixed31_32 amdgpu_dm_fixpt_from_s3132(__u64 x)
 {
 	struct fixed31_32 val;
@@ -425,7 +425,7 @@ amdgpu_dm_create_color_properties(struct amdgpu_device *adev)
  * Returns:
  * DRM LUT or NULL
  */
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 const struct drm_color_lut *
 __extract_blob_lut(const struct drm_property_blob *blob, uint32_t *size)
 {
@@ -442,7 +442,7 @@ EXPORT_IF_KUNIT(__extract_blob_lut);
  * Returns:
  * DRM LUT or NULL
  */
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 const struct drm_color_lut32 *
 __extract_blob_lut32(const struct drm_property_blob *blob, uint32_t *size)
 {
@@ -464,7 +464,7 @@ EXPORT_IF_KUNIT(__extract_blob_lut32);
  * True if the given lut is a linear mapping of values, i.e. it acts like a
  * bypass LUT. Otherwise, false.
  */
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 bool __is_lut_linear(const struct drm_color_lut *lut, uint32_t size)
 {
 	int i;
@@ -501,7 +501,7 @@ EXPORT_IF_KUNIT(__is_lut_linear);
  *
  * The conversion depends on the size of the lut - whether or not it's legacy.
  */
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 void __drm_lut_to_dc_gamma(const struct drm_color_lut *lut,
 				  struct dc_gamma *gamma, bool is_legacy)
 {
@@ -541,7 +541,7 @@ EXPORT_IF_KUNIT(__drm_lut_to_dc_gamma);
  *
  * The conversion depends on the size of the lut - whether or not it's legacy.
  */
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 void __drm_lut32_to_dc_gamma(const struct drm_color_lut32 *lut, struct dc_gamma *gamma)
 {
 	int i;
@@ -561,7 +561,7 @@ EXPORT_IF_KUNIT(__drm_lut32_to_dc_gamma);
  *
  * The matrix needs to be a 3x4 (12 entry) matrix.
  */
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 void __drm_ctm_to_dc_matrix(const struct drm_color_ctm *ctm,
 			   struct fixed31_32 *matrix)
 {
@@ -595,7 +595,7 @@ EXPORT_IF_KUNIT(__drm_ctm_to_dc_matrix);
  *
  * The matrix needs to be a 3x4 (12 entry) matrix.
  */
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 void __drm_ctm_3x4_to_dc_matrix(const struct drm_color_ctm_3x4 *ctm,
 				struct fixed31_32 *matrix)
 {
@@ -624,7 +624,7 @@ EXPORT_IF_KUNIT(__drm_ctm_3x4_to_dc_matrix);
  * Returns:
  * 0 in case of success, -ENOMEM if fails
  */
-VISIBLE_IF_KUNIT int
+STATIC_IFN_KUNIT int
 __set_legacy_tf(struct dc_transfer_func *func,
 		const struct drm_color_lut *lut, uint32_t lut_size,
 		bool has_rom)
@@ -664,7 +664,7 @@ EXPORT_IF_KUNIT(__set_legacy_tf);
  * Returns:
  * 0 in case of success. -ENOMEM if fails.
  */
-VISIBLE_IF_KUNIT int
+STATIC_IFN_KUNIT int
 __set_output_tf(struct dc_transfer_func *func,
 		const struct drm_color_lut *lut, uint32_t lut_size,
 		bool has_rom)
@@ -724,7 +724,7 @@ EXPORT_IF_KUNIT(__set_output_tf);
  * Returns:
  * 0 in case of success. -ENOMEM if fails.
  */
-VISIBLE_IF_KUNIT int
+STATIC_IFN_KUNIT int
 __set_output_tf_32(struct dc_transfer_func *func,
 		   const struct drm_color_lut32 *lut, uint32_t lut_size,
 		   bool has_rom)
@@ -772,14 +772,14 @@ __set_output_tf_32(struct dc_transfer_func *func,
 }
 EXPORT_IF_KUNIT(__set_output_tf_32);
 
-VISIBLE_IF_KUNIT void __set_tf_bypass(struct dc_transfer_func *tf)
+STATIC_IFN_KUNIT void __set_tf_bypass(struct dc_transfer_func *tf)
 {
 	tf->type = TF_TYPE_BYPASS;
 	tf->tf = TRANSFER_FUNCTION_LINEAR;
 }
 EXPORT_IF_KUNIT(__set_tf_bypass);
 
-VISIBLE_IF_KUNIT void __set_tf_distributed_points(struct dc_transfer_func *tf,
+STATIC_IFN_KUNIT void __set_tf_distributed_points(struct dc_transfer_func *tf,
 					enum dc_transfer_func_predefined predefined_tf)
 {
 	tf->type = TF_TYPE_DISTRIBUTED_POINTS;
@@ -788,7 +788,7 @@ VISIBLE_IF_KUNIT void __set_tf_distributed_points(struct dc_transfer_func *tf,
 }
 EXPORT_IF_KUNIT(__set_tf_distributed_points);
 
-VISIBLE_IF_KUNIT int amdgpu_dm_set_atomic_regamma(struct dc_transfer_func *out_tf,
+STATIC_IFN_KUNIT int amdgpu_dm_set_atomic_regamma(struct dc_transfer_func *out_tf,
 					const struct drm_color_lut *regamma_lut,
 					uint32_t regamma_size, bool has_rom,
 					enum dc_transfer_func_predefined tf)
@@ -832,7 +832,7 @@ EXPORT_IF_KUNIT(amdgpu_dm_set_atomic_regamma);
  * Returns:
  * 0 in case of success. -ENOMEM if fails.
  */
-VISIBLE_IF_KUNIT int __set_input_tf(struct dc_color_caps *caps,
+STATIC_IFN_KUNIT int __set_input_tf(struct dc_color_caps *caps,
 				    struct dc_transfer_func *func,
 				    const struct drm_color_lut *lut, uint32_t lut_size)
 {
@@ -870,7 +870,7 @@ EXPORT_IF_KUNIT(__set_input_tf);
  * Returns:
  * 0 in case of success. -ENOMEM if fails.
  */
-VISIBLE_IF_KUNIT int __set_input_tf_32(struct dc_color_caps *caps,
+STATIC_IFN_KUNIT int __set_input_tf_32(struct dc_color_caps *caps,
 				       struct dc_transfer_func *func,
 				       const struct drm_color_lut32 *lut, uint32_t lut_size)
 {
@@ -897,7 +897,7 @@ VISIBLE_IF_KUNIT int __set_input_tf_32(struct dc_color_caps *caps,
 }
 EXPORT_IF_KUNIT(__set_input_tf_32);
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 enum dc_transfer_func_predefined
 amdgpu_tf_to_dc_tf(enum amdgpu_transfer_function tf)
 {
@@ -928,7 +928,7 @@ amdgpu_tf_to_dc_tf(enum amdgpu_transfer_function tf)
 }
 EXPORT_IF_KUNIT(amdgpu_tf_to_dc_tf);
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 enum dc_transfer_func_predefined
 amdgpu_colorop_tf_to_dc_tf(enum drm_colorop_curve_1d_type tf)
 {
@@ -951,7 +951,7 @@ amdgpu_colorop_tf_to_dc_tf(enum drm_colorop_curve_1d_type tf)
 }
 EXPORT_IF_KUNIT(amdgpu_colorop_tf_to_dc_tf);
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 void __to_dc_lut3d_color(struct dc_rgb *rgb,
 				const struct drm_color_lut lut,
 				int bit_precision)
@@ -962,7 +962,7 @@ void __to_dc_lut3d_color(struct dc_rgb *rgb,
 }
 EXPORT_IF_KUNIT(__to_dc_lut3d_color);
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 void __drm_3dlut_to_dc_3dlut(const struct drm_color_lut *lut,
 				    uint32_t lut3d_size,
 				    struct tetrahedral_params *params,
@@ -1008,7 +1008,7 @@ void __drm_3dlut_to_dc_3dlut(const struct drm_color_lut *lut,
 }
 EXPORT_IF_KUNIT(__drm_3dlut_to_dc_3dlut);
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 void __to_dc_lut3d_32_color(struct dc_rgb *rgb,
 				   const struct drm_color_lut32 lut,
 				   int bit_precision)
@@ -1019,7 +1019,7 @@ void __to_dc_lut3d_32_color(struct dc_rgb *rgb,
 }
 EXPORT_IF_KUNIT(__to_dc_lut3d_32_color);
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 void __drm_3dlut32_to_dc_3dlut(const struct drm_color_lut32 *lut,
 				       uint32_t lut3d_size,
 				       struct tetrahedral_params *params,
@@ -1073,7 +1073,7 @@ EXPORT_IF_KUNIT(__drm_3dlut32_to_dc_3dlut);
  * Map user 3D LUT data to DC 3D LUT and all necessary bits to program it
  * on DCN accordingly.
  */
-VISIBLE_IF_KUNIT void amdgpu_dm_atomic_lut3d(const struct drm_color_lut *drm_lut3d,
+STATIC_IFN_KUNIT void amdgpu_dm_atomic_lut3d(const struct drm_color_lut *drm_lut3d,
 				     uint32_t drm_lut3d_size,
 				     struct dc_plane_cm *cm)
 {
@@ -1095,7 +1095,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_atomic_lut3d(const struct drm_color_lut *drm_lut
 }
 EXPORT_IF_KUNIT(amdgpu_dm_atomic_lut3d);
 
-VISIBLE_IF_KUNIT int amdgpu_dm_atomic_shaper_lut(const struct drm_color_lut *shaper_lut,
+STATIC_IFN_KUNIT int amdgpu_dm_atomic_shaper_lut(const struct drm_color_lut *shaper_lut,
 				       bool has_rom,
 				       enum dc_transfer_func_predefined tf,
 				       uint32_t shaper_size,
@@ -1121,7 +1121,7 @@ VISIBLE_IF_KUNIT int amdgpu_dm_atomic_shaper_lut(const struct drm_color_lut *sha
 }
 EXPORT_IF_KUNIT(amdgpu_dm_atomic_shaper_lut);
 
-VISIBLE_IF_KUNIT int amdgpu_dm_atomic_blend_lut(const struct drm_color_lut *blend_lut,
+STATIC_IFN_KUNIT int amdgpu_dm_atomic_blend_lut(const struct drm_color_lut *blend_lut,
 				       bool has_rom,
 				       enum dc_transfer_func_predefined tf,
 				       uint32_t blend_size,
@@ -1544,7 +1544,7 @@ __set_dm_plane_degamma(struct drm_plane_state *plane_state,
 	return 0;
 }
 
-VISIBLE_IF_KUNIT int
+STATIC_IFN_KUNIT int
 __set_colorop_in_tf_1d_curve(struct dc_plane_state *dc_plane_state,
 			     struct drm_colorop_state *colorop_state)
 {
@@ -1642,7 +1642,7 @@ __set_dm_plane_colorop_fixed_matrix(struct drm_plane_state *plane_state,
 	return 0;
 }
 
-VISIBLE_IF_KUNIT int
+STATIC_IFN_KUNIT int
 __set_dm_plane_colorop_degamma(struct drm_plane_state *plane_state,
 			       struct dc_plane_state *dc_plane_state,
 			       struct drm_colorop *colorop)
@@ -1670,7 +1670,7 @@ __set_dm_plane_colorop_degamma(struct drm_plane_state *plane_state,
 }
 EXPORT_IF_KUNIT(__set_dm_plane_colorop_degamma);
 
-VISIBLE_IF_KUNIT int
+STATIC_IFN_KUNIT int
 __set_dm_plane_colorop_3x4_matrix(struct drm_plane_state *plane_state,
 				  struct dc_plane_state *dc_plane_state,
 				  struct drm_colorop *colorop)
@@ -1712,7 +1712,7 @@ __set_dm_plane_colorop_3x4_matrix(struct drm_plane_state *plane_state,
 }
 EXPORT_IF_KUNIT(__set_dm_plane_colorop_3x4_matrix);
 
-VISIBLE_IF_KUNIT int
+STATIC_IFN_KUNIT int
 __set_dm_plane_colorop_multiplier(struct drm_plane_state *plane_state,
 				  struct dc_plane_state *dc_plane_state,
 				  struct drm_colorop *colorop)
@@ -1834,7 +1834,7 @@ __set_dm_plane_colorop_shaper(struct drm_plane_state *plane_state,
  * Returns:
  * 0 on success. -EINVAL if drm_lut3d_size is zero.
  */
-VISIBLE_IF_KUNIT int __set_colorop_3dlut(const struct drm_color_lut32 *drm_lut3d,
+STATIC_IFN_KUNIT int __set_colorop_3dlut(const struct drm_color_lut32 *drm_lut3d,
 					 uint32_t drm_lut3d_size,
 					 struct dc_3dlut *lut)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
index 51e814874533..47d90b67120e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
@@ -113,7 +113,7 @@ EXPORT_IF_KUNIT(amdgpu_dm_colorop_kunit_set_ops);
 
 #endif
 
-VISIBLE_IF_KUNIT int
+STATIC_IFN_KUNIT int
 amdgpu_dm_build_default_pipeline(struct drm_device *dev, struct drm_plane *plane,
 				  bool hw_3d_lut, struct drm_prop_enum_list *list)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 6ac9c4e4845d..b2eb6ab6b890 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -89,12 +89,12 @@ static const struct drm_encoder_funcs amdgpu_dm_encoder_funcs = {
 	.destroy = amdgpu_dm_encoder_destroy,
 };
 
-VISIBLE_IF_KUNIT void dm_encoder_helper_disable(struct drm_encoder *encoder)
+STATIC_IFN_KUNIT void dm_encoder_helper_disable(struct drm_encoder *encoder)
 {
 }
 EXPORT_IF_KUNIT(dm_encoder_helper_disable);
 
-VISIBLE_IF_KUNIT int dm_encoder_helper_atomic_check(struct drm_encoder *encoder,
+STATIC_IFN_KUNIT int dm_encoder_helper_atomic_check(struct drm_encoder *encoder,
 					  struct drm_crtc_state *crtc_state,
 					  struct drm_connector_state *conn_state)
 {
@@ -217,7 +217,7 @@ int amdgpu_dm_encoder_init(struct drm_device *dev,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_encoder_init);
 
-VISIBLE_IF_KUNIT enum drm_mode_subconnector get_subconnector_type(struct dc_link *link)
+STATIC_IFN_KUNIT enum drm_mode_subconnector get_subconnector_type(struct dc_link *link)
 {
 	switch (link->dpcd_caps.dongle_type) {
 	case DISPLAY_DONGLE_NONE:
@@ -237,7 +237,7 @@ VISIBLE_IF_KUNIT enum drm_mode_subconnector get_subconnector_type(struct dc_link
 }
 EXPORT_IF_KUNIT(get_subconnector_type);
 
-VISIBLE_IF_KUNIT void update_subconnector_property(struct amdgpu_dm_connector *aconnector)
+STATIC_IFN_KUNIT void update_subconnector_property(struct amdgpu_dm_connector *aconnector)
 {
 	struct dc_link *link = aconnector->dc_link;
 	struct drm_connector *connector = &aconnector->base;
@@ -255,9 +255,9 @@ VISIBLE_IF_KUNIT void update_subconnector_property(struct amdgpu_dm_connector *a
 }
 EXPORT_IF_KUNIT(update_subconnector_property);
 
-VISIBLE_IF_KUNIT int amdgpu_dm_connector_get_modes(struct drm_connector *connector);
+STATIC_IFN_KUNIT int amdgpu_dm_connector_get_modes(struct drm_connector *connector);
 
-VISIBLE_IF_KUNIT void amdgpu_dm_fbc_init(struct drm_connector *connector)
+STATIC_IFN_KUNIT void amdgpu_dm_fbc_init(struct drm_connector *connector)
 {
 	struct amdgpu_device *adev = drm_to_adev(connector->dev);
 	struct dm_compressor_info *compressor = &adev->dm.compressor;
@@ -335,7 +335,7 @@ int amdgpu_dm_detect_mst_link_for_all_connectors(struct drm_device *dev)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_detect_mst_link_for_all_connectors);
 
-VISIBLE_IF_KUNIT void hdmi_cec_unset_edid(struct amdgpu_dm_connector *aconnector)
+STATIC_IFN_KUNIT void hdmi_cec_unset_edid(struct amdgpu_dm_connector *aconnector)
 {
 	struct cec_notifier *n = aconnector->notifier;
 
@@ -401,7 +401,7 @@ amdgpu_dm_find_first_crtc_matching_connector(struct drm_atomic_commit *state,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_find_first_crtc_matching_connector);
 
-VISIBLE_IF_KUNIT void amdgpu_dm_set_panel_type(struct amdgpu_dm_connector *aconnector)
+STATIC_IFN_KUNIT void amdgpu_dm_set_panel_type(struct amdgpu_dm_connector *aconnector)
 {
 	struct drm_connector *connector = &aconnector->base;
 	struct drm_display_info *display_info = &connector->display_info;
@@ -470,7 +470,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_set_panel_type(struct amdgpu_dm_connector *aconn
 }
 EXPORT_IF_KUNIT(amdgpu_dm_set_panel_type);
 
-VISIBLE_IF_KUNIT void amdgpu_dm_update_cacp_caps(struct amdgpu_dm_connector *aconnector)
+STATIC_IFN_KUNIT void amdgpu_dm_update_cacp_caps(struct amdgpu_dm_connector *aconnector)
 {
 	struct amdgpu_device *adev = drm_to_adev(aconnector->base.dev);
 	struct dc_link *link = aconnector->dc_link;
@@ -725,7 +725,7 @@ amdgpu_dm_convert_color_depth_from_display_info(const struct drm_connector *conn
 }
 EXPORT_IF_KUNIT(amdgpu_dm_convert_color_depth_from_display_info);
 
-VISIBLE_IF_KUNIT enum dc_aspect_ratio
+STATIC_IFN_KUNIT enum dc_aspect_ratio
 get_aspect_ratio(const struct drm_display_mode *mode_in)
 {
 	/* 1-1 mapping, since both enums follow the HDMI spec. */
@@ -815,7 +815,7 @@ amdgpu_dm_get_output_color_space(const struct dc_crtc_timing *dc_crtc_timing,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_get_output_color_space);
 
-VISIBLE_IF_KUNIT enum display_content_type
+STATIC_IFN_KUNIT enum display_content_type
 get_output_content_type(const struct drm_connector_state *connector_state)
 {
 	switch (connector_state->content_type) {
@@ -834,7 +834,7 @@ get_output_content_type(const struct drm_connector_state *connector_state)
 }
 EXPORT_IF_KUNIT(get_output_content_type);
 
-VISIBLE_IF_KUNIT bool adjust_colour_depth_from_display_info(
+STATIC_IFN_KUNIT bool adjust_colour_depth_from_display_info(
 	struct dc_crtc_timing *timing_out,
 	const struct drm_display_info *info)
 {
@@ -872,7 +872,7 @@ VISIBLE_IF_KUNIT bool adjust_colour_depth_from_display_info(
 }
 EXPORT_IF_KUNIT(adjust_colour_depth_from_display_info);
 
-VISIBLE_IF_KUNIT void fill_stream_properties_from_drm_display_mode(
+STATIC_IFN_KUNIT void fill_stream_properties_from_drm_display_mode(
 	struct dc_stream_state *stream,
 	const struct drm_display_mode *mode_in,
 	const struct drm_connector *connector,
@@ -987,7 +987,7 @@ VISIBLE_IF_KUNIT void fill_stream_properties_from_drm_display_mode(
 }
 EXPORT_IF_KUNIT(fill_stream_properties_from_drm_display_mode);
 
-VISIBLE_IF_KUNIT void
+STATIC_IFN_KUNIT void
 copy_crtc_timing_for_drm_display_mode(const struct drm_display_mode *src_mode,
 				      struct drm_display_mode *dst_mode)
 {
@@ -1008,7 +1008,7 @@ copy_crtc_timing_for_drm_display_mode(const struct drm_display_mode *src_mode,
 }
 EXPORT_IF_KUNIT(copy_crtc_timing_for_drm_display_mode);
 
-VISIBLE_IF_KUNIT void
+STATIC_IFN_KUNIT void
 decide_crtc_timing_for_drm_display_mode(struct drm_display_mode *drm_mode,
 					const struct drm_display_mode *native_mode,
 					bool scale_enabled)
@@ -1448,7 +1448,7 @@ void amdgpu_dm_update_stream_scaling_settings(struct drm_device *dev,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_update_stream_scaling_settings);
 
-VISIBLE_IF_KUNIT struct dc_stream_state *
+STATIC_IFN_KUNIT struct dc_stream_state *
 create_stream_for_sink(struct drm_connector *connector,
 		       const struct drm_display_mode *drm_mode,
 		       const struct dm_connector_state *dm_state,
@@ -1650,7 +1650,7 @@ EXPORT_IF_KUNIT(create_stream_for_sink);
  *
  * Return: The probed connector status (connected/disconnected/unknown).
  */
-VISIBLE_IF_KUNIT enum drm_connector_status
+STATIC_IFN_KUNIT enum drm_connector_status
 amdgpu_dm_connector_poll(struct amdgpu_dm_connector *aconnector, bool force)
 {
 	struct drm_connector *connector = &aconnector->base;
@@ -1759,7 +1759,7 @@ static bool amdgpu_dm_hide_secondary_tile_from_userspace(struct drm_connector *c
  * Return: The connector status (connected, disconnected, or unknown).
  *
  */
-VISIBLE_IF_KUNIT enum drm_connector_status
+STATIC_IFN_KUNIT enum drm_connector_status
 amdgpu_dm_connector_detect(struct drm_connector *connector, bool force)
 {
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
@@ -1905,7 +1905,7 @@ int amdgpu_dm_connector_atomic_get_property(struct drm_connector *connector,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_connector_atomic_get_property);
 
-VISIBLE_IF_KUNIT void amdgpu_dm_connector_unregister(struct drm_connector *connector)
+STATIC_IFN_KUNIT void amdgpu_dm_connector_unregister(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *amdgpu_dm_connector = to_amdgpu_dm_connector(connector);
 
@@ -1917,7 +1917,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_connector_unregister(struct drm_connector *conne
 }
 EXPORT_IF_KUNIT(amdgpu_dm_connector_unregister);
 
-VISIBLE_IF_KUNIT void amdgpu_dm_connector_destroy(struct drm_connector *connector)
+STATIC_IFN_KUNIT void amdgpu_dm_connector_destroy(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 	struct amdgpu_device *adev = drm_to_adev(connector->dev);
@@ -2020,7 +2020,7 @@ amdgpu_dm_connector_atomic_duplicate_state(struct drm_connector *connector)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_connector_atomic_duplicate_state);
 
-VISIBLE_IF_KUNIT int
+STATIC_IFN_KUNIT int
 amdgpu_dm_connector_late_register(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *amdgpu_dm_connector =
@@ -2052,7 +2052,7 @@ amdgpu_dm_connector_late_register(struct drm_connector *connector)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_connector_late_register);
 
-VISIBLE_IF_KUNIT void amdgpu_dm_connector_funcs_force(struct drm_connector *connector)
+STATIC_IFN_KUNIT void amdgpu_dm_connector_funcs_force(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 	struct dc_link *dc_link = aconnector->dc_link;
@@ -2109,7 +2109,7 @@ static int get_modes(struct drm_connector *connector)
 	return amdgpu_dm_connector_get_modes(connector);
 }
 
-VISIBLE_IF_KUNIT void create_eml_sink(struct amdgpu_dm_connector *aconnector)
+STATIC_IFN_KUNIT void create_eml_sink(struct amdgpu_dm_connector *aconnector)
 {
 	struct drm_connector *connector = &aconnector->base;
 	struct dc_link *dc_link = aconnector->dc_link;
@@ -2156,7 +2156,7 @@ VISIBLE_IF_KUNIT void create_eml_sink(struct amdgpu_dm_connector *aconnector)
 }
 EXPORT_IF_KUNIT(create_eml_sink);
 
-VISIBLE_IF_KUNIT void handle_edid_mgmt(struct amdgpu_dm_connector *aconnector)
+STATIC_IFN_KUNIT void handle_edid_mgmt(struct amdgpu_dm_connector *aconnector)
 {
 	struct dc_link *link = (struct dc_link *)aconnector->dc_link;
 
@@ -2173,7 +2173,7 @@ VISIBLE_IF_KUNIT void handle_edid_mgmt(struct amdgpu_dm_connector *aconnector)
 }
 EXPORT_IF_KUNIT(handle_edid_mgmt);
 
-VISIBLE_IF_KUNIT enum dc_status dm_validate_stream_and_context(struct dc *dc,
+STATIC_IFN_KUNIT enum dc_status dm_validate_stream_and_context(struct dc *dc,
 						struct dc_stream_state *stream)
 {
 	enum dc_status dc_result = DC_ERROR_UNEXPECTED;
@@ -2603,7 +2603,7 @@ int amdgpu_dm_fill_hdr_info_packet(const struct drm_connector_state *state,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_fill_hdr_info_packet);
 
-VISIBLE_IF_KUNIT int
+STATIC_IFN_KUNIT int
 amdgpu_dm_connector_atomic_check(struct drm_connector *conn,
 				 struct drm_atomic_commit *state)
 {
@@ -2721,7 +2721,7 @@ int amdgpu_dm_convert_dc_color_depth_into_bpc(enum dc_color_depth display_color_
 }
 EXPORT_IF_KUNIT(amdgpu_dm_convert_dc_color_depth_into_bpc);
 
-VISIBLE_IF_KUNIT int to_drm_connector_type(enum signal_type st, uint32_t connector_id)
+STATIC_IFN_KUNIT int to_drm_connector_type(enum signal_type st, uint32_t connector_id)
 {
 	switch (st) {
 	case SIGNAL_TYPE_HDMI_TYPE_A:
@@ -2757,7 +2757,7 @@ VISIBLE_IF_KUNIT int to_drm_connector_type(enum signal_type st, uint32_t connect
 }
 EXPORT_IF_KUNIT(to_drm_connector_type);
 
-VISIBLE_IF_KUNIT struct drm_encoder *amdgpu_dm_connector_to_encoder(struct drm_connector *connector)
+STATIC_IFN_KUNIT struct drm_encoder *amdgpu_dm_connector_to_encoder(struct drm_connector *connector)
 {
 	struct drm_encoder *encoder;
 
@@ -2769,7 +2769,7 @@ VISIBLE_IF_KUNIT struct drm_encoder *amdgpu_dm_connector_to_encoder(struct drm_c
 }
 EXPORT_IF_KUNIT(amdgpu_dm_connector_to_encoder);
 
-VISIBLE_IF_KUNIT void amdgpu_dm_get_native_mode(struct drm_connector *connector)
+STATIC_IFN_KUNIT void amdgpu_dm_get_native_mode(struct drm_connector *connector)
 {
 	struct drm_encoder *encoder;
 	struct amdgpu_encoder *amdgpu_encoder;
@@ -2799,7 +2799,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_get_native_mode(struct drm_connector *connector)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_get_native_mode);
 
-VISIBLE_IF_KUNIT struct drm_display_mode *
+STATIC_IFN_KUNIT struct drm_display_mode *
 amdgpu_dm_create_common_mode(struct drm_encoder *encoder,
 			     const char *name,
 			     int hdisplay, int vdisplay)
@@ -2842,7 +2842,7 @@ static const struct amdgpu_dm_mode_size {
 	{"1920x1200", 1920, 1200}
 };
 
-VISIBLE_IF_KUNIT void amdgpu_dm_connector_add_common_modes(struct drm_encoder *encoder,
+STATIC_IFN_KUNIT void amdgpu_dm_connector_add_common_modes(struct drm_encoder *encoder,
 						 struct drm_connector *connector)
 {
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
@@ -2930,7 +2930,7 @@ EXPORT_IF_KUNIT(amdgpu_set_panel_orientation);
  * per-tile timing from the primary connector so compositors only pick the full
  * 5K mode.
  */
-VISIBLE_IF_KUNIT void amdgpu_dm_prune_primary_tile_modes(struct drm_connector *connector)
+STATIC_IFN_KUNIT void amdgpu_dm_prune_primary_tile_modes(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 	struct drm_display_mode *mode, *t;
@@ -2965,7 +2965,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_prune_primary_tile_modes(struct drm_connector *c
 }
 EXPORT_IF_KUNIT(amdgpu_dm_prune_primary_tile_modes);
 
-VISIBLE_IF_KUNIT void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *connector,
+STATIC_IFN_KUNIT void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *connector,
 					      const struct drm_edid *drm_edid)
 {
 	struct amdgpu_dm_connector *amdgpu_dm_connector =
@@ -3001,7 +3001,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *co
 }
 EXPORT_IF_KUNIT(amdgpu_dm_connector_ddc_get_modes);
 
-VISIBLE_IF_KUNIT bool is_duplicate_mode(struct amdgpu_dm_connector *aconnector,
+STATIC_IFN_KUNIT bool is_duplicate_mode(struct amdgpu_dm_connector *aconnector,
 			      struct drm_display_mode *mode)
 {
 	struct drm_display_mode *m;
@@ -3015,7 +3015,7 @@ VISIBLE_IF_KUNIT bool is_duplicate_mode(struct amdgpu_dm_connector *aconnector,
 }
 EXPORT_IF_KUNIT(is_duplicate_mode);
 
-VISIBLE_IF_KUNIT uint add_fs_modes(struct amdgpu_dm_connector *aconnector)
+STATIC_IFN_KUNIT uint add_fs_modes(struct amdgpu_dm_connector *aconnector)
 {
 	const struct drm_display_mode *m;
 	struct drm_display_mode *new_mode;
@@ -3092,7 +3092,7 @@ VISIBLE_IF_KUNIT uint add_fs_modes(struct amdgpu_dm_connector *aconnector)
 }
 EXPORT_IF_KUNIT(add_fs_modes);
 
-VISIBLE_IF_KUNIT void amdgpu_dm_connector_add_freesync_modes(struct drm_connector *connector,
+STATIC_IFN_KUNIT void amdgpu_dm_connector_add_freesync_modes(struct drm_connector *connector,
 						   const struct drm_edid *drm_edid)
 {
 	struct amdgpu_dm_connector *amdgpu_dm_connector =
@@ -3117,7 +3117,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_connector_add_freesync_modes(struct drm_connecto
 }
 EXPORT_IF_KUNIT(amdgpu_dm_connector_add_freesync_modes);
 
-VISIBLE_IF_KUNIT int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
+STATIC_IFN_KUNIT int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *amdgpu_dm_connector =
 			to_amdgpu_dm_connector(connector);
@@ -3360,7 +3360,7 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_connector_init_helper);
 
-VISIBLE_IF_KUNIT int amdgpu_dm_i2c_xfer(struct i2c_adapter *i2c_adap,
+STATIC_IFN_KUNIT int amdgpu_dm_i2c_xfer(struct i2c_adapter *i2c_adap,
 			      struct i2c_msg *msgs, int num)
 {
 	struct amdgpu_i2c_adapter *i2c = i2c_get_adapdata(i2c_adap);
@@ -3406,7 +3406,7 @@ VISIBLE_IF_KUNIT int amdgpu_dm_i2c_xfer(struct i2c_adapter *i2c_adap,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_i2c_xfer);
 
-VISIBLE_IF_KUNIT u32 amdgpu_dm_i2c_func(struct i2c_adapter *adap)
+STATIC_IFN_KUNIT u32 amdgpu_dm_i2c_func(struct i2c_adapter *adap)
 {
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
 }
@@ -3543,7 +3543,7 @@ int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_connector_init);
 
-VISIBLE_IF_KUNIT int dm_force_atomic_commit(struct drm_connector *connector)
+STATIC_IFN_KUNIT int dm_force_atomic_commit(struct drm_connector *connector)
 {
 	int ret = 0;
 	struct drm_device *ddev = connector->dev;
@@ -3643,7 +3643,7 @@ void dm_restore_drm_connector_state(struct drm_device *dev,
 }
 EXPORT_IF_KUNIT(dm_restore_drm_connector_state);
 
-VISIBLE_IF_KUNIT void parse_edid_displayid_vrr(struct drm_connector *connector,
+STATIC_IFN_KUNIT void parse_edid_displayid_vrr(struct drm_connector *connector,
 				     const struct edid *edid)
 {
 	u8 *edid_ext = NULL;
@@ -3687,7 +3687,7 @@ VISIBLE_IF_KUNIT void parse_edid_displayid_vrr(struct drm_connector *connector,
 }
 EXPORT_IF_KUNIT(parse_edid_displayid_vrr);
 
-VISIBLE_IF_KUNIT int get_amd_vsdb(struct amdgpu_dm_connector *aconnector,
+STATIC_IFN_KUNIT int get_amd_vsdb(struct amdgpu_dm_connector *aconnector,
 			struct amdgpu_hdmi_vsdb_info *vsdb_info)
 {
 	struct drm_connector *connector = &aconnector->base;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index c58cbf00543f..db546dd44b91 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -44,7 +44,7 @@ static const char *const pipe_crc_sources[] = {
 	"auto",
 };
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 enum amdgpu_dm_pipe_crc_source dm_parse_crc_source(const char *source)
 {
 	if (!source || !strcmp(source, "none"))
@@ -62,7 +62,7 @@ enum amdgpu_dm_pipe_crc_source dm_parse_crc_source(const char *source)
 }
 EXPORT_IF_KUNIT(dm_parse_crc_source);
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 bool dm_is_crc_source_crtc(enum amdgpu_dm_pipe_crc_source src)
 {
 	return (src == AMDGPU_DM_PIPE_CRC_SOURCE_CRTC) ||
@@ -70,7 +70,7 @@ bool dm_is_crc_source_crtc(enum amdgpu_dm_pipe_crc_source src)
 }
 EXPORT_IF_KUNIT(dm_is_crc_source_crtc);
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 bool dm_is_crc_source_dprx(enum amdgpu_dm_pipe_crc_source src)
 {
 	return (src == AMDGPU_DM_PIPE_CRC_SOURCE_DPRX) ||
@@ -78,7 +78,7 @@ bool dm_is_crc_source_dprx(enum amdgpu_dm_pipe_crc_source src)
 }
 EXPORT_IF_KUNIT(dm_is_crc_source_dprx);
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 bool dm_need_crc_dither(enum amdgpu_dm_pipe_crc_source src)
 {
 	return (src == AMDGPU_DM_PIPE_CRC_SOURCE_CRTC_DITHER) ||
@@ -97,7 +97,7 @@ EXPORT_IF_KUNIT(dm_need_crc_dither);
  *
  * Return: true if the DP AUX handle is needed, false otherwise.
  */
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 bool dm_need_dp_aux(enum amdgpu_dm_pipe_crc_source source,
 		    enum amdgpu_dm_pipe_crc_source cur_crc_src)
 {
@@ -116,7 +116,7 @@ EXPORT_IF_KUNIT(dm_need_dp_aux);
  *
  * Return: true if drm_dp_start_crc() should be called, false otherwise.
  */
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 bool dm_crc_source_should_start_dprx(enum amdgpu_dm_pipe_crc_source source,
 				      enum amdgpu_dm_pipe_crc_source cur_crc_src)
 {
@@ -136,7 +136,7 @@ EXPORT_IF_KUNIT(dm_crc_source_should_start_dprx);
  *
  * Return: true if drm_dp_stop_crc() should be called, false otherwise.
  */
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 bool dm_crc_source_should_stop_dprx(enum amdgpu_dm_pipe_crc_source source,
 				     enum amdgpu_dm_pipe_crc_source cur_crc_src)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 5e95d1544887..5036ac1c4fd5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -170,7 +170,7 @@ bool amdgpu_dm_is_headless(struct amdgpu_device *adev)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_is_headless);
 
-VISIBLE_IF_KUNIT void amdgpu_dm_idle_worker(struct work_struct *work)
+STATIC_IFN_KUNIT void amdgpu_dm_idle_worker(struct work_struct *work)
 {
 	struct idle_workqueue *idle_work;
 
@@ -223,7 +223,7 @@ struct idle_workqueue *idle_create_workqueue(struct amdgpu_device *adev)
 }
 EXPORT_IF_KUNIT(idle_create_workqueue);
 
-VISIBLE_IF_KUNIT void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
+STATIC_IFN_KUNIT void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 {
 	struct vblank_control_work *vblank_work =
 		container_of(work, struct vblank_control_work, work);
@@ -251,7 +251,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *w
 EXPORT_IF_KUNIT(amdgpu_dm_crtc_vblank_control_worker);
 
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY) || IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
-VISIBLE_IF_KUNIT int amdgpu_dm_crtc_set_vline0_irq(struct drm_crtc *crtc, int irq_type,
+STATIC_IFN_KUNIT int amdgpu_dm_crtc_set_vline0_irq(struct drm_crtc *crtc, int irq_type,
 						   bool enable)
 {
 	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
@@ -424,7 +424,7 @@ void amdgpu_dm_crtc_disable_vblank(struct drm_crtc *crtc)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_crtc_disable_vblank);
 
-VISIBLE_IF_KUNIT void amdgpu_dm_crtc_destroy_state(struct drm_crtc *crtc,
+STATIC_IFN_KUNIT void amdgpu_dm_crtc_destroy_state(struct drm_crtc *crtc,
 				  struct drm_crtc_state *state)
 {
 	struct dm_crtc_state *cur = to_dm_crtc_state(state);
@@ -441,7 +441,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_crtc_destroy_state(struct drm_crtc *crtc,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_crtc_destroy_state);
 
-VISIBLE_IF_KUNIT struct drm_crtc_state *amdgpu_dm_crtc_duplicate_state(struct drm_crtc *crtc)
+STATIC_IFN_KUNIT struct drm_crtc_state *amdgpu_dm_crtc_duplicate_state(struct drm_crtc *crtc)
 {
 	struct dm_crtc_state *state, *cur;
 
@@ -478,7 +478,7 @@ VISIBLE_IF_KUNIT struct drm_crtc_state *amdgpu_dm_crtc_duplicate_state(struct dr
 }
 EXPORT_IF_KUNIT(amdgpu_dm_crtc_duplicate_state);
 
-VISIBLE_IF_KUNIT void amdgpu_dm_crtc_destroy(struct drm_crtc *crtc)
+STATIC_IFN_KUNIT void amdgpu_dm_crtc_destroy(struct drm_crtc *crtc)
 {
 	/*
 	 * ISM workers are intentionally quiesced by amdgpu_dm_ism_disable()
@@ -491,7 +491,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_crtc_destroy(struct drm_crtc *crtc)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_crtc_destroy);
 
-VISIBLE_IF_KUNIT struct drm_crtc_state *amdgpu_dm_crtc_create_state(struct drm_crtc *crtc)
+STATIC_IFN_KUNIT struct drm_crtc_state *amdgpu_dm_crtc_create_state(struct drm_crtc *crtc)
 {
 	struct dm_crtc_state *state;
 
@@ -506,7 +506,7 @@ VISIBLE_IF_KUNIT struct drm_crtc_state *amdgpu_dm_crtc_create_state(struct drm_c
 EXPORT_IF_KUNIT(amdgpu_dm_crtc_create_state);
 
 #ifdef CONFIG_DEBUG_FS
-VISIBLE_IF_KUNIT int amdgpu_dm_crtc_late_register(struct drm_crtc *crtc)
+STATIC_IFN_KUNIT int amdgpu_dm_crtc_late_register(struct drm_crtc *crtc)
 {
 	crtc_debugfs_init(crtc);
 
@@ -607,7 +607,7 @@ static void amdgpu_dm_crtc_helper_disable(struct drm_crtc *crtc)
 {
 }
 
-VISIBLE_IF_KUNIT int amdgpu_dm_crtc_count_crtc_active_planes(struct drm_crtc_state *new_crtc_state)
+STATIC_IFN_KUNIT int amdgpu_dm_crtc_count_crtc_active_planes(struct drm_crtc_state *new_crtc_state)
 {
 	struct drm_atomic_commit *state = new_crtc_state->state;
 	struct drm_plane *plane;
@@ -640,7 +640,7 @@ VISIBLE_IF_KUNIT int amdgpu_dm_crtc_count_crtc_active_planes(struct drm_crtc_sta
 }
 EXPORT_IF_KUNIT(amdgpu_dm_crtc_count_crtc_active_planes);
 
-VISIBLE_IF_KUNIT void amdgpu_dm_crtc_update_crtc_active_planes(struct drm_crtc *crtc,
+STATIC_IFN_KUNIT void amdgpu_dm_crtc_update_crtc_active_planes(struct drm_crtc *crtc,
 						     struct drm_crtc_state *new_crtc_state)
 {
 	struct dm_crtc_state *dm_new_crtc_state =
@@ -656,7 +656,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_crtc_update_crtc_active_planes(struct drm_crtc *
 }
 EXPORT_IF_KUNIT(amdgpu_dm_crtc_update_crtc_active_planes);
 
-VISIBLE_IF_KUNIT bool amdgpu_dm_crtc_helper_mode_fixup(struct drm_crtc *crtc,
+STATIC_IFN_KUNIT bool amdgpu_dm_crtc_helper_mode_fixup(struct drm_crtc *crtc,
 					       const struct drm_display_mode *mode,
 					       struct drm_display_mode *adjusted_mode)
 {
@@ -664,7 +664,7 @@ VISIBLE_IF_KUNIT bool amdgpu_dm_crtc_helper_mode_fixup(struct drm_crtc *crtc,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_crtc_helper_mode_fixup);
 
-VISIBLE_IF_KUNIT int amdgpu_dm_crtc_helper_atomic_check(struct drm_crtc *crtc,
+STATIC_IFN_KUNIT int amdgpu_dm_crtc_helper_atomic_check(struct drm_crtc *crtc,
 					      struct drm_atomic_commit *state)
 {
 	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
index 9784712f7f56..8204ad4018e6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
@@ -41,7 +41,7 @@
 #include "amdgpu_dm_cursor.h"
 #include "dm_helpers.h"
 
-VISIBLE_IF_KUNIT int dm_check_cursor_fb(struct amdgpu_crtc *new_acrtc,
+STATIC_IFN_KUNIT int dm_check_cursor_fb(struct amdgpu_crtc *new_acrtc,
 				       struct drm_plane_state *new_plane_state,
 				       struct drm_framebuffer *fb)
 {
@@ -171,7 +171,7 @@ bool amdgpu_dm_should_update_native_cursor(struct drm_atomic_commit *state,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_should_update_native_cursor);
 
-VISIBLE_IF_KUNIT void dm_get_oriented_plane_size(struct drm_plane_state *plane_state,
+STATIC_IFN_KUNIT void dm_get_oriented_plane_size(struct drm_plane_state *plane_state,
 					 int *src_w, int *src_h)
 {
 	switch (plane_state->rotation & DRM_MODE_ROTATE_MASK) {
@@ -190,7 +190,7 @@ VISIBLE_IF_KUNIT void dm_get_oriented_plane_size(struct drm_plane_state *plane_s
 }
 EXPORT_IF_KUNIT(dm_get_oriented_plane_size);
 
-VISIBLE_IF_KUNIT void
+STATIC_IFN_KUNIT void
 dm_get_plane_scale(struct drm_plane_state *plane_state,
 		   int *out_plane_scale_w, int *out_plane_scale_h)
 {
@@ -231,7 +231,7 @@ EXPORT_IF_KUNIT(dm_get_plane_scale);
  *
  * Return: true if the pipeline modifies pixels, false otherwise.
  */
-VISIBLE_IF_KUNIT bool dm_plane_color_pipeline_active(struct drm_atomic_commit *state,
+STATIC_IFN_KUNIT bool dm_plane_color_pipeline_active(struct drm_atomic_commit *state,
 						     struct drm_plane *plane,
 						     bool use_old)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
index 1bc37b996d91..f4b0ced7d391 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
@@ -411,7 +411,7 @@ dm_dmub_send_vbios_gpint_command(struct amdgpu_device *adev,
 	return DMUB_STATUS_TIMEOUT;
 }
 
-VISIBLE_IF_KUNIT void *dm_dmub_get_vbios_bounding_box(struct amdgpu_device *adev)
+STATIC_IFN_KUNIT void *dm_dmub_get_vbios_bounding_box(struct amdgpu_device *adev)
 {
 	void *bb;
 	long long addr;
@@ -493,7 +493,7 @@ enum dmub_ips_disable_type dm_get_default_ips_mode(
 }
 EXPORT_IF_KUNIT(dm_get_default_ips_mode);
 
-VISIBLE_IF_KUNIT uint32_t amdgpu_dm_dmub_reg_read(void *ctx, uint32_t address)
+STATIC_IFN_KUNIT uint32_t amdgpu_dm_dmub_reg_read(void *ctx, uint32_t address)
 {
 	struct amdgpu_device *adev = ctx;
 
@@ -501,7 +501,7 @@ VISIBLE_IF_KUNIT uint32_t amdgpu_dm_dmub_reg_read(void *ctx, uint32_t address)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_dmub_reg_read);
 
-VISIBLE_IF_KUNIT void amdgpu_dm_dmub_reg_write(void *ctx, uint32_t address,
+STATIC_IFN_KUNIT void amdgpu_dm_dmub_reg_write(void *ctx, uint32_t address,
 					       uint32_t value)
 {
 	struct amdgpu_device *adev = ctx;
@@ -869,7 +869,7 @@ int amdgpu_dm_process_dmub_aux_transfer_sync(
 }
 EXPORT_IF_KUNIT(amdgpu_dm_process_dmub_aux_transfer_sync);
 
-VISIBLE_IF_KUNIT void abort_fused_io(
+STATIC_IFN_KUNIT void abort_fused_io(
 		struct dc_context *ctx,
 		const struct dmub_cmd_fused_request *request
 )
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 20c1ce8cda44..47cbc826ed45 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -38,8 +38,7 @@
  */
 #define PSP_SRM_VERSION_MAX 0xFFFF
 
-VISIBLE_IF_KUNIT
-bool lp_write_i2c(void *handle, uint32_t address, const uint8_t *data, uint32_t size)
+STATIC_IFN_KUNIT bool lp_write_i2c(void *handle, uint32_t address, const uint8_t *data, uint32_t size)
 {
 	struct dc_link *link = handle;
 	struct i2c_payload i2c_payloads[] = {{true, address, size, (void *)data} };
@@ -50,8 +49,7 @@ bool lp_write_i2c(void *handle, uint32_t address, const uint8_t *data, uint32_t
 }
 EXPORT_IF_KUNIT(lp_write_i2c);
 
-VISIBLE_IF_KUNIT
-bool lp_read_i2c(void *handle, uint32_t address, uint8_t offset, uint8_t *data, uint32_t size)
+STATIC_IFN_KUNIT bool lp_read_i2c(void *handle, uint32_t address, uint8_t offset, uint8_t *data, uint32_t size)
 {
 	struct dc_link *link = handle;
 
@@ -64,8 +62,7 @@ bool lp_read_i2c(void *handle, uint32_t address, uint8_t offset, uint8_t *data,
 }
 EXPORT_IF_KUNIT(lp_read_i2c);
 
-VISIBLE_IF_KUNIT
-bool lp_write_dpcd(void *handle, uint32_t address, const uint8_t *data, uint32_t size)
+STATIC_IFN_KUNIT bool lp_write_dpcd(void *handle, uint32_t address, const uint8_t *data, uint32_t size)
 {
 	struct dc_link *link = handle;
 
@@ -73,7 +70,7 @@ bool lp_write_dpcd(void *handle, uint32_t address, const uint8_t *data, uint32_t
 }
 EXPORT_IF_KUNIT(lp_write_dpcd);
 
-VISIBLE_IF_KUNIT bool lp_read_dpcd(void *handle, uint32_t address, uint8_t *data, uint32_t size)
+STATIC_IFN_KUNIT bool lp_read_dpcd(void *handle, uint32_t address, uint8_t *data, uint32_t size)
 {
 	struct dc_link *link = handle;
 
@@ -81,7 +78,7 @@ VISIBLE_IF_KUNIT bool lp_read_dpcd(void *handle, uint32_t address, uint8_t *data
 }
 EXPORT_IF_KUNIT(lp_read_dpcd);
 
-VISIBLE_IF_KUNIT bool lp_atomic_write_poll_read_i2c(
+STATIC_IFN_KUNIT bool lp_atomic_write_poll_read_i2c(
 						void *handle,
 						const struct mod_hdcp_atomic_op_i2c *write,
 						const struct mod_hdcp_atomic_op_i2c *poll,
@@ -96,7 +93,7 @@ VISIBLE_IF_KUNIT bool lp_atomic_write_poll_read_i2c(
 }
 EXPORT_IF_KUNIT(lp_atomic_write_poll_read_i2c);
 
-VISIBLE_IF_KUNIT bool lp_atomic_write_poll_read_aux(
+STATIC_IFN_KUNIT bool lp_atomic_write_poll_read_aux(
 						void *handle,
 						const struct mod_hdcp_atomic_op_aux *write,
 						const struct mod_hdcp_atomic_op_aux *poll,
@@ -111,7 +108,7 @@ VISIBLE_IF_KUNIT bool lp_atomic_write_poll_read_aux(
 }
 EXPORT_IF_KUNIT(lp_atomic_write_poll_read_aux);
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 uint8_t *psp_get_srm(struct psp_context *psp, uint32_t *srm_version, uint32_t *srm_size)
 {
 	struct ta_hdcp_shared_memory *hdcp_cmd;
@@ -137,7 +134,7 @@ uint8_t *psp_get_srm(struct psp_context *psp, uint32_t *srm_version, uint32_t *s
 }
 EXPORT_IF_KUNIT(psp_get_srm);
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 int psp_set_srm(struct psp_context *psp,
 		       u8 *srm, uint32_t srm_size, uint32_t *srm_version)
 {
@@ -167,7 +164,7 @@ int psp_set_srm(struct psp_context *psp,
 }
 EXPORT_IF_KUNIT(psp_set_srm);
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 void process_output(struct hdcp_workqueue *hdcp_work)
 {
 	struct mod_hdcp_output output = hdcp_work->output;
@@ -190,7 +187,7 @@ void process_output(struct hdcp_workqueue *hdcp_work)
 }
 EXPORT_IF_KUNIT(process_output);
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 bool hdcp_get_content_protection_from_status(
 	unsigned int hdcp_content_type,
 	enum mod_hdcp_encryption_status encryption_status,
@@ -217,7 +214,7 @@ bool hdcp_get_content_protection_from_status(
 }
 EXPORT_IF_KUNIT(hdcp_get_content_protection_from_status);
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 void hdcp_get_link_display_adjustments(
 	bool enable_encryption,
 	u8 content_type,
@@ -254,7 +251,7 @@ void hdcp_get_link_display_adjustments(
 }
 EXPORT_IF_KUNIT(hdcp_get_link_display_adjustments);
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 void link_lock(struct hdcp_workqueue *work, bool lock)
 {
 	int i = 0;
@@ -268,7 +265,7 @@ void link_lock(struct hdcp_workqueue *work, bool lock)
 }
 EXPORT_IF_KUNIT(link_lock);
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 void hdcp_update_display_encryption_control(struct hdcp_workqueue *hdcp_work,
 					    struct hdcp_workqueue *hdcp_w,
 					    unsigned int conn_index,
@@ -324,7 +321,7 @@ void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
 }
 EXPORT_IF_KUNIT(hdcp_update_display);
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 void hdcp_remove_display(struct hdcp_workqueue *hdcp_work,
 				unsigned int link_index,
 			 struct amdgpu_dm_connector *aconnector)
@@ -389,7 +386,7 @@ void hdcp_handle_cpirq(struct hdcp_workqueue *hdcp_work, unsigned int link_index
 }
 EXPORT_IF_KUNIT(hdcp_handle_cpirq);
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 void event_callback(struct work_struct *work)
 {
 	struct hdcp_workqueue *hdcp_work;
@@ -408,7 +405,7 @@ void event_callback(struct work_struct *work)
 }
 EXPORT_IF_KUNIT(event_callback);
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 void event_property_update(struct work_struct *work)
 {
 	struct hdcp_workqueue *hdcp_work = container_of(work, struct hdcp_workqueue,
@@ -470,7 +467,7 @@ void event_property_update(struct work_struct *work)
 }
 EXPORT_IF_KUNIT(event_property_update);
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 void event_property_validate(struct work_struct *work)
 {
 	struct hdcp_workqueue *hdcp_work =
@@ -522,7 +519,7 @@ void event_property_validate(struct work_struct *work)
 }
 EXPORT_IF_KUNIT(event_property_validate);
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 void event_watchdog_timer(struct work_struct *work)
 {
 	struct hdcp_workqueue *hdcp_work;
@@ -543,7 +540,7 @@ void event_watchdog_timer(struct work_struct *work)
 }
 EXPORT_IF_KUNIT(event_watchdog_timer);
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 void event_cpirq(struct work_struct *work)
 {
 	struct hdcp_workqueue *hdcp_work;
@@ -575,7 +572,7 @@ void hdcp_destroy(struct kobject *kobj, struct hdcp_workqueue *hdcp_work)
 }
 EXPORT_IF_KUNIT(hdcp_destroy);
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 bool enable_assr(void *handle, struct dc_link *link)
 {
 	struct hdcp_workqueue *hdcp_work = handle;
@@ -611,7 +608,7 @@ bool enable_assr(void *handle, struct dc_link *link)
 }
 EXPORT_IF_KUNIT(enable_assr);
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 void update_config(void *handle, struct cp_psp_stream_config *config)
 {
 	struct hdcp_workqueue *hdcp_work = handle;
@@ -748,7 +745,7 @@ EXPORT_IF_KUNIT(update_config);
  *	-if we try to "1. SET" a newer version and PSP rejects it. That means the format is
  *	incorrect/corrupted and we should correct our SRM by getting it from PSP
  */
-VISIBLE_IF_KUNIT ssize_t srm_data_write(struct file *filp, struct kobject *kobj,
+STATIC_IFN_KUNIT ssize_t srm_data_write(struct file *filp, struct kobject *kobj,
 			      const struct bin_attribute *bin_attr, char *buffer,
 			      loff_t pos, size_t count)
 {
@@ -773,7 +770,7 @@ VISIBLE_IF_KUNIT ssize_t srm_data_write(struct file *filp, struct kobject *kobj,
 }
 EXPORT_IF_KUNIT(srm_data_write);
 
-VISIBLE_IF_KUNIT ssize_t srm_data_read(struct file *filp, struct kobject *kobj,
+STATIC_IFN_KUNIT ssize_t srm_data_read(struct file *filp, struct kobject *kobj,
 			     const struct bin_attribute *bin_attr, char *buffer,
 			     loff_t pos, size_t count)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 091cde038d21..3217aa82bea2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -89,7 +89,7 @@ union vcp_reply {
 	unsigned char raw[11];
 };
 
-VISIBLE_IF_KUNIT u32 edid_extract_panel_id(struct edid *edid)
+STATIC_IFN_KUNIT u32 edid_extract_panel_id(struct edid *edid)
 {
 	return (u32)edid->mfg_id[0] << 24   |
 	       (u32)edid->mfg_id[1] << 16   |
@@ -97,7 +97,7 @@ VISIBLE_IF_KUNIT u32 edid_extract_panel_id(struct edid *edid)
 }
 EXPORT_IF_KUNIT(edid_extract_panel_id);
 
-VISIBLE_IF_KUNIT void apply_edid_quirks(struct dc_link *link, struct edid *edid,
+STATIC_IFN_KUNIT void apply_edid_quirks(struct dc_link *link, struct edid *edid,
 			      struct dc_edid_caps *edid_caps)
 {
 	struct amdgpu_dm_connector *aconnector = link->priv;
@@ -277,7 +277,7 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 }
 EXPORT_IF_KUNIT(dm_helpers_parse_edid_caps);
 
-VISIBLE_IF_KUNIT void
+STATIC_IFN_KUNIT void
 fill_dc_mst_payload_table_from_drm(struct dc_link *link,
 				   bool enable,
 				   struct drm_dp_mst_atomic_payload *target_payload,
@@ -335,7 +335,7 @@ void dm_helpers_dp_update_branch_info(
 {}
 EXPORT_IF_KUNIT(dm_helpers_dp_update_branch_info);
 
-VISIBLE_IF_KUNIT void dm_helpers_construct_old_payload(
+STATIC_IFN_KUNIT void dm_helpers_construct_old_payload(
 			struct drm_dp_mst_topology_mgr *mgr,
 			struct drm_dp_mst_topology_state *mst_state,
 			struct drm_dp_mst_atomic_payload *new_payload,
@@ -768,7 +768,7 @@ bool dm_helpers_execute_fused_io(
 }
 EXPORT_IF_KUNIT(dm_helpers_execute_fused_io);
 
-VISIBLE_IF_KUNIT bool execute_synaptics_rc_command(struct drm_dp_aux *aux,
+STATIC_IFN_KUNIT bool execute_synaptics_rc_command(struct drm_dp_aux *aux,
 		bool is_write_cmd,
 		unsigned char cmd,
 		unsigned int length,
@@ -842,7 +842,7 @@ VISIBLE_IF_KUNIT bool execute_synaptics_rc_command(struct drm_dp_aux *aux,
 }
 EXPORT_IF_KUNIT(execute_synaptics_rc_command);
 
-VISIBLE_IF_KUNIT void apply_synaptics_fifo_reset_wa(struct drm_dp_aux *aux)
+STATIC_IFN_KUNIT void apply_synaptics_fifo_reset_wa(struct drm_dp_aux *aux)
 {
 	unsigned char data[16] = {0};
 
@@ -911,7 +911,7 @@ EXPORT_IF_KUNIT(apply_synaptics_fifo_reset_wa);
 /* MST Dock */
 static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
 
-VISIBLE_IF_KUNIT uint8_t write_dsc_enable_synaptics_non_virtual_dpcd_mst(
+STATIC_IFN_KUNIT uint8_t write_dsc_enable_synaptics_non_virtual_dpcd_mst(
 		struct drm_dp_aux *aux,
 		const struct dc_stream_state *stream,
 		bool enable)
@@ -1071,7 +1071,7 @@ bool dm_helpers_is_dp_sink_present(struct dc_link *link)
 }
 EXPORT_IF_KUNIT(dm_helpers_is_dp_sink_present);
 
-VISIBLE_IF_KUNIT int
+STATIC_IFN_KUNIT int
 dm_helpers_probe_acpi_edid(void *data, u8 *buf, unsigned int block, size_t len)
 {
 	struct drm_connector *connector = data;
@@ -1111,7 +1111,7 @@ dm_helpers_probe_acpi_edid(void *data, u8 *buf, unsigned int block, size_t len)
 }
 EXPORT_IF_KUNIT(dm_helpers_probe_acpi_edid);
 
-VISIBLE_IF_KUNIT const struct drm_edid *
+STATIC_IFN_KUNIT const struct drm_edid *
 dm_helpers_read_acpi_edid(struct amdgpu_dm_connector *aconnector)
 {
 	struct drm_connector *connector = &aconnector->base;
@@ -1134,7 +1134,7 @@ dm_helpers_read_acpi_edid(struct amdgpu_dm_connector *aconnector)
 }
 EXPORT_IF_KUNIT(dm_helpers_read_acpi_edid);
 
-VISIBLE_IF_KUNIT const struct drm_edid *
+STATIC_IFN_KUNIT const struct drm_edid *
 dm_helpers_read_vbios_hardcoded_edid(struct dc_link *link, struct amdgpu_dm_connector *aconnector)
 {
 	struct dc_bios *bios = link->ctx->dc_bios;
@@ -1174,7 +1174,7 @@ dm_helpers_read_vbios_hardcoded_edid(struct dc_link *link, struct amdgpu_dm_conn
 }
 EXPORT_IF_KUNIT(dm_helpers_read_vbios_hardcoded_edid);
 
-VISIBLE_IF_KUNIT uint8_t get_max_frl_rate(uint8_t max_lanes, uint8_t max_rate_per_lane)
+STATIC_IFN_KUNIT uint8_t get_max_frl_rate(uint8_t max_lanes, uint8_t max_rate_per_lane)
 {
 	uint8_t max_frl_rate;
 
@@ -1197,7 +1197,7 @@ VISIBLE_IF_KUNIT uint8_t get_max_frl_rate(uint8_t max_lanes, uint8_t max_rate_pe
 }
 EXPORT_IF_KUNIT(get_max_frl_rate);
 
-VISIBLE_IF_KUNIT uint8_t get_dsc_max_slices(uint8_t max_slices, int clk_per_slice)
+STATIC_IFN_KUNIT uint8_t get_dsc_max_slices(uint8_t max_slices, int clk_per_slice)
 {
 	uint8_t dsc_max_slices;
 
@@ -1675,7 +1675,7 @@ void dm_helpers_dp_mst_update_branch_bandwidth(
 }
 EXPORT_IF_KUNIT(dm_helpers_dp_mst_update_branch_bandwidth);
 
-VISIBLE_IF_KUNIT const uint32_t dm_freesync_pcon_whitelist[] = {
+STATIC_IFN_KUNIT const uint32_t dm_freesync_pcon_whitelist[] = {
 	DP_BRANCH_DEVICE_ID_0060AD,
 	DP_BRANCH_DEVICE_ID_00E04C,
 	DP_BRANCH_DEVICE_ID_90CC24,
@@ -1684,13 +1684,13 @@ VISIBLE_IF_KUNIT const uint32_t dm_freesync_pcon_whitelist[] = {
 };
 EXPORT_IF_KUNIT(dm_freesync_pcon_whitelist);
 
-VISIBLE_IF_KUNIT uint32_t dm_freesync_pcon_whitelist_count(void)
+STATIC_IFN_KUNIT uint32_t dm_freesync_pcon_whitelist_count(void)
 {
 	return ARRAY_SIZE(dm_freesync_pcon_whitelist);
 }
 EXPORT_IF_KUNIT(dm_freesync_pcon_whitelist_count);
 
-VISIBLE_IF_KUNIT bool dm_is_freesync_pcon_whitelist(const uint32_t branch_dev_id)
+STATIC_IFN_KUNIT bool dm_is_freesync_pcon_whitelist(const uint32_t branch_dev_id)
 {
 	u32 i;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 94d0f2d6eb90..c3ed63843202 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -609,7 +609,7 @@ EXPORT_IF_KUNIT(amdgpu_dm_irq_resume_late);
  * amdgpu_dm_irq_schedule_work - schedule all work items registered for the
  * "irq_source".
  */
-VISIBLE_IF_KUNIT void amdgpu_dm_irq_schedule_work(struct amdgpu_device *adev,
+STATIC_IFN_KUNIT void amdgpu_dm_irq_schedule_work(struct amdgpu_device *adev,
 					enum dc_irq_source irq_source)
 {
 	struct  list_head *handler_list = &adev->dm.irq_handler_list_low_tab[irq_source];
@@ -673,7 +673,7 @@ EXPORT_IF_KUNIT(amdgpu_dm_irq_schedule_work);
  * amdgpu_dm_irq_immediate_work
  * Callback high irq work immediately, don't send to work queue
  */
-VISIBLE_IF_KUNIT void amdgpu_dm_irq_immediate_work(struct amdgpu_device *adev,
+STATIC_IFN_KUNIT void amdgpu_dm_irq_immediate_work(struct amdgpu_device *adev,
 					 enum dc_irq_source irq_source)
 {
 	struct amdgpu_dm_irq_handler_data *handler_data;
@@ -720,7 +720,7 @@ EXPORT_IF_KUNIT(amdgpu_dm_irq_ack);
  * Calls all registered high irq work immediately, and schedules work for low
  * irq. The DM IRQ table is used to find the corresponding handlers.
  */
-VISIBLE_IF_KUNIT int amdgpu_dm_irq_handler(struct amdgpu_device *adev,
+STATIC_IFN_KUNIT int amdgpu_dm_irq_handler(struct amdgpu_device *adev,
 				 struct amdgpu_irq_src *source,
 				 struct amdgpu_iv_entry *entry)
 {
@@ -747,7 +747,7 @@ VISIBLE_IF_KUNIT int amdgpu_dm_irq_handler(struct amdgpu_device *adev,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_irq_handler);
 
-VISIBLE_IF_KUNIT enum dc_irq_source amdgpu_dm_hpd_to_dal_irq_source(unsigned int type)
+STATIC_IFN_KUNIT enum dc_irq_source amdgpu_dm_hpd_to_dal_irq_source(unsigned int type)
 {
 	switch (type) {
 	case AMDGPU_HPD_1:
@@ -768,7 +768,7 @@ VISIBLE_IF_KUNIT enum dc_irq_source amdgpu_dm_hpd_to_dal_irq_source(unsigned int
 }
 EXPORT_IF_KUNIT(amdgpu_dm_hpd_to_dal_irq_source);
 
-VISIBLE_IF_KUNIT int amdgpu_dm_set_hpd_irq_state(struct amdgpu_device *adev,
+STATIC_IFN_KUNIT int amdgpu_dm_set_hpd_irq_state(struct amdgpu_device *adev,
 				       struct amdgpu_irq_src *source,
 				       unsigned int type,
 				       enum amdgpu_interrupt_state state)
@@ -815,7 +815,7 @@ static inline int dm_irq_state(struct amdgpu_device *adev,
 	return 0;
 }
 
-VISIBLE_IF_KUNIT int amdgpu_dm_set_pflip_irq_state(struct amdgpu_device *adev,
+STATIC_IFN_KUNIT int amdgpu_dm_set_pflip_irq_state(struct amdgpu_device *adev,
 					 struct amdgpu_irq_src *source,
 					 unsigned int crtc_id,
 					 enum amdgpu_interrupt_state state)
@@ -830,7 +830,7 @@ VISIBLE_IF_KUNIT int amdgpu_dm_set_pflip_irq_state(struct amdgpu_device *adev,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_set_pflip_irq_state);
 
-VISIBLE_IF_KUNIT int amdgpu_dm_set_crtc_irq_state(struct amdgpu_device *adev,
+STATIC_IFN_KUNIT int amdgpu_dm_set_crtc_irq_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
 					unsigned int crtc_id,
 					enum amdgpu_interrupt_state state)
@@ -845,7 +845,7 @@ VISIBLE_IF_KUNIT int amdgpu_dm_set_crtc_irq_state(struct amdgpu_device *adev,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_set_crtc_irq_state);
 
-VISIBLE_IF_KUNIT int amdgpu_dm_set_vline0_irq_state(struct amdgpu_device *adev,
+STATIC_IFN_KUNIT int amdgpu_dm_set_vline0_irq_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
 					unsigned int crtc_id,
 					enum amdgpu_interrupt_state state)
@@ -860,7 +860,7 @@ VISIBLE_IF_KUNIT int amdgpu_dm_set_vline0_irq_state(struct amdgpu_device *adev,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_set_vline0_irq_state);
 
-VISIBLE_IF_KUNIT int amdgpu_dm_set_dmub_outbox_irq_state(struct amdgpu_device *adev,
+STATIC_IFN_KUNIT int amdgpu_dm_set_dmub_outbox_irq_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
 					unsigned int crtc_id,
 					enum amdgpu_interrupt_state state)
@@ -873,7 +873,7 @@ VISIBLE_IF_KUNIT int amdgpu_dm_set_dmub_outbox_irq_state(struct amdgpu_device *a
 }
 EXPORT_IF_KUNIT(amdgpu_dm_set_dmub_outbox_irq_state);
 
-VISIBLE_IF_KUNIT int amdgpu_dm_set_vupdate_irq_state(struct amdgpu_device *adev,
+STATIC_IFN_KUNIT int amdgpu_dm_set_vupdate_irq_state(struct amdgpu_device *adev,
 					   struct amdgpu_irq_src *source,
 					   unsigned int crtc_id,
 					   enum amdgpu_interrupt_state state)
@@ -888,7 +888,7 @@ VISIBLE_IF_KUNIT int amdgpu_dm_set_vupdate_irq_state(struct amdgpu_device *adev,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_set_vupdate_irq_state);
 
-VISIBLE_IF_KUNIT int amdgpu_dm_set_dmub_trace_irq_state(struct amdgpu_device *adev,
+STATIC_IFN_KUNIT int amdgpu_dm_set_dmub_trace_irq_state(struct amdgpu_device *adev,
 					   struct amdgpu_irq_src *source,
 					   unsigned int type,
 					   enum amdgpu_interrupt_state state)
@@ -1116,7 +1116,7 @@ static void force_connector_state(
 	mutex_unlock(&aconnector->hpd_lock);
 }
 
-VISIBLE_IF_KUNIT void dm_handle_hpd_rx_offload_work(struct work_struct *work)
+STATIC_IFN_KUNIT void dm_handle_hpd_rx_offload_work(struct work_struct *work)
 {
 	struct hpd_rx_irq_offload_work *offload_work;
 	struct amdgpu_dm_connector *aconnector;
@@ -1259,7 +1259,7 @@ void amdgpu_dm_hpd_rx_irq_work_suspend(struct amdgpu_display_manager *dm)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_hpd_rx_irq_work_suspend);
 
-VISIBLE_IF_KUNIT bool are_sinks_equal(const struct dc_sink *sink1, const struct dc_sink *sink2)
+STATIC_IFN_KUNIT bool are_sinks_equal(const struct dc_sink *sink1, const struct dc_sink *sink2)
 {
 	if (!sink1 || !sink2)
 		return false;
@@ -1353,7 +1353,7 @@ void amdgpu_dm_hdmi_hpd_debounce_work(struct work_struct *work)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_hdmi_hpd_debounce_work);
 
-VISIBLE_IF_KUNIT void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector,
+STATIC_IFN_KUNIT void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector,
 				  enum dc_detect_reason reason)
 {
 	struct drm_connector *connector = &aconnector->base;
@@ -1453,7 +1453,7 @@ VISIBLE_IF_KUNIT void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnect
 }
 EXPORT_IF_KUNIT(handle_hpd_irq_helper);
 
-VISIBLE_IF_KUNIT void handle_hpd_irq(void *param)
+STATIC_IFN_KUNIT void handle_hpd_irq(void *param)
 {
 	struct amdgpu_dm_connector *aconnector = (struct amdgpu_dm_connector *)param;
 
@@ -1462,10 +1462,8 @@ VISIBLE_IF_KUNIT void handle_hpd_irq(void *param)
 }
 EXPORT_IF_KUNIT(handle_hpd_irq);
 
-VISIBLE_IF_KUNIT void
-schedule_hpd_rx_offload_work(struct amdgpu_device *adev,
-			     struct hpd_rx_irq_offload_work_queue *offload_wq,
-			     union hpd_irq_data hpd_irq_data)
+STATIC_IFN_KUNIT void schedule_hpd_rx_offload_work(struct amdgpu_device *adev, struct hpd_rx_irq_offload_work_queue *offload_wq,
+							union hpd_irq_data hpd_irq_data)
 {
 	struct hpd_rx_irq_offload_work *offload_work = kzalloc_obj(*offload_work);
 
@@ -1484,7 +1482,7 @@ schedule_hpd_rx_offload_work(struct amdgpu_device *adev,
 }
 EXPORT_IF_KUNIT(schedule_hpd_rx_offload_work);
 
-VISIBLE_IF_KUNIT void handle_hpd_rx_irq(void *param)
+STATIC_IFN_KUNIT void handle_hpd_rx_irq(void *param)
 {
 	struct amdgpu_dm_connector *aconnector = (struct amdgpu_dm_connector *)param;
 	struct drm_connector *connector = &aconnector->base;
@@ -1627,7 +1625,7 @@ EXPORT_IF_KUNIT(handle_hpd_rx_irq);
  * Dmub Hpd interrupt processing callback. Gets displayindex through the
  * ink index and calls helper to do the processing.
  */
-VISIBLE_IF_KUNIT void dmub_hpd_callback(struct amdgpu_device *adev,
+STATIC_IFN_KUNIT void dmub_hpd_callback(struct amdgpu_device *adev,
 			      struct dmub_notification *notify)
 {
 	struct amdgpu_dm_connector *aconnector;
@@ -1703,7 +1701,7 @@ EXPORT_IF_KUNIT(dmub_hpd_callback);
  * HPD sense changes can occur during low power states and need to be
  * notified from firmware to driver.
  */
-VISIBLE_IF_KUNIT void dmub_hpd_sense_callback(struct amdgpu_device *adev,
+STATIC_IFN_KUNIT void dmub_hpd_sense_callback(struct amdgpu_device *adev,
 			      struct dmub_notification *notify)
 {
 	drm_dbg_driver(adev_to_drm(adev), "DMUB HPD SENSE callback.\n");
@@ -1822,7 +1820,7 @@ EXPORT_IF_KUNIT(amdgpu_dm_get_crtc_by_otg_inst);
  * Handles the pageflip interrupt by notifying all interested parties
  * that the pageflip has been completed.
  */
-VISIBLE_IF_KUNIT void dm_pflip_high_irq(void *interrupt_params)
+STATIC_IFN_KUNIT void dm_pflip_high_irq(void *interrupt_params)
 {
 	struct amdgpu_crtc *amdgpu_crtc;
 	struct common_irq_params *irq_params = interrupt_params;
@@ -1920,7 +1918,7 @@ VISIBLE_IF_KUNIT void dm_pflip_high_irq(void *interrupt_params)
 }
 EXPORT_IF_KUNIT(dm_pflip_high_irq);
 
-VISIBLE_IF_KUNIT void dm_handle_vmin_vmax_update(struct work_struct *offload_work)
+STATIC_IFN_KUNIT void dm_handle_vmin_vmax_update(struct work_struct *offload_work)
 {
 	struct vupdate_offload_work *work = container_of(offload_work, struct vupdate_offload_work, work);
 	struct amdgpu_device *adev = work->adev;
@@ -2096,7 +2094,7 @@ static void dm_crtc_high_irq_handler(struct amdgpu_device *adev,
 	spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
 }
 
-VISIBLE_IF_KUNIT void dm_vupdate_high_irq(void *interrupt_params)
+STATIC_IFN_KUNIT void dm_vupdate_high_irq(void *interrupt_params)
 {
 	struct common_irq_params *irq_params = interrupt_params;
 	struct amdgpu_device *adev = irq_params->adev;
@@ -2182,7 +2180,7 @@ EXPORT_IF_KUNIT(dm_vupdate_high_irq);
  * Used on DCE (VLINE0, set to vblank start). On DCN the equivalent handling is
  * driven by VUPDATE_NO_LOCK in dm_vupdate_high_irq().
  */
-VISIBLE_IF_KUNIT void dm_crtc_high_irq(void *interrupt_params)
+STATIC_IFN_KUNIT void dm_crtc_high_irq(void *interrupt_params)
 {
 	struct common_irq_params *irq_params = interrupt_params;
 	struct amdgpu_device *adev = irq_params->adev;
@@ -2219,7 +2217,7 @@ static void dm_dcn_vertical_interrupt0_high_irq(void *interrupt_params)
 }
 #endif /* CONFIG_DRM_AMD_SECURE_DISPLAY */
 
-VISIBLE_IF_KUNIT void dm_handle_hpd_work(struct work_struct *work)
+STATIC_IFN_KUNIT void dm_handle_hpd_work(struct work_struct *work)
 {
 	struct dmub_hpd_work *dmub_hpd_wrk;
 
@@ -2241,7 +2239,7 @@ VISIBLE_IF_KUNIT void dm_handle_hpd_work(struct work_struct *work)
 }
 EXPORT_IF_KUNIT(dm_handle_hpd_work);
 
-VISIBLE_IF_KUNIT const char *dmub_notification_type_str(enum dmub_notification_type e)
+STATIC_IFN_KUNIT const char *dmub_notification_type_str(enum dmub_notification_type e)
 {
 	switch (e) {
 	case DMUB_NOTIFICATION_NO_DATA:
@@ -2274,7 +2272,7 @@ EXPORT_IF_KUNIT(dmub_notification_type_str);
  * Handles the Outbox Interrupt
  * event handler.
  */
-VISIBLE_IF_KUNIT void dm_dmub_outbox1_low_irq(void *interrupt_params)
+STATIC_IFN_KUNIT void dm_dmub_outbox1_low_irq(void *interrupt_params)
 {
 	struct dmub_notification notify = {0};
 	struct common_irq_params *irq_params = interrupt_params;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
index 3cf2743b6b84..127eaba4de60 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
@@ -44,7 +44,7 @@
  * This function defines the idle state management FSM. Invalid transitions
  * are ignored and will not progress the FSM.
  */
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 bool dm_ism_next_state(enum amdgpu_dm_ism_state current_state,
 		       enum amdgpu_dm_ism_event event,
 		       enum amdgpu_dm_ism_state *next_state)
@@ -130,7 +130,7 @@ bool dm_ism_next_state(enum amdgpu_dm_ism_state current_state,
 }
 EXPORT_IF_KUNIT(dm_ism_next_state);
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 uint64_t dm_ism_get_sso_delay(const struct amdgpu_dm_ism *ism,
 				     const struct dc_stream_state *stream)
 {
@@ -163,7 +163,7 @@ EXPORT_IF_KUNIT(dm_ism_get_sso_delay);
  * Calculates the delay before allowing idle optimizations based on recent
  * idle history and the current stream timing.
  */
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 uint64_t dm_ism_get_idle_allow_delay(const struct amdgpu_dm_ism *ism,
 				     const struct dc_stream_state *stream)
 {
@@ -230,7 +230,7 @@ EXPORT_IF_KUNIT(dm_ism_get_idle_allow_delay);
  * dm_ism_insert_record - Insert a record into the circular history buffer
  * @ism: ISM instance
  */
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 void dm_ism_insert_record(struct amdgpu_dm_ism *ism)
 {
 	struct amdgpu_dm_ism_record *record;
@@ -249,7 +249,7 @@ void dm_ism_insert_record(struct amdgpu_dm_ism *ism)
 EXPORT_IF_KUNIT(dm_ism_insert_record);
 
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 void dm_ism_set_last_idle_ts(struct amdgpu_dm_ism *ism)
 {
 	ism->last_idle_timestamp_ns = ktime_get_ns();
@@ -257,7 +257,7 @@ void dm_ism_set_last_idle_ts(struct amdgpu_dm_ism *ism)
 EXPORT_IF_KUNIT(dm_ism_set_last_idle_ts);
 
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 bool dm_ism_trigger_event(struct amdgpu_dm_ism *ism,
 				 enum amdgpu_dm_ism_event event)
 {
@@ -332,7 +332,7 @@ static void dm_ism_commit_idle_optimization_state(struct amdgpu_dm_ism *ism,
 	}
 }
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 enum amdgpu_dm_ism_event dm_ism_dispatch_next_event(
 	enum amdgpu_dm_ism_state current_state,
 	uint64_t delay_ns,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index f5975070d973..ee3f3df6bb8d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -56,7 +56,7 @@
  * Translate a failed AUX transaction's operation result into an errno-style
  * return value. @result is returned unchanged for AUX_RET_SUCCESS.
  */
-VISIBLE_IF_KUNIT ssize_t dm_dp_aux_transfer_result(ssize_t result,
+STATIC_IFN_KUNIT ssize_t dm_dp_aux_transfer_result(ssize_t result,
 						   enum aux_return_code_type operation_result)
 {
 	switch (operation_result) {
@@ -84,7 +84,7 @@ EXPORT_IF_KUNIT(dm_dp_aux_transfer_result);
 /*
  * Derive the AUX payload transaction flags from a DP AUX request field.
  */
-VISIBLE_IF_KUNIT void dm_dp_aux_fill_payload_flags(u8 request,
+STATIC_IFN_KUNIT void dm_dp_aux_fill_payload_flags(u8 request,
 						   struct aux_payload *payload)
 {
 	payload->i2c_over_aux = (request & DP_AUX_NATIVE_WRITE) == 0;
@@ -98,7 +98,7 @@ EXPORT_IF_KUNIT(dm_dp_aux_fill_payload_flags);
 /*
  * This function handles both native AUX and I2C-Over-AUX transactions.
  */
-VISIBLE_IF_KUNIT ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
+STATIC_IFN_KUNIT ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 					    struct drm_dp_aux_msg *msg)
 {
 	ssize_t result = 0;
@@ -168,7 +168,7 @@ VISIBLE_IF_KUNIT ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 }
 EXPORT_IF_KUNIT(dm_dp_aux_transfer);
 
-VISIBLE_IF_KUNIT void
+STATIC_IFN_KUNIT void
 dm_dp_mst_connector_destroy(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *aconnector =
@@ -188,7 +188,7 @@ dm_dp_mst_connector_destroy(struct drm_connector *connector)
 }
 EXPORT_IF_KUNIT(dm_dp_mst_connector_destroy);
 
-VISIBLE_IF_KUNIT int
+STATIC_IFN_KUNIT int
 amdgpu_dm_mst_connector_late_register(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *amdgpu_dm_connector =
@@ -209,7 +209,7 @@ amdgpu_dm_mst_connector_late_register(struct drm_connector *connector)
 EXPORT_IF_KUNIT(amdgpu_dm_mst_connector_late_register);
 
 
-VISIBLE_IF_KUNIT void
+STATIC_IFN_KUNIT void
 amdgpu_dm_mst_reset_mst_connector_setting(struct amdgpu_dm_connector *aconnector)
 {
 	aconnector->drm_edid = NULL;
@@ -220,7 +220,7 @@ amdgpu_dm_mst_reset_mst_connector_setting(struct amdgpu_dm_connector *aconnector
 }
 EXPORT_IF_KUNIT(amdgpu_dm_mst_reset_mst_connector_setting);
 
-VISIBLE_IF_KUNIT void
+STATIC_IFN_KUNIT void
 amdgpu_dm_mst_connector_early_unregister(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *aconnector =
@@ -279,7 +279,7 @@ bool needs_dsc_aux_workaround(struct dc_link *link)
 EXPORT_IF_KUNIT(needs_dsc_aux_workaround);
 
 #if defined(CONFIG_DRM_AMD_DC_FP) || IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
-VISIBLE_IF_KUNIT bool is_synaptics_cascaded_panamera(struct dc_link *link, struct drm_dp_mst_port *port)
+STATIC_IFN_KUNIT bool is_synaptics_cascaded_panamera(struct dc_link *link, struct drm_dp_mst_port *port)
 {
 	u8 branch_vendor_data[4] = { 0 }; // Vendor data 0x50C ~ 0x50F
 
@@ -295,7 +295,7 @@ VISIBLE_IF_KUNIT bool is_synaptics_cascaded_panamera(struct dc_link *link, struc
 }
 EXPORT_IF_KUNIT(is_synaptics_cascaded_panamera);
 
-VISIBLE_IF_KUNIT bool validate_dsc_caps_on_connector(struct amdgpu_dm_connector *aconnector)
+STATIC_IFN_KUNIT bool validate_dsc_caps_on_connector(struct amdgpu_dm_connector *aconnector)
 {
 	struct dc_sink *dc_sink = aconnector->dc_sink;
 	struct drm_dp_mst_port *port = aconnector->mst_output_port;
@@ -342,7 +342,7 @@ VISIBLE_IF_KUNIT bool validate_dsc_caps_on_connector(struct amdgpu_dm_connector
 EXPORT_IF_KUNIT(validate_dsc_caps_on_connector);
 #endif
 
-VISIBLE_IF_KUNIT bool retrieve_downstream_port_device(struct amdgpu_dm_connector *aconnector)
+STATIC_IFN_KUNIT bool retrieve_downstream_port_device(struct amdgpu_dm_connector *aconnector)
 {
 	union dp_downstream_port_present ds_port_present;
 
@@ -362,7 +362,7 @@ VISIBLE_IF_KUNIT bool retrieve_downstream_port_device(struct amdgpu_dm_connector
 }
 EXPORT_IF_KUNIT(retrieve_downstream_port_device);
 
-VISIBLE_IF_KUNIT bool retrieve_branch_specific_data(struct amdgpu_dm_connector *aconnector)
+STATIC_IFN_KUNIT bool retrieve_branch_specific_data(struct amdgpu_dm_connector *aconnector)
 {
 	struct drm_connector *connector = &aconnector->base;
 	struct drm_dp_mst_port *port = aconnector->mst_output_port;
@@ -391,7 +391,7 @@ VISIBLE_IF_KUNIT bool retrieve_branch_specific_data(struct amdgpu_dm_connector *
 }
 EXPORT_IF_KUNIT(retrieve_branch_specific_data);
 
-VISIBLE_IF_KUNIT int dm_dp_mst_get_modes(struct drm_connector *connector)
+STATIC_IFN_KUNIT int dm_dp_mst_get_modes(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 	int ret = 0;
@@ -525,7 +525,7 @@ VISIBLE_IF_KUNIT int dm_dp_mst_get_modes(struct drm_connector *connector)
 }
 EXPORT_IF_KUNIT(dm_dp_mst_get_modes);
 
-VISIBLE_IF_KUNIT struct drm_encoder *
+STATIC_IFN_KUNIT struct drm_encoder *
 dm_mst_atomic_best_encoder(struct drm_connector *connector,
 			   struct drm_atomic_commit *state)
 {
@@ -538,7 +538,7 @@ dm_mst_atomic_best_encoder(struct drm_connector *connector,
 }
 EXPORT_IF_KUNIT(dm_mst_atomic_best_encoder);
 
-VISIBLE_IF_KUNIT int
+STATIC_IFN_KUNIT int
 dm_dp_mst_detect(struct drm_connector *connector,
 		 struct drm_modeset_acquire_ctx *ctx, bool force)
 {
@@ -610,7 +610,7 @@ dm_dp_mst_detect(struct drm_connector *connector,
 }
 EXPORT_IF_KUNIT(dm_dp_mst_detect);
 
-VISIBLE_IF_KUNIT int dm_dp_mst_atomic_check(struct drm_connector *connector,
+STATIC_IFN_KUNIT int dm_dp_mst_atomic_check(struct drm_connector *connector,
 					    struct drm_atomic_commit *state)
 {
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
@@ -662,7 +662,7 @@ dm_dp_create_fake_mst_encoders(struct amdgpu_device *adev)
 }
 EXPORT_IF_KUNIT(dm_dp_create_fake_mst_encoders);
 
-VISIBLE_IF_KUNIT struct drm_connector *
+STATIC_IFN_KUNIT struct drm_connector *
 dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 			struct drm_dp_mst_port *port,
 			const char *pathprop)
@@ -750,7 +750,7 @@ EXPORT_IF_KUNIT(dm_dp_add_mst_connector);
  * Select the ESI[1] mask used to filter the MST sideband ready bits for a
  * given message-ready event type.
  */
-VISIBLE_IF_KUNIT u8 dm_mst_msg_ready_mask(enum mst_msg_ready_type msg_rdy_type)
+STATIC_IFN_KUNIT u8 dm_mst_msg_ready_mask(enum mst_msg_ready_type msg_rdy_type)
 {
 	switch (msg_rdy_type) {
 	case DOWN_REP_MSG_RDY_EVENT:
@@ -769,7 +769,7 @@ EXPORT_IF_KUNIT(dm_mst_msg_ready_mask);
 /*
  * Select the DPCD ESI address and read length based on the DPCD revision.
  */
-VISIBLE_IF_KUNIT void dm_mst_select_esi_dpcd(u8 dpcd_rev, int *dpcd_addr,
+STATIC_IFN_KUNIT void dm_mst_select_esi_dpcd(u8 dpcd_rev, int *dpcd_addr,
 					     u8 *dpcd_bytes_to_read)
 {
 	if (dpcd_rev < 0x12) {
@@ -869,7 +869,7 @@ void dm_handle_mst_sideband_msg_ready_event(
 }
 EXPORT_IF_KUNIT(dm_handle_mst_sideband_msg_ready_event);
 
-VISIBLE_IF_KUNIT void dm_handle_mst_down_rep_msg_ready(struct drm_dp_mst_topology_mgr *mgr)
+STATIC_IFN_KUNIT void dm_handle_mst_down_rep_msg_ready(struct drm_dp_mst_topology_mgr *mgr)
 {
 	dm_handle_mst_sideband_msg_ready_event(mgr, DOWN_REP_MSG_RDY_EVENT);
 }
@@ -1231,7 +1231,7 @@ static int try_disable_dsc(struct drm_atomic_commit *state,
 	return 0;
 }
 
-VISIBLE_IF_KUNIT bool get_conv_frl_bw(struct amdgpu_dm_connector *aconnector,
+STATIC_IFN_KUNIT bool get_conv_frl_bw(struct amdgpu_dm_connector *aconnector,
 				      uint32_t *bw_in_kbps, uint32_t *dsc_bw_in_kbps)
 {
 	unsigned int max_conv_bw_in_kbps = 0;
@@ -1304,7 +1304,7 @@ static void build_frl_mst_dsc_params(struct amdgpu_dm_connector *aconnector,
 	}
 }
 
-VISIBLE_IF_KUNIT void log_dsc_params(int count, struct dsc_mst_fairness_vars *vars, int k)
+STATIC_IFN_KUNIT void log_dsc_params(int count, struct dsc_mst_fairness_vars *vars, int k)
 {
 	int i;
 
@@ -1493,7 +1493,7 @@ static int compute_mst_dsc_configs_for_link(struct drm_atomic_commit *state,
 	return 0;
 }
 
-VISIBLE_IF_KUNIT bool is_dsc_need_re_compute(
+STATIC_IFN_KUNIT bool is_dsc_need_re_compute(
 	struct drm_atomic_commit *state,
 	struct dc_state *dc_state,
 	struct dc_link *dc_link)
@@ -1697,7 +1697,7 @@ int compute_mst_dsc_configs_for_state(struct drm_atomic_commit *state,
 }
 EXPORT_IF_KUNIT(compute_mst_dsc_configs_for_state);
 
-VISIBLE_IF_KUNIT int pre_compute_mst_dsc_configs_for_state(struct drm_atomic_commit *state,
+STATIC_IFN_KUNIT int pre_compute_mst_dsc_configs_for_state(struct drm_atomic_commit *state,
 							   struct dc_state *dc_state,
 							   struct dsc_mst_fairness_vars *vars)
 {
@@ -1751,7 +1751,7 @@ VISIBLE_IF_KUNIT int pre_compute_mst_dsc_configs_for_state(struct drm_atomic_com
 }
 EXPORT_IF_KUNIT(pre_compute_mst_dsc_configs_for_state);
 
-VISIBLE_IF_KUNIT int find_crtc_index_in_state_by_stream(struct drm_atomic_commit *state,
+STATIC_IFN_KUNIT int find_crtc_index_in_state_by_stream(struct drm_atomic_commit *state,
 							struct dc_stream_state *stream)
 {
 	int i;
@@ -1783,7 +1783,7 @@ static bool is_link_to_dschub(struct dc_link *dc_link)
 	return true;
 }
 
-VISIBLE_IF_KUNIT bool is_dsc_precompute_needed(struct drm_atomic_commit *state)
+STATIC_IFN_KUNIT bool is_dsc_precompute_needed(struct drm_atomic_commit *state)
 {
 	int i;
 	struct drm_crtc *crtc;
@@ -1948,7 +1948,7 @@ static bool is_dsc_common_config_possible(struct dc_stream_state *stream,
 #endif
 
 #if defined(CONFIG_DRM_AMD_DC_FP) || IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
-VISIBLE_IF_KUNIT bool dp_get_link_current_set_bw(struct drm_dp_aux *aux, uint32_t *cur_link_bw)
+STATIC_IFN_KUNIT bool dp_get_link_current_set_bw(struct drm_dp_aux *aux, uint32_t *cur_link_bw)
 {
 	uint32_t total_data_bw_efficiency_x10000 = 0;
 	uint32_t link_rate_per_lane_kbps = 0;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index d1363b01a62c..19c138cfcac8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -157,7 +157,7 @@ void amdgpu_dm_plane_fill_blending_from_plane_state(const struct drm_plane_state
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_blending_from_plane_state);
 
-VISIBLE_IF_KUNIT void amdgpu_dm_plane_add_modifier(uint64_t **mods, uint64_t *size,
+STATIC_IFN_KUNIT void amdgpu_dm_plane_add_modifier(uint64_t **mods, uint64_t *size,
 						   uint64_t *cap, uint64_t mod)
 {
 	if (!*mods)
@@ -184,7 +184,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_plane_add_modifier(uint64_t **mods, uint64_t *si
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_add_modifier);
 
-VISIBLE_IF_KUNIT void amdgpu_dm_plane_add_modifier_dedup(uint64_t **mods, uint64_t *size,
+STATIC_IFN_KUNIT void amdgpu_dm_plane_add_modifier_dedup(uint64_t **mods, uint64_t *size,
 							 uint64_t *cap, uint64_t mod)
 {
 	uint64_t i;
@@ -200,13 +200,13 @@ VISIBLE_IF_KUNIT void amdgpu_dm_plane_add_modifier_dedup(uint64_t **mods, uint64
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_add_modifier_dedup);
 
-VISIBLE_IF_KUNIT bool amdgpu_dm_plane_modifier_has_dcc(uint64_t modifier)
+STATIC_IFN_KUNIT bool amdgpu_dm_plane_modifier_has_dcc(uint64_t modifier)
 {
 	return IS_AMD_FMT_MOD(modifier) && AMD_FMT_MOD_GET(DCC, modifier);
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_modifier_has_dcc);
 
-VISIBLE_IF_KUNIT unsigned int amdgpu_dm_plane_modifier_gfx9_swizzle_mode(uint64_t modifier)
+STATIC_IFN_KUNIT unsigned int amdgpu_dm_plane_modifier_gfx9_swizzle_mode(uint64_t modifier)
 {
 	if (modifier == DRM_FORMAT_MOD_LINEAR)
 		return 0;
@@ -215,7 +215,7 @@ VISIBLE_IF_KUNIT unsigned int amdgpu_dm_plane_modifier_gfx9_swizzle_mode(uint64_
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_modifier_gfx9_swizzle_mode);
 
-VISIBLE_IF_KUNIT int amdgpu_dm_plane_fill_gfx6_tiling_info_from_modifier(
+STATIC_IFN_KUNIT int amdgpu_dm_plane_fill_gfx6_tiling_info_from_modifier(
 						struct dc_tiling_info *tiling_info,
 						uint64_t modifier)
 {
@@ -250,9 +250,8 @@ VISIBLE_IF_KUNIT int amdgpu_dm_plane_fill_gfx6_tiling_info_from_modifier(
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx6_tiling_info_from_modifier);
 
-VISIBLE_IF_KUNIT
-void amdgpu_dm_plane_fill_gfx9_tiling_info_from_device(const struct amdgpu_device *adev,
-						       struct dc_tiling_info *tiling_info)
+STATIC_IFN_KUNIT void amdgpu_dm_plane_fill_gfx9_tiling_info_from_device(const struct amdgpu_device *adev,
+									struct dc_tiling_info *tiling_info)
 {
 	/* Fill GFX9 params */
 	tiling_info->gfx9.num_pipes =
@@ -273,10 +272,9 @@ void amdgpu_dm_plane_fill_gfx9_tiling_info_from_device(const struct amdgpu_devic
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx9_tiling_info_from_device);
 
-VISIBLE_IF_KUNIT
-void amdgpu_dm_plane_fill_gfx9_tiling_info_from_modifier(const struct amdgpu_device *adev,
-							 struct dc_tiling_info *tiling_info,
-							 uint64_t modifier)
+STATIC_IFN_KUNIT void amdgpu_dm_plane_fill_gfx9_tiling_info_from_modifier(const struct amdgpu_device *adev,
+									  struct dc_tiling_info *tiling_info,
+									  uint64_t modifier)
 {
 	unsigned int mod_bank_xor_bits = AMD_FMT_MOD_GET(BANK_XOR_BITS, modifier);
 	unsigned int mod_pipe_xor_bits = AMD_FMT_MOD_GET(PIPE_XOR_BITS, modifier);
@@ -303,7 +301,7 @@ void amdgpu_dm_plane_fill_gfx9_tiling_info_from_modifier(const struct amdgpu_dev
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx9_tiling_info_from_modifier);
 
-VISIBLE_IF_KUNIT int amdgpu_dm_plane_validate_dcc(struct amdgpu_device *adev,
+STATIC_IFN_KUNIT int amdgpu_dm_plane_validate_dcc(struct amdgpu_device *adev,
 						  const enum surface_pixel_format format,
 						  const enum dc_rotation_angle rotation,
 						  const struct dc_tiling_info *tiling_info,
@@ -353,7 +351,7 @@ VISIBLE_IF_KUNIT int amdgpu_dm_plane_validate_dcc(struct amdgpu_device *adev,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_validate_dcc);
 
-VISIBLE_IF_KUNIT int amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers(struct amdgpu_device *adev,
+STATIC_IFN_KUNIT int amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers(struct amdgpu_device *adev,
 									       const struct amdgpu_framebuffer *afb,
 									       const enum surface_pixel_format format,
 									       const enum dc_rotation_angle rotation,
@@ -405,7 +403,7 @@ VISIBLE_IF_KUNIT int amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers(struct amdgp
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_gfx9_attrs_from_modifiers);
 
-VISIBLE_IF_KUNIT int amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers(struct amdgpu_device *adev,
+STATIC_IFN_KUNIT int amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers(struct amdgpu_device *adev,
 										const struct amdgpu_framebuffer *afb,
 										const enum surface_pixel_format format,
 										const enum dc_rotation_angle rotation,
@@ -509,7 +507,7 @@ static void amdgpu_dm_plane_add_gfx10_1_modifiers(const struct amdgpu_device *ad
  * present at specific indices.
  * See SiLib::HwlSetupTileInfo() and CiLib::HwlSetupTileInfo() in addrlib.
  */
-VISIBLE_IF_KUNIT u32 amdgpu_dm_plane_get_gfx6_tile_idx(const struct amdgpu_device *adev,
+STATIC_IFN_KUNIT u32 amdgpu_dm_plane_get_gfx6_tile_idx(const struct amdgpu_device *adev,
 						       const u32 bpp,
 						       const enum array_mode_values arr)
 {
@@ -548,7 +546,7 @@ EXPORT_IF_KUNIT(amdgpu_dm_plane_get_gfx6_tile_idx);
  * can be calculated. The TILE_SPLIT field is only used for the depth micro tile mode.
  * See CiLib::HwlComputeMacroModeIndex() in addrlib.
  */
-VISIBLE_IF_KUNIT u32 amdgpu_dm_plane_calc_gfx7_tile_split(const struct amdgpu_device *adev,
+STATIC_IFN_KUNIT u32 amdgpu_dm_plane_calc_gfx7_tile_split(const struct amdgpu_device *adev,
 							  const u32 bpp,
 							  const u32 gb_tile_mode)
 {
@@ -577,7 +575,7 @@ EXPORT_IF_KUNIT(amdgpu_dm_plane_calc_gfx7_tile_split);
  * present at specific indices.
  * See CiLib::HwlComputeMacroModeIndex() in addrlib.
  */
-VISIBLE_IF_KUNIT u32 amdgpu_dm_plane_get_gfx7_macro_tile_idx(const u32 bpp,
+STATIC_IFN_KUNIT u32 amdgpu_dm_plane_get_gfx7_macro_tile_idx(const u32 bpp,
 							     const u32 tile_split_bytes)
 {
 	const u32 thickness = 1;
@@ -602,7 +600,7 @@ EXPORT_IF_KUNIT(amdgpu_dm_plane_get_gfx7_macro_tile_idx);
  * Select suitable micro and macro tile modes for the given bits per pixel,
  * and calculate the corresponding DRM format modifier.
  */
-VISIBLE_IF_KUNIT u64 amdgpu_dm_plane_calc_gfx6_mod(const struct amdgpu_device *adev,
+STATIC_IFN_KUNIT u64 amdgpu_dm_plane_calc_gfx6_mod(const struct amdgpu_device *adev,
 						   const u32 bpp,
 						   const enum array_mode_values arr)
 {
@@ -666,7 +664,7 @@ EXPORT_IF_KUNIT(amdgpu_dm_plane_calc_gfx6_mod);
  * On GFX6-8, not all DRM format modifier can be used with all image formats.
  * Check whether the specified modifier is supported with the given bits per pixel value.
  */
-VISIBLE_IF_KUNIT bool amdgpu_dm_plane_gfx6_format_mod_supported(const struct amdgpu_device *adev,
+STATIC_IFN_KUNIT bool amdgpu_dm_plane_gfx6_format_mod_supported(const struct amdgpu_device *adev,
 								const u32 bpp,
 								const u64 modifier)
 {
@@ -1020,9 +1018,7 @@ static void amdgpu_dm_plane_add_gfx12_modifiers(struct amdgpu_device *adev,
 
 }
 
-VISIBLE_IF_KUNIT
-int amdgpu_dm_plane_get_plane_modifiers(struct amdgpu_device *adev, unsigned int plane_type,
-										uint64_t **mods)
+STATIC_IFN_KUNIT int amdgpu_dm_plane_get_plane_modifiers(struct amdgpu_device *adev, unsigned int plane_type, uint64_t **mods)
 {
 	uint64_t size = 0, capacity = 128;
 	*mods = kmalloc_array(capacity, sizeof(uint64_t), GFP_KERNEL);
@@ -1080,7 +1076,7 @@ int amdgpu_dm_plane_get_plane_modifiers(struct amdgpu_device *adev, unsigned int
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_get_plane_modifiers);
 
-VISIBLE_IF_KUNIT int amdgpu_dm_plane_get_plane_formats(const struct drm_plane *plane,
+STATIC_IFN_KUNIT int amdgpu_dm_plane_get_plane_formats(const struct drm_plane *plane,
 						       const struct dc_plane_cap *plane_cap,
 						       uint32_t *formats, int max_formats)
 {
@@ -1230,7 +1226,7 @@ int amdgpu_dm_plane_fill_plane_buffer_attributes(struct amdgpu_device *adev,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_plane_buffer_attributes);
 
-VISIBLE_IF_KUNIT int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane,
+STATIC_IFN_KUNIT int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane,
 						       struct drm_plane_state *new_state)
 {
 	struct amdgpu_framebuffer *afb;
@@ -1330,7 +1326,7 @@ VISIBLE_IF_KUNIT int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_helper_prepare_fb);
 
-VISIBLE_IF_KUNIT void amdgpu_dm_plane_helper_cleanup_fb(struct drm_plane *plane,
+STATIC_IFN_KUNIT void amdgpu_dm_plane_helper_cleanup_fb(struct drm_plane *plane,
 							struct drm_plane_state *old_state)
 {
 	struct amdgpu_bo *rbo;
@@ -1352,7 +1348,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_plane_helper_cleanup_fb(struct drm_plane *plane,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_helper_cleanup_fb);
 
-VISIBLE_IF_KUNIT void amdgpu_dm_plane_get_min_max_dc_plane_scaling(struct drm_device *dev,
+STATIC_IFN_KUNIT void amdgpu_dm_plane_get_min_max_dc_plane_scaling(struct drm_device *dev,
 								   struct drm_framebuffer *fb,
 								   int *min_downscale, int *max_upscale)
 {
@@ -1539,7 +1535,7 @@ int amdgpu_dm_plane_fill_dc_scaling_info(struct amdgpu_device *adev,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_dc_scaling_info);
 
-VISIBLE_IF_KUNIT int amdgpu_dm_plane_atomic_check(struct drm_plane *plane,
+STATIC_IFN_KUNIT int amdgpu_dm_plane_atomic_check(struct drm_plane *plane,
 						  struct drm_atomic_commit *state)
 {
 	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
@@ -1587,7 +1583,7 @@ VISIBLE_IF_KUNIT int amdgpu_dm_plane_atomic_check(struct drm_plane *plane,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_atomic_check);
 
-VISIBLE_IF_KUNIT int amdgpu_dm_plane_atomic_async_check(struct drm_plane *plane,
+STATIC_IFN_KUNIT int amdgpu_dm_plane_atomic_async_check(struct drm_plane *plane,
 							struct drm_atomic_commit *state, bool flip)
 {
 	struct drm_crtc_state *new_crtc_state;
@@ -1747,7 +1743,7 @@ void amdgpu_dm_plane_handle_cursor_update(struct drm_plane *plane,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_handle_cursor_update);
 
-VISIBLE_IF_KUNIT void amdgpu_dm_plane_atomic_async_update(struct drm_plane *plane,
+STATIC_IFN_KUNIT void amdgpu_dm_plane_atomic_async_update(struct drm_plane *plane,
 							  struct drm_atomic_commit *state)
 {
 	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
@@ -1772,7 +1768,7 @@ VISIBLE_IF_KUNIT void amdgpu_dm_plane_atomic_async_update(struct drm_plane *plan
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_atomic_async_update);
 
-VISIBLE_IF_KUNIT void amdgpu_dm_plane_panic_flush(struct drm_plane *plane)
+STATIC_IFN_KUNIT void amdgpu_dm_plane_panic_flush(struct drm_plane *plane)
 {
 	struct dm_plane_state *dm_plane_state = to_dm_plane_state(plane->state);
 	struct drm_framebuffer *fb = plane->state->fb;
@@ -1805,7 +1801,7 @@ static const struct drm_plane_helper_funcs dm_primary_plane_helper_funcs = {
 	.panic_flush = amdgpu_dm_plane_panic_flush,
 };
 
-VISIBLE_IF_KUNIT struct drm_plane_state *amdgpu_dm_plane_drm_plane_create_state(struct drm_plane *plane)
+STATIC_IFN_KUNIT struct drm_plane_state *amdgpu_dm_plane_drm_plane_create_state(struct drm_plane *plane)
 {
 	struct dm_plane_state *amdgpu_state;
 
@@ -1838,7 +1834,7 @@ VISIBLE_IF_KUNIT struct drm_plane_state *amdgpu_dm_plane_drm_plane_create_state(
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_drm_plane_create_state);
 
-VISIBLE_IF_KUNIT struct drm_plane_state *
+STATIC_IFN_KUNIT struct drm_plane_state *
 amdgpu_dm_plane_drm_plane_duplicate_state(struct drm_plane *plane)
 {
 	struct dm_plane_state *dm_plane_state, *old_dm_plane_state;
@@ -1895,7 +1891,7 @@ amdgpu_dm_plane_drm_plane_duplicate_state(struct drm_plane *plane)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_drm_plane_duplicate_state);
 
-VISIBLE_IF_KUNIT bool amdgpu_dm_plane_format_mod_supported(struct drm_plane *plane,
+STATIC_IFN_KUNIT bool amdgpu_dm_plane_format_mod_supported(struct drm_plane *plane,
 							   uint32_t format,
 							   uint64_t modifier)
 {
@@ -1966,7 +1962,7 @@ VISIBLE_IF_KUNIT bool amdgpu_dm_plane_format_mod_supported(struct drm_plane *pla
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_format_mod_supported);
 
-VISIBLE_IF_KUNIT void amdgpu_dm_plane_drm_plane_destroy_state(struct drm_plane *plane,
+STATIC_IFN_KUNIT void amdgpu_dm_plane_drm_plane_destroy_state(struct drm_plane *plane,
 							      struct drm_plane_state *state)
 {
 	struct dm_plane_state *dm_plane_state = to_dm_plane_state(state);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index 13901a1e6907..3280bfadc6a8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -36,7 +36,7 @@
 #include "dm_helpers.h"
 #include "amdgpu_dm_pp_smu.h"
 
-VISIBLE_IF_KUNIT void build_pm_display_cfg(
+STATIC_IFN_KUNIT void build_pm_display_cfg(
 		struct amd_pp_display_configuration *pm_display_cfg,
 		const struct dm_pp_display_configuration *pp_display_cfg)
 {
@@ -104,7 +104,7 @@ bool dm_pp_apply_display_requirements(
 }
 EXPORT_IF_KUNIT(dm_pp_apply_display_requirements);
 
-VISIBLE_IF_KUNIT void get_default_clock_levels(
+STATIC_IFN_KUNIT void get_default_clock_levels(
 		enum dm_pp_clock_type clk_type,
 		struct dm_pp_clock_levels *clks)
 {
@@ -137,7 +137,7 @@ VISIBLE_IF_KUNIT void get_default_clock_levels(
 }
 EXPORT_IF_KUNIT(get_default_clock_levels);
 
-VISIBLE_IF_KUNIT enum amd_pp_clock_type dc_to_pp_clock_type(
+STATIC_IFN_KUNIT enum amd_pp_clock_type dc_to_pp_clock_type(
 		enum dm_pp_clock_type dm_pp_clk_type)
 {
 	enum amd_pp_clock_type amd_pp_clk_type = 0;
@@ -180,7 +180,7 @@ VISIBLE_IF_KUNIT enum amd_pp_clock_type dc_to_pp_clock_type(
 }
 EXPORT_IF_KUNIT(dc_to_pp_clock_type);
 
-VISIBLE_IF_KUNIT void pp_to_dc_clock_levels(
+STATIC_IFN_KUNIT void pp_to_dc_clock_levels(
 		const struct amd_pp_clocks *pp_clks,
 		struct dm_pp_clock_levels *dc_clks,
 		enum dm_pp_clock_type dc_clk_type)
@@ -207,7 +207,7 @@ VISIBLE_IF_KUNIT void pp_to_dc_clock_levels(
 }
 EXPORT_IF_KUNIT(pp_to_dc_clock_levels);
 
-VISIBLE_IF_KUNIT void pp_to_dc_clock_levels_with_latency(
+STATIC_IFN_KUNIT void pp_to_dc_clock_levels_with_latency(
 		const struct pp_clock_levels_with_latency *pp_clks,
 		struct dm_pp_clock_levels_with_latency *clk_level_info,
 		enum dm_pp_clock_type dc_clk_type)
@@ -235,7 +235,7 @@ VISIBLE_IF_KUNIT void pp_to_dc_clock_levels_with_latency(
 }
 EXPORT_IF_KUNIT(pp_to_dc_clock_levels_with_latency);
 
-VISIBLE_IF_KUNIT void pp_to_dc_clock_levels_with_voltage(
+STATIC_IFN_KUNIT void pp_to_dc_clock_levels_with_voltage(
 		const struct pp_clock_levels_with_voltage *pp_clks,
 		struct dm_pp_clock_levels_with_voltage *clk_level_info,
 		enum dm_pp_clock_type dc_clk_type)
@@ -264,7 +264,7 @@ VISIBLE_IF_KUNIT void pp_to_dc_clock_levels_with_voltage(
 }
 EXPORT_IF_KUNIT(pp_to_dc_clock_levels_with_voltage);
 
-VISIBLE_IF_KUNIT void cap_clock_levels_to_validation(
+STATIC_IFN_KUNIT void cap_clock_levels_to_validation(
 		struct dm_pp_clock_levels *dc_clks,
 		enum dm_pp_clock_type clk_type,
 		const struct amd_pp_simple_clock_info *validation_clks)
@@ -423,7 +423,7 @@ bool dm_pp_apply_clock_for_voltage_request(
 }
 EXPORT_IF_KUNIT(dm_pp_apply_clock_for_voltage_request);
 
-VISIBLE_IF_KUNIT void build_wm_clock_ranges_soc15(
+STATIC_IFN_KUNIT void build_wm_clock_ranges_soc15(
 		const struct pp_smu_wm_range_sets *ranges,
 		struct dm_pp_wm_sets_with_clock_ranges_soc15 *wm_with_clock_ranges)
 {
@@ -468,7 +468,7 @@ VISIBLE_IF_KUNIT void build_wm_clock_ranges_soc15(
 }
 EXPORT_IF_KUNIT(build_wm_clock_ranges_soc15);
 
-VISIBLE_IF_KUNIT void pp_rv_set_wm_ranges(struct pp_smu *pp,
+STATIC_IFN_KUNIT void pp_rv_set_wm_ranges(struct pp_smu *pp,
 		struct pp_smu_wm_range_sets *ranges)
 {
 	const struct dc_context *ctx = pp->dm;
@@ -482,7 +482,7 @@ VISIBLE_IF_KUNIT void pp_rv_set_wm_ranges(struct pp_smu *pp,
 }
 EXPORT_IF_KUNIT(pp_rv_set_wm_ranges);
 
-VISIBLE_IF_KUNIT void pp_rv_set_pme_wa_enable(struct pp_smu *pp)
+STATIC_IFN_KUNIT void pp_rv_set_pme_wa_enable(struct pp_smu *pp)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
@@ -491,7 +491,7 @@ VISIBLE_IF_KUNIT void pp_rv_set_pme_wa_enable(struct pp_smu *pp)
 }
 EXPORT_IF_KUNIT(pp_rv_set_pme_wa_enable);
 
-VISIBLE_IF_KUNIT void pp_rv_set_active_display_count(struct pp_smu *pp, int count)
+STATIC_IFN_KUNIT void pp_rv_set_active_display_count(struct pp_smu *pp, int count)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
@@ -500,7 +500,7 @@ VISIBLE_IF_KUNIT void pp_rv_set_active_display_count(struct pp_smu *pp, int coun
 }
 EXPORT_IF_KUNIT(pp_rv_set_active_display_count);
 
-VISIBLE_IF_KUNIT void pp_rv_set_min_deep_sleep_dcfclk(struct pp_smu *pp, int clock)
+STATIC_IFN_KUNIT void pp_rv_set_min_deep_sleep_dcfclk(struct pp_smu *pp, int clock)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
@@ -509,7 +509,7 @@ VISIBLE_IF_KUNIT void pp_rv_set_min_deep_sleep_dcfclk(struct pp_smu *pp, int clo
 }
 EXPORT_IF_KUNIT(pp_rv_set_min_deep_sleep_dcfclk);
 
-VISIBLE_IF_KUNIT void pp_rv_set_hard_min_dcefclk_by_freq(struct pp_smu *pp, int clock)
+STATIC_IFN_KUNIT void pp_rv_set_hard_min_dcefclk_by_freq(struct pp_smu *pp, int clock)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
@@ -518,7 +518,7 @@ VISIBLE_IF_KUNIT void pp_rv_set_hard_min_dcefclk_by_freq(struct pp_smu *pp, int
 }
 EXPORT_IF_KUNIT(pp_rv_set_hard_min_dcefclk_by_freq);
 
-VISIBLE_IF_KUNIT void pp_rv_set_hard_min_fclk_by_freq(struct pp_smu *pp, int mhz)
+STATIC_IFN_KUNIT void pp_rv_set_hard_min_fclk_by_freq(struct pp_smu *pp, int mhz)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
@@ -527,7 +527,7 @@ VISIBLE_IF_KUNIT void pp_rv_set_hard_min_fclk_by_freq(struct pp_smu *pp, int mhz
 }
 EXPORT_IF_KUNIT(pp_rv_set_hard_min_fclk_by_freq);
 
-VISIBLE_IF_KUNIT enum pp_smu_status pp_nv_set_wm_ranges(struct pp_smu *pp,
+STATIC_IFN_KUNIT enum pp_smu_status pp_nv_set_wm_ranges(struct pp_smu *pp,
 		struct pp_smu_wm_range_sets *ranges)
 {
 	const struct dc_context *ctx = pp->dm;
@@ -539,7 +539,7 @@ VISIBLE_IF_KUNIT enum pp_smu_status pp_nv_set_wm_ranges(struct pp_smu *pp,
 }
 EXPORT_IF_KUNIT(pp_nv_set_wm_ranges);
 
-VISIBLE_IF_KUNIT enum pp_smu_status pp_nv_set_display_count(struct pp_smu *pp, int count)
+STATIC_IFN_KUNIT enum pp_smu_status pp_nv_set_display_count(struct pp_smu *pp, int count)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
@@ -556,7 +556,7 @@ VISIBLE_IF_KUNIT enum pp_smu_status pp_nv_set_display_count(struct pp_smu *pp, i
 }
 EXPORT_IF_KUNIT(pp_nv_set_display_count);
 
-VISIBLE_IF_KUNIT enum pp_smu_status
+STATIC_IFN_KUNIT enum pp_smu_status
 pp_nv_set_min_deep_sleep_dcfclk(struct pp_smu *pp, int mhz)
 {
 	const struct dc_context *ctx = pp->dm;
@@ -574,7 +574,7 @@ pp_nv_set_min_deep_sleep_dcfclk(struct pp_smu *pp, int mhz)
 }
 EXPORT_IF_KUNIT(pp_nv_set_min_deep_sleep_dcfclk);
 
-VISIBLE_IF_KUNIT enum pp_smu_status pp_nv_set_hard_min_dcefclk_by_freq(
+STATIC_IFN_KUNIT enum pp_smu_status pp_nv_set_hard_min_dcefclk_by_freq(
 		struct pp_smu *pp, int mhz)
 {
 	const struct dc_context *ctx = pp->dm;
@@ -598,7 +598,7 @@ VISIBLE_IF_KUNIT enum pp_smu_status pp_nv_set_hard_min_dcefclk_by_freq(
 }
 EXPORT_IF_KUNIT(pp_nv_set_hard_min_dcefclk_by_freq);
 
-VISIBLE_IF_KUNIT enum pp_smu_status
+STATIC_IFN_KUNIT enum pp_smu_status
 pp_nv_set_hard_min_uclk_by_freq(struct pp_smu *pp, int mhz)
 {
 	const struct dc_context *ctx = pp->dm;
@@ -622,7 +622,7 @@ pp_nv_set_hard_min_uclk_by_freq(struct pp_smu *pp, int mhz)
 }
 EXPORT_IF_KUNIT(pp_nv_set_hard_min_uclk_by_freq);
 
-VISIBLE_IF_KUNIT enum pp_smu_status pp_nv_set_pstate_handshake_support(
+STATIC_IFN_KUNIT enum pp_smu_status pp_nv_set_pstate_handshake_support(
 	struct pp_smu *pp, bool pstate_handshake_supported)
 {
 	const struct dc_context *ctx = pp->dm;
@@ -636,7 +636,7 @@ VISIBLE_IF_KUNIT enum pp_smu_status pp_nv_set_pstate_handshake_support(
 }
 EXPORT_IF_KUNIT(pp_nv_set_pstate_handshake_support);
 
-VISIBLE_IF_KUNIT bool pp_smu_nv_clock_id_to_pp(enum pp_smu_nv_clock_id clock_id,
+STATIC_IFN_KUNIT bool pp_smu_nv_clock_id_to_pp(enum pp_smu_nv_clock_id clock_id,
 		enum amd_pp_clock_type *clock_type)
 {
 	switch (clock_id) {
@@ -657,7 +657,7 @@ VISIBLE_IF_KUNIT bool pp_smu_nv_clock_id_to_pp(enum pp_smu_nv_clock_id clock_id,
 }
 EXPORT_IF_KUNIT(pp_smu_nv_clock_id_to_pp);
 
-VISIBLE_IF_KUNIT enum pp_smu_status pp_nv_set_voltage_by_freq(struct pp_smu *pp,
+STATIC_IFN_KUNIT enum pp_smu_status pp_nv_set_voltage_by_freq(struct pp_smu *pp,
 		enum pp_smu_nv_clock_id clock_id, int mhz)
 {
 	const struct dc_context *ctx = pp->dm;
@@ -683,7 +683,7 @@ VISIBLE_IF_KUNIT enum pp_smu_status pp_nv_set_voltage_by_freq(struct pp_smu *pp,
 }
 EXPORT_IF_KUNIT(pp_nv_set_voltage_by_freq);
 
-VISIBLE_IF_KUNIT enum pp_smu_status pp_nv_get_maximum_sustainable_clocks(
+STATIC_IFN_KUNIT enum pp_smu_status pp_nv_get_maximum_sustainable_clocks(
 		struct pp_smu *pp, struct pp_smu_nv_clock_table *max_clocks)
 {
 	const struct dc_context *ctx = pp->dm;
@@ -701,7 +701,7 @@ VISIBLE_IF_KUNIT enum pp_smu_status pp_nv_get_maximum_sustainable_clocks(
 }
 EXPORT_IF_KUNIT(pp_nv_get_maximum_sustainable_clocks);
 
-VISIBLE_IF_KUNIT enum pp_smu_status pp_nv_get_uclk_dpm_states(struct pp_smu *pp,
+STATIC_IFN_KUNIT enum pp_smu_status pp_nv_get_uclk_dpm_states(struct pp_smu *pp,
 		unsigned int *clock_values_in_khz, unsigned int *num_states)
 {
 	const struct dc_context *ctx = pp->dm;
@@ -720,7 +720,7 @@ VISIBLE_IF_KUNIT enum pp_smu_status pp_nv_get_uclk_dpm_states(struct pp_smu *pp,
 }
 EXPORT_IF_KUNIT(pp_nv_get_uclk_dpm_states);
 
-VISIBLE_IF_KUNIT enum pp_smu_status pp_rn_get_dpm_clock_table(
+STATIC_IFN_KUNIT enum pp_smu_status pp_rn_get_dpm_clock_table(
 		struct pp_smu *pp, struct dpm_clocks *clock_table)
 {
 	const struct dc_context *ctx = pp->dm;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index 522fc81d09b5..dbad0a6d3a2b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -32,7 +32,7 @@
 #include "modules/power/power_helpers.h"
 #include "dm_helpers.h"
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 bool link_supports_psrsu(struct dc_link *link)
 {
 	struct dc *dc = link->ctx->dc;
@@ -62,7 +62,7 @@ bool link_supports_psrsu(struct dc_link *link)
 }
 EXPORT_IF_KUNIT(link_supports_psrsu);
 
-VISIBLE_IF_KUNIT
+STATIC_IFN_KUNIT
 void amdgpu_dm_psr_fill_caps(struct dc_link *link, struct psr_caps *caps)
 {
 	struct dpcd_caps *dpcd_caps = &link->dpcd_caps;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
index 9e6cb3ab52ae..6f91a992d43f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
@@ -87,7 +87,7 @@ EXPORT_IF_KUNIT(amdgpu_dm_wb_kunit_set_ops);
 
 #endif
 
-VISIBLE_IF_KUNIT int amdgpu_dm_wb_encoder_atomic_check(struct drm_encoder *encoder,
+STATIC_IFN_KUNIT int amdgpu_dm_wb_encoder_atomic_check(struct drm_encoder *encoder,
 					struct drm_crtc_state *crtc_state,
 					struct drm_connector_state *conn_state)
 {
@@ -124,14 +124,14 @@ VISIBLE_IF_KUNIT int amdgpu_dm_wb_encoder_atomic_check(struct drm_encoder *encod
 EXPORT_IF_KUNIT(amdgpu_dm_wb_encoder_atomic_check);
 
 
-VISIBLE_IF_KUNIT int amdgpu_dm_wb_connector_get_modes(struct drm_connector *connector)
+STATIC_IFN_KUNIT int amdgpu_dm_wb_connector_get_modes(struct drm_connector *connector)
 {
 	/* Maximum resolution supported by DWB */
 	return drm_add_modes_noedid(connector, 3840, 2160);
 }
 EXPORT_IF_KUNIT(amdgpu_dm_wb_connector_get_modes);
 
-VISIBLE_IF_KUNIT int amdgpu_dm_wb_prepare_job(struct drm_writeback_connector *wb_connector,
+STATIC_IFN_KUNIT int amdgpu_dm_wb_prepare_job(struct drm_writeback_connector *wb_connector,
 			       struct drm_writeback_job *job)
 {
 	struct amdgpu_framebuffer *afb;
@@ -196,7 +196,7 @@ VISIBLE_IF_KUNIT int amdgpu_dm_wb_prepare_job(struct drm_writeback_connector *wb
 }
 EXPORT_IF_KUNIT(amdgpu_dm_wb_prepare_job);
 
-VISIBLE_IF_KUNIT void amdgpu_dm_wb_cleanup_job(struct drm_writeback_connector *connector,
+STATIC_IFN_KUNIT void amdgpu_dm_wb_cleanup_job(struct drm_writeback_connector *connector,
 				struct drm_writeback_job *job)
 {
 	struct amdgpu_bo *rbo;
diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
index ac1522fc2e70..c887fdcba049 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -30,8 +30,6 @@
 #ifndef __DM_HELPERS__
 #define __DM_HELPERS__
 
-#include <kunit/visibility.h>
-
 #include "modules/inc/mod_info_packet_types.h"
 #include "dc_types.h"
 #include "dc.h"
@@ -195,10 +193,12 @@ void dm_helpers_mccs_vcp_set(
 		struct dc_sink *sink);
 
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+#define STATIC_IFN_KUNIT
 #define INLINE_IFN_KUNIT inline
 #define EXPORT_IF_KUNIT(symbol) EXPORT_SYMBOL(symbol)
 
 #else
+#define STATIC_IFN_KUNIT static
 #define INLINE_IFN_KUNIT
 #define EXPORT_IF_KUNIT(symbol)
 #endif
-- 
2.55.0

