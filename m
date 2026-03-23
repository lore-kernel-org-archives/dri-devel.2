Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A47F483FB
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 20:30:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62D9310E4E7;
	Mon, 23 Mar 2026 20:30:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oURtSD63";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010063.outbound.protection.outlook.com [52.101.56.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D151610E4DB;
 Mon, 23 Mar 2026 20:30:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oUA6Rry7uj5KuYIUnLZ9KmBmUiHO2qDcJwEwfl/xRRG1XG8c2KAJJu/Fu3TfIXDpW3+OSo/YkWJdG/IDIsg2y2oOTc8v29PTLQ4G4h7q13tPVbGepHjekby0gF45pRSf6eVOJlrdYGn8R5W/wR+/3a5YrzQCZ1i0IdtZ7a+FP6In3sffbyiXQupllCYZUgAQi9Cv2zKtDsZjtG8JFHU10qkFx23qFbBQCsKRnXsnAyTfHbVBNVjGtTPDIYi933S7X/eqB+CcazsEuFr0LA6p+7RO02/ZNAEbmvHlbj0eBBAhS8cm+Ly+Z9EsvKBSj7Q7rEJ5uqE94gNSGeoCpPHU2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLXSe54B6kxZkVZ4dKs+TOthR3eWdiihdcC6MFED+1Y=;
 b=Vq00dnKfVkcBEBvU1hbS0Od4moiMsQj/FqqTUwbkfGKxaaCROTZ67ZaYEA3CTD7/8yf0U/PzG7v+o3uew+QAtCycLNqE/g5pNfxpaa9dCotOJss7TVmLafSxfu6e5UAxMRfzy7d3DPrwRjk2fy+2OTFh/zO3VTVyzjBe/ZzJYS/ZYsvMV+m0/m047+DvmPEI0k3ccwJXmeA6V/RFNPbYc0/WkdQT7et97JN17nDNnUA+PZ3zF+vAsgD7gu9Gp1bKVP44uQTuzubYMFpFrJtUimrdL3yRECX9+5lvjPxWfZvYebCb8DjCx9IEAzWI8vRNVduyyBN+HkkzyMbd3gQxoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLXSe54B6kxZkVZ4dKs+TOthR3eWdiihdcC6MFED+1Y=;
 b=oURtSD6377aVqbr6/DxeMGYiOuZ+8xO2C8rxmhl0DF47DpMvgkJ4FWwgfvt0XOD6aU3eN4Sg/CNunC2vIMKOTuGklL8oW9j2LxWe1Kt0EMT/x/RYR2AVfNF7bEzuqblDr0gpSp8ZRGMotNGw/oxV5OfOk2E+baA2gQP6QIVJWMU=
Received: from BN0PR04CA0188.namprd04.prod.outlook.com (2603:10b6:408:e9::13)
 by DM4PR12MB8523.namprd12.prod.outlook.com (2603:10b6:8:18e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 20:30:15 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:e9:cafe::44) by BN0PR04CA0188.outlook.office365.com
 (2603:10b6:408:e9::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 20:30:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 20:30:15 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 15:30:13 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 15:30:13 -0500
Received: from thonkpad (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server id 15.2.2562.17 via Frontend Transport;
 Mon, 23 Mar 2026 15:30:12 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <simona@ffwll.ch>, <airlied@gmail.com>,
 <jani.nikula@linux.intel.com>, <ville.syrjala@linux.intel.com>,
 <superm1@kernel.org>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH v2 3/5] drm/amd/display: Refactor amdgpu_dm_crtc_set_vblank
Date: Mon, 23 Mar 2026 16:27:53 -0400
Message-ID: <20260323202755.315929-4-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323202755.315929-1-sunpeng.li@amd.com>
References: <20260323202755.315929-1-sunpeng.li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|DM4PR12MB8523:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e4d0bb6-ea41-4523-ba44-08de891afdd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: LqOhtnWPeI9I6JyjbXed52OZzfaDHmgQU1Zl1BZMhpcdiDC8wdV4QeXKIJ9GTNMBEl58Rm1iVVkBN6QIIxGko4szEBP+YR/o10GhyCIHyyClm35dkAhnVYhZaTAGlZkOeDFtOdswWG0sdvHEWVVsxI+OZt2okU78fQ2aM+j5pHKyuXrAHR72U9fkvF0zWZFyWWBMay2gN4p5zuF4fOx9h7wbJ/YLDHb8hpc3JCJXqaXBwmxDz7BZuvzxLP6D0GxviijtmaMj5ZReRmQUH9aiQBeqvDM/Tn1LOf00bHuvPa9asA7gNFoFAuRFlKTR5xh7jhPe6V1eM8RddWmitQiVssuXuHrNRbdcaigP6nDOGw2wXwcM0LCaN+drirPcv3U5B/1sCydm4xGphBjVVMdkFYjY4OZxa3NQJqLNzrvW7rdwp0fRuONJ/lajKDCFmyYbcP68F4iqKaB/fUc5m56WJ6t6sjrli5dGObC3axBkZYAygQu8zw52ZLCkZT+LMWk62fUrxdgM8HhouiNo2swxpV8M+ID3+sN/EOUrRNfzO+OuZfg5fedU3Vpao6vwGdIGOPl1FOhgwGy9KtDc+GWZw37+qP/RhwqZ9zM2OW4sGjPb2n+JyG09Vwcs6EF/OUsWwNSgG6I6p6wv82zYzDOEG5hwDtnceX8KVdzDzfCy1Su6Fl1OQ3G/7wbMJ0VQUj4Lx7RO2nzLHqSrTDf9SagA8Y+VduUpnAet9TVfgcMmhlV35i2jZL/kI47v4rlESZoybgb9VxoD+elj6S5cFqLAAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mA2ChVgWV/nIbkuynPF/423XkGx7vepaA7I/QEUgUk1LqvD9R8wuec2FQSQN4KnYLkxuW0xf+YBy2hORiAxH+0qoixy4QYd+K1fzviHITOLI800eReZrb7Y8GH/7r1c/ExVt2ZbrleYNmdUqFObtHuV2w+EFNcvr0lnDG/pEOB+LJ14CXwclcP10jsRJPd+cWn9bLiJbri4SIda2Lf08K26t1ttpEKAzCZ5zIORO/IXNslpFblo5uHcmep8lkIwaOdbd2vkyefRsTYMayY87lJ7N+/K/3on8GA0Z8X5yhX/zBB1yGLy820f9363FkmglIRwzZph7jd0E24pqYSA+6430quRfQ+uRcANiWi/SyevstlacFxC6I5LRxVctbWxfoQOfts2F4XoMVnF+D26bLpQ6fKCgWLXhSB0urjPPEfwTBGs3VbxqV/1LBFCUpWtV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 20:30:15.3257 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4d0bb6-ea41-4523-ba44-08de891afdd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8523
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

From: Leo Li <sunpeng.li@amd.com>

[Why]

In preparation of implementing deferred vblank work, refactor
amdgpu_dm_crtc_set_vblank to split out the actual enabling/disabling of
vblank interrupts + restoring vblank counts/timestamps from the rest.

[How]

* Move the vblank_control_work init and queueing out into
  amdgpu_dm_crtc_queue_vblank_work()
* Move crtc->enabled check out to parent function
  amdgpu_dm_crtc_enable_vblank()
* Call amdgpu_dm_crtc_queue_vblank_work() from parent functions
  amdgpu_dm_crtc_(enable|disable)_vblank()
* As a drive-by cleanup, make amdgpu_dm_crtc_(enable|disable)_vblank()
  static; they're not called from anywhere else.

No functional changes are intended.

Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 87 +++++++++++++------
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.h    |  4 -
 2 files changed, 59 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 304437c2284d8..e6727d5098863 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -293,20 +293,12 @@ static inline int amdgpu_dm_crtc_set_vblank(struct drm_crtc *crtc, bool enable)
 	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
 	struct dm_crtc_state *acrtc_state = to_dm_crtc_state(crtc->state);
 	struct amdgpu_display_manager *dm = &adev->dm;
-	struct vblank_control_work *work;
 	int irq_type;
 	int rc = 0;
 
-	if (enable && !acrtc->base.enabled) {
-		drm_dbg_vbl(crtc->dev,
-				"Reject vblank enable on unconfigured CRTC %d (enabled=%d)\n",
-				acrtc->crtc_id, acrtc->base.enabled);
-		return -EINVAL;
-	}
-
 	irq_type = amdgpu_display_crtc_idx_to_irq_type(adev, acrtc->crtc_id);
 
-	if (enable) {
+	if (enable && crtc->enabled) {
 		struct dc *dc = adev->dm.dc;
 		struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
 		struct psr_settings *psr = &acrtc_state->stream->link->psr_settings;
@@ -387,39 +379,78 @@ static inline int amdgpu_dm_crtc_set_vblank(struct drm_crtc *crtc, bool enable)
 			return rc;
 	}
 #endif
+	return 0;
+}
 
-	if (amdgpu_in_reset(adev))
-		return 0;
-
-	if (dm->vblank_control_workqueue) {
-		work = kzalloc_obj(*work, GFP_ATOMIC);
-		if (!work)
-			return -ENOMEM;
+static int amdgpu_dm_crtc_queue_vblank_work(struct amdgpu_display_manager *dm,
+					    struct amdgpu_crtc *acrtc,
+					    struct dm_crtc_state *acrtc_state,
+					    bool enable)
+{
+	struct vblank_control_work *work;
 
-		INIT_WORK(&work->work, amdgpu_dm_crtc_vblank_control_worker);
-		work->dm = dm;
-		work->acrtc = acrtc;
-		work->enable = enable;
+	work = kzalloc_obj(*work, GFP_ATOMIC);
+	if (!work)
+		return -ENOMEM;
 
-		if (acrtc_state->stream) {
-			dc_stream_retain(acrtc_state->stream);
-			work->stream = acrtc_state->stream;
-		}
+	INIT_WORK(&work->work, amdgpu_dm_crtc_vblank_control_worker);
+	work->dm = dm;
+	work->acrtc = acrtc;
+	work->enable = enable;
 
-		queue_work(dm->vblank_control_workqueue, &work->work);
+	if (acrtc_state->stream) {
+		dc_stream_retain(acrtc_state->stream);
+		work->stream = acrtc_state->stream;
 	}
+	queue_work(dm->vblank_control_workqueue, &work->work);
 
 	return 0;
 }
 
-int amdgpu_dm_crtc_enable_vblank(struct drm_crtc *crtc)
+static int amdgpu_dm_crtc_enable_vblank(struct drm_crtc *crtc)
 {
-	return amdgpu_dm_crtc_set_vblank(crtc, true);
+	struct dm_crtc_state *acrtc_state = to_dm_crtc_state(crtc->state);
+	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
+	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
+	struct amdgpu_display_manager *dm = &adev->dm;
+	int ret;
+
+	if (!crtc->enabled) {
+		drm_dbg_vbl(crtc->dev,
+				"Reject vblank enable on unconfigured CRTC %d (enabled=%d)\n",
+				crtc->index, crtc->enabled);
+		return -EINVAL;
+	}
+
+	ret = amdgpu_dm_crtc_set_vblank(crtc, true);
+	if (ret)
+		return ret;
+
+	if (amdgpu_in_reset(adev))
+		return 0;
+
+	if (dm->vblank_control_workqueue)
+		return amdgpu_dm_crtc_queue_vblank_work(dm, acrtc,
+							acrtc_state, true);
+
+	return 0;
 }
 
-void amdgpu_dm_crtc_disable_vblank(struct drm_crtc *crtc)
+static void amdgpu_dm_crtc_disable_vblank(struct drm_crtc *crtc)
 {
+	struct dm_crtc_state *acrtc_state = to_dm_crtc_state(crtc->state);
+	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
+	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
+	struct amdgpu_display_manager *dm = &adev->dm;
+
 	amdgpu_dm_crtc_set_vblank(crtc, false);
+
+	if (amdgpu_in_reset(adev))
+		return;
+
+	if (dm->vblank_control_workqueue)
+		amdgpu_dm_crtc_queue_vblank_work(dm, acrtc,
+						 acrtc_state, false);
 }
 
 static void amdgpu_dm_crtc_destroy_state(struct drm_crtc *crtc,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
index c1212947a77b8..655a6c4f83fb8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
@@ -39,10 +39,6 @@ bool amdgpu_dm_crtc_vrr_active_irq(struct amdgpu_crtc *acrtc);
 
 bool amdgpu_dm_crtc_vrr_active(const struct dm_crtc_state *dm_state);
 
-int amdgpu_dm_crtc_enable_vblank(struct drm_crtc *crtc);
-
-void amdgpu_dm_crtc_disable_vblank(struct drm_crtc *crtc);
-
 int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
 			struct drm_plane *plane,
 			uint32_t link_index);
-- 
2.53.0

