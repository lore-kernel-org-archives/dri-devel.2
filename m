Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C94CD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 07:53:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67A7610ED00;
	Wed, 13 May 2026 07:53:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b35ZTuRN";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C42B10E0C6
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 19:05:37 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-48374014a77so35777525e9.3
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 12:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778439936; x=1779044736; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wULIO50aMY8iqYqnteMyOQw6QvzezVAoGO8iMs+bIKs=;
 b=b35ZTuRNg3pPNM95orzQztaIQ4ywFWh6OH0OSJK3wpvTJ6YeOfDbI8BS0Z1dSMIN8R
 MEe0sUGsJhRi23SouVssiPI1NRQuS2oHsSrBFKXesk0WHTOcmJBT9vv2xA3IkYxPKDhX
 6LgKSwzMKcoID1rsttLkNQbKZGjb8/oSWhkIMBY9AHWN8W27dVaOht4oqQoHtE3/Dy/t
 /K1rp4+puE9spRpKA8T8K5cKcJO1jbzeHti9tsnUgyDefi+q7OGrB+aNYZw356pxSTw0
 9tDiZgOGNptXulz8Y+6ZbhNRCoLcfJhFEWTGwcVxEz5rW/tqD0s1scLcMcwB/WbHAUQg
 dfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778439936; x=1779044736;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wULIO50aMY8iqYqnteMyOQw6QvzezVAoGO8iMs+bIKs=;
 b=gmvnP5rnhzq5XUMqC1PALf/RFwpubisTxQmB1XIBhSBBsIcXLkGtYk2EpSHgKcXzmg
 mRAGDxSGXvEvi2v5mgoZIAK6cMED9cJrjTdpOl9uFiLrhY/8/vkNYg6m4jEw/df97DCa
 C11+JKJdPvkec4qOyZ1PlMktUUCctwPiMudd2RueXhUaUBccKAeyPUJ0xIIWLxRP/2ge
 ZBK4pQzrBMPeyhbtStJb08vXYg9hfIWBzDzeowpU60JjACg2Sq3cd9wM7mYdtoVbJFjm
 QCt7+gcGTM2a64M1teZnOtUvzXJxogaEL55r0oIFQSh+C6bYlz/hJFFOGQrnJPrtcCqV
 LRRg==
X-Gm-Message-State: AOJu0YxLCkvAWdXUX2C6J9gVNQu51kiSORCJUiujt96L4O9r3ARVRdqp
 idGoO1+oO+DTYlaviWszDQNMHEfpj7TIRK8IwhsNFL2CIMBaw/vP3cNh
X-Gm-Gg: Acq92OH6pWQvvZALF/pGOyGfFY64ajA3Nw6g4vo459sKWKrbcjZNIM468CteFuXLMQz
 RweWA3ERqYfxo1emT9RvbQGfgAqWNCVJtaeyvkV+Jn5qMJYBu4uvqSW3y57t5kWtGoarRadoF85
 +iP7WEdP/WQ8VWAPDx8ngJIvQ5QZiTewyUkxIZnHq/TNTHF1V9J1Gm35JhM82jngKQUuCSCggk9
 r0ZhLbXMfiMFcctl3GKwHlr7Ac4sbKOJY2stAmodDfhl3TWy/pb8+zXlH2IFkd5cweShLhxHUml
 YE0fqZ7pZRUPMI+Go1mVSgQ1MCTp18iwfYyoj83GKdnMBaLP4TU07aBWiFk765TWWOFCriDoY14
 +HEmpdjJr08rnf8cbIp5JupRU0EkkN8KTftwa/WFtcGhSbPEkopGF4SYA3EnLlNrm4nPTZxr1H6
 /HLVjLBh0mR4UhhKAI8fcaaViTWEgCMoUmSj4mhdo=
X-Received: by 2002:a05:600c:a02:b0:489:1c1f:35f1 with SMTP id
 5b1f17b1804b1-48e706ad0damr110613005e9.4.1778439935639; 
 Sun, 10 May 2026 12:05:35 -0700 (PDT)
Received: from skylab.fritz.box ([2a06:4944:10fb:f400:3dc3:7b05:ba52:3241])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e701e9585sm133070855e9.5.2026.05.10.12.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 12:05:35 -0700 (PDT)
From: Gilles Risch <gilles.risch@gmail.com>
To: alexander.deucher@amd.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Gilles Risch <gilles.risch@gmail.com>
Subject: [PATCH] The Apple iMac11,
 1 (late 2009) has an integrated ATI Mobility Radeon HD 4850. This
 machine suffers from a similar problem as the iMac10,
 1 (late 2009) and the iMac11,
 2 (mid 2010). This small patch fixes the issue on this machine.
Date: Sun, 10 May 2026 21:05:06 +0200
Message-ID: <20260510190505.4810-2-gilles.risch@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 May 2026 07:53:28 +0000
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

Fixes freedesktop issue 164
Link: https://gitlab.freedesktop.org/xorg/driver/xf86-video-ati/-/issues/164

Signed-off-by: Gilles Risch <gilles.risch@gmail.com>
---
 drivers/gpu/drm/radeon/atombios_crtc.c     | 4 ++--
 drivers/gpu/drm/radeon/atombios_encoders.c | 9 +++++----
 drivers/gpu/drm/radeon/radeon.h            | 1 +
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/radeon/atombios_crtc.c b/drivers/gpu/drm/radeon/atombios_crtc.c
index 2fc0334e0..3c6d33273 100644
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
index 5cfd8fcfa..4e984973c 100644
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
index 527b9d19d..6b7c0abe4 100644
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

