Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DC9606A325
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 17:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hkzfxyba
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52CD810EC73;
	Thu, 19 Nov 2026 17:06:55 +0000 (UTC)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5485911266F
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 17:06:48 +0000 (UTC)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cdd48746a49so4489a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 09:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795108008; x=1795712808;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=S+ehNx9nxe0Vbkw2VFM/NtFxwLazlnXEs5+6KOboXyw=;
 b=hkzfxyba70QO4kLQsWcv4QtTQN/IsiXcRgQUJnFFbq/Q9J7V1XdGHb9WjQRpCnw1xe
 O2qnxiuw/WLdJqnwo1WIsrumJ5qYsp3w2M0JLSXhuoW6bazmXdxxtEUzP1dQKgDZRUqr
 dYl5s9fJjKcGNgFdakF8HKQernlVuf/3FcoE6l/UhHn4w2oTWUfjYhzH6gDKQChwQsqL
 g0cIY9ofYcbauhK4WzJCxC5wqpDabAG66XqvQmRNzdfMBRwDXidiq0rHRznpYDaRk1i+
 HK6pWYRlho+nMD/v7TS5VTYZkScORL+Bz6rE+vFWh9ZJgiUTPmWh8jga2clP0RrkwzXA
 /oeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795108008; x=1795712808;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S+ehNx9nxe0Vbkw2VFM/NtFxwLazlnXEs5+6KOboXyw=;
 b=D0WMs/KsdqDrP+tt82EqeDROHRbjYQGYHHbl1zF40okV81ODRXYhx1x+K4hBswg1vs
 uAlBHtjcadAUUWcSnqqUeiPYlhhtoaRAIktpRl5vsOkVLGQiqdWevYSX9AQUfU1C5R8Y
 oSmvm8Wt1KIcUc292fPhHCS3QXW/zIm209REgf0pinIjPPPuS3bK+k1+s+fozOO/Xcja
 xWmuzMnw8GEExc2qtyGzkLjMLxifZpzY/xFeyooFcKRiiUeojnRlsKdD3j2W77APgkJy
 e1XnE3j3cxAQGIvwPoJZlfSGnCktRpJGeegCIbF06eq1n17dcYKUE1ryZxI+gcToVxAs
 h6Yg==
X-Forwarded-Encrypted: i=1;
 AL+hErFPKWQgVq4HD88L7WKBqMrDhFUkENUvwQC699Dsiiic3qEVjDrhORfuQrOxCUpQxEa2UL7lcCem5/o=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+pw6y2J6BMzzKbkF/zhmIGYe9qCzvX2ktVyiGcL7MH8EjnDFYs
 utEN0yAfM7TX3Rz5zgKlgsFqQWl3V//zN7wvDChCfkYZaorsQdt2PgbL3lLgzirzVckQ8weJnkJ
 +tY8P1+k10g==
X-Received: from pgfv2-n1.prod.google.com
 ([2002:a05:6a02:8742:10b0:cd8:b543:4c4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:6a28:b0:3e1:4424:8f72
 with SMTP id adf61e73a8af0-4014d35cae7mr249471637.69.1795108007517; Thu, 19
 Nov 2026 09:06:47 -0800 (PST)
Date: Thu, 19 Nov 2026 09:06:42 -0800
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261119170642.1521198-1-irogers@google.com>
Subject: [PATCH] drm/i915/display: Pass crtc->pipe to
 intel_pmdemand_update_port_clock()
From: Ian Rogers <irogers@google.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Elkin Cruz <elkin@google.com>,
 Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In intel_modeset_readout_hw_state(), 'pipe' is only populated inside the
earlier for_each_intel_encoder() loop. Later, inside
for_each_intel_crtc(), intel_pmdemand_update_port_clock() is called with
'pipe' instead of 'crtc->pipe'.

When the encoder list is empty (for example on headless SKUs or VBT
configurations with all display outputs disabled), 'pipe' is completely
uninitialized and indexes out-of-bounds into pmdemand_state->ddi_clocks[].
Even when encoders are present, every CRTC iteration overwrites the slot
for the last encoder's pipe rather than updating crtc->pipe.

Scope 'pipe' locally to for_each_intel_encoder() and pass crtc->pipe to
intel_pmdemand_update_port_clock().

Found via an x86_64 LLVM=1 (Clang 21.1.8) allyesconfig audit with
-Wconditional-uninitialized enabled; fix and changelog drafted with an AI
coding assistant. Build-tested for both i915 and xe under LLVM=1 W=1
(-Werror) and -Wconditional-uninitialized; not runtime-tested on Intel
Xe_LPD+ hardware.

Fixes: 4c4cc7ac207f ("drm/i915/mtl: Add support for PM DEMAND")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/gpu/drm/i915/display/intel_modeset_setup.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_modeset_setup.c b/drivers/gpu/drm/i915/display/intel_modeset_setup.c
index 6aed88173770..e5d7c05e006a 100644
--- a/drivers/gpu/drm/i915/display/intel_modeset_setup.c
+++ b/drivers/gpu/drm/i915/display/intel_modeset_setup.c
@@ -695,7 +695,6 @@ static void intel_modeset_readout_hw_state(struct intel_display *display)
 {
 	struct intel_pmdemand_state *pmdemand_state =
 		to_intel_pmdemand_state(display->pmdemand.obj.state);
-	enum pipe pipe;
 	struct intel_crtc *crtc;
 	struct intel_encoder *encoder;
 	struct intel_connector *connector;
@@ -726,8 +725,7 @@ static void intel_modeset_readout_hw_state(struct intel_display *display)
 
 	for_each_intel_encoder(display->drm, encoder) {
 		struct intel_crtc_state *crtc_state = NULL;
-
-		pipe = 0;
+		enum pipe pipe = PIPE_A;
 
 		if (encoder->get_hw_state(encoder, &pipe)) {
 			crtc = intel_crtc_for_pipe(display, pipe);
@@ -869,7 +867,8 @@ static void intel_modeset_readout_hw_state(struct intel_display *display)
 		drm_dbg_kms(display->drm, "[CRTC:%d:%s] min_cdclk %d kHz\n",
 			    crtc->base.base.id, crtc->base.name, crtc_state->min_cdclk);
 
-		intel_pmdemand_update_port_clock(display, pmdemand_state, pipe,
+		intel_pmdemand_update_port_clock(display, pmdemand_state,
+						 crtc->pipe,
 						 crtc_state->port_clock);
 	}
 
-- 
2.56.1.708.g77570a6a1d-goog

