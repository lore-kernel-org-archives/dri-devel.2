Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01183606A883
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SiwMuH9q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C11110F028;
	Sat, 14 Nov 2026 16:25:03 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 254EF10E55A
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 01:44:05 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c468bd799ecso283408366b.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 17:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794620643; x=1795225443; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uLsjaTn65LaFIAzBSRyBBq8jlmudpJnh9O4lsKxLsso=;
 b=SiwMuH9qc3rf30NiD4l3sQdI1J/+IpBBV05k06/s5ooru7KqS6LooOhxg1EMXjKR/D
 KWxoSFhsheogizSQJdkDcE4D0zru9UhTsiG9iXyaYfAo9kJPnn99oDOYnGgWvIvE1iWi
 jqPm2+fMuXjMlJhL3G9E+9PDBch7PX8InLOVDAa14AH/FXkM0g8baSOvhVlpMhenqJbd
 jevswEV3Q94IGhGkDS6Zs1rQf9qjoEQ/I74O44M0unY/jlDJoAZN6lWAbPsnxFxPzUgc
 HgFUOJRti3peU+HIdae5ZoIzsWsb+z70uKcL3UKiyjawLfVh46VeRxSZf4cdb5ROLF6R
 Qd9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794620643; x=1795225443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uLsjaTn65LaFIAzBSRyBBq8jlmudpJnh9O4lsKxLsso=;
 b=B+jZymgOI8NEI7klC8xciKMtfuKoEkhjbfLNrxOjgxy9fWHbakdxC/+yGTtrXhRXRn
 Dj65QNkz+MVEn+cxmpI9un7EbLl5HoVOtLkJwPtxBiqAx0de8bULl6uPnYFt2uKBPxXX
 zH2SbLC9rqZQsXxwO33e+/KUSi6wc8BvsbWnmoVtvBGJ175Q+19eFL/kT+huZPIGoekM
 O5wZTZDB3xxUXTBBGM9teEam9vrCe2ZkcNW0W4wkOWh/xiM/iouKJAVyn7DEKt4wAO0l
 TbdWrDW25KQaaRkZz7uB9EiHSd4CkDEsQM+TtdXxb3uhNLF6Bk5YI2v886s5NvpffMvE
 B2ug==
X-Forwarded-Encrypted: i=1;
 AL+hErEnllm/MoIiJc3wS171cnUwu3PjlPv2woVIJaa1FyNexU0kIUrYMee5GG6MXJWx7XESiUc08cd+VDE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+DvnY04bdsmJNIOqMtG5L3kKU1hBv7tB4cB3XZUgPTvvZ2fH9V
 HdeHWyDFqLTRnprOoxoXY2SvgxiaasFpZmqCHeOwUX9f9iYxnUx4uW0t
X-Gm-Gg: AYBFou3O9nDX+OtVe0k3u9F0b9Bgh2tJus4UyeAFPYYq+hpvssd68m0n0N5GYbfmovi
 Ox9eUoaaBPoFKYr+yrKMNOrNb+/h/C9jsXm7GfVoLsv+aZde/TnVaLy4+sGVTp9CkrL8Uo9t7gq
 Gwi6iHD28t/h34trKkbmqnwdWodovSE8SzwvztWunssrKks6UekeOHIVqlhqJhiZ1fhHUmq9/PZ
 Oih6ktShF32KZQFHHpOJj4pHUPwjXdEMKMp08PGvx81wfFl4WqYvTfcpY3MVMv96Gkdij880Kke
 yBWE1fwaOSeXpP23UeT9zfuYk4JfM6pwPrWI87VPmrADpCwtlAAiyDwWzTJztEiTqHbtJzSXLX8
 zRbiHY0jQv5/YSeZ7yafEbh0C+VpwN1aDDLfXGdS9iLzxii74k2Rt5qKjh2405c000TSuoTME/z
 gov4sk7UqBidYBhnRuPKzAmDJa/JcTgKifLGexcOvvwF9Tw8dvw0n28z+QSsfLGqQ+4KEkdj4Pk
 hNhDVpU7+uGpFlhPTGx/dG7dO6TjfIbKKnWpAZdsfy54vF1g+Ujzjk/GjOvID5RXfcuayxniXOC
 4xTRdefFh/gUQchoR3XGZ7Fdaj1GHkOGuNW0O84JA/ZYhQmTItwW1VUp7cU8ueJg3PG9KSaH+Yl
 UDxTgXeFFZ653TzEAvFEBUeQ=
X-Received: by 2002:a17:907:3f23:b0:c50:93b6:52fa with SMTP id
 a640c23a62f3a-c509614e782mr364785766b.2.1794620643332; 
 Fri, 13 Nov 2026 17:44:03 -0800 (PST)
Received: from SMOK.angora-ide.ts.net
 (mm-156-219-126-178.vitebsk.dynamic.pppoe.byfly.by. [178.126.219.156])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b5a4c1sm161402666b.48.2026.11.13.17.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 17:44:03 -0800 (PST)
From: ElXreno <elxreno@gmail.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net,
 ville.syrjala@linux.intel.com, ankit.k.nautiyal@intel.com,
 mitulkumar.ajitkumar.golani@intel.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 ElXreno <elxreno@gmail.com>
Subject: [PATCH 6/7] drm/i915: Evade the vblank on the scanline of the joiner
 primary
Date: Sat, 14 Nov 2026 04:43:34 +0300
Message-ID: <20261114014335.2132756-7-elxreno@gmail.com>
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

The scanline counter of a joiner secondary pipe was observed to wrap
at 8192 lines on Arrow Lake, with pipes A and B joined. Sampling
PIPEDSL of both pipes, they agree up to line 8191, which is the
largest value pipe B ever returns, while pipe A counts on up to the
vmax vtotal. From line 8192 on pipe B reads 8192 lines less than
pipe A. This comes from measurement only, I have no documentation for
it, and I could not check whether it is a property of the joiner
secondary or of that pipe.

It is harmless as long as vtotal stays below 8192, which every fixed
refresh rate mode that needs the joiner does. With VRR the vmax
vtotal can be larger, 12200 for a 3840x2400@240 mode with a 48 Hz
lower limit. The vmax vblank start at line 12160 then reads as 3968
on the secondary, vblank evasion on that pipe never sees its evasion
window, and the pipe gets armed across the vblank:

 Atomic update failure on pipe B (start=48480 end=48481) time 8 us, min 12101, max 12159, scanline start 3965, end 3969

All joined pipes run off the timings of the primary, so look at the
scanline counter of the primary when evading the vblank on a
secondary. This matters for the commits that still take the per pipe
critical sections with the joiner.

Only the evasion is changed. The vblank timestamps of a secondary
still come from its own counter, and so does the end scanline in the
message above, while the start scanline is now the primary's.

Signed-off-by: ElXreno <elxreno@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_vblank.c | 12 ++++++++++--
 drivers/gpu/drm/i915/display/intel_vblank.h |  2 +-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_vblank.c b/drivers/gpu/drm/i915/display/intel_vblank.c
index fc9d1e14ec87..6654ef590da6 100644
--- a/drivers/gpu/drm/i915/display/intel_vblank.c
+++ b/drivers/gpu/drm/i915/display/intel_vblank.c
@@ -11,6 +11,7 @@
 #include "intel_color.h"
 #include "intel_crtc.h"
 #include "intel_de.h"
+#include "intel_display.h"
 #include "intel_display_jiffies.h"
 #include "intel_display_regs.h"
 #include "intel_display_types.h"
@@ -683,6 +684,13 @@ void intel_vblank_evade_init(const struct intel_crtc_state *old_crtc_state,
 	/* TODO: maybe just use the active timings here? */
 	crtc_state = pre_commit_crtc_state(old_crtc_state, new_crtc_state);
 
+	/*
+	 * The scanline counter of a joiner secondary pipe has been
+	 * seen to wrap at 8192 lines (on ARL), which the VRR vmax can
+	 * exceed. The primary runs off the same timings and counts on.
+	 */
+	evade->scanline_crtc = intel_primary_crtc(crtc_state);
+
 	adjusted_mode = &crtc_state->hw.adjusted_mode;
 
 	if (crtc->mode_flags & I915_MODE_FLAG_VRR) {
@@ -738,7 +746,7 @@ int intel_vblank_evade(struct intel_vblank_evade_ctx *evade)
 		 */
 		prepare_to_wait(wq, &wait, TASK_UNINTERRUPTIBLE);
 
-		scanline = intel_get_crtc_scanline(crtc);
+		scanline = intel_get_crtc_scanline(evade->scanline_crtc);
 		if (scanline < evade->min || scanline > evade->max)
 			break;
 
@@ -774,7 +782,7 @@ int intel_vblank_evade(struct intel_vblank_evade_ctx *evade)
 	 * FIXME figure out if BXT+ DSI suffers from this as well
 	 */
 	while (evade->need_vlv_dsi_wa && scanline == evade->vblank_start)
-		scanline = intel_get_crtc_scanline(crtc);
+		scanline = intel_get_crtc_scanline(evade->scanline_crtc);
 
 	return scanline;
 }
diff --git a/drivers/gpu/drm/i915/display/intel_vblank.h b/drivers/gpu/drm/i915/display/intel_vblank.h
index 98d04cacd65f..28b4c458fa18 100644
--- a/drivers/gpu/drm/i915/display/intel_vblank.h
+++ b/drivers/gpu/drm/i915/display/intel_vblank.h
@@ -16,7 +16,7 @@ struct intel_crtc;
 struct intel_crtc_state;
 
 struct intel_vblank_evade_ctx {
-	struct intel_crtc *crtc;
+	struct intel_crtc *crtc, *scanline_crtc;
 	int min, max, vblank_start;
 	bool need_vlv_dsi_wa;
 };
-- 
2.56.0

