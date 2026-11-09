Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6872E606A33F
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EVJQU01t
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6503A10EE98;
	Tue, 10 Nov 2026 08:33:41 +0000 (UTC)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com
 [209.85.210.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3276E10E291
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 23:02:45 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id
 46e09a7af769-85f34b20042so801762a34.0
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 15:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794265364; x=1794870164; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=a4krrjNNHrHpQ9XaCev1J8mXOobYD6TWbvvVIVTH+Og=;
 b=EVJQU01t/8S8XhWcYqMNHoHCmtY/lNLHw/wlAx2vYr42HdilAF9wjnvQYwFEROg661
 wOkXdHj8DleQWuZnGY7W9VdajUXIVfI/hdVAKLDF2UJKxHEH3Rh0rWpv7S5Wo6qBwCxd
 7pNYnRWpv8YjtOP7Gp6xgQDGCbI5GFmafuTfhblOe6b+HKehWV+tzP+5hxllmcDJuWDR
 puS54jCOrzrg8FHO0HhYzdx0TRVlPVa4s892LDz4CzbvLuK6nbSz9ydAGdnn6HJZXy8l
 KMJre6SN6Fdpwq8D5GCh3TCkXhSEFUHPGILDCpy6SEiQqyB8X1uxvQBTUkJHaAAYSP+u
 E9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794265364; x=1794870164;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a4krrjNNHrHpQ9XaCev1J8mXOobYD6TWbvvVIVTH+Og=;
 b=DAX+KGlE5bqGNQl8ihwWOmn43GKIVG2rN52le3Raa6otSkAVYgj5ftnASY9jrjRQI6
 M7KXAgF3WvTxAWqdfX5fKKypxyMvfR5137nLaSMbsp8a+73fvhb4C4qUCfO25G45lAX0
 HCbagd5ibekY5XtmHrs06IZjELN6/Ciwt/1hHS1/uySZ64NOP29Y48Zfj8AVI9XfK9bb
 yV/kRMqrbtH3bpH42ZoVyjZ4mZ+LsdWpaLmoUuSCK1zlHnsiHQOra6Q0/+qaEsYmoUkB
 WRD0Yt1gDXlFbExFJSbZeK5d33YVjLuvfPE1WFnBN9OcU/iYgYv7KDAzfW6nHpQMFfpN
 Zg3w==
X-Forwarded-Encrypted: i=1;
 AL+hErFGsqZH6Jv98BD+I9frWXfqg59noCyaC8XEuAS9nymhaqGfah2tvGWPOQOmojIKIVIgRZZjuiTQiNM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z94sOp/39uc74ZF+IgqX5LIClRaZpxduZQdc72B0tysCbfUiOgo
 IVON9bAoJQejuu0ByRWpNhCNhUetrhuNKJ0aqHLwJYOhe0I6Ep73MUGx
X-Gm-Gg: AYBFou26Cu4zyGzq7EVRSGCWiS78saIBKOSvljMKMpPz7J6Hzm6kwliC2d8TLywQnkJ
 ty0goALmm5zxcEjaiMOeXrMa0FacYh/2J7ted+gFS4B5riqHInuybTaC3GdZyKGK4Di6+avZw3A
 UnTkeBgc9zukbiTdga2DXJzo9eCHudbOEZY08wnCnU1eN4rjSINE77nVyYvs0f+PbKLUw+xu5KK
 lcxc/TJg1mJEHEoCn123BwiENl+LG/BSS9ODZ45VvkvSoV17BjMXJ5OIsUvZw814ytpuuRs7Bgr
 siWzCwdXfXV3pITUxR8VrLFGy8ox8hCi9nYssYT6/decrch0YrhXDJzCdyvRhnFBnBikXSJx7OV
 tq4umEaN9Q3NuPt49VqFLctPGRM/OI/hq6PP39bnGrxjjIecYLD96cCaqJThZnZ5PvpBj6Pu2W7
 6BGVOLrcleW8jHTz8iwv3BuXVbZ3diWaJYut4h3Asmuv+RjjaQgScCqKZchBnRlLTWEDSGPuanY
 jBu/HuMCVqwmdf6ovz0gW4zPasrkafhZ9n0/fAbCrzC25VIFZXXKR8OWiAtQddIZemNo2YuYnRB
 mrNt7YQsi5Qh2yemphdYZfjB7P5RvDpYxGIRuYDfZB4t4IoCSbv0A7b/fDkhqd9xLTntsCSl4Zj
 4hHBhcRrYOaxIaedpAHBDoWjMU1ilqYrEfwSryySYqjsW
X-Received: by 2002:a05:6830:2705:b0:85f:4b0f:ca75 with SMTP id
 46e09a7af769-860dc5b6b7bmr654994a34.3.1794265364158; 
 Mon, 09 Nov 2026 15:02:44 -0800 (PST)
Received: from desktop ([68.248.142.83]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-860dca41bdcsm560771a34.2.2026.11.09.15.02.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 15:02:43 -0800 (PST)
From: Claudio Forain <claudioforain@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
 ray.wu@amd.com, superm1@kernel.org, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, Claudio Forain <claudioforain@gmail.com>
Subject: [PATCH] drm/amd/display: Only allow idle optimizations when all CRTCs
 are idle
Date: Mon,  9 Nov 2026 17:01:47 -0600
Message-ID: <20261109230147.16302-1-claudioforain@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 08:33:28 +0000
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
CRTC. When a CRTC's ISM reaches OPTIMIZED_IDLE it enables idle
optimizations globally as long as no CRTC holds a vblank reference
(dm->active_vblank_irq_count == 0). It does not check whether the ISMs
of the other CRTCs are idle.

With two displays on X11, one static and one receiving cursor updates,
the static CRTC's ISM enables idle optimizations while the cursor CRTC is
busy. Legacy cursor updates do not take a vblank reference, so nothing
vetoes it. On ASICs that set debug.exit_idle_opt_for_cursor_updates
(DCN30x, DCN32x, DCN401, ...), every call to
dc_stream_program_cursor_attributes() and
dc_stream_program_cursor_position() then exits and re-enters idle
optimizations itself. That is up to four synchronous DMUB commands per
cursor update, each taking up to ~1.6 ms on DCN401, all under dc_lock in
the X server's input thread. The cursor visibly speeds up and slows down
while the desktop is otherwise idle.

Measured on RX 9070 XT (DCN401), 240 Hz + 60 Hz displays, Xorg, cursor
moving continuously for 15 s (ftrace, cursor handler entry to
dc_stream_program_cursor_position entry):

                                 before      after
  cursor updates/s                1686        2572
  latency median / P95 / P99    144/858/927  17/19/87 us
  samples > 500 us                5460           0
  idle opt calls from cursor   58093           0
    programming
  dcn401_apply_idle_power_
    optimizations calls          58198           6

With a single display, or with any vblank requestor active, the issue
does not occur. Commit a1fc7bf6677e ("drm/amd/display: Restore 5s vbl
offdelay for NV3x+ DGPUs") hid the issue by keeping vblank enabled on the
cursor CRTC; it reappeared with commit f39283eab44f ("Revert
"drm/amd/display: Restore 5s vbl offdelay for NV3x+ DGPUs"").

[How]
Before allowing idle optimizations, also require every CRTC with an
active stream to be in OPTIMIZED_IDLE or OPTIMIZED_IDLE_SSO. The ISM
updates current_state before dispatching, so the last CRTC to go idle
still allows idle optimizations and no idle entry is lost. Idle
optimizations are still entered on a static desktop (173 entries in a
15 s static capture with the patch applied), idle GPU power is
unchanged (25.9 W before, 25.8 W after), and vblank enable/disable is
unchanged.

The problem was found and the fix written with an AI coding assistant,
working from ftrace captures taken on the affected system: function
tracer counts and caller attribution, and function_graph durations of
the cursor, ISM and DMUB paths. The assistant proposed the change and
drafted this changelog; the submitter reproduced the issue, built and
ran each test kernel, and confirmed the results.

Fixes: 754003486c3c ("drm/amd/display: Add Idle state manager(ISM)")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/6115
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/4906
Assisted-by: claude-opus-5-5
Signed-off-by: Claudio Forain <claudioforain@gmail.com>
---
Testing and limitations:
- Reproduced and tested on v7.3.3 (Gentoo) with RX 9070 XT (DCN401),
  Xorg, two DP displays (240 Hz + 60 Hz). The issue reproduces only with
  both displays active; disabling one makes stock 7.3.3 behave.
- Built and booted on v7.3.3. This posting is rebased onto
  amd-staging-drm-next, where it applies cleanly, but it has not been
  built or run on that tree.
- Not tested: other DCN generations, APUs, PSR/Replay panels (the
  OPTIMIZED_IDLE_SSO path), Wayland compositors, hotplug and
  suspend/resume with the patch, and the ISM KUnit tests.
- Idle GPU power on a static desktop (hwmon power1_average, 40 x 1 s):
  25.9 W before, 25.8 W after. Only checked on this setup.
- crtc->state is read under dc_lock only, like the existing
  to_dm_crtc_state(acrtc->base.state) in amdgpu_dm_ism_commit_event().

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
index 127eaba..79546ad 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
@@ -276,6 +276,32 @@ bool dm_ism_trigger_event(struct amdgpu_dm_ism *ism,
 EXPORT_IF_KUNIT(dm_ism_trigger_event);
 
 
+/*
+ * Idle optimizations are HW-wide, but each CRTC runs its own ISM. Only allow
+ * them once every active CRTC's ISM has reached an optimized idle state, so a
+ * static CRTC cannot enable idle optimizations while another CRTC is still busy
+ * (e.g. receiving cursor updates without a vblank reference). Otherwise every
+ * cursor update on the busy CRTC must exit and re-enter idle through DMUB.
+ */
+static bool dm_ism_all_crtcs_idle(struct amdgpu_display_manager *dm)
+{
+	struct drm_crtc *crtc;
+
+	drm_for_each_crtc(crtc, adev_to_drm(dm->adev)) {
+		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
+		struct dm_crtc_state *state = to_dm_crtc_state(crtc->state);
+
+		if (!state || !state->stream)
+			continue;
+
+		if (acrtc->ism.current_state != DM_ISM_STATE_OPTIMIZED_IDLE &&
+		    acrtc->ism.current_state != DM_ISM_STATE_OPTIMIZED_IDLE_SSO)
+			return false;
+	}
+
+	return true;
+}
+
 static void dm_ism_commit_idle_optimization_state(struct amdgpu_dm_ism *ism,
 					     struct dc_stream_state *stream,
 					     bool vblank_enabled,
@@ -326,7 +352,8 @@ static void dm_ism_commit_idle_optimization_state(struct amdgpu_dm_ism *ism,
 	 * optimizations at the start of this func -- we should disallow
 	 * whenever there's *an* active CRTC.
 	 */
-	if (!vblank_enabled && dm->active_vblank_irq_count == 0) {
+	if (!vblank_enabled && dm->active_vblank_irq_count == 0 &&
+	    dm_ism_all_crtcs_idle(dm)) {
 		dc_post_update_surfaces_to_stream(dm->dc);
 		dc_allow_idle_optimizations(dm->dc, true);
 	}
-- 
2.x
