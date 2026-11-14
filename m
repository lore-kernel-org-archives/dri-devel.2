Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB264606A327
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UeGeggtV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A55810F043;
	Sat, 14 Nov 2026 16:25:21 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4158C10E665
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 01:44:06 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c5083bc0e28so314849866b.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 17:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794620644; x=1795225444; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VhzDk/0P7t86MVcw1NLuypzKVGHVFOfLDCe4I/LxAp8=;
 b=UeGeggtVAjDTXN7azPpByWLzSwA0+rjoHpvbPjgt59WVjgjOowv7CYrCaL5V42h4If
 F3koh+yAELG/44SmHlLX0GidnQdF1JhImOEDCnR1IUStQmh4H8OftlhIxNJWZz6PNdMS
 I7ag4f3Xwxc4lFqPBOiyDe8eE1TauUgjYfsQXPTMmAZMfa1fHC66zn6/iilvCV2wyfss
 bjnKdxl69yqp/TmBG45s+zc/nOHdQH6rBLonXW+MZwN+6AZ5U1AmM6/DKO6GkW0egDHn
 dVmYCElxZuPN3qmC5wMR+h2Ho10MH50Qjdsr3ndx8NULpQ04aME+GAZL6jMxdSS68Znu
 WeqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794620644; x=1795225444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VhzDk/0P7t86MVcw1NLuypzKVGHVFOfLDCe4I/LxAp8=;
 b=DclpiHaDj4vJa78pwQV2eBxkEHfF+Ji6gNOOxqNa3L8F/C40z7N5Z1icL5wTzr8tFx
 rUoSyd3VhePgkLsoCh5ZG7+Ml/c7jRBiySqe1k7N7HkmhUAWJAs/natXMIDTbgfXQh5l
 Ji7C3uqGE07UQXHV3yDVJuAhG/eGt7J7Oni5EqqtzcbAPM+JM/nkOmolWOnCuvTHSbjq
 c2ZNfceRbjXLhfP0kfiecqKsGD809GNck2QCkP5sbYtnwqgm9lCWVW0MN6ES9xWXk2NQ
 lEPzAPQpLmanWNJyynSiI5rlXMoD1qGCJji5039HBn/+g+mASGGIvkySzdtp4TPGJ4m4
 LEpg==
X-Forwarded-Encrypted: i=1;
 AL+hErE32VJj4uk/cSUdWTo7wL/jkMNq1dny3ACPgkOgH0eVL6/CGMII3hwyTdQBmSg5zrTC41MXvTrhoNU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9tI73f1itsg9lM0j2eeWV/ipNRxkicmJbqpiDZy80/h9D4RvK2
 yBsqJU0OuL5JBUjVvsJezQig8L8m1ftrqIi3Y/N2VA9D5vegb62+bYWu
X-Gm-Gg: AYBFou1D4kUrzb5og70yBx85nju/I+nQnxuP3W6j03zWzz+L3svqiWfZohImLniigp9
 3ROk8ckGrhPQymMovSTzYbJUfFUrLEbormsHjr86ceNUXWygWOQO3TxBdnXm+Ex4TXgHuEkmUVe
 zMKqRF5yjk/cPE3K8JUf14xgHwNPIQk+H3RUBf3WBitTYIx+hR3LUnPsC2n7gj//Pl66TVbVNMg
 mVeJk/Q18WcPAWy1I5zr1q40HlD1Fg3ZB5gwHO/n5NgdMVpyFP9xbqmna2qTM30W7/Ldhs2oGk9
 /nZqWLekKz9ufWwf11C4dc+OiYVk6d9qQPQKCK74WNsJwCu4dQLF9YK8lHitbc8c8H4UxIvDcb3
 D1m+QjnUCwpyujjUkS3heHmaDvVP1eZU1T+Uk+DwIAkmgecPwbzCWa01Plr2+mJH7PELxsSfhoq
 7JZk9ncN3SlKbXvuPSjiA9oTSaswGG82CqX9I4x+kCtuVt7vFydW0AoAtZSr5VOZ4/LSi/7JGFe
 B0ZDYpANqVEKhXLHL/YV/1TgLuHe0cqPfRsAWhqiMlzSXr/PfOa+vqBpXCfhij2PpgLB2doBAEY
 kqpQu4ay4wvHch3JTjcwnHpiZcJiBlumIbc6lU42LxGHNRyi5apG3bkbKDgwX3NvxXrMDJNuSfJ
 wy+xgavxj8iy6prcdF4iRqww=
X-Received: by 2002:a17:907:3e07:b0:c4d:4d5b:849b with SMTP id
 a640c23a62f3a-c50963408demr386393866b.19.1794620644542; 
 Fri, 13 Nov 2026 17:44:04 -0800 (PST)
Received: from SMOK.angora-ide.ts.net
 (mm-156-219-126-178.vitebsk.dynamic.pppoe.byfly.by. [178.126.219.156])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b5a4c1sm161402666b.48.2026.11.13.17.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 17:44:04 -0800 (PST)
From: ElXreno <elxreno@gmail.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net,
 ville.syrjala@linux.intel.com, ankit.k.nautiyal@intel.com,
 mitulkumar.ajitkumar.golani@intel.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 ElXreno <elxreno@gmail.com>
Subject: [PATCH 7/7] drm/i915/vrr: Allow VRR with the pipe joiner
Date: Sat, 14 Nov 2026 04:43:35 +0300
Message-ID: <20261114014335.2132756-8-elxreno@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114014335.2132756-1-elxreno@gmail.com>
References: <20261114014335.2132756-1-elxreno@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 16:24:47 +0000
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VRR has been limited to the fixed refresh rate timing generator with
the joiner, as the transcoder level VRR operations were not sequenced
against the pipe level updates of the joined pipes. That keeps VRR
away from every mode that needs the joiner, such as 3840x2400@240 on
the eDP panels of current 18" laptops.

The transcoder is now programmed only by the joiner primary, and on
the MMIO path all joined pipes are armed inside one vblank evasion
critical section, with the push sent at its end. Take that path for
VRR with the joiner and let VRR through.

A commit whose new state has VRR enabled with the joiner does not use
the DSB. The push must not be sent before every joined pipe has been
armed, but each pipe runs its own DSB and nothing orders them against
each other. Leaving the push to the DSB of the primary, on the
grounds that it is committed last, is not enough. The secondary's DSB
waits for the safe window after it has armed (DSB_OPCODE_WAIT_VBLANKS
with the safe window chicken bits, then the wait in
intel_dsb_wait_for_delayed_vblank()). When the primary's push ends
the safe window before the secondary's DSB gets there, that DSB waits
for the safe window of the next frame, and it is still busy when
intel_dsb_wait() gives it 1 ms after the flip of the primary has
completed:

 [CRTC:271:pipe B] DSB 0 timed out waiting for idle (current head=0x100, head=0x0, tail=0x140)

That is what a port which only skips the push on the secondaries
gives, 13 times in 27 minutes of desktop use on Arrow Lake. The DSB
of a secondary can't check on the push either: commit c3571a239e10
("drm/i915/vrr: Check that the push send bit is clear after delayed
vblank") notes that reading TRANS_PUSH from it ends in a DSB response
timeout.

The LUT load has the same ordering problem: a colour DSB either sends
the push itself or has to be ordered against the push that the CPU
sends, on each pipe. So no colour DSB is prepared for such a commit
either, and the LUTs are loaded the way they are without one: ahead
of the commit when they can be preloaded, by the vblank worker after
it otherwise, in which case the commit takes the per pipe critical
sections, or with MMIO inside the critical section on the platforms
with double buffered LUTs. The commit that turns VRR off has no VRR
push to order and keeps its colour DSBs, which are then started from
inside the joined critical section.

One thing changes for joined modes even while VRR is off, as it
follows vrr.in_range: the sink is told to ignore the MSA timing
parameters during link training, as for any other mode within the
VRR range.

intel_vrr_compute_config() does not ask for LRR with the joiner, and
DC balance is kept off, each with a FIXME. The vblank delay fastset
that reuses the LRR code is not touched: where it applies (inherited
state, or the always on VRR timing generator) it still writes the
transcoder timings from every joined pipe, with identical values.

Signed-off-by: ElXreno <elxreno@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_color.c   |  4 +++
 drivers/gpu/drm/i915/display/intel_display.c |  4 +++
 drivers/gpu/drm/i915/display/intel_vrr.c     | 31 ++++++++++++--------
 drivers/gpu/drm/i915/display/intel_vrr.h     |  1 +
 4 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_color.c b/drivers/gpu/drm/i915/display/intel_color.c
index 4070dc8d97d9..08d1c999637e 100644
--- a/drivers/gpu/drm/i915/display/intel_color.c
+++ b/drivers/gpu/drm/i915/display/intel_color.c
@@ -2023,6 +2023,10 @@ void intel_color_prepare_commit(struct intel_atomic_state *state,
 	if (!crtc_state->pre_csc_lut && !crtc_state->post_csc_lut)
 		return;
 
+	/* TODO sequence the LUT load vs. the VRR push for joined pipes via DSB */
+	if (intel_vrr_needs_mmio_commit(crtc_state))
+		return;
+
 	if (HAS_DOUBLE_BUFFERED_LUT(display))
 		crtc_state->dsb_color = intel_dsb_prepare(state, crtc, INTEL_DSB_0, 1024);
 	else
diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 1fda1bb15674..8f30337c8967 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -7681,6 +7681,10 @@ intel_atomic_commit_type(struct intel_atomic_state *state,
 	if (new_crtc_state->do_async_flip)
 		return INTEL_COMMIT_MMIO;
 
+	/* TODO sequence the VRR push for joined pipes via DSB */
+	if (intel_vrr_needs_mmio_commit(new_crtc_state))
+		return INTEL_COMMIT_MMIO;
+
 	/* TODO handle VRR with flip queue */
 	if (intel_flipq_supported(display) &&
 	    !new_crtc_state->vrr.enable &&
diff --git a/drivers/gpu/drm/i915/display/intel_vrr.c b/drivers/gpu/drm/i915/display/intel_vrr.c
index 668c495e7407..6543c140e2b5 100644
--- a/drivers/gpu/drm/i915/display/intel_vrr.c
+++ b/drivers/gpu/drm/i915/display/intel_vrr.c
@@ -450,6 +450,10 @@ intel_vrr_dc_balance_compute_config(struct intel_crtc_state *crtc_state)
 	    !crtc_state->vrr.enable || !display->params.enable_dc_balance)
 		return;
 
+	/* FIXME figure out DC balance with joined pipes */
+	if (crtc_state->joiner_pipes)
+		return;
+
 	crtc_state->vrr.dc_balance.vmax = crtc_state->vrr.vmax;
 	crtc_state->vrr.dc_balance.vmin = crtc_state->vrr.vmin;
 	crtc_state->vrr.dc_balance.max_increase =
@@ -495,21 +499,11 @@ intel_vrr_compute_config(struct intel_crtc_state *crtc_state,
 	crtc_state->vrr.in_range =
 		intel_vrr_is_in_range(connector, drm_mode_vrefresh(adjusted_mode));
 
-	/*
-	 * Allow fixed refresh rate with VRR Timing Generator.
-	 * For now set the vrr.in_range to 0, to allow fixed_rr but skip actual
-	 * VRR and LRR.
-	 * #TODO For actual VRR with joiner, we need to figure out how to
-	 * correctly sequence transcoder level stuff vs. pipe level stuff
-	 * in the commit.
-	 */
-	if (crtc_state->joiner_pipes)
-		crtc_state->vrr.in_range = false;
-
 	vmin = intel_vrr_compute_vmin(crtc_state);
 
 	if (crtc_state->vrr.in_range) {
-		if (HAS_LRR(display))
+		/* FIXME sequence the LRR timing update for joined pipes */
+		if (HAS_LRR(display) && !crtc_state->joiner_pipes)
 			crtc_state->update_lrr = true;
 		vmax = intel_vrr_compute_vmax(connector, adjusted_mode);
 	} else {
@@ -832,6 +826,19 @@ void intel_vrr_check_push_sent(struct intel_dsb *dsb,
 	}
 }
 
+/*
+ * A VRR push latches all joined pipes at once, so it may be sent only
+ * after every one of them has been armed. Each pipe runs its own DSB
+ * and nothing orders the DSBs of the joined pipes against each other,
+ * so they can't sequence that between themselves. Such commits take
+ * the MMIO path, where the joined pipes are armed inside one vblank
+ * evasion critical section.
+ */
+bool intel_vrr_needs_mmio_commit(const struct intel_crtc_state *crtc_state)
+{
+	return crtc_state->vrr.enable && crtc_state->joiner_pipes;
+}
+
 bool intel_vrr_is_push_sent(const struct intel_crtc_state *crtc_state)
 {
 	struct intel_display *display = to_intel_display(crtc_state);
diff --git a/drivers/gpu/drm/i915/display/intel_vrr.h b/drivers/gpu/drm/i915/display/intel_vrr.h
index 19c7990be1b2..a72ffba47a80 100644
--- a/drivers/gpu/drm/i915/display/intel_vrr.h
+++ b/drivers/gpu/drm/i915/display/intel_vrr.h
@@ -32,6 +32,7 @@ void intel_vrr_check_push_sent(struct intel_dsb *dsb,
 			       const struct intel_crtc_state *crtc_state);
 void intel_vrr_dcb_increment_flip_count(struct intel_crtc_state *crtc_state,
 					struct intel_crtc *crtc);
+bool intel_vrr_needs_mmio_commit(const struct intel_crtc_state *crtc_state);
 bool intel_vrr_is_push_sent(const struct intel_crtc_state *crtc_state);
 void intel_vrr_disable(const struct intel_crtc_state *old_crtc_state);
 void intel_vrr_psr_frame_change_enable(const struct intel_crtc_state *crtc_state);
-- 
2.56.0

