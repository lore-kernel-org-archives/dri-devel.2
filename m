Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEA7606A329
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UkJPpQpa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FA2F10ED16;
	Mon, 16 Nov 2026 08:59:57 +0000 (UTC)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
 [209.85.210.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44C5E10E4B9
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 00:14:48 +0000 (UTC)
Received: by mail-ot1-f52.google.com with SMTP id
 46e09a7af769-862aca1ed4dso459708a34.0
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 16:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794788087; x=1795392887; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hajHB6HzF67vIT/RkiyTzXzkwKgwGw3/XSrXRBWaGzk=;
 b=UkJPpQpaBqy2R6xncTaK53bYzBk8v5tnKQc+iPtG3LWQzB7Ke4rpqp5AIY88q2QBXB
 DOJNKZEkgvS35Fc/I+oOyey7Mpbq5DAexeWfV3LhM0hjXLzFrql/hChAf0/5TnBv9A+T
 vy5Oo8EMl5wKK4pharm6vJTFf3UbbH3CqY72qwpDgvZE+SalwC+TEDxXCKYJrBgElENS
 J5/i5ZzDLwwq+UXpXEva6MNsMVwodnOKSi47FbtTesLC533r1HkFuQ3ETuHRnp6X/cII
 Ua6PAyAA24pjRxLdha7bNyR3feNNWVECwsHj9gXIHQBasK8IHvUVVry9Uzl7/mk9O8Fo
 TDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794788087; x=1795392887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hajHB6HzF67vIT/RkiyTzXzkwKgwGw3/XSrXRBWaGzk=;
 b=GylemvYvaNnL6EKodXz4GZNFQ/3YM+BvB+zFTNMljBEqbEve+VrUeHEYLmBrwhL9Ow
 gzuoId5H6hW5X1qUK8nfCLiGj4oP4DX5aBwQem7LzaniTjqNCbd8QLiUtrN4WhS+FPNw
 3b4s7KAWCRSk6YBIZXlIXXM1Djcmfgn0us3YPDYD2tIKcCJAZN8aDnENgk332m0niAzH
 X+R0SSxPG622xI10E7ZUJqQ9qYX753+UYPCuAmJZru7Wdl6J1TF/H2fT9dhMitv6lvFi
 PjTC/4hS194GodSimNt92FEnrlswSqbANwmVuS4WQOUxLx+phHzrOnVt5Iad5+BuMktm
 rIog==
X-Forwarded-Encrypted: i=1;
 AL+hErEw+SSHjmuhRvKyAlQoYHHDMVldSwmHxtsDex0RiZ4qDDixHH2nJ7FrYu1VXVoZHn55Ays59gJ37hc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+ISmfCrGIpkXY0tKljYbjrSuKMKkYtyfpP/SvVETSjAzFdllkK
 N9HjuZfyFV+9LxTmMoGt9RKorEIs9XjlXoMfET6qejpN8CIMZWgKkl/m
X-Gm-Gg: AYBFou0kNde+3SttAcKJ3GCeERPcqsrWg5DOlxwU2M15E1Ys8Voow/O7FEayH0Coa+I
 jg/DAkvhfJfzTk6F72hXcKAdKzTNnEMLuBvZ2gkgw6BzeqKv7NjmSQtOEl70ULxYXtmZoyb0kW0
 myCRnRsSH9R6p01xpiuQZ5VkjVsZfsotfjYSy2XG/1KodH5hdhqhHTNlUb/G4cwdIP6BHa2rePO
 46CN9AxGETSoBAxp6Ngxl4I4SzhKopV1dryOJP8/NM3Ez1iPKFPQN68PhZ+WUHOhoQ73KDzqQhY
 Sut0Lm9XGbhm2pLRvoBV9sK1Qoc2GQAz55iXFFdIlR18GkgUjFajDP5dm/wMFMeFB+E8+/q8Da2
 mDUVuannsFBIsGTEyj2ECHWLNqnhhMIMCfnJJjh3D2xOivpsjH/9pXnDCWb8lBswoIKIPEsO3rQ
 CBvIiyJEMHm5+MjW0zFJxpjwbXsEIIoRxXUIMHa1Q23/VsvDQQmbth5+BakS9/CI/QDBx8uy70C
 /K9hQ3pS1eWB7tbo/M/dyFKy13jszyLQ9+bE+5zRehDnDU21FQHLpsB+k8Dx8k4sWlkVV0MpyS/
 VH5vowy3VMvkSWSIlF6LbYkU4UAWX6ZD+r4hcWR1ft4aL3I+VhJHRvpkBf1ZLt9r437wPlQ69L+
 moxpQKOZBlK+iJTDeCtXtQEmPtQHLCtxo956++vX/BQDO
X-Received: by 2002:a05:6808:2386:b0:567:dc9f:c83f with SMTP id
 5614622812f47-56e642d3183mr8069796b6e.14.1794788086920; 
 Sun, 15 Nov 2026 16:14:46 -0800 (PST)
Received: from desktop ([68.248.142.83]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-56e6dcfc483sm8495537b6e.1.2026.11.15.16.14.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 16:14:46 -0800 (PST)
From: Claudio Forain <claudioforain@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
 ray.wu@amd.com, alex.hung@amd.com, superm1@kernel.org, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, Claudio Forain <claudioforain@gmail.com>
Subject: [PATCH v2] drm/amd/display: Disallow idle on cursor update during ISM
 hysteresis
Date: Sun, 15 Nov 2026 18:11:51 -0600
Message-ID: <20261116001151.28754-1-claudioforain@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109230147.16302-1-claudioforain@gmail.com>
References: <20261109230147.16302-1-claudioforain@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 16 Nov 2026 08:58:46 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

[Why]
Idle optimizations are HW-wide, but the Idle State Manager (ISM) runs per
CRTC. With two displays, a static CRTC's ISM reaches OPTIMIZED_IDLE and
allows idle optimizations while another CRTC is receiving legacy cursor
updates, which hold no vblank reference. The cursor CRTC's ISM then sits in
HYSTERESIS_WAITING, and BEGIN_CURSOR_UPDATE only moves it to
HYSTERESIS_BUSY without touching idle.

Every cursor update then calls dc_stream_program_cursor_attributes(),
which exits and re-enters idle through synchronous DMUB commands. On DCNs
that set debug.exit_idle_opt_for_cursor_updates,
dc_stream_program_cursor_position() does the same, for up to four DMUB
commands per cursor update under dc_lock. On Xorg with an RX 9070 XT
(DCN401) the cursor visibly speeds up and slows down.

ISM tracing on v7.3.3 while moving the cursor: of 12675 cursor updates that
started in HYSTERESIS_WAITING, 9172 ran with idle allowed; none of the 866
that started in FULL_POWER_RUNNING did, as vblank was enabled there.

[How]
When BEGIN_CURSOR_UPDATE moves a CRTC from HYSTERESIS_WAITING to
HYSTERESIS_BUSY, disallow idle. The CRTC's hysteresis timer, re-armed on
END_CURSOR_UPDATE, allows idle again once the cursor stops. Only idle is
touched; static screen optimizations are left alone. FULL_POWER states
are not changed: no timer is pending there that would allow idle again.
The change is not DCN specific, as the cursor attributes path exits idle
on every DCN.

With this change, the same trace shows none of 22732 cursor updates
running with idle allowed, and idle is allowed again once the cursor
stops. Static desktop GPU power is unchanged (25.9 W average over 40 s,
with and without the change).

Add KUnit tests for the veto and for FULL_POWER_RUNNING leaving idle
untouched.

Fixes: 754003486c3c ("drm/amd/display: Add Idle state manager(ISM)")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/6115
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/4906
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Claudio Forain <claudioforain@gmail.com>
---

Notes:
    v2:
    - New approach. v1 allowed idle only when every CRTC was idle, which read
      other CRTCs' state under only dc_lock, could leave idle disallowed for
      good after a CRTC was enabled or resumed static, and broke the ISM KUnit
      commit tests (all found by the sashiko.dev review). v2 keeps the
      per-CRTC model: it only disallows idle when a cursor update starts on a
      CRTC in hysteresis, and that CRTC's own timer allows it again. No other
      CRTC's state is read.
    - Call dc_allow_idle_optimizations() directly rather than
      dm_ism_commit_idle_optimization_state(), which would also toggle the
      PSR/Replay static screen events on every cursor update. The veto shows
      in the amdgpu_dm_ism_event trace as HYSTERESIS_WAITING ->
      HYSTERESIS_BUSY on BEGIN_CURSOR_UPDATE, and in the DC IPS log with
      dm_ism_dispatch_power_state as the caller.
    - Add KUnit tests.
    
    v1: https://lore.kernel.org/r/20261109230147.16302-1-claudioforain@gmail.com/
    
    AI assistance: Claude Code (claude-opus-5-5) helped me trace the ISM and
    idle interaction, wrote the ftrace capture and analysis scripts, and
    drafted the code change, the KUnit tests and this changelog. I reviewed
    all of it and ran the traces, power measurements and KUnit tests myself.
    Before sending, I ran a local Sashiko review (with Claude) on v2. It
    found a KUNIT_ASSERT inside a scoped_guard, a redundant
    idle_optimizations_allowed check with a test that could not fail, and
    a changelog that understated which DCNs are affected; all are fixed here.
    
    Tested:
    - RX 9070 XT (DCN401), Xorg, two DP displays (240 Hz, and 60 Hz rotated),
      patch applied to v7.3.3: the ISM traces in the changelog, plus after
      DPMS off/on and after a modeset of the 60 Hz display. In both, idle was
      allowed again after the cursor stopped and no cursor update ran with
      idle allowed.
    - ISM KUnit suite on amd-staging-drm-next (UML): all pass.
    
    Not tested:
    - Suspend/resume: CONFIG_SUSPEND is not set on this machine, so I could
      not test it as I said I would in the v1 thread.
    - Other DCNs and APUs. With IPS, idle now stays off for the hysteresis
      window while the cursor moves instead of being exited and re-entered on
      every update; I have not measured the power impact there.
    - PSR/Replay panels and Wayland compositors.

 .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c |  17 +++
 .../amdgpu_dm/tests/amdgpu_dm_ism_test.c      | 110 ++++++++++++++++++
 2 files changed, 127 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
index 127eaba4de..21eeae66cb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
@@ -401,6 +401,23 @@ static enum amdgpu_dm_ism_event dm_ism_dispatch_power_state(
 			mod_delayed_work(system_dfl_wq, &ism->delayed_work,
 					 nsecs_to_jiffies(delay_ns));
 		break;
+	case DM_ISM_STATE_HYSTERESIS_BUSY:
+		/*
+		 * Idle optimizations are HW-wide, so another CRTC's ISM may have
+		 * allowed them while this CRTC was still in hysteresis. Every
+		 * cursor update would then exit and re-enter idle through DMUB.
+		 * Disallow idle when a cursor update starts here; this CRTC's
+		 * hysteresis timer, re-armed on END_CURSOR_UPDATE, allows it
+		 * again once the cursor stops. Only idle is touched, not static
+		 * screen optimizations.
+		 */
+		if (ism->previous_state == DM_ISM_STATE_HYSTERESIS_WAITING) {
+			struct amdgpu_crtc *acrtc = ism_to_amdgpu_crtc(ism);
+			struct dc *dc = drm_to_adev(acrtc->base.dev)->dm.dc;
+
+			dc_allow_idle_optimizations(dc, false);
+		}
+		break;
 	case DM_ISM_STATE_OPTIMIZED_IDLE:
 		sso_delay_ns = dm_ism_get_sso_delay(ism, acrtc_state->stream);
 		if (sso_delay_ns > 0) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c
index a9c6485e2a..6c51129826 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c
@@ -1375,6 +1375,114 @@ static void dm_test_ism_commit_disallows_idle_on_timer_aborted(struct kunit *tes
 	amdgpu_dm_ism_flush(&acrtc->ism);
 }
 
+/*
+ * Config and history shared by the cursor tests below: a non-zero idle-allow
+ * delay parks the FSM in HYSTERESIS_WAITING, and sso_num_frames = 0 lets the
+ * timer cascade straight to OPTIMIZED_IDLE_SSO.
+ */
+static const struct amdgpu_dm_ism_config dm_ism_test_cursor_config = {
+	.filter_num_frames = 5,
+	.filter_entry_count = 3,
+	.activation_num_delay_frames = 10,
+	.filter_history_size = 8,
+	.filter_old_history_threshold = 0,
+	.sso_num_frames = 0,
+};
+
+/**
+ * dm_test_ism_cursor_in_hysteresis_disallows_idle - cursor vetoes foreign idle
+ * @test: KUnit test context
+ *
+ * Idle optimizations are HW-wide; here another CRTC is modelled as having
+ * allowed them while this CRTC waits in HYSTERESIS_WAITING. A cursor update
+ * (BEGIN_CURSOR_UPDATE -> HYSTERESIS_BUSY) must disallow idle so that cursor
+ * programming does not exit and re-enter idle per update. END_CURSOR_UPDATE
+ * must re-arm the hysteresis timer without re-allowing, and the timer must
+ * allow idle again.
+ */
+static void dm_test_ism_cursor_in_hysteresis_disallows_idle(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc = alloc_test_acrtc(test, &adev);
+	struct amdgpu_dm_ism_config config = dm_ism_test_cursor_config;
+	struct dc_stream_state *stream;
+
+	stream = setup_commit_test(test, acrtc, &config);
+	setup_idle_delay_history(&acrtc->ism, stream);
+
+	scoped_guard(mutex, &adev->dm.dc_lock) {
+		amdgpu_dm_ism_commit_event(&acrtc->ism,
+					   DM_ISM_EVENT_ENTER_IDLE_REQUESTED);
+		KUNIT_EXPECT_EQ(test, (int)acrtc->ism.current_state,
+				(int)DM_ISM_STATE_HYSTERESIS_WAITING);
+
+		/* Another CRTC's ISM allowed HW-wide idle. */
+		adev->dm.dc->idle_optimizations_allowed = true;
+
+		amdgpu_dm_ism_commit_event(&acrtc->ism,
+					   DM_ISM_EVENT_BEGIN_CURSOR_UPDATE);
+		KUNIT_EXPECT_EQ(test, (int)acrtc->ism.current_state,
+				(int)DM_ISM_STATE_HYSTERESIS_BUSY);
+		KUNIT_EXPECT_EQ(test, dm_ism_test_idle.calls, 1);
+		KUNIT_EXPECT_FALSE(test, dm_ism_test_idle.last_allow);
+		KUNIT_EXPECT_FALSE(test, adev->dm.dc->idle_optimizations_allowed);
+
+		amdgpu_dm_ism_commit_event(&acrtc->ism,
+					   DM_ISM_EVENT_END_CURSOR_UPDATE);
+		KUNIT_EXPECT_EQ(test, (int)acrtc->ism.current_state,
+				(int)DM_ISM_STATE_HYSTERESIS_WAITING);
+		KUNIT_EXPECT_TRUE(test, delayed_work_pending(&acrtc->ism.delayed_work));
+		KUNIT_EXPECT_EQ(test, dm_ism_test_idle.calls, 1);
+		KUNIT_EXPECT_FALSE(test, adev->dm.dc->idle_optimizations_allowed);
+
+		/* Run the hysteresis timer's event by hand. */
+		cancel_delayed_work(&acrtc->ism.delayed_work);
+		amdgpu_dm_ism_commit_event(&acrtc->ism,
+					   DM_ISM_EVENT_TIMER_ELAPSED);
+		KUNIT_EXPECT_EQ(test, (int)acrtc->ism.current_state,
+				(int)DM_ISM_STATE_OPTIMIZED_IDLE_SSO);
+		KUNIT_EXPECT_EQ(test, dm_ism_test_idle.calls, 2);
+		KUNIT_EXPECT_TRUE(test, dm_ism_test_idle.last_allow);
+		KUNIT_EXPECT_TRUE(test, adev->dm.dc->idle_optimizations_allowed);
+	}
+
+	amdgpu_dm_ism_flush(&acrtc->ism);
+}
+
+/**
+ * dm_test_ism_cursor_in_full_power_leaves_idle - FULL_POWER cursor is a no-op
+ * @test: KUnit test context
+ *
+ * A CRTC in FULL_POWER_RUNNING has no pending hysteresis timer that would
+ * allow idle again, so a cursor update there must not disallow idle;
+ * otherwise idle could stay off after the cursor stops.
+ */
+static void dm_test_ism_cursor_in_full_power_leaves_idle(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc = alloc_test_acrtc(test, &adev);
+	struct amdgpu_dm_ism_config config = dm_ism_test_cursor_config;
+
+	setup_commit_test(test, acrtc, &config);
+	adev->dm.dc->idle_optimizations_allowed = true;
+
+	scoped_guard(mutex, &adev->dm.dc_lock) {
+		amdgpu_dm_ism_commit_event(&acrtc->ism,
+					   DM_ISM_EVENT_BEGIN_CURSOR_UPDATE);
+		KUNIT_EXPECT_EQ(test, (int)acrtc->ism.current_state,
+				(int)DM_ISM_STATE_FULL_POWER_BUSY);
+		amdgpu_dm_ism_commit_event(&acrtc->ism,
+					   DM_ISM_EVENT_END_CURSOR_UPDATE);
+		KUNIT_EXPECT_EQ(test, (int)acrtc->ism.current_state,
+				(int)DM_ISM_STATE_FULL_POWER_RUNNING);
+
+		KUNIT_EXPECT_EQ(test, dm_ism_test_idle.calls, 0);
+		KUNIT_EXPECT_TRUE(test, adev->dm.dc->idle_optimizations_allowed);
+	}
+
+	amdgpu_dm_ism_flush(&acrtc->ism);
+}
+
 /**
  * dm_test_ism_exit_from_optimized_idle_disallows_idle - leaving OPTIMIZED_IDLE
  * @test: KUnit test context
@@ -1615,6 +1723,8 @@ static struct kunit_case dm_ism_test_cases[] = {
 	KUNIT_CASE(dm_test_ism_commit_allows_idle_on_optimized_idle),
 	KUNIT_CASE(dm_test_ism_commit_enables_sso_on_optimized_idle_sso),
 	KUNIT_CASE(dm_test_ism_commit_disallows_idle_on_timer_aborted),
+	KUNIT_CASE(dm_test_ism_cursor_in_hysteresis_disallows_idle),
+	KUNIT_CASE(dm_test_ism_cursor_in_full_power_leaves_idle),
 	/* dm_ism_dispatch_power_state previous-state arms */
 	KUNIT_CASE(dm_test_ism_exit_from_optimized_idle_disallows_idle),
 	KUNIT_CASE(dm_test_ism_exit_from_sso_disallows_idle),
-- 
2.56.0

