Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C91CD6E55
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 21:20:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E7CE10E568;
	Mon,  1 Jun 2026 21:20:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NEDi/VSc";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F0AA10E9BA
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 21:20:04 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-490a7629380so18298825e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 14:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780348803; x=1780953603; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qnwAsy6Fhk/v2/m0U2Y/k7DuV+rs4ovp810ofu9BhuY=;
 b=NEDi/VScMjuj5aFKmTiM5JRYCjNNrMXAKTFYWWbpK+wuqXkZa1JGF0m+lfoA84OkDF
 00fIXxQMWY8qfFys1C6JAGrodAvx532OofEuy0Pzh6kTGr6Y7DG98FasV0xT0MpsAeI9
 +szfIZk91586GAMJ8ZqNWJzOUeykl6bbHIFjtMHCDA37xqz9a9RdP9iiks9sRPophwpo
 bKtzx4nPcvq5C/pcGVcq8Ir+PsKJ0KL2K9LW3OdsIqYwfgNf2jdf1xmISWLpD/Wcy1aw
 vvYg07qFVGgVgWbg/lVIKbiVVTncyUa2Cj8GWmlPclGYYTIYUYvuOGePgzMXlBa6UZJf
 Rmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780348803; x=1780953603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qnwAsy6Fhk/v2/m0U2Y/k7DuV+rs4ovp810ofu9BhuY=;
 b=B9nddb22qnWduKT94jRmwoXdez0tj6VYyPTTfthPrSFD/63m8IaZBtZLBMISnKSJfu
 SVELfVyGAHrBFPKzEpQfQivz9vdxwQeXyPludBd+UALzDQ6h3Z2RItR/H5jzo3BzbmFw
 1Awz80qayXTZYnESlN4j/XnYX1y+zkMvz601reezBd6IIp/3puhWW/tt3WwF6ko5ycO4
 eDJFyRnB1wJlESlG6cs4Wj4EuMd0djpQDl9E5MqwrjlGC3+PmTfq/OL7GKW7HNYWRFkm
 wtbkuvgtRx+8B7xBuIQoUEsdX4a9/CozQheIz3WKTdzHqY9VluH9gP2hKcKgfxHfgHQC
 RLcw==
X-Forwarded-Encrypted: i=1;
 AFNElJ88PStLxVblN3q/c+m8977/fBo4J4A/JCn2Pzzef/ud9qNFoOkjMNW5ZokTbL0jTYfxfrybOlQoPA0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwH8gt3qfvVrD3qUpFvdbgicBqLz8VmKAAKcqHsYoeYNRxYifDU
 VOuhfQnJHdYPS7j+JYJUkom2MLU73UBA8XitcohrPkK2yuVWDwn4cCVD
X-Gm-Gg: Acq92OF4Wf7XBeQquzMZ6BTFEwzatMU1zWd7Q+iwaXoLRrPf/66kmOThhtmABTOI6vP
 OwPMRHgdQKNpl9JqSXaRAHuzIFvCFpLW8DwW5u4zxjk3FEwZLpRv4fymMRMkvzMNhl3XkOz0ogI
 1lxkIh9a7p+FsgEepdbYchKEWjm/dZYoC/45O/Pydmk1H2xRK8ah/L0eoAqJ6joJvkCorx2iE0K
 Q+FfqKvJwcgc/Odr6ZBo7Q7eNV+oNa+IiI7+nlvP4zl0Ka+9ZtTacmP0x86aqxkrf/QGfVys53N
 D8c5LbXeqnpbTmu76g++4msQxMLXOV8499UOo4T8vgL4oGKQQB8iUAbqFCiEADa1BYFdjkqS9cO
 1UbQd5w7gdSPQBeBv5PAX3ofn0a40zXxWCr0fJlll52v9BsP+f+XfPPXImN5811u6UwuhztXgXC
 rBsM870pswM+0i2G5Pt+4D7+X7pFvKGjNPAkqx0ovkrhvKjt93
X-Received: by 2002:a05:600c:4fc4:b0:490:6889:202 with SMTP id
 5b1f17b1804b1-490a29639e6mr225017555e9.29.1780348802385; 
 Mon, 01 Jun 2026 14:20:02 -0700 (PDT)
Received: from skylab.fritz.box ([2a06:4944:10fb:f400:8383:b4e3:3885:b00a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ad63b34dsm19778925e9.27.2026.06.01.14.20.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 14:20:01 -0700 (PDT)
From: Gilles Risch <gilles.risch@gmail.com>
To: alexander.deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Gilles Risch <gilles.risch@gmail.com>
Subject: [PATCH v5] drm/radeon: fix internal display on iMac11,
 1 (RV770/DCE3.1)
Date: Mon,  1 Jun 2026 23:19:32 +0200
Message-ID: <20260601211931.2837-2-gilles.risch@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CADnq5_Os2Bk8Dd9d8m_CkK9nYSporzUqbiRA=YD85nRBB6XjMw@mail.gmail.com>
References: <CADnq5_Os2Bk8Dd9d8m_CkK9nYSporzUqbiRA=YD85nRBB6XjMw@mail.gmail.com>
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

The Apple iMac11,1 (27-inch, Late 2009) uses a Mobility Radeon HD 4850
(RV770/DCE3.1) with a 2560x1440 internal panel on an internal
DisplayPort path. Without this fix the display stays dark under KMS.

This machine suffers from the same issue as iMac10,1 and iMac11,2:
Apple routes the internal display through Link B of the DIG encoder
instead of Link A. Add iMac11,1 to the existing DMI quirk and move
the Apple-specific encoder assignment into its own block, independent
of the DCE version check.

Additionally, the 2560x1440 panel requires RADEON_PLL_USE_FRAC_FB_DIV
and ATOM_ENCODER_CMD_DP_VIDEO_ON, limited to iMac11,1 via dmi_match()
to avoid affecting other boards.

Signed-off-by: Gilles Risch <gilles.risch@gmail.com>
---
 drivers/gpu/drm/radeon/atombios_crtc.c     |  5 ++++-
 drivers/gpu/drm/radeon/atombios_encoders.c | 23 ++++++++++++----------
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/radeon/atombios_crtc.c b/drivers/gpu/drm/radeon/atombios_crtc.c
index 2fc0334e0..075eba2d4 100644
--- a/drivers/gpu/drm/radeon/atombios_crtc.c
+++ b/drivers/gpu/drm/radeon/atombios_crtc.c
@@ -24,6 +24,8 @@
  *          Alex Deucher
  */
 
+#include <linux/dmi.h>
+
 #include <drm/drm_fixed.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
@@ -594,7 +596,8 @@ static u32 atombios_adjust_pll(struct drm_crtc *crtc,
 		if (((rdev->family == CHIP_RS780) || (rdev->family == CHIP_RS880))
 		    && !radeon_crtc->ss_enabled)
 			radeon_crtc->pll_flags |= RADEON_PLL_USE_FRAC_FB_DIV;
-		if (ASIC_IS_DCE32(rdev) && mode->clock > 165000)
+		if ((ASIC_IS_DCE32(rdev) || dmi_match(DMI_PRODUCT_NAME, "iMac11,1"))
+		    && mode->clock > 165000)
 			radeon_crtc->pll_flags |= RADEON_PLL_USE_FRAC_FB_DIV;
 	} else {
 		radeon_crtc->pll_flags |= RADEON_PLL_LEGACY;
diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm/radeon/atombios_encoders.c
index 5cfd8fcfa..8b3f8303a 100644
--- a/drivers/gpu/drm/radeon/atombios_encoders.c
+++ b/drivers/gpu/drm/radeon/atombios_encoders.c
@@ -1707,7 +1707,7 @@ radeon_atom_encoder_dpms_dig(struct drm_encoder *encoder, int mode)
 		if (ENCODER_MODE_IS_DP(atombios_get_encoder_mode(encoder)) && connector) {
 			/* DP_SET_POWER_D0 is set in radeon_dp_link_train */
 			radeon_dp_link_train(encoder, connector);
-			if (ASIC_IS_DCE4(rdev))
+			if (ASIC_IS_DCE4(rdev) || dmi_match(DMI_PRODUCT_NAME, "iMac11,1"))
 				atombios_dig_encoder_setup(encoder, ATOM_ENCODER_CMD_DP_VIDEO_ON, 0);
 		}
 		if (radeon_encoder->devices & (ATOM_DEVICE_LCD_SUPPORT)) {
@@ -2123,17 +2123,20 @@ int radeon_atom_pick_dig_encoder(struct drm_encoder *encoder, int fe_idx)
 	}
 
 	/*
-	 * On DCE32 any encoder can drive any block so usually just use crtc id,
-	 * but Apple thinks different at least on iMac10,1 and iMac11,2, so there use linkb,
-	 * otherwise the internal eDP panel will stay dark.
+	 * Apple routes the internal eDP panel through Link B of the DIG encoder
+	 * instead of Link A on the iMac10,1, iMac11,1 and iMac11,2.
+	 * Use linkb to avoid a dark display.
 	 */
-	if (ASIC_IS_DCE32(rdev)) {
-		if (dmi_match(DMI_PRODUCT_NAME, "iMac10,1") ||
-		    dmi_match(DMI_PRODUCT_NAME, "iMac11,2"))
-			enc_idx = (dig->linkb) ? 1 : 0;
-		else
-			enc_idx = radeon_crtc->crtc_id;
+	if (dmi_match(DMI_PRODUCT_NAME, "iMac10,1") ||
+	    dmi_match(DMI_PRODUCT_NAME, "iMac11,1") ||
+	    dmi_match(DMI_PRODUCT_NAME, "iMac11,2")) {
+		enc_idx = (dig->linkb) ? 1 : 0;
+		goto assigned;
+	}
 
+	/* on DCE32 and encoder can driver any block so just crtc id */
+	if (ASIC_IS_DCE32(rdev)) {
+		enc_idx = radeon_crtc->crtc_id;
 		goto assigned;
 	}
 
-- 
2.47.3

