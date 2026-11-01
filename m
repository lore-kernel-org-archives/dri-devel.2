Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B64606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=softbase.tech header.i=@softbase.tech header.a=rsa-sha256 header.s=protonmail3 header.b=EXzKOxkl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1457C10EA3D;
	Sun,  1 Nov 2026 12:38:54 +0000 (UTC)
X-Greylist: delayed 523 seconds by postgrey-1.36 at gabe;
 Sun, 01 Nov 2026 12:38:47 UTC
Received: from mail-244102.protonmail.ch (mail-244102.protonmail.ch
 [109.224.244.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 795DE10EA3D
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 12:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=softbase.tech;
 s=protonmail3; t=1793536198; x=1793795398;
 bh=MXG9XxsNUYUBQFUk2jiqmUkACxCXCveVoiDIppG6/JI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=EXzKOxkl70OCmui4jy79De7H6k0YKei3U0Ft+swv/5PlZ2gHA6piffFlnWhap8wAl
 fP6x7bS1Wsmot3KsrCjic1noBx2lnJvLmIqPqECq3ccCnLizh12NZYrbX4rWZxaffm
 9R/LTfqnoIAwPQ/XqcfEpNW07uh/0ZNKzWB0bMOcwuKZKtWXlmrTX4WjrQKiozLM1c
 5yhSg1buHg2m5kYJ7lYFPtWI0NCX3xbGv/2T3hXsAX3uvg6q+ix8EhTQaZ3fZF5x95
 50LPN3wRq5+OZzlKytWMJImMjLGCftSSMJ3uiyz6/9JqORD+7c9gSgkZ3TCBhfVVcX
 v+ARvmqWti2Kg==
X-Pm-Submission-Id: 4jHZ0g3FNKz2Sd2v
From: "Beat M. Liechti" <beat@softbase.tech>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Federico Amedeo Izzo <federico@izzo.pro>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, "Beat M. Liechti" <beat@softbase.tech>,
 stable@vger.kernel.org
Subject: [PATCH v2 1/2] drm/msm/dpu: don't reassign resources on color
 management changes
Date: Sun,  1 Nov 2026 13:26:57 +0100
Message-ID: <20261101122943.8155-2-beat@softbase.tech>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261101122943.8155-1-beat@softbase.tech>
References: <20261101095754.33840-1-beat@softbase.tech>
 <20261101122943.8155-1-beat@softbase.tech>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since commit 39a750ff5fc9 ("drm/msm/dpu: Add DSPP GC driver to provide
GAMMA_LUT DRM property"), dpu_crtc_atomic_check() releases and reserves
the hardware blocks of a CRTC whenever color_mgmt_changed is set, not
only on a modeset. A commit that merely replaces the GAMMA_LUT or CTM
blob of an active CRTC can therefore move that CRTC to a different
CTL/LM pair without disabling and re-enabling the pipeline, and the
hardware keeps scanning out through blocks the driver no longer
considers in use.

This is easy to hit with GNOME/mutter on a laptop driving an external
display: closing the lid disables the eDP CRTC, and in the same atomic
commit mutter sets new color blobs on the still active HDMI CRTC. With
drm.debug enabled, dpu_rm_reserve() moves the HDMI CRTC from CTL_1 to
the just released CTL_0 while its encoder is neither disabled nor
re-enabled. A few seconds later the display SMMU reports context faults
at the refresh rate and the external screen fills with garbage. Opening
the lid again leads to a stream of "vblank timeout" and "frame done
timeout" errors and the machine has to be power cycled.

Color management affects the topology in only one way: DSPP blocks are
requested when either CTM or GAMMA_LUT is set. Handle that case in
dpu_crtc_check_mode_changed() by requiring a full modeset when the
presence of CTM/GAMMA_LUT changes, and stop reallocating resources on a
bare color_mgmt_changed. Don't set allow_modeset here: if userspace
did not allow a modeset, the atomic core rejects the commit instead of
the CRTC being silently moved to other blocks.

Fixes: 39a750ff5fc9 ("drm/msm/dpu: Add DSPP GC driver to provide GAMMA_LUT DRM property")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Beat M. Liechti <beat@softbase.tech>
---

Notes:
    Changes in v2:
    - Don't set allow_modeset on behalf of userspace; only set mode_changed
      and let drm_atomic_check_only() reject commits that did not allow a
      modeset (Dmitry)
    - New patch 2/2 removes the CTM-only allow_modeset hack from
      msm_atomic_check(), which is redundant with this check (Sashiko review)
    - Link to v1: https://lore.kernel.org/r/20261101095754.33840-1-beat@softbase.tech
    
    Testing: ThinkPad T14s Gen 6 (X1E78100), GNOME 50 / mutter on Wayland,
    LG 4K60 monitor on the HDMI port (DP to HDMI bridge), logind set to not
    suspend on lid close while on external power. Without this patch every
    lid close reproduces the corruption and hang described above. With it,
    closing and opening the lid produces no SMMU faults, vblank timeouts or
    frame done timeouts, and both displays keep working.
    
    v2 was retested on the same kernel with both patches applied: lid
    close/open, Night Light toggled repeatedly with the lid open and closed,
    and a color profile change. No SMMU faults or timeouts, no visual
    problems, and with drm.debug=0x16 no commit was rejected for requiring
    a modeset, so mutter is not affected by the stricter check.
    
    On msm-next the patch has only been compile tested (W=1, no new
    warnings), not run.
    
    The RFC "drm/msm/dpu: Force modeset if new CTLs have been reserved"
    (https://lists.freedesktop.org/archives/freedreno/2025-March/036824.html)
    addresses reassignment without a modeset in general. This patch only
    removes the color management trigger.
    
    The root cause analysis of the drm.debug trace, the fix and the
    changelog were developed with an AI coding assistant (Claude by
    Anthropic). I reviewed the change and tested it on the hardware above.

 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 25 +++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 42d0a529b..cfcc3556a 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1516,6 +1516,19 @@ int dpu_crtc_check_mode_changed(struct drm_crtc_state *old_crtc_state,
 	    (!clone_mode_requested && clone_mode_enabled))
 		new_crtc_state->mode_changed = true;
 
+	/*
+	 * DSPP blocks are reserved only when CTM or GAMMA_LUT is set (see
+	 * dpu_crtc_get_topology()), so enabling or disabling color management
+	 * changes the hardware topology. Changing resources on an active CRTC
+	 * requires a full modeset; otherwise the CTL/LM blocks get swapped
+	 * underneath a running pipeline. If userspace did not allow a modeset,
+	 * drm_atomic_check_only() rejects the commit.
+	 */
+	if (new_crtc_state->enable &&
+	    (!!(old_crtc_state->ctm || old_crtc_state->gamma_lut) !=
+	     !!(new_crtc_state->ctm || new_crtc_state->gamma_lut)))
+		new_crtc_state->mode_changed = true;
+
 	return 0;
 }
 
@@ -1534,9 +1547,15 @@ static int dpu_crtc_atomic_check(struct drm_crtc *crtc,
 
 	bool needs_dirtyfb = dpu_crtc_needs_dirtyfb(crtc_state);
 
-	/* don't reallocate resources if only ACTIVE has beeen changed */
-	if (crtc_state->mode_changed || crtc_state->connectors_changed ||
-	    crtc_state->color_mgmt_changed) {
+	/*
+	 * Don't reallocate resources if only ACTIVE or color management
+	 * values have changed. A change in DSPP requirements is turned into a
+	 * modeset by dpu_crtc_check_mode_changed(). Reallocating on a plain
+	 * color_mgmt_changed would move an active CRTC to different CTL/LM
+	 * blocks without a modeset, leaving the hardware scanning out through
+	 * stale CTL/LM state (SMMU faults, corrupted output, vblank timeouts).
+	 */
+	if (crtc_state->mode_changed || crtc_state->connectors_changed) {
 		rc = dpu_crtc_assign_resources(crtc, crtc_state);
 		if (rc < 0)
 			return rc;
-- 
2.53.0

