Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2EDCD4F21
	for <dri-devel@archiver.kernel.org>; Sat, 16 May 2026 09:25:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ED9110E0F6;
	Sat, 16 May 2026 09:25:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hBlxiza4";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7472810E0D4
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 09:25:25 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso13565515e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 02:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778923523; x=1779528323; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=achqQyyIP4rnn7sCWNMLaWeFxphvcEeKGoSKkFPXgdA=;
 b=hBlxiza4qEgMCrkBT8syjF77gc1wZkgD3D/uHoNZR4XM/yZPAqtd4i5sFqacpxwQhD
 atku5YS5EQInc3ndpnwl7JjSyfC0/Vc/rCt5d1Jd5Crqtrv1cxKYAmQ8x30SELBpvkeY
 9RzFBEPyhgQ7S7tMbukfnlszrqnMa7xcop7xmulqmoO92hFS/Etp6g8/5vumwmHlTqn7
 wQkgSsm+n2aN5cQi9WGhizieKXiLaRlqyBYRkszETy0h4ZI2kKnn6VhTPsuAYJzJx5cN
 kT4TxwSOw4phcwjvWFdfc+PKtO5x3vflf+ZUKORGTO/2pwN7bvamjYbXVG7PYU4tktEx
 ++VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778923523; x=1779528323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=achqQyyIP4rnn7sCWNMLaWeFxphvcEeKGoSKkFPXgdA=;
 b=KyDnclh/TT3VvdhiXXh9n8Jg3mFUB4jtEo5cBvN6MrDCd2kN3VwthabTctoUHYbE5f
 WNBplKaa4ng+1RHYoQ0hGumkyJXqd+elBtbNvbcuSJvwJer3wXeSXRL2/6z3GZonpMuE
 3ZCfQMtdNvkmCNZ662onIfVLzNsUBEa7uOTZd16jBTMdPnlMIijQYgzdXJiRea04y77E
 pw3Q5h3XW+fnfRrSrPk2JTzHDG0lQJjgVKFAbHIqwdqVyOxkA2MoUM90ZhtmnIvzIxVY
 xiZAQp2fpXOm/w5cqR2hO7utrwNVRnOvPOo5FH3v4vjsfwlwxYSqRVGourrhDk+uYtsY
 M1BA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Fm5aNGJIlO+ms9e9bWE9CLSfLPLtzVXLnTw93dgiDFyvAdbTdiA8YuPPQCac9vtk0ihMxjfLyxO4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyp0cXG+FOA2IeJoDEBLxtWUkyWBCpxU+8bGagbvQsUi4XwXfc3
 5SJ3+GyW4O4OFSHuOjJqGCTFHjNoF/s/D20jcHCCtYFUwieOv54mrCMNOa4ujg==
X-Gm-Gg: Acq92OG+xKC5I+HpcrIsn18E01BzLY7bEPGkcRt1AHJZ1uba9rYjYffA2p5HggkEMJP
 Xm91n4wgW8FYM9pAf+O/fyCd5xZk5Nm/yvbAQUgiwolFi1g0Jn/CXyWoftv7nObx1eO0/64/Hnp
 IOwlXIM20roI90oMKFRUBjAkUKi1mBX9g0MddjPTuWZUjknlt+TyNnuZKBuHq1n/92CTcAcMgPz
 g4GK8ArxZcgpMJ7uJkwETjDvxjoj6apnLCWDJXPlTZIKAE7gYFRKLKTm3YzAflDWge487KsDWoP
 kUfkf68XO2pBSNSWJwwVUE/F7o3vstA/AnWqpdUK440cHWUuMjgY437tUtqyXO4voEV0bhFw3TY
 R+XfIHO0A9GqQ70m2vU/Wn8oOs7bdozO8cI8fN6Ct9NV13TYHBSpA7r4jVqE62rajgWiGUpeuH1
 viEET1L+JLghNnLnP/kxbn6DaAdqeCfu7qz76/tQ==
X-Received: by 2002:a05:600c:a30a:b0:48f:e230:29f4 with SMTP id
 5b1f17b1804b1-48fe53a4866mr76718055e9.15.1778923523124; 
 Sat, 16 May 2026 02:25:23 -0700 (PDT)
Received: from skylab.fritz.box ([2a06:4944:10fb:f400:77d:501a:25b2:e8f4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe83ba2sm32135175e9.35.2026.05.16.02.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 02:25:22 -0700 (PDT)
From: Gilles Risch <gilles.risch@gmail.com>
To: alexander.deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Gilles Risch <gilles.risch@gmail.com>
Subject: [PATCH v2] drm/radeon: fix internal display on iMac11,
 1 (RV770/DCE3.1)
Date: Sat, 16 May 2026 11:24:21 +0200
Message-ID: <20260516092420.3579-2-gilles.risch@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260510185426.4264-1-gilles.risch@gmail.com>
References: <20260510185426.4264-1-gilles.risch@gmail.com>
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

The Apple iMac11,1 (late 2009) has an integrated ATI Mobility Radeon
HD 4850 (RV770/M98L) with a 2560x1440 internal panel connected via an
internal DisplayPort path. This machine suffers from a similar problem
as the iMac10,1 (late 2009) and the iMac11,2 (mid 2010). Without this
fix the display stays dark under KMS. Two issues are addressed:

1. The RV770 implements DCE3.1 and not DCE3.2. ASIC_IS_DCE32() starts at
   CHIP_RV730 which is newer than RV770, so the RV770 never matched the
   DCE3.2 PLL and encoder logic. Introduce ASIC_IS_DCE31() starting at
   CHIP_RV770 to fix this.

2. Apple routed the internal display through Link B of the DIG encoder
   instead of Link A, as observed in the kernel display connector log.
   The same quirk already exists for iMac10,1 and iMac11,2 - iMac11,1
   was simply missing from the list.

Note: resume from suspend still results in a dark screen as the DP
re-driver chips on the mainboard lose their state during power-off.
This will be addressed in a follow-up patch.

Fixes freedesktop issue 164
Link: https://gitlab.freedesktop.org/xorg/driver/xf86-video-ati/-/issues/164

Signed-off-by: Gilles Risch <gilles.risch@gmail.com>
---
v2: No code changes. Fixed commit message:
    - Added drm/radeon: prefix to subject line
    - Added empty line between subject and body
    - Added technical description of the changes

 drivers/gpu/drm/radeon/atombios_crtc.c     | 4 ++--
 drivers/gpu/drm/radeon/atombios_encoders.c | 9 +++++----
 drivers/gpu/drm/radeon/radeon.h            | 1 +
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/radeon/atombios_crtc.c b/drivers/gpu/drm/radeon/atombios_crtc.c
index 2fc0334e0d6c..3c6d332739e3 100644
--- a/drivers/gpu/drm/radeon/atombios_crtc.c
+++ b/drivers/gpu/drm/radeon/atombios_crtc.c
@@ -580,7 +580,7 @@ static u32 atombios_adjust_pll(struct drm_crtc *crtc,
 			radeon_crtc->pll_flags |= (/*RADEON_PLL_USE_FRAC_FB_DIV |*/
 				RADEON_PLL_PREFER_CLOSEST_LOWER);
 
-		if (ASIC_IS_DCE32(rdev) && mode->clock > 200000)	/* range limits??? */
+		if (ASIC_IS_DCE31(rdev) && mode->clock > 200000)	/* range limits??? */
 			radeon_crtc->pll_flags |= RADEON_PLL_PREFER_HIGH_FB_DIV;
 		else
 			radeon_crtc->pll_flags |= RADEON_PLL_PREFER_LOW_REF_DIV;
@@ -594,7 +594,7 @@ static u32 atombios_adjust_pll(struct drm_crtc *crtc,
 		if (((rdev->family == CHIP_RS780) || (rdev->family == CHIP_RS880))
 		    && !radeon_crtc->ss_enabled)
 			radeon_crtc->pll_flags |= RADEON_PLL_USE_FRAC_FB_DIV;
-		if (ASIC_IS_DCE32(rdev) && mode->clock > 165000)
+		if (ASIC_IS_DCE31(rdev) && mode->clock > 165000)
 			radeon_crtc->pll_flags |= RADEON_PLL_USE_FRAC_FB_DIV;
 	} else {
 		radeon_crtc->pll_flags |= RADEON_PLL_LEGACY;
diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm/radeon/atombios_encoders.c
index 5cfd8fcfa5e8..4e984973c043 100644
--- a/drivers/gpu/drm/radeon/atombios_encoders.c
+++ b/drivers/gpu/drm/radeon/atombios_encoders.c
@@ -2123,12 +2123,13 @@ int radeon_atom_pick_dig_encoder(struct drm_encoder *encoder, int fe_idx)
 	}
 
 	/*
-	 * On DCE32 any encoder can drive any block so usually just use crtc id,
-	 * but Apple thinks different at least on iMac10,1 and iMac11,2, so there use linkb,
-	 * otherwise the internal eDP panel will stay dark.
+	 * On DCE31 and DCE32 any encoder can drive any block so usually just use crtc id,
+	 * but Apple thinks different at least on iMac10,1, iMac11,1 and iMac11,2,
+	 * so there use linkb, otherwise the internal eDP panel will stay dark.
 	 */
-	if (ASIC_IS_DCE32(rdev)) {
+	if (ASIC_IS_DCE31(rdev)) {
 		if (dmi_match(DMI_PRODUCT_NAME, "iMac10,1") ||
+		    dmi_match(DMI_PRODUCT_NAME, "iMac11,1") ||
 		    dmi_match(DMI_PRODUCT_NAME, "iMac11,2"))
 			enc_idx = (dig->linkb) ? 1 : 0;
 		else
diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index 527b9d19d730..6b7c0abe49fb 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -2625,6 +2625,7 @@ void r100_pll_errata_after_index(struct radeon_device *rdev);
 			    (rdev->family == CHIP_RS740)  ||	\
 			    (rdev->family >= CHIP_R600))
 #define ASIC_IS_DCE3(rdev) ((rdev->family >= CHIP_RV620))
+#define ASIC_IS_DCE31(rdev) ((rdev->family >= CHIP_RV770))
 #define ASIC_IS_DCE32(rdev) ((rdev->family >= CHIP_RV730))
 #define ASIC_IS_DCE4(rdev) ((rdev->family >= CHIP_CEDAR))
 #define ASIC_IS_DCE41(rdev) ((rdev->family >= CHIP_PALM) && \
-- 
2.47.3

