Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44610CD5BB6
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 14:42:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00AEB10F626;
	Fri, 22 May 2026 14:42:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mariushoch.de header.i=@mariushoch.de header.b="EXuGrg2m";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2E6310E1C9;
 Thu, 21 May 2026 18:27:03 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gLxhP28rTz9vLF;
 Thu, 21 May 2026 20:27:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mariushoch.de;
 s=MBO0001; t=1779388021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=GYkf84zKQ1koXdJ8sJbWorRHXORylD9/JuNrnSRVhMk=;
 b=EXuGrg2mnXNU2e83JRMVB5I2K3ncTReK933T4sXH6nAcQLJ+oDRgYS9VRO5qcCohfvUsHV
 9QdC39z76pint1GOoMOjOmwPjupiX6Y0aSyap+yX5LUcchK2Lx8dGBCipWJ2PkcJj81+vN
 TBxmNdbCldjXqXxXb3+/LPpmqt7XpGpO+9k1w7p0RCnhEeCrgWpXDZlkM0rqQSRme4G5wR
 sy+B6gohE941vLOREpIsnqZRvEVQtzy+tTko9hTLjnn6lQbmbNv8NSaB+Htf65RP+tGs+g
 8rCNO7jjrOHdqJpu2huEPhGKvurez37TrzVB/RvXGPKe2kuvTwus3osZZRMtOQ==
From: Marius Hoch <mail@mariushoch.de>
To: linux-kernel@vger.kernel.org
Cc: Marius Hoch <mail@mariushoch.de>, stable@vger.kernel.org,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Joe Perches <joe@perches.com>,
 Mika Kahola <mika.kahola@intel.com>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/i915: Don't set min_cdclk in the initial crtc_state
Date: Thu, 21 May 2026 20:07:12 +0200
Message-ID: <20260521180722.328317-2-mail@mariushoch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 22 May 2026 14:41:04 +0000
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

Setting the min_cdclk this early means that intel_cdclk_atomic_check
(called via intel_atomic_check) will not pick up the initial min_cdclk, as
there is no change between the old and new atomic states. This is
problematic, especially on Gemini Lake, where the picture gets unstable if
the CDCLK is too low (see vlv_dsi_min_cdclk).

This was introduced in 7a8d9cfa6db0, which states that the min_cdclk must
be set before calling intel_compute_global_watermarks. However, as the
only place that calls intel_compute_global_watermarks is
intel_atomic_check, right after setting the min_cdclk on new_crtc_state,
there is no need to set the min_cdclk initially.

This surfaced as a bug on my IdeaPad Duet 3 after ba91b9eecb47, leading
to the screen output being completely garbled initially (when asking for
the dm-crypt passphrase). It recovers after the passphrase prompt, as this
only affects the initial state.

Tested on an IdeaPad Duet 3 10IGL5-LTE (with UHD Graphics 605).

Cc: stable@vger.kernel.org
Fixes: 7a8d9cfa6db0 ("drm/i915: Compute per-crtc min_cdclk earlier")
Signed-off-by: Marius Hoch <mail@mariushoch.de>
---
 drivers/gpu/drm/i915/display/intel_modeset_setup.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_modeset_setup.c b/drivers/gpu/drm/i915/display/intel_modeset_setup.c
index 4086f16a12bf..9278856375e9 100644
--- a/drivers/gpu/drm/i915/display/intel_modeset_setup.c
+++ b/drivers/gpu/drm/i915/display/intel_modeset_setup.c
@@ -865,11 +865,6 @@ static void intel_modeset_readout_hw_state(struct intel_display *display)
 				    crtc_state->plane_min_cdclk[plane->id]);
 		}
 
-		crtc_state->min_cdclk = intel_crtc_min_cdclk(crtc_state);
-
-		drm_dbg_kms(display->drm, "[CRTC:%d:%s] min_cdclk %d kHz\n",
-			    crtc->base.base.id, crtc->base.name, crtc_state->min_cdclk);
-
 		intel_pmdemand_update_port_clock(display, pmdemand_state, pipe,
 						 crtc_state->port_clock);
 	}
-- 
2.54.0

