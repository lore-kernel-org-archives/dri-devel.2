Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB36606A323
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eofjXEM5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D988A10F032;
	Sat, 14 Nov 2026 16:25:09 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A144810ED05
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 01:44:01 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c4697404c2bso262497866b.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 17:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794620639; x=1795225439; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z5fnz0J6vpb3Ewmw43nxWynz3ZbXtBhlPwMnvHWjbog=;
 b=eofjXEM5vDw7L1u3KnLxhI2MWDbxAYYqtKCndBsQgO/XHPmnRdwFopDTWnmRGMYlsk
 iqCd54YSxu/qVRz/aN6mqxW0h1YOKCtYjPymFLwcrzyJyKxqlas+pvXcc+alq7Q+/0vO
 cm5d6Fue/cm54jisW5GrLtJBO1BaZtF/JsRQP563S2VYPNWUvtA8l/bU89ySFf6QEGI1
 UK9RE5rvPeYUAKQh2UBXKeSffSm0WdlI78z0P51Vw2v8B48DOpkKrCSC16ej7m0gaNm+
 Rlt0f6UEgDhe8fi/NQRFuFqgM2rHySUm2zyXytohFYTZOQimsqJ709D2570uKI43UGN9
 bajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794620639; x=1795225439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z5fnz0J6vpb3Ewmw43nxWynz3ZbXtBhlPwMnvHWjbog=;
 b=BnIrs2tBYJu6SyF5KixO3RKpT+yjlw21/jW65RoM0fvqXZ8wlCqF0C5k2R3Sl441eC
 ruBaFmFwU4UlvVeY8AlzOG3EdUX4hFnNdk0w2jq1QABOg49Qe23wDZ7UZbAd0Ajjhjlg
 v75Qe5SAF9s6jhjXbQeD5izTA78Hds4VfItvkX9y6g8RDKbyNhb8o1rS10xFK+idod8a
 EgnscB0jiKVOP4v/aWBzDDgNCZyskuyG/tTOcz+SP4pEEXQ75CWQbSHHvM4xZJswadFn
 O6PWz0BpetqfjBR2sAKvB1iefbx1Ntdb+EA92Y5cfKMlvQmJW77H5HU2NhWqnB5MXXMO
 IH/g==
X-Forwarded-Encrypted: i=1;
 AL+hErFsyN4v73UlfPgKZOEIjYhc/zfCsGkLsJjwLuP0O+jjF8eTis+6HmsWk5sTTmkU3SBkZE5NUwqwv+w=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+VEhNEvCd19VJaGgm78G7t2XJFf4J9Zrv8qe1yvl7h7YEuks0W
 RH4QivSnkIJEk7XiNk2CkkzDoSomdRPITyEOo20yVmd8hElzySgjuNwZ
X-Gm-Gg: AYBFou3QUSDUVjn4CCuQw3eDfojMdN0v67nmhLxHRv1SV0mgsw8K2aAqNm254v7jl0Z
 8gWt0qPEOuDY64Od7HuQZ8sRwoUPyaldf1PZVFyR/bFLq5weG0Bh7YAV9g6xg4S4DvhIJRfpJDx
 umzr8MvGb07wyEvhLJs2tFVIscSgk8uiFNPrskkGkQMVX+iWMwRMyglwRWk/OSxRj1/+KV0xGWk
 GL4e17o7VW8MQiVShoCjxMGMbrgApw9guJ4LOHGCtXy8+joiY96U8DMrS8Ihh9DXl8nE97EH2Dr
 3TF8S37nqfymeEDKRZ/xJpaKCbIvSZRuwIsltpyUKVxkYK3rv5OLaCZ+AvenL8MyoDnlLArThM+
 Aula0RLyo596Iz9Ah63cAI9Z+SNoMW72ei6HvA5f2nPpIUZpEhke1A+6jA7LBLE8X78EoEgpEkt
 /9sVBk/XSYftRvnazF12ou8JY2boNyjK8IHaBpugb790k2pGk8i+el1MWx5DGn5mdNG1IxJDpsu
 ixikaR1mBDqL9x9//pBjMFcPjYiFyyqq3Ynic1ys3Y70UbCjCNGBW51/khE7GfiCYardnXB+KFn
 d+3npEm5gV66VMW9TQiahHJicT3sNdEnireHdMQQOKWwC5exgUepRHWBMGJBtSD+NFdrcDQvEpa
 JEHfLaOWsaDkVbU31YIU4oKDTlYPhNkHgvsIkeHQMS6bc
X-Received: by 2002:a17:907:9305:b0:c2e:4e08:19ab with SMTP id
 a640c23a62f3a-c50963d50e5mr364215466b.16.1794620639602; 
 Fri, 13 Nov 2026 17:43:59 -0800 (PST)
Received: from SMOK.angora-ide.ts.net
 (mm-156-219-126-178.vitebsk.dynamic.pppoe.byfly.by. [178.126.219.156])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b5a4c1sm161402666b.48.2026.11.13.17.43.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 17:43:59 -0800 (PST)
From: ElXreno <elxreno@gmail.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net,
 ville.syrjala@linux.intel.com, ankit.k.nautiyal@intel.com,
 mitulkumar.ajitkumar.golani@intel.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 ElXreno <elxreno@gmail.com>
Subject: [PATCH 3/7] drm/i915/vrr: Leave the transcoder to the joiner primary
Date: Sat, 14 Nov 2026 04:43:31 +0300
Message-ID: <20261114014335.2132756-4-elxreno@gmail.com>
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

All joined pipes run off the transcoder of the primary, and the crtc
states of the secondaries are copies of the primary's state, the VRR
state included. The commit therefore reaches the transcoder level VRR
functions for every joined pipe: intel_pre_update_crtc() calls
intel_vrr_set_transcoder_timings() for each crtc whose VRR parameters
changed, intel_pre_plane_update() and commit_pipe_post_planes() call
intel_vrr_disable() and intel_vrr_enable(), and both commit paths
call intel_vrr_send_push() and intel_vrr_check_push_sent() per crtc.

Do these once, from the primary. When disabling VRR also switch the
active timings of all joined pipes as soon as the transcoder has left
VRR mode, rather than leaving the secondaries on the VRR timings
until their own turn comes.

The check in intel_vrr_set_transcoder_timings() drops the second,
identical programming of the transcoder that a joined fixed refresh
rate configuration gets today. Everything else depends on vrr.enable,
which is never set with the joiner yet, so there is no other
functional change. In particular the push a secondary sends for the
PSR and Panel Replay frame change is left as it is.

The checks in intel_vrr_set_transcoder_timings(), intel_vrr_send_push(),
intel_vrr_enable() and intel_vrr_disable() are the ones Ankit Nautiyal
posted in "drm/i915/vrr: Handle joiner with vrr", last in [1].

[1] https://lore.kernel.org/intel-gfx/20250224061717.1095226-14-ankit.k.nautiyal@intel.com/

Suggested-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Signed-off-by: ElXreno <elxreno@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_display.c | 15 ++++++++++++--
 drivers/gpu/drm/i915/display/intel_vrr.c     | 21 ++++++++++++++++++++
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 9a503b25ae47..20b1103e3de4 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -1237,10 +1237,21 @@ static void intel_pre_plane_update(struct intel_atomic_state *state,
 
 	intel_psr_pre_plane_update(state, crtc);
 
-	if (intel_crtc_vrr_disabling(state, crtc)) {
+	/* The joined pipes are handled in one go from the primary */
+	if (intel_crtc_vrr_disabling(state, crtc) &&
+	    !intel_crtc_is_joiner_secondary(old_crtc_state)) {
+		struct intel_crtc *pipe_crtc;
+
 		intel_vrr_disable(old_crtc_state);
 		intel_vrr_dcb_reset(old_crtc_state, crtc);
-		intel_crtc_update_active_timings(old_crtc_state, false);
+
+		for_each_intel_crtc_in_pipe_mask(display, pipe_crtc,
+						 intel_crtc_joined_pipe_mask(old_crtc_state)) {
+			const struct intel_crtc_state *old_pipe_crtc_state =
+				intel_atomic_get_old_crtc_state(state, pipe_crtc);
+
+			intel_crtc_update_active_timings(old_pipe_crtc_state, false);
+		}
 
 		/*
 		 * VRR is being disabled seamlessly (no modeset, Panel Replay
diff --git a/drivers/gpu/drm/i915/display/intel_vrr.c b/drivers/gpu/drm/i915/display/intel_vrr.c
index a5a5d11380a4..668c495e7407 100644
--- a/drivers/gpu/drm/i915/display/intel_vrr.c
+++ b/drivers/gpu/drm/i915/display/intel_vrr.c
@@ -19,6 +19,7 @@
 #include "intel_de.h"
 #include "intel_dip.h"
 #include "intel_dip_regs.h"
+#include "intel_display.h"
 #include "intel_display_limits.h"
 #include "intel_display_regs.h"
 #include "intel_display_types.h"
@@ -674,6 +675,10 @@ void intel_vrr_set_transcoder_timings(const struct intel_crtc_state *crtc_state)
 	if (!HAS_VRR(display))
 		return;
 
+	/* The joined pipes drive one transcoder, so program it once. */
+	if (intel_crtc_is_joiner_secondary(crtc_state))
+		return;
+
 	/*
 	 * Bspec says:
 	 * "(note: VRR needs to be programmed after
@@ -773,6 +778,13 @@ void intel_vrr_send_push(struct intel_dsb *dsb,
 	if (!crtc_state->vrr.enable && !intel_psr_use_trans_push(crtc_state))
 		return;
 
+	/*
+	 * A VRR push latches all joined pipes at once, it is up to the
+	 * primary to send it once every one of them has been armed.
+	 */
+	if (crtc_state->vrr.enable && intel_crtc_is_joiner_secondary(crtc_state))
+		return;
+
 	if (dsb)
 		intel_dsb_nonpost_start(dsb);
 
@@ -793,6 +805,9 @@ void intel_vrr_check_push_sent(struct intel_dsb *dsb,
 	if (!crtc_state->vrr.enable)
 		return;
 
+	if (intel_crtc_is_joiner_secondary(crtc_state))
+		return;
+
 	/*
 	 * Make sure the push send bit has cleared. This should
 	 * already be the case as long as the caller makes sure
@@ -1005,6 +1020,9 @@ void intel_vrr_enable(const struct intel_crtc_state *crtc_state)
 	if (!crtc_state->vrr.enable)
 		return;
 
+	if (intel_crtc_is_joiner_secondary(crtc_state))
+		return;
+
 	intel_vrr_set_vrr_timings(crtc_state);
 	intel_vrr_enable_dc_balancing(crtc_state);
 
@@ -1019,6 +1037,9 @@ void intel_vrr_disable(const struct intel_crtc_state *old_crtc_state)
 	if (!old_crtc_state->vrr.enable)
 		return;
 
+	if (intel_crtc_is_joiner_secondary(old_crtc_state))
+		return;
+
 	if (!intel_vrr_always_use_vrr_tg(display))
 		intel_vrr_tg_disable(old_crtc_state);
 
-- 
2.56.0

