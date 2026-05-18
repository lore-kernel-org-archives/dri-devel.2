Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D107CD4F58
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 07:13:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FDC110E183;
	Tue, 19 May 2026 07:13:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I1QdSQtJ";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8154910E355
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 21:20:30 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-44a5174670eso1546202f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 14:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779139229; x=1779744029; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=91PXPoM2XMelQ4xNCvH0aS1l4HeuvF9F6hz/TwrZmjg=;
 b=I1QdSQtJhjwYWH0o1y7rkSdbRvrcbUBRdVdiNAKWnYIvzYy9pvCXex6++MreKDj6ve
 pbn45TI110U0BptF7OVDUwz4KEtYITqqIweTuppBShIgBVS2rDlJWBj9USlDvJ4frnBc
 xgzzPUWKNmruwvC7XJx0Md1+VUuR0k6SEbOpdqtWX+gKyT1VXtjF0v2Ckq7vU6lzzbhB
 Ds3moOVdKkaoFapzMar3EjhLJPsuvIYxnbHc3ner6cN7XiSxNBCyiM454Wc78Feh21YK
 ay3pSRUvxSYVLMwtxoNC1+Ak+ABMSWuvW8onmy09lmrOfDjkmdOjoUdjoxSZRbcWIl8k
 Wbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779139229; x=1779744029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=91PXPoM2XMelQ4xNCvH0aS1l4HeuvF9F6hz/TwrZmjg=;
 b=pMnY2VSJ92gx3Wtr78Z1xj++Khq3Zjq24VwCilZUqb4NPtQiXeoF3GxDACJKdJGCG4
 CuMhUSrIPvduV+LaZExHoCATjc8J2RPRnxO7SonqsjY70/o1cisfgTUaSb4RmL89aP01
 zrO9APGoV4wvOcqTdvkpaVBTW05H2zqKSAJMIxz9mE4Q6OtCpPxXkssOISOKlv1wrsFG
 OwZIiR9jdEo+/w15w0t3qbDDW1OkoYbjJmtx5sNU8eQQWIXmjHjzOvMi4nwH3IFEeudO
 LiVzOq4viNJAZt495GWxeD66P6wPWmp7hl9D4xy3wLnfND/7DQuoOPExTOmCbWxOZcKh
 LJBQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ97IHx0O9hD+J4XnVTHrb0FA4GBUqsBI0wGSmY6ke1/xgFGTxmoKdCs5/nHq2D8AYG0XB3Ho31lSy0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx4lwZT5lC4QCx5H1E+fXtGSPWjMR64yaHU0Y4u4s0vv+lDz+s9
 WKEmg/d9f/TiFqGJ3BQqLmMAL/wRBkSchKzk3TrEQLxXcokjTWltylx4ZH3NgA==
X-Gm-Gg: Acq92OGIUY18n8D20hnG4w5FDiiDHjvfDQX7i4ZWmT/kxLr8jyEU8VyJihOtxGaE77i
 3vFHWbGajWT6194Ef6vm8cu14JgAiGgXAsctzduDhvif3fd6gu2AmNgQKNZ2FSnU2ptE53eFcd2
 1iXZfslSB9ba5nOYqucjRA2yuwicKNbzantynFmlCtfGfmG1pdHR8mnXUrbs0L7NSeD+/d3jP86
 tv17Jr914LcSHY0xWLiEi7b7Vr180dDewo2CI/1cf/cUJBaJWaIzISfIrwx5elrfiB119pVbTJe
 GblKYGLTZzB5ckBvGlhkmPBGMcP2iLf5FHVJYdmFaJLZYUsViYOGClaDk9lZVFL663fyNg+dUxQ
 5oHUUxKbJQ8r1T/5UwKb6sGwf3/m4OTi1g6JRJAchR6NtyOxDLoBtgkVNaAzjyWK4/ZKBfh+36P
 Ph9bO8v2kVblooNew1kSFjRhh3kzzaKbawhcP/a2q7c8UhFBxr
X-Received: by 2002:a05:6000:1787:b0:455:fbb:28bb with SMTP id
 ffacd0b85a97d-45e5c5dd6famr26011067f8f.35.1779139228788; 
 Mon, 18 May 2026 14:20:28 -0700 (PDT)
Received: from skylab.fritz.box ([2a06:4944:10fb:f400:564:5711:52c6:59ff])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ed2ffdfsm37133980f8f.15.2026.05.18.14.20.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:20:28 -0700 (PDT)
From: Gilles Risch <gilles.risch@gmail.com>
To: alexander.deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 lkp@intel.com, Gilles Risch <gilles.risch@gmail.com>
Subject: [PATCH v3 1/2] drm/radeon: fix internal display on iMac11,
 1 (RV770/DCE3.1)
Date: Mon, 18 May 2026 23:14:11 +0200
Message-ID: <20260518211409.4868-5-gilles.risch@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CADnq5_PhXmCNOGz9zK8mz7Y0Jw-J9uexhVjGLRqMA4AOHsJ5TQ@mail.gmail.com>
References: <CADnq5_PhXmCNOGz9zK8mz7Y0Jw-J9uexhVjGLRqMA4AOHsJ5TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 19 May 2026 07:13:01 +0000
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
v3: No code changes. 

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

