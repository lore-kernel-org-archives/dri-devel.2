Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0519606A326
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=E7d6i6we
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB7BB112124;
	Thu, 19 Nov 2026 08:25:02 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010066.outbound.protection.outlook.com [52.101.56.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6483E112117;
 Thu, 19 Nov 2026 08:24:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1yQJKURgHPW1oBQ1TuOrs9T35ftK4NkQIeW26ok8FgkJJfv0g0CNEnc+rpFVMh4d7LIzZfnnG1A3S4qgCynBkWbjiRuep7ndrumTUvVyD4TkT/DRVLhMi3hISU1l7O5gb9UUFMwqIqAhXeF841YoKoQdi0fPkLjXgcx1sq6a1qLugNa0zRrWt6PCtQXEZvWByAWYTSYmPuGIGOlbtlGwKCC2dPcYZa4aQ9PVRJug+XeyVMzKHOUMH3owFpw9/IfBDtXkfvQN8q/FCeFaeAByjTDCoYgz5C28FzAxIMqTSPe1j6BIZ+dJoL50o1hYZmeoD2nIO8TzFEksCxHdLhCaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vqhzg2VANxCZFPBRusFRa5QLxiEWrAYOzaWv4yeZa1o=;
 b=uKv3cVGXUgomLfR0d3Nefi1N49NBN/mEK4EJWnN7BvsdOXBY/kZMnkwVkRkNgJvnGl1CQksB3DIO33z9MgTt9LXPuXwBtnZ063W0boR+8qhKeLx9G1tV1Vlygg/rV03jbOP4Rl35iEUiSYU8krQ5ewdK5xXicUbHEddaluzpaS1B5si4TNQQTW2LmfKkQsRGTSef6NCDNRvQcXY79snh+O5Ov0V+i5BL4gq+AVW/9zZm6RZ64doFqG0Tr0k9QeAZ1XqRkN4n9ZWUUEzy+70EaeSKWPU0nw/YLgzqOr4iIXok04ffhv04faWcojpW0cL681WMkvd7ZLrVMv4/XdVZAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vqhzg2VANxCZFPBRusFRa5QLxiEWrAYOzaWv4yeZa1o=;
 b=E7d6i6weNwtykR8wCC5u12cUSdS30XMzaNim8PUosngIW73b0ZG7LGbXCk4vcV907VEedxA8THkyUCuByYjHnlkVVazWtFmPwRuwuzSnrQSViDg9OYunbg0MOGYDXfQD1PqT3yThgEZNbH156kjz+mAgeLDFt538EPg5jWlYuWY=
Received: from SN7P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::16)
 by DM4PR12MB7694.namprd12.prod.outlook.com (2603:10b6:8:102::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 08:24:48 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:124:cafe::d) by SN7P222CA0016.outlook.office365.com
 (2603:10b6:806:124::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 08:24:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 19 Nov 2026 08:24:48 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 02:24:44 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>, <tzimmermann@suse.de>,
 <ville.syrjala@linux.intel.com>, Prike Liang <Prike.Liang@amd.com>, "Harry
 Wentland" <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH v2 5/5] drm/amd/display: turn vblank off in DRM across GPU
 reset
Date: Thu, 19 Nov 2026 16:24:24 +0800
Message-ID: <20261119082424.554841-5-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119082424.554841-1-Prike.Liang@amd.com>
References: <20261119082424.554841-1-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|DM4PR12MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: d4341c54-598a-4bd8-27eb-08df4616936f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|261102123227099003|56012099006|261026140227099003|11063799006|261026121527099003|261021123027099003|261021121427099003|261028144727099003|10067099003|261022075727099003|261022105027099003|261022115727099003|261102130727099003|261009221227099003|261009223027099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TQoZV+zhGEEZWziLumiTa0w09/lT9rxq6xEhRXQEK+zt0FMlHlgLZwzcM3OSVuXfVcFBZ7qFOQs3oOrjO8vscAVsPgpTmdQwMHHB9Wpy62w9jMqLDXu/eqCltR3u8eYM3QswFW+ww85gphup6CBvuFyXRI4GW4uW088akaRV6a8KwpZG9iIl2c8e2zNLVz6fekXndmmuRud6UHKnU4DAWBbYtpijig0fw4O649g6ppMu/zvQLL2P84sxvzELXv3rC9/9UiEbNrSCxqROz0h40mmbt+ERyAVSmovXjZY3S1GB5OpL3WB+w2OBaccNZIfwY1iKv+Vnlyix0f1Dc7fdmjhY4uz90TDAFxX6d3T3vUJO5OMmQ/wUQ8beuenWAq7z2F5aaOmNKdX/0zV6K/BdLMdDPjXQrosU8lyi+vRhwIKmN7KkEo0qNg5jWarih+lo/FThxm1VKIj918M9Lc89fw20ObxVcmWdgGT1OXM64u4u7tSKAG03P/v3gM2x1v37I/oi8eaRePfv5a12wNKnejCRQTkFJ90S9zvZ19MhYhzFqDwhNg0Qf5DsIsqg6L5JzcRbAyjZv466oeoyFkNoQuhRfOVjF/5CrGSeyVqQsJjmufEu9et4LkvB3m6ZiVphbvxz+DimndWW3jD31N8uhvmnd+mCuPs2zf5Qs3biF3DxfluUH3jwCVVEyDVUcm7Y07aHhQdqJWKjLsmB+atqLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(261102123227099003)(56012099006)(261026140227099003)(11063799006)(261026121527099003)(261021123027099003)(261021121427099003)(261028144727099003)(10067099003)(261022075727099003)(261022105027099003)(261022115727099003)(261102130727099003)(261009221227099003)(261009223027099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KnfkJPzG3jyNaRWOqEuIOHVmUex/g/VUqBU4YLVq4ZTei44iIs/ZxKJfYE1hxWqLRlRedKARCMMbOS/JNclWCzqEwcidJVLS66U0emXlNENxho0jofGFvqh1zk62lAsx+LyiYBO7dqQqi8gyDc1aK3zMtBbKFJ4+Up/eApF7xv8o4cGYnXGnv8acPcG7PFNF96FDI9TK3TB8UdSUXxy646SSRgKAUvFV27qCpmj5V01o5jVE9A5Djbw6rd9Ft9MlK1jWN+RJjt4s9WviusKPavrVt3G6o7+GFKOBczXHGZgRr/A/jg4O99TqpPk60mVHmIRCMZw5G+GrMlkbEydmYbsVoSvesGS8bu6fh94zObqm/spwhqccJT0UIgsWIVFAlE3u6ZFvqY1MJKYvqolLU09NxnY+XZYsbl0e4DG0/v7p8L4+HxwhECAaBc/xaokM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 08:24:48.5954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4341c54-598a-4bd8-27eb-08df4616936f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7694
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
index 3bf6b407bfdf..35bbdbe0ff1d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1502,6 +1502,56 @@ STATIC_IFN_KUNIT void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
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
@@ -1636,6 +1686,7 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
 			return -ENOMEM;
 		}
 
+		dm_gpureset_toggle_vblank(adev, dm->cached_dc_state, false);
 		dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, false);
 
 		res = amdgpu_dm_commit_zero_streams(dm->dc);
@@ -1975,6 +2026,7 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 		dm_gpureset_commit_state(dm->cached_dc_state, dm);
 
 		dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, true);
+		dm_gpureset_toggle_vblank(adev, dm->cached_dc_state, true);
 
 		dc_state_release(dm->cached_dc_state);
 		dm->cached_dc_state = NULL;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index c2b6d4abd9c7..75a5c0309998 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1354,6 +1354,7 @@ void mmhub_read_system_context(struct amdgpu_device *adev,
 			       struct dc_phy_addr_space_config *pa_config);
 int amdgpu_dm_init_power_module(struct amdgpu_display_manager *dm);
 void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev, struct dc_state *state, bool enable);
+void dm_gpureset_toggle_vblank(struct amdgpu_device *adev, struct dc_state *state, bool enable);
 enum dc_status amdgpu_dm_commit_zero_streams(struct dc *dc);
 int dm_cache_state(struct amdgpu_device *adev);
 void dm_destroy_cached_state(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 99f2a6a41970..2cfdd3a77521 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -5415,6 +5415,113 @@ static void dm_test_gpureset_toggle_interrupts_dcn(struct kunit *test)
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
@@ -5669,6 +5776,11 @@ static struct kunit_case amdgpu_dm_tests[] = {
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

