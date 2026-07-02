Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326EAC44501
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:21:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F4C010F19B;
	Thu,  2 Jul 2026 07:21:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="lVL4QmpA";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4E3310F187;
 Thu,  2 Jul 2026 07:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1782976884;
 bh=BDqEyaLSf5oPui7QLPP/4vffKV9STElBBLDe6hW029Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lVL4QmpATSJIP0E+eLpgYl3xk29Ud+VvPreCg/Jo+5nJ4kry4JHORrKrCxDaIQWPH
 7XJQKB5nROwUeMRrhm7XmjGD3GX23n53sb+0bN1VQDEltpA0BnQTaxmtk6LUGSnZoa
 dgFuIpjtiK1WIMYQTX8ZByKi4y4rY5VQw7TKz8rKVVhmZGOl3kSYxgKX9yewsQyTeE
 76jzEz0CIjlY81V2SMslb+PprTGb6PNq11rxZG6MZ4DqC7S6kgpI9FGnE2uyPNMiOy
 AqFahJACMgeKWJadNvUpZZlfypaHYvUOgpgy/fVkUHF8TWCGQsJXJL942/UBVlzsHk
 2vhWrsEJF1f3g==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-xe@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [PATCH 04/10] drm/intel/display: Convert vblank event handling to
 2-stage arming
Date: Thu,  2 Jul 2026 09:21:47 +0200
Message-ID: <20260702072154.171324-5-dev@lankhorst.se>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702072154.171324-1-dev@lankhorst.se>
References: <20260702072154.171324-1-dev@lankhorst.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This is converts the vblank functions to be called with interrupts
disabled, even on PREEMPT_RT kernels.

Because the PREEMPT_RT kernel converts all spinlocks to rt-mutexes,
the normal vblank functions cannot be used inside the critical section.

Instead, prepare the vblank at the start, and then enable the vblank
work after the hardware programming is completed.

This allows us to keep programming the hardware with interrupts
disabled, and still schedule completion on PREEMPT_RT on next vblank.

Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/gpu/drm/i915/display/intel_crtc.c | 84 ++++++++++++-----------
 1 file changed, 44 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_crtc.c b/drivers/gpu/drm/i915/display/intel_crtc.c
index 805645318747f..34a159f7c9a43 100644
--- a/drivers/gpu/drm/i915/display/intel_crtc.c
+++ b/drivers/gpu/drm/i915/display/intel_crtc.c
@@ -527,6 +527,10 @@ static void intel_crtc_vblank_work_init(struct intel_crtc_state *crtc_state)
 
 	drm_vblank_work_init(&crtc_state->vblank_work, &crtc->base,
 			     intel_crtc_vblank_work);
+
+	drm_vblank_work_schedule_disabled(&crtc_state->vblank_work,
+					  drm_crtc_accurate_vblank_count(&crtc->base) + 1);
+
 	/*
 	 * Interrupt latency is critical for getting the vblank
 	 * work executed as early as possible during the vblank.
@@ -571,6 +575,21 @@ int intel_scanlines_to_usecs(const struct drm_display_mode *adjusted_mode,
 				adjusted_mode->crtc_clock);
 }
 
+static void intel_crtc_arm_vblank_event(struct intel_crtc_state *crtc_state)
+{
+	struct intel_crtc *crtc = to_intel_crtc(crtc_state->uapi.crtc);
+	unsigned long irqflags;
+
+	if (!crtc_state->uapi.event)
+		return;
+
+	drm_WARN_ON(crtc->base.dev, drm_crtc_vblank_get(&crtc->base) != 0);
+
+	spin_lock_irqsave(&crtc->base.dev->event_lock, irqflags);
+	drm_crtc_prepare_arm_vblank_event(&crtc->base, crtc_state->uapi.event);
+	spin_unlock_irqrestore(&crtc->base.dev->event_lock, irqflags);
+}
+
 /**
  * intel_pipe_update_start() - start update of a set of display registers
  * @state: the atomic state
@@ -607,6 +626,8 @@ void intel_pipe_update_start(struct intel_atomic_state *state,
 
 	if (intel_crtc_needs_vblank_work(new_crtc_state))
 		intel_crtc_vblank_work_init(new_crtc_state);
+	else
+		intel_crtc_arm_vblank_event(new_crtc_state);
 
 	if (state->base.legacy_cursor_update) {
 		struct intel_plane *plane;
@@ -684,23 +705,6 @@ static void dbg_vblank_evade(struct intel_crtc *crtc, ktime_t end)
 static void dbg_vblank_evade(struct intel_crtc *crtc, ktime_t end) {}
 #endif
 
-static void intel_crtc_arm_vblank_event(struct intel_crtc_state *crtc_state)
-{
-	struct intel_crtc *crtc = to_intel_crtc(crtc_state->uapi.crtc);
-	unsigned long irqflags;
-
-	if (!crtc_state->uapi.event)
-		return;
-
-	drm_WARN_ON(crtc->base.dev, drm_crtc_vblank_get(&crtc->base) != 0);
-
-	spin_lock_irqsave(&crtc->base.dev->event_lock, irqflags);
-	drm_crtc_arm_vblank_event(&crtc->base, crtc_state->uapi.event);
-	spin_unlock_irqrestore(&crtc->base.dev->event_lock, irqflags);
-
-	crtc_state->uapi.event = NULL;
-}
-
 void intel_crtc_prepare_vblank_event(struct intel_crtc_state *crtc_state,
 				     struct drm_pending_vblank_event **event)
 {
@@ -754,29 +758,10 @@ void intel_pipe_update_end(struct intel_atomic_state *state,
 	 * event outside of the critical section - the spinlock might spin for a
 	 * while ... */
 	if (intel_crtc_needs_vblank_work(new_crtc_state)) {
-		drm_vblank_work_schedule(&new_crtc_state->vblank_work,
-					 drm_crtc_accurate_vblank_count(&crtc->base) + 1,
-					 false);
-	} else {
-		intel_crtc_arm_vblank_event(new_crtc_state);
-	}
-
-	if (state->base.legacy_cursor_update) {
-		struct intel_plane *plane;
-		struct intel_plane_state *old_plane_state;
-		int i;
-
-		for_each_old_intel_plane_in_state(state, plane, old_plane_state, i) {
-			if (old_plane_state->hw.crtc == &crtc->base &&
-			    old_plane_state->unpin_work.vblank) {
-				drm_vblank_work_schedule(&old_plane_state->unpin_work,
-							 drm_crtc_accurate_vblank_count(&crtc->base) + 1,
-							 false);
-
-				/* Remove plane from atomic state, cleanup/free is done from vblank worker. */
-				memset(&state->base.planes[i], 0, sizeof(state->base.planes[i]));
-			}
-		}
+		drm_vblank_work_enable(&new_crtc_state->vblank_work);
+	} else if (new_crtc_state->uapi.event) {
+		drm_crtc_arm_prepared_vblank_event(new_crtc_state->uapi.event);
+		new_crtc_state->uapi.event = NULL;
 	}
 
 	/*
@@ -800,6 +785,25 @@ void intel_pipe_update_end(struct intel_atomic_state *state,
 
 	local_irq_enable();
 
+	/* Run after local_irq_enable(), not timing sensitive */
+	if (state->base.legacy_cursor_update) {
+		struct intel_plane *plane;
+		struct intel_plane_state *old_plane_state;
+		int i;
+
+		for_each_old_intel_plane_in_state(state, plane, old_plane_state, i) {
+			if (old_plane_state->hw.crtc == &crtc->base &&
+			    old_plane_state->unpin_work.vblank) {
+				drm_vblank_work_schedule(&old_plane_state->unpin_work,
+							 drm_crtc_accurate_vblank_count(&crtc->base) + 1,
+							 false);
+
+				/* Remove plane from atomic state, cleanup/free is done from vblank worker. */
+				memset(&state->base.planes[i], 0, sizeof(state->base.planes[i]));
+			}
+		}
+	}
+
 	if (intel_parent_vgpu_active(display))
 		goto out;
 
-- 
2.53.0

