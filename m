Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2856CD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 23:08:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35DAD10F6D3;
	Thu, 28 May 2026 23:08:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=poorly.run header.i=@poorly.run header.b="XI79Uu3f";
	dkim-atps=neutral
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com
 [209.85.128.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 874B910F6D3
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 23:08:19 +0000 (UTC)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-7dbfebfbf50so22216467b3.3
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 16:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=poorly.run; s=google; t=1780009698; x=1780614498; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WCd+eJCIusrbfetJCTMFBLKlj+qUy/ODp/mDze4wwfU=;
 b=XI79Uu3fxVmmHfcXazXplB8duYD/JPuqSQ9lGW2qTgF8+t4n8iwhVTC8y2DxQJrCqR
 qfDJu7CqLEEFi9uTbE5fIEh2WbEeenfSQVhqoPONbjwTgF7mGCf7mQ2PuLWH7I/2PAR/
 3/0PQh9ZIZK/bDnT5PbcmLJ6NRYlUBT6QG+Fx4aFxah5lZ9kCeuf/u/LVgBTMYp7dMPA
 L509LD+Al1rXwhg2mxFBmrjlsusNBsDvSZGY/gw1BMyYSBQtmY3UoRyvoLnYqNNlgyB9
 NqjUiS/RTGlsH7Gs4bUJk/xFf9EF+5/YDApbGM7GNZcIlLcN1s53j4FpFkb7epEYTvqc
 6WLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780009698; x=1780614498;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WCd+eJCIusrbfetJCTMFBLKlj+qUy/ODp/mDze4wwfU=;
 b=CZ//WejtXWxmPUnQbpoLc/lgDvA0+cRDCitpvLJ/o5YH3BRhmNOSjEp+YZTKY2gYuG
 bvHUDgWS7/XNzWldocTrYNcSfsE6lj2vuhJUzaFNKLfmaj/2KN1ss/qVfzA337BX3/1b
 fyynCVnaQ414/QhebzF44Buy3+juVGjUDPn36qlsY6zEz/aJ7SnzxtDCqera4d2kRTus
 Ah9T22vNLzrPqcrNVAmIlN2YXXsnejSbQwqu1UybXluFeFuw7NZzKOJxEMJlPyfZgDIQ
 P7cU4VrfLs/87/8J/snLrv9vgq8m8WNsPwPqZzyZUFYqa+jJBRIiyR1UMnhISY2s1YJz
 aaqQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9nBEaXub+s2mIolpZnE9+4SDW5BURxBh5xvL94jGHpekbycKF9xnyDV25/E33t4yzRTJNJfgHqVAE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxgkHaDT/PM/6yWanl/zs2mdnUwide9IPsA6z35UKIFQXij0ojb
 DoKMItBTk68hko/slfso1gxT0/Y+P68ovy3fMIf3yncV20Nrl8gSbvYcGFXmcDVqdtc=
X-Gm-Gg: Acq92OGTSHySlXiCHZ7oDKDb20KTKwm66TR1GJc90+E2BLIDuR7qh+UqLJK0zRNuE4D
 5OVI+59YPjo/YbGutpGyr7R1tVbev6H70d9tbvvO6HNobr1WxBYuXE5BffPyEwT1Eu9vPsM3cre
 3BipjAY/FaJgOIOdzYGESfjyyOElwzrcdneSCf8rfSaB2SYpo93ZoyHb65huYf1UTSP5dd3tjTy
 /IJ84NxaozOKjpIj/O7FYk8dl9F1Zvwm5f25+V+woXQNeQ3pxbcZimGllX6sHKuIk1egvpSc0uN
 V2Mh9mJ/P5nIm2CGKNYxEHwq13OmtYmvPRhiqbubqpSgCfiqcsyGlAd43AGB3rydH8hDK+iP7GF
 u7m8E6wiHDkqkOS2hb2x0WnTOFBPwmU8Q9TaYTO/7+lZv3tmWHIuCfZiGzhn36U8wWALESXVEfv
 UMj8n6DmXxeOK49py/cM8Ny9Up71qWsoTMsJgAnVqKxcrFoG/JlX70JxiFY9zVx4b0+A==
X-Received: by 2002:a05:690c:6e0c:b0:7d0:4824:6411 with SMTP id
 00721157ae682-7de4d16b634mr2397747b3.47.1780009698408; 
 Thu, 28 May 2026 16:08:18 -0700 (PDT)
Received: from localhost (182.221.85.34.bc.googleusercontent.com.
 [34.85.221.182]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-7de6ea5d9b2sm34117b3.47.2026.05.28.16.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 16:08:18 -0700 (PDT)
From: Sean Paul <sean@poorly.run>
To: intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
 chaitanya.kumar.borah@intel.com
Cc: Sean Paul <seanpaul@google.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v3 1/2] drm/i915/color: Fix step discontinuity in Post-CSC
 Gamma LUT
Date: Thu, 28 May 2026 19:07:46 -0400
Message-ID: <20260528230817.2455072-1-sean@poorly.run>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
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

Signed-off-by: Sean Paul <seanpaul@google.com>
Link: https://lore.kernel.org/intel-gfx/20260521180143.2143262-1-sean@poorly.run/ #v1
Link: https://lore.kernel.org/intel-gfx/20260525135730.1122696-1-sean@poorly.run/ #v2

Changes in v2:
- Split out into separate patches for pre/post csc fixes
- Dropped loop bounds fix in favor of [1]
Changes in v3:
- None

[1]- https://lore.kernel.org/r/20260519075245.383864-1-pranay.samala@intel.com
---
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

