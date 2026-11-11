Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7094606A334
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QcZt3Hnq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7D8510F9B0;
	Wed, 11 Nov 2026 08:56:08 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013020.outbound.protection.outlook.com
 [40.93.196.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3517910F9B6;
 Wed, 11 Nov 2026 08:56:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PncRhnsDvlX61jNH6qoGvHnKhrt6y2UiceKSUm5fS1AAm75Kjb5+jHLeq24ZG0pccs/e4PJz8PGqzgW0A/hABgKXhu2xIzeMcvEM5wf9rjvq8O1ytWR3n67yH0EE8KAhn/6sMy8orXOCTVKlSvP4DSVhUOkuWSBQXJQlYwnfq0xDuIg19Isex5QS7OJF9h1QZW3+iPu+SMeuSdpX1JPnsaoA4QnkrMv4Q2dNVsDNUuJy73yYhlYrIm+HPKgiGm8rxU1TE7BFJrklT01CbAza/XouhcdzgTQv07ulQX2AizOZeQoKKbmdHfN0ixJLMruK6Zo1GsT/mupKvmXZLIOKSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rOWxTlen22JcR6oipTFNGUL5w7sUigTzpxNLw3GkuI=;
 b=R9UN/lDSjbSCfsmotP2JAtZw4pgrO/uHnfUMRDONTCr8zyNtqoTk+1s5OhUZnjM/pMt7SjRa2WGX5IjZ83gXnNkrAfYclJl+kgmXHI7NygFAk7RH71Wt7m21WDES7MuDVCEb7fRL1ae2WUMpV57JEJNeZm9Gmif/dt8BEfejw78mSBKrAAQJxQgP/B0EUR1y2rGvl5xuDdOZPoMWpXPqTlMB/7iPs807KVrdZMVA6pTEknY8ce+Y1YOF3dExkF2S3RkpfUQ6zjAAEGJmN6iUAUpgVlohufh9cGaJw2LXToq8hv8Tb/rHgT9/s61sKa61jReHPtR5GVqHP506//vm/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rOWxTlen22JcR6oipTFNGUL5w7sUigTzpxNLw3GkuI=;
 b=QcZt3Hnqn2cvEvx3L/5dN0KNTBMyqgVjKOMumHaEEWZpISSR9/R8GrZID8qF03vnArrEDv6zgzC7wNtMYeluFNbV+2U7R6hs0NsVf6tY4M6ZbA0QJhaVy65pZPxtQKe/aYGB8lQ/PA4kyh6rpWOhK9yjfBkBBSPoJIAepNNRGZo=
Received: from DM6PR02CA0147.namprd02.prod.outlook.com (2603:10b6:5:332::14)
 by LY0PR12MB563561.namprd12.prod.outlook.com (2603:10b6:404:203::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 08:55:56 +0000
Received: from DM3PEPF000265BE.namprd04.prod.outlook.com
 (2603:10b6:5:332:cafe::ab) by DM6PR02CA0147.outlook.office365.com
 (2603:10b6:5:332::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 08:55:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265BE.mail.protection.outlook.com (10.167.23.251) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 08:55:55 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 02:55:51 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>, <tzimmermann@suse.de>, "Prike
 Liang" <Prike.Liang@amd.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li
 <sunpeng.li@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH RESEND 4/5] drm/amd/display: turn vblank off in DRM across GPU
 reset
Date: Wed, 11 Nov 2026 16:55:33 +0800
Message-ID: <20261111085534.514957-4-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111085534.514957-1-Prike.Liang@amd.com>
References: <20261111085534.514957-1-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BE:EE_|LY0PR12MB563561:EE_
X-MS-Office365-Filtering-Correlation-Id: fa0d2a84-f9bd-462d-d90c-08df3fd198da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|18002099003|22082099003|6133799003|261009221227099003|56012099006|11063799006|261021121427099003|261102130727099003|261102123227099003|261009223027099003|261022115727099003|261022075727099003|10067099003|261022105027099003|261026121527099003|261026140227099003|261021123027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: kjeYkUATZuJj9tuSdCmD0hVSC2r/PfZzvXHrhZYJYVGKVP3JERPrgxltZlm1LZOq6wA2J982ay7A7rsmJ34HPABWt3h9RbcOVSY49ZWLv8mk/bpq4OSKbbD9SFnGDL6wsyPn8lKUR0vVvUiCtnSsUsyzUw4N1QSjcQJ0Bck9gajh0QYn1hOyyIFT1HbLWkltWJRO6OwO4tnkYffu1eDwSKud9ymLsGrQLRi8m3RxcNUlHE2EKWsD8Xr5blLP9VN5Wwh4aykQLjpl9Mfo9cgKh63sbeFGf5ol2SCYyiDu96kdaR6SXPX93UD0OOA45MO7ZOFcob96xrDs89oAfGSTyIb1uzKkYNgUSKRwtb9lsnZMaPq/NIE3Eum6XitrCl/2GOjgbHhFhteKoITzWwS6dTuEH0yJS1gNuPToWlbXdb88pIiX138mF1dqiI982ygNA1Jhki7sYPqu7BZjIu8I39njnpNGuvZkbfvMV89PYJuN9m8YCuTnRKrAlWfoVJ7bMb/E3+H7vX1TI9N6juaDWrcqugA8zb3iywNn3s41MyuPLzYUkuZOogAqktzWAakC6JZ8porKd1V66WQQ8dGREq0h4Dfpzz/B9UE2dEAMk2iq+x/2Vagp4EoXNwZCftcBhFBHriyNeiD3cSUeL+mgDqUcFIbdSpgodKD9piTYX8fTCVC1xo5diOdoDFBH2jmcwU39eDYGHN4AYhWspIdZGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(18002099003)(22082099003)(6133799003)(261009221227099003)(56012099006)(11063799006)(261021121427099003)(261102130727099003)(261102123227099003)(261009223027099003)(261022115727099003)(261022075727099003)(10067099003)(261022105027099003)(261026121527099003)(261026140227099003)(261021123027099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gEI+xuEfPZg3m+skFr3sWOJcumktwfC/gXOGcCm+GyF/t0RfNqNSWHBW9cXMTc/z2c4cURGBkfekWKPwu2kFxnrqbLKKp3+RvxPvtGqWqLceVTiuzMPyJhNsA4kLnjd+MEnMgPd+aJbJ3W6trjnrPg7TunXRGM+u9qLLOmqfLUon/pvoMwZ7eZZFOMoP16fvVLfiHmqNUqdaZ+6AKys4p6mPmwDeEf7PtrQTA/ISX+L8ysDtK6JZZTrwozNBXNLRdeBXy+8HzY6DGDZwyJe/TbR+CduifKNwF3K10o/yaPnT0exE7+qC8pihsVEmJ+CXP8K1Qfy74dsSJYT+PKm94LsghzGkX3kqtKbp7gtsxfDnxuuwNi4+WQyMkCPpAOnWJN9YRYQSr2/4RIZ0aeFj0EPRcsdkpc1PqM7r0lR50BlNck+emBM8cj1dkPZn1f60
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 08:55:55.4342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0d2a84-f9bd-462d-d90c-08df3fd198da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265BE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB563561
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

For a GPU reset, dm_suspend() stops all streams with
amdgpu_dm_commit_zero_streams() and toggles the OTG interrupts
directly, and dm_resume() restores the cached DC state the same way.
Neither goes through manage_dm_interrupts(), so DRM is never told that
vblank stops: drm_crtc_vblank_get() keeps succeeding while no vblank
interrupt can arrive until the streams are back.

Since commit ebc3351cc4a9 ("drm/amdgpu: remove suspend/resume DRM
clients during GPU recovery"), the fbdev client keeps running during
recovery, and its damage worker rate-limits display updates with
drm_client_modeset_wait_for_vblank(). Every display update during the
reset then waits for a vblank that never comes, until the wait times
out and warns:

  amdgpu 0000:03:00.0: [drm] vblank wait timed out on crtc 0
  WARNING: drivers/gpu/drm/drm_vblank.c:1320 at drm_crtc_wait_one_vblank+0x194/0x200
  Workqueue: events drm_fb_helper_damage_work
  Call Trace:
   drm_client_modeset_wait_for_vblank+0x63/0x80
   drm_fb_helper_damage_work+0x89/0x1a0

FBIO_WAITFORVSYNC runs into the same timeout, and DRM_IOCTL_WAIT_VBLANK
sleeps until its own 3 second timeout.

Do what a regular CRTC disable does: call drm_crtc_vblank_off() for the
CRTCs of the cached DC state before their streams are stopped, and
drm_crtc_vblank_on_config() with their existing configuration once the
streams and interrupts are restored. drm_crtc_vblank_get() then fails
for the duration of the reset, so drm_client_modeset_wait_for_vblank()
doesn't wait at all, and DRM_IOCTL_WAIT_VBLANK waiters are woken up.
Page flips that get to amdgpu_dm_commit_planes() meanwhile have their
event sent right away, see the previous patch.

drm_crtc_vblank_off() also clears the vblank timestamping constants,
which a modeset sets again before it turns vblank back on. Recompute
them from the CRTC state after the reset as well; otherwise the vblank
timestamp query in drm_crtc_vblank_on_config() warns about an
uninitialized mode.

A modeset that waits for dc_lock during the reset may be turning one of
these CRTCs off. Leave vblank off for a CRTC that is no longer enabled;
amdgpu_dm_crtc_set_vblank() would refuse to enable vblank on it anyway.

Neither call can block on the reset: drm_crtc_vblank_off() only takes
spinlocks and flushes the DRM vblank worker, which DM doesn't use, and
amdgpu_dm_crtc_set_vblank() doesn't queue vblank_control_work during a
reset. Unlike suspending the DRM clients, this doesn't make recovery
wait for anything that may itself depend on the reset.

Add KUnit tests for the new helper.

Fixes: ebc3351cc4a9 ("drm/amdgpu: remove suspend/resume DRM clients during GPU recovery")
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Assisted-by: Copilot:claude-opus-5.5
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  52 ++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 112 ++++++++++++++++++
 3 files changed, 165 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d3882ffcb5d4..007968e892c8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1496,6 +1496,56 @@ STATIC_IFN_KUNIT void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
 }
 EXPORT_IF_KUNIT(dm_gpureset_toggle_interrupts);
 
+/**
+ * dm_gpureset_toggle_vblank() - Turn DRM vblank off or on around a GPU reset
+ * @adev: amdgpu device
+ * @state: DC state whose streams the reset stops and restores
+ * @enable: false before the streams are stopped, true once they are restored
+ *
+ * The GPU reset path stops and restores the streams through DC directly and
+ * bypasses manage_dm_interrupts(). Turn vblank off in DRM like a CRTC
+ * disable does, so that drm_crtc_vblank_get() fails while no vblank
+ * interrupt can arrive, instead of letting vblank waiters such as the fbdev
+ * damage worker sleep until they time out.
+ */
+STATIC_IFN_KUNIT void dm_gpureset_toggle_vblank(struct amdgpu_device *adev,
+						struct dc_state *state, bool enable)
+{
+	struct drm_vblank_crtc_config config;
+	struct amdgpu_crtc *acrtc;
+	int i;
+
+	for (i = 0; i < state->stream_count; i++) {
+		int otg_inst = state->stream_status[i].primary_otg_inst;
+
+		acrtc = amdgpu_dm_get_crtc_by_otg_inst(adev, otg_inst);
+		if (!acrtc)
+			continue;
+
+		if (!enable) {
+			drm_crtc_vblank_off(&acrtc->base);
+			continue;
+		}
+
+		/*
+		 * A modeset waiting for dc_lock may be turning the CRTC off,
+		 * and amdgpu_dm_crtc_set_vblank() refuses to enable vblank on
+		 * it then. Leave its vblank off.
+		 */
+		if (!acrtc->base.enabled)
+			continue;
+
+		/* drm_crtc_vblank_off() cleared the timestamping constants. */
+		drm_calc_timestamping_constants(&acrtc->base,
+						&acrtc->base.state->adjusted_mode);
+
+		/* Keep the off delay that manage_dm_interrupts() configured. */
+		config = drm_crtc_vblank_crtc(&acrtc->base)->config;
+		drm_crtc_vblank_on_config(&acrtc->base, &config);
+	}
+}
+EXPORT_IF_KUNIT(dm_gpureset_toggle_vblank);
+
 DEFINE_FREE(state_release, struct dc_state *, dc_state_release(_T))
 
 STATIC_IFN_KUNIT enum dc_status amdgpu_dm_commit_zero_streams(struct dc *dc)
@@ -1630,6 +1680,7 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
 			return -ENOMEM;
 		}
 
+		dm_gpureset_toggle_vblank(adev, dm->cached_dc_state, false);
 		dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, false);
 
 		res = amdgpu_dm_commit_zero_streams(dm->dc);
@@ -1969,6 +2020,7 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 		dm_gpureset_commit_state(dm->cached_dc_state, dm);
 
 		dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, true);
+		dm_gpureset_toggle_vblank(adev, dm->cached_dc_state, true);
 
 		dc_state_release(dm->cached_dc_state);
 		dm->cached_dc_state = NULL;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index f8503ebf28f4..303e9a57e7b8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1351,6 +1351,7 @@ void mmhub_read_system_context(struct amdgpu_device *adev,
 			       struct dc_phy_addr_space_config *pa_config);
 int amdgpu_dm_init_power_module(struct amdgpu_display_manager *dm);
 void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev, struct dc_state *state, bool enable);
+void dm_gpureset_toggle_vblank(struct amdgpu_device *adev, struct dc_state *state, bool enable);
 enum dc_status amdgpu_dm_commit_zero_streams(struct dc *dc);
 int dm_cache_state(struct amdgpu_device *adev);
 void dm_destroy_cached_state(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index ebec1260c510..ed2e65bad674 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -5232,6 +5232,113 @@ static void dm_test_gpureset_toggle_interrupts_dcn(struct kunit *test)
 	dm_gpureset_toggle_interrupts(adev, state, true);
 }
 
+/* Tests for dm_gpureset_toggle_vblank() */
+
+/*
+ * One stream on the OTG of the CRTC from dm_test_irq_mgmt_ctx_alloc(), which
+ * is enabled with a 1080p60 mode and has its vblank set up like on a regular
+ * CRTC enable: timestamping constants first, then manage_dm_interrupts().
+ */
+static struct dc_state *dm_test_gpureset_vblank_state(struct kunit *test,
+						      struct dm_test_irq_mgmt_ctx *ctx)
+{
+	struct drm_display_mode *mode = &ctx->acrtc_state->base.adjusted_mode;
+	struct dc_state *state = dm_kunit_alloc_dc_state(test);
+
+	mode->crtc_clock = 148500;
+	mode->crtc_htotal = 2200;
+	mode->crtc_vtotal = 1125;
+	ctx->acrtc->base.state = &ctx->acrtc_state->base;
+	ctx->acrtc->base.enabled = true;
+	drm_calc_timestamping_constants(&ctx->acrtc->base, mode);
+	ctx->adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 1, 2);
+	manage_dm_interrupts(ctx->adev, ctx->acrtc, ctx->acrtc_state);
+
+	state->stream_count = 1;
+	state->stream_status[0].primary_otg_inst = ctx->acrtc->otg_inst;
+
+	return state;
+}
+
+/**
+ * dm_test_gpureset_toggle_vblank_off - Test vblank is off while streams are down
+ * @test: The KUnit test context
+ *
+ * drm_crtc_vblank_get() has to fail, or vblank waiters such as the fbdev
+ * damage worker sleep until they time out.
+ */
+static void dm_test_gpureset_toggle_vblank_off(struct kunit *test)
+{
+	struct dm_test_irq_mgmt_ctx *ctx = dm_test_irq_mgmt_ctx_alloc(test);
+	struct dc_state *state = dm_test_gpureset_vblank_state(test, ctx);
+	struct drm_crtc *crtc = &ctx->acrtc->base;
+
+	KUNIT_ASSERT_EQ(test, drm_crtc_vblank_get(crtc), 0);
+	drm_crtc_vblank_put(crtc);
+
+	dm_gpureset_toggle_vblank(ctx->adev, state, false);
+
+	KUNIT_EXPECT_FALSE(test, ctx->adev->ddev.vblank[0].enabled);
+	KUNIT_EXPECT_EQ(test, drm_crtc_vblank_get(crtc), -EINVAL);
+}
+
+/**
+ * dm_test_gpureset_toggle_vblank_on - Test vblank comes back with its config and mode
+ * @test: The KUnit test context
+ */
+static void dm_test_gpureset_toggle_vblank_on(struct kunit *test)
+{
+	struct dm_test_irq_mgmt_ctx *ctx = dm_test_irq_mgmt_ctx_alloc(test);
+	struct dc_state *state = dm_test_gpureset_vblank_state(test, ctx);
+	struct drm_crtc *crtc = &ctx->acrtc->base;
+
+	dm_gpureset_toggle_vblank(ctx->adev, state, false);
+	dm_gpureset_toggle_vblank(ctx->adev, state, true);
+
+	/* manage_dm_interrupts() derived this off delay from the timing. */
+	KUNIT_EXPECT_EQ(test, ctx->adev->ddev.vblank[0].config.offdelay_ms, 34);
+	/* Vblank timestamps need the mode that drm_crtc_vblank_off() cleared. */
+	KUNIT_EXPECT_EQ(test, ctx->adev->ddev.vblank[0].hwmode.crtc_clock, 148500);
+	KUNIT_ASSERT_EQ(test, drm_crtc_vblank_get(crtc), 0);
+	drm_crtc_vblank_put(crtc);
+}
+
+/**
+ * dm_test_gpureset_toggle_vblank_no_crtc - Test streams without a CRTC are skipped
+ * @test: The KUnit test context
+ */
+static void dm_test_gpureset_toggle_vblank_no_crtc(struct kunit *test)
+{
+	struct dm_test_irq_mgmt_ctx *ctx = dm_test_irq_mgmt_ctx_alloc(test);
+	struct dc_state *state = dm_test_gpureset_vblank_state(test, ctx);
+	struct drm_crtc *crtc = &ctx->acrtc->base;
+
+	state->stream_status[0].primary_otg_inst = ctx->acrtc->otg_inst + 1;
+
+	dm_gpureset_toggle_vblank(ctx->adev, state, false);
+
+	KUNIT_ASSERT_EQ(test, drm_crtc_vblank_get(crtc), 0);
+	drm_crtc_vblank_put(crtc);
+}
+
+/**
+ * dm_test_gpureset_toggle_vblank_crtc_disabled - Test a disabled CRTC stays off
+ * @test: The KUnit test context
+ *
+ * A modeset that waits for the reset to finish may be turning the CRTC off.
+ */
+static void dm_test_gpureset_toggle_vblank_crtc_disabled(struct kunit *test)
+{
+	struct dm_test_irq_mgmt_ctx *ctx = dm_test_irq_mgmt_ctx_alloc(test);
+	struct dc_state *state = dm_test_gpureset_vblank_state(test, ctx);
+
+	dm_gpureset_toggle_vblank(ctx->adev, state, false);
+	ctx->acrtc->base.enabled = false;
+	dm_gpureset_toggle_vblank(ctx->adev, state, true);
+
+	KUNIT_EXPECT_EQ(test, drm_crtc_vblank_get(&ctx->acrtc->base), -EINVAL);
+}
+
 static struct kunit_case amdgpu_dm_tests[] = {
 	/* Simple DM callbacks */
 	KUNIT_CASE(dm_test_wait_for_idle),
@@ -5481,6 +5588,11 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_initialize_plane_overlay),
 	/* dm_gpureset_toggle_interrupts */
 	KUNIT_CASE(dm_test_gpureset_toggle_interrupts_dcn),
+	/* dm_gpureset_toggle_vblank */
+	KUNIT_CASE(dm_test_gpureset_toggle_vblank_off),
+	KUNIT_CASE(dm_test_gpureset_toggle_vblank_on),
+	KUNIT_CASE(dm_test_gpureset_toggle_vblank_no_crtc),
+	KUNIT_CASE(dm_test_gpureset_toggle_vblank_crtc_disabled),
 	{}
 };
 
-- 
2.34.1

