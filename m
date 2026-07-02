Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E0A7C43602
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:21:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B438B10F1AD;
	Thu,  2 Jul 2026 07:21:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="pUQTY0vB";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECFD410F198;
 Thu,  2 Jul 2026 07:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1782976886;
 bh=urxsbtugd8+UdPADq6BZx60lq8D4HcydlFOp3SgwB5E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pUQTY0vB7cBrUuKG14Z6TTF5MSxN2K6SgKZNeQ7V7X7RqtcJGuyd5pk8M2Gs+TBoa
 rBfMYZijbfKKMb0QEp+nEJOgxqUMtSiqpSUhUipIpw6hERBR06QxTGzfXUMJ6PYDbK
 jXU8Jpsr6+jaocJspWcBU6V3JY63g3e2uWRiqFgn1QIfH7hk/VvzI8kcRBXFDRTMRe
 //2YXAQE6SCechU7QCBnVPjdtk9aIpPwiqGVjQgj9aQt/lJtLDBreNIVWcb+o7MCJf
 SY4IRkCTd6PTwdLpRxW5nA0r3TiFe5DDL7125YrkrepHpxqjSGW8MjNtBWJMfIXf3o
 dys1qwnRWQscQ==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-xe@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Maarten Lankhorst <dev@lankhorst.se>,
 Uma Shankar <uma.shankar@intel.com>
Subject: [PATCH 07/10] drm/i915/display: Handle vlv dsi workaround in
 scanline_in_safe_range too
Date: Thu,  2 Jul 2026 09:21:50 +0200
Message-ID: <20260702072154.171324-8-dev@lankhorst.se>
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

Now that we have a macro, might as well handle the VLV dsi workaround
too.

This makes the vblank evasion code slightly more deterministic, by not
looping with interrupts disabled.

Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
---
 drivers/gpu/drm/i915/display/intel_vblank.c | 36 ++++++++++-----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_vblank.c b/drivers/gpu/drm/i915/display/intel_vblank.c
index ca08059e088ea..6f1fa952b5391 100644
--- a/drivers/gpu/drm/i915/display/intel_vblank.c
+++ b/drivers/gpu/drm/i915/display/intel_vblank.c
@@ -739,6 +739,24 @@ static bool scanline_in_safe_range(struct intel_vblank_evade_ctx *evade, int *sc
 	else
 		*scanline = __intel_get_crtc_scanline(evade->crtc);
 
+	/*
+	 * On VLV/CHV DSI the scanline counter would appear to
+	 * increment approx. 1/3 of a scanline before start of vblank.
+	 * The registers still get latched at start of vblank however.
+	 * This means we must not write any registers on the first
+	 * line of vblank (since not the whole line is actually in
+	 * vblank). And unfortunately we can't use the interrupt to
+	 * wait here since it will fire too soon. We could use the
+	 * frame start interrupt instead since it will fire after the
+	 * critical scanline, but that would require more changes
+	 * in the interrupt code. So for now we'll just do the nasty
+	 * thing and poll for the bad scanline to pass us by.
+	 *
+	 * FIXME figure out if BXT+ DSI suffers from this as well
+	 */
+	if (evade->need_vlv_dsi_wa && *scanline == evade->vblank_start)
+		return false;
+
 	return *scanline < evade->min || *scanline > evade->max;
 }
 
@@ -769,24 +787,6 @@ int intel_vblank_evade(struct intel_vblank_evade_ctx *evade)
 		local_irq_disable();
 	}
 
-	/*
-	 * On VLV/CHV DSI the scanline counter would appear to
-	 * increment approx. 1/3 of a scanline before start of vblank.
-	 * The registers still get latched at start of vblank however.
-	 * This means we must not write any registers on the first
-	 * line of vblank (since not the whole line is actually in
-	 * vblank). And unfortunately we can't use the interrupt to
-	 * wait here since it will fire too soon. We could use the
-	 * frame start interrupt instead since it will fire after the
-	 * critical scanline, but that would require more changes
-	 * in the interrupt code. So for now we'll just do the nasty
-	 * thing and poll for the bad scanline to pass us by.
-	 *
-	 * FIXME figure out if BXT+ DSI suffers from this as well
-	 */
-	while (evade->need_vlv_dsi_wa && scanline == evade->vblank_start)
-		scanline = intel_get_crtc_scanline(crtc);
-
 	return scanline;
 }
 
-- 
2.53.0

