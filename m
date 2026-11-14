Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F26606A32D
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PSlAsAlB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 760FB10ECA6;
	Sat, 14 Nov 2026 16:24:48 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11AE210E2D1
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 01:44:04 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-c4d581da0aaso241492166b.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 17:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794620642; x=1795225442; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gVcYrHxuKjjRDsavX/u54wCI8Z5NBBro/KfpNW0Hgew=;
 b=PSlAsAlBKR1eJfNX0s3CCrfiFEzTUQqfrqtOZ4XRAIAMeGPMVzd7wfkCDRtrSfwD3C
 DOLLejzMzrOBfVsSV4F7z/47Yd/OVor5z5MaNNPdpOvLmkz0a6XM44QIlPRLSYbDps2t
 kEskpE1m0ue68ot1HyVvJN7Hp2V89tGnBfa8nUeUVcJmQfqLV2yvZdhXKTjiTvknNOke
 LdqBAEfD/OSCToueU9OijOwTdc8Iak1M2OzaP7h167/L+LseKBIpfslLiEQDICW1l/T6
 AAg5h0naC5EsL4KLp0SIEUWYr7vS1qVJMegalcYKXru+vwwo+4Am4oKsJUPiGKtIhfZV
 yYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794620642; x=1795225442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gVcYrHxuKjjRDsavX/u54wCI8Z5NBBro/KfpNW0Hgew=;
 b=xdnRKAlK7gp49AoOd/YPVrnxpYf6ZaMF4vHPsLuHCRlL5Tm1Xvs8Q8/92bmqV9+i3X
 GoSjc//SZhSBADWWdrMyGYembe0BPgX1PZGD42A5IW2ZPrk/nwBxg+5P2MnV5Wssz1U8
 Z2HONE5oGxXIdYh/h1FaBUFJOBoWtBQFSyWzOq+3svruIhFif/uz/KJx9ByUltEBMOU2
 Snade+6bDGSg+o7UeDMFAYH1KuaauV4scWseKfjPAuG0u5KLQyrzrokvnNP8Y8/dI655
 2x+cPRybKwPM2vB3DZqysH4fn2MCnpwiEXClKIjvl2ONv1OBcs/GRmW9J1ec2nTA3K7K
 hXRg==
X-Forwarded-Encrypted: i=1;
 AL+hErFjKBgxt/JVVpS7hgIy1o9ZMX8JrFoCRt5YU6fg7IfG9NmovZlu9ukLsrFb6jRMaT3n2qugYwUiLSU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/neW9HHxM8o6NzgmSiyFN36LeQzZcgJUitLQvKv+EX4CpKc45o
 86TLmIxRMQBk08tp9TlEwxEGJa2SOpvoyawCVugNazlmFgT6u5VDK9AZ
X-Gm-Gg: AYBFou2NcqL5GsINzxC7VOe3+xxxmW/QWo/c+kus8+UJy0XjNlC7+9+Ya18c000AR5H
 8S1FoXkx9zw48vfbJjDBiVGdObmGBF800Aq4zjU/5DfIko906vSvkY2wV+hmjI/Rd3AU+Q8gxoJ
 JT350daQv987KbK4otKJ2cV4o3X+wNLw5JmLMPaVckpFfrMuP86O1fAjz0QX4nK2jQM2Hkj1XAl
 ow6JCGeuwE774pSZejezCSUF5ZU1fupBuvItVgxpfU0k3pXF1+OOcNAlazdzlwMSA2R6L6Zz0kN
 LrRv8w9L/ja6ANEwRLk/8uOaWbWjAEjzvaFgzWV1r5GmkxZ5jX4MwuU3JK4oXQQN6j2i4eatIyq
 1mH9I8QyGiEjhkFXqkXrREI5nksd3IbMxW9qq3SBxPZZYxmECS3eDDD93bsl0WvS3EnlPtl1xRH
 egPymwOpzda88gNSHyxlmJL6f5LHgbfvizwzbI7zGPr42FjeT8MNpUkGOism/nIcLeCx78KpLiP
 th+JNWHGKiyA20RZt8gvDwYiCS+CnHjweTr2GEcJK+NwGauxeL+l27xrIMnEls31sOwt/oKQcol
 3AK3JHROudNaCUO+uSNK4bzGXBRLiDQoURk2CarZX3K7WVUdFHN4W/oONuHn8rkLusZPmJ9UrBj
 9uXgujkFprHprwQZl1dnVVeQ=
X-Received: by 2002:a17:907:96ac:b0:c29:3c97:c994 with SMTP id
 a640c23a62f3a-c50963bd677mr349321366b.35.1794620642059; 
 Fri, 13 Nov 2026 17:44:02 -0800 (PST)
Received: from SMOK.angora-ide.ts.net
 (mm-156-219-126-178.vitebsk.dynamic.pppoe.byfly.by. [178.126.219.156])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b5a4c1sm161402666b.48.2026.11.13.17.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 17:44:01 -0800 (PST)
From: ElXreno <elxreno@gmail.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net,
 ville.syrjala@linux.intel.com, ankit.k.nautiyal@intel.com,
 mitulkumar.ajitkumar.golani@intel.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 ElXreno <elxreno@gmail.com>
Subject: [PATCH 5/7] drm/i915: Arm joined pipes within one vblank evasion for
 VRR
Date: Sat, 14 Nov 2026 04:43:33 +0300
Message-ID: <20261114014335.2132756-6-elxreno@gmail.com>
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

All joined pipes run off the transcoder of the primary, so one vblank
latches every one of them. On the MMIO path each pipe nevertheless
goes through its own intel_pipe_update_start()/intel_pipe_update_end()
critical section, one pipe after another. When the vblank falls
between two of them the earlier pipe latches its new state a frame
ahead of the later one, and for that frame the halves of the screen
come from different frames.

With VRR that gets worse, as the commit ends the frame itself: the
push at the end of the primary's section latches whatever has been
armed by then. Commit the joined pipes together when VRR is in use:
do the vblank evasion once, on the primary, arm all of them inside
that critical section and let the primary send the push at its end.
The evasion accounting, the trace events and the atomic update
failure check then run once as well, for the primary.

Armed this way the critical section takes 15 us on average for two
pipes on Arrow Lake (71983 commits at 240 fps: 71918 under 30 us, 16
between 30 and 60 us, 49 between 60 and 188 us), against the 100 us
the evasion allows for. The window is not scaled with the number of
pipes. The 49 are single MMIO writes that stall, not more work: the
instruction count is that of an ordinary section, the CPU stays in
C0, there is no SMI or NMI, and the register differs from case to
case. The per pipe sections of the same mode without VRR and with
the DSB turned off show the same stalls (15 of 72002 sections over
60 us), so they do not come from arming two pipes in one section.
None of them ran into a vblank.

The per pipe sequence is kept where the critical section has per
pipe work attached or the pipes need sequencing against others:
modesets, the atomic fallback of a legacy cursor update, async flips,
commits that need the vblank worker for the LUT load and commits that
change the DDB allocation of a joined pipe. The vblank worker is
needed on the platforms without double buffered LUTs, when a colour
update or a fastset has LUTs to load that can neither be preloaded
nor be left to a colour DSB. Commits that go through the DSB or the
flip queue are not affected, and neither is the commit sequence of a
joined configuration without VRR. The latter has the same race
against the fixed vblank, it is left alone only to keep this change
to the case that can be tested with it.

On the platforms with double buffered LUTs there is no vblank worker.
Where no colour DSB is used the LUTs are loaded with MMIO inside the
critical section, which here is the joined one and then loads them
for all joined pipes. I have no such hardware and have not tested
that.

No functional change yet, VRR is not allowed with the joiner.

Signed-off-by: ElXreno <elxreno@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_crtc.c    |  2 +-
 drivers/gpu/drm/i915/display/intel_crtc.h    |  1 +
 drivers/gpu/drm/i915/display/intel_display.c | 88 ++++++++++++++++++++
 3 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_crtc.c b/drivers/gpu/drm/i915/display/intel_crtc.c
index 139c9dae536e..f41616a060b5 100644
--- a/drivers/gpu/drm/i915/display/intel_crtc.c
+++ b/drivers/gpu/drm/i915/display/intel_crtc.c
@@ -487,7 +487,7 @@ int intel_crtc_get_pipe_from_crtc_id_ioctl(struct drm_device *dev, void *data,
 	return 0;
 }
 
-static bool intel_crtc_needs_vblank_work(const struct intel_crtc_state *crtc_state)
+bool intel_crtc_needs_vblank_work(const struct intel_crtc_state *crtc_state)
 {
 	struct intel_display *display = to_intel_display(crtc_state);
 
diff --git a/drivers/gpu/drm/i915/display/intel_crtc.h b/drivers/gpu/drm/i915/display/intel_crtc.h
index 12507b51ee77..0478394b01e8 100644
--- a/drivers/gpu/drm/i915/display/intel_crtc.h
+++ b/drivers/gpu/drm/i915/display/intel_crtc.h
@@ -50,6 +50,7 @@ void intel_pipe_update_start(struct intel_atomic_state *state,
 			     struct intel_crtc *crtc);
 void intel_pipe_update_end(struct intel_atomic_state *state,
 			   struct intel_crtc *crtc);
+bool intel_crtc_needs_vblank_work(const struct intel_crtc_state *crtc_state);
 void intel_wait_for_vblank_workers(struct intel_atomic_state *state);
 struct intel_crtc *intel_first_crtc(struct intel_display *display);
 struct intel_crtc *intel_crtc_for_pipe(struct intel_display *display,
diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index aa03f674d93b..1fda1bb15674 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -7151,12 +7151,100 @@ static void intel_post_update_crtc(struct intel_atomic_state *state,
 	}
 }
 
+/*
+ * All joined pipes run off the transcoder of the primary, so one
+ * vblank latches every one of them, and with VRR the commit itself
+ * ends the frame with a push. The arming registers of all joined
+ * pipes then have to be written within a single vblank evasion
+ * critical section, with the push at its end, or the pipes may
+ * latch in different frames.
+ */
+static bool intel_crtc_needs_joined_update(struct intel_atomic_state *state,
+					   struct intel_crtc *crtc)
+{
+	struct intel_display *display = to_intel_display(state);
+	const struct intel_crtc_state *old_crtc_state =
+		intel_atomic_get_old_crtc_state(state, crtc);
+	const struct intel_crtc_state *new_crtc_state =
+		intel_atomic_get_new_crtc_state(state, crtc);
+	struct intel_crtc *pipe_crtc;
+
+	if (!new_crtc_state->joiner_pipes)
+		return false;
+
+	/* FIXME do this for the fixed refresh rate case as well */
+	if (!old_crtc_state->vrr.enable && !new_crtc_state->vrr.enable)
+		return false;
+
+	/* FIXME the cursor unpin works are set up per pipe */
+	if (state->base.legacy_cursor_update)
+		return false;
+
+	for_each_intel_crtc_in_pipe_mask(display, pipe_crtc,
+					 intel_crtc_joined_pipe_mask(new_crtc_state)) {
+		const struct intel_crtc_state *old_pipe_crtc_state =
+			intel_atomic_get_old_crtc_state(state, pipe_crtc);
+		const struct intel_crtc_state *new_pipe_crtc_state =
+			intel_atomic_get_new_crtc_state(state, pipe_crtc);
+
+		/* The DSB and the flip queue do their own vblank evasion */
+		if (new_pipe_crtc_state->commit_type != INTEL_COMMIT_MMIO)
+			return false;
+
+		if (intel_crtc_needs_modeset(new_pipe_crtc_state) ||
+		    new_pipe_crtc_state->do_async_flip)
+			return false;
+
+		/* FIXME the vblank work is set up per pipe */
+		if (intel_crtc_needs_vblank_work(new_pipe_crtc_state))
+			return false;
+
+		/*
+		 * A changed DDB allocation must be sequenced
+		 * against the other pipes one pipe at a time.
+		 */
+		if (!skl_ddb_entry_equal(&old_pipe_crtc_state->wm.skl.ddb,
+					 &new_pipe_crtc_state->wm.skl.ddb))
+			return false;
+	}
+
+	return true;
+}
+
+static void intel_update_joined_crtcs(struct intel_atomic_state *state,
+				      struct intel_crtc *primary_crtc)
+{
+	struct intel_display *display = to_intel_display(state);
+	const struct intel_crtc_state *new_crtc_state =
+		intel_atomic_get_new_crtc_state(state, primary_crtc);
+	u8 pipe_mask = intel_crtc_joined_pipe_mask(new_crtc_state);
+	struct intel_crtc *pipe_crtc;
+
+	/* Perform vblank evasion around the commit of all joined pipes */
+	intel_pipe_update_start(state, primary_crtc);
+
+	for_each_intel_crtc_in_pipe_mask_reverse(display, pipe_crtc, pipe_mask)
+		commit_pipe_arm(state, pipe_crtc);
+
+	intel_pipe_update_end(state, primary_crtc);
+
+	for_each_intel_crtc_in_pipe_mask_reverse(display, pipe_crtc, pipe_mask)
+		intel_post_update_crtc(state, pipe_crtc);
+}
+
 static void intel_update_crtc(struct intel_atomic_state *state,
 			      struct intel_crtc *crtc)
 {
 	struct intel_crtc_state *new_crtc_state =
 		intel_atomic_get_new_crtc_state(state, crtc);
 
+	if (intel_crtc_needs_joined_update(state, crtc)) {
+		/* The secondaries are committed along with the primary */
+		if (intel_crtc_is_joiner_primary(new_crtc_state))
+			intel_update_joined_crtcs(state, crtc);
+		return;
+	}
+
 	switch (new_crtc_state->commit_type) {
 	case INTEL_COMMIT_FLIPQ:
 		intel_flipq_enable(new_crtc_state);
-- 
2.56.0

