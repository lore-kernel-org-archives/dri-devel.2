Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E927ACD5BC9
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 13:57:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4791D10E128;
	Mon, 25 May 2026 13:57:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=poorly.run header.i=@poorly.run header.b="drl1dbHg";
	dkim-atps=neutral
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com
 [209.85.128.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C63510E128
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:57:32 +0000 (UTC)
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-7bdaa68cf81so88381467b3.3
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 06:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=poorly.run; s=google; t=1779717451; x=1780322251; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R2Pnx/Mi+Y/3KV/4Sc1GEttUJtfyf8f5vLDsmZdB3eA=;
 b=drl1dbHgFn46jD9/1E+ftFwo8fyEynU0mzF7rrsOJG1h+Djaa6JbjM/0SZA7UKgPY+
 NTP4j9vJukZhEAOb3N0Gwf2AXoIZvsjx1EYXFe1PfN5T71l3Dd2VwSYWehPWVEcAck91
 kmxGWZvOVMf0nt+5vo2UFGKOJuGr3uP5CIG7PaSbpy8HMU7dTK2a/ozJ9KObsaZL+uE/
 ssFFqp4gMhzStA13VF4M4lSVQr6mbknzlOJRiu31kE5AqlTvTH5Q8xhkKoYli8Qfv7vQ
 oU/INzDTwA6xF+EeNktGhPrRBvdsytBWoBAzlnxFbTGPAkHpc8p0j2bd8fjTpncTxIDu
 24VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779717451; x=1780322251;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R2Pnx/Mi+Y/3KV/4Sc1GEttUJtfyf8f5vLDsmZdB3eA=;
 b=CMQNS+F4MsBvCgscKAktF6uIxonVBPffyhYKOmVafTlIM+cizsgNLI0P8MSFHut5Ml
 28Ph462jDCwyEChFEjgTpsBKVDk/YhIFvB8cO0sBISKRWxDfKNvXw0gnIT++/N8/cfkv
 +P8J60x1n8LeMog1DzsuA4pEiOea47OWWMALJHEztd4ypa6RDln8ZiaRnG72syPI+mtK
 Ar9Y8BDxODuoyRDcmLdU9+LJ8OE10HsLWxmXvqkX/L1E8tyhc1XSkCZhkTL4vhDVSJrT
 XM0/GjE4BqrtQcuSl4cR1Gcz4fgVGtXbBqtnENCd/IOoV+1KlDPtjEmQpdMTL022jH/6
 uMXA==
X-Forwarded-Encrypted: i=1;
 AFNElJ91n7yZHw+vClyTgwadnj5NlvwCMjLzFTbEtL0Sas0l507haOWBzDa5vdFJrariV/S+bjHUxEpOG9Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxo97y0/XXp9/3AWr/sWs0XNX97EwjHobXgRx/EF2v+olA5q99F
 qkSqzHIB357HGO1M7KAwYLBH5jO8zPEgFmh55/2U2L+X+ZFKofp52Z00n2wuCfyMBo4=
X-Gm-Gg: Acq92OFU5pLErrl6nJD4hXycGzxY0mzE119+uOR6TdlhkI/Zf2DaU2PVob2cga6ZYiF
 doTtoNwbzLPCirlpG46F5AOvxoHoVuMdk2NGvh+OrdymqSlZ9qSW36Gtt814JJAodnkTyuDaxC1
 tk9MfYo9Gu8O9GgLnOQ0nL5QQ/ty4GouA2Z9o+SPcZFrSacquczSizoqM/1iQ44OXU5I3i5p4sU
 AvWdZruDRsLB7Fxh9KWWtrmL86Z6esxwF4qWHAzKq85S0JjHfcH1Z7BcWIuN5BVW5WOMWIe+7JT
 uqCwouaZK+38MxHWSUt71PjJdVQVVI846riUtC/pCP6KX+D1ivAoO50q1T7xmrgmnLF6Iuk5x3O
 53h3RkstYKvzIZVx3rYxVwBRH16zrKqNheDH9y1YGr9Js9vZzsyUXEcX143U4L9XMNNOdAuLy7b
 nbKVmwiCH8UNBSD753JhiWCV9fu34jktxH1CoOzP+HydFBlMGEMWmKJnY=
X-Received: by 2002:a05:690c:338e:b0:7c9:30f5:2054 with SMTP id
 00721157ae682-7d33a95ca47mr156744337b3.40.1779717451418; 
 Mon, 25 May 2026 06:57:31 -0700 (PDT)
Received: from localhost (191.99.245.35.bc.googleusercontent.com.
 [35.245.99.191]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-7d389d176a9sm46721407b3.16.2026.05.25.06.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 06:57:30 -0700 (PDT)
From: Sean Paul <sean@poorly.run>
To: intel-gfx@lists.freedesktop.org,
	jani.nikula@linux.intel.com
Cc: Sean Paul <seanpaul@google.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v2.1 1/2] drm/i915/color: Fix step discontinuity in Post-CSC
 Gamma LUT
Date: Mon, 25 May 2026 09:56:04 -0400
Message-ID: <20260525135730.1122696-1-sean@poorly.run>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
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

From: Sean Paul <seanpaul@google.com>

Fix a step discontinuity in the Post-CSC Gamma LUT when SDR dimming
is active by clamping Segment 2 to the last user-provided LUT entry
value instead of hardcoding it to 1.0 (1 << 24).

Link: https://lore.kernel.org/intel-gfx/20260521180143.2143262-1-sean@poorly.run/ #v1
Signed-off-by: Sean Paul <seanpaul@google.com>

Changes in v2:
- Split out into separate patches for pre/post csc fixes
- Dropped loop bounds fix in favor of [1]

[1]- https://lore.kernel.org/r/20260519075245.383864-1-pranay.samala@intel.com
---

Changes in v2.1:
- Rebased on Pranay's patch and sending without in-reply-to

 drivers/gpu/drm/i915/display/intel_color.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_color.c b/drivers/gpu/drm/i915/display/intel_color.c
index 7ef870cd9a16..7185f3628dcf 100644
--- a/drivers/gpu/drm/i915/display/intel_color.c
+++ b/drivers/gpu/drm/i915/display/intel_color.c
@@ -4038,11 +4038,11 @@ xelpd_program_plane_post_csc_lut(struct intel_dsb *dsb,
 						   lut_val);
 			}
 
-			/* Segment 2 */
+			/* Segment 2 - clamp to the last LUT value to prevent step discontinuity */
 			do {
 				intel_de_write_dsb(display, dsb,
 						   PLANE_POST_CSC_GAMC_DATA_ENH(pipe, plane, 0),
-						   (1 << 24));
+						   lut_val);
 			} while (i++ < 34);
 		} else {
 			/*TODO: Add for segment 0 */
-- 
Sean Paul, Software Engineer, Google / Chromium OS

