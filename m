Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024D6C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 00:43:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E79110E1A6;
	Mon, 17 Aug 2026 00:43:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lBwx5GkS";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8E2A10E1A6
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 00:43:39 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-47fde295992so1959702f8f.0
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 17:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786927418; x=1787532218; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pCREQy6It226dTYeaLnGfvrHe1ADDTxHfHCidnxEJo0=;
 b=lBwx5GkS20fga0MIUkbHcg+cOTYvb4f+KhScWc/j3R2h5QchwDqVauig3S4WhbV38W
 JpVgsPs49i2Th1Hg18NkO51CrCONjPzaZ1odPQOMtnJg91g/7ArPxFuE84GiIqkFzKu0
 EDsx2ALta1m38rsYigToJK7Mylmx5HrTrvIlqzJ1POamq74hBK6OOCjPAao6h9793qNA
 fb+lkSLOWGOspXp7Fmf6X2FkJ4q32iXggSm+ss2XxBQlSBYPPL/aDGW5naNULmyN2eOt
 V2sOnTh1w0jRYKfQCQRPsLnlZ3mo1kk6cMIL5SBGfMFzydEtmD0niltIaIuoyq4nt+7J
 eGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786927418; x=1787532218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pCREQy6It226dTYeaLnGfvrHe1ADDTxHfHCidnxEJo0=;
 b=KLjXz5xb8lPJcjwLprNfnRqkm62qT/wIgBw4ATEn2A0gNIPuPwN7hx1e11iVFj1Byu
 C4eqpkxZRT7XbfFpuOndCJEUBhtc7YopnQ6DfsqIw1yxpHuG1YIB9hob4SGZHl+NZLvr
 6mLYMY1QR2GnXfXcJ2Wmjn0be2O0a2eWmDY4lQ47wbz8XstAigaFMDEyAWmukeczDF0m
 12s5SJ2cNl7c/CsEC8vMrgOrbvQApnAesTayTaQJSpex30QPJ/rfBAB5IhB8ad/ANjhX
 sfFWoDaBl6eS57k8ZvFyDOPRtpA+FxOwON3k8wgQ8YuUYoau1PRWO04lHGdAAVsqhSo3
 sLBQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrw/n5ngzEu4L12iWlrkx4ZB1YsyPD1W7kebKNU1DcBTOKlb6W5luDSuTfuV2j+Vyr0dhZu5IKAqqU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzilYvRh/aeaNWaObrXKbPQwhrnbf41t7fvrLaDQ7WTeaqEik9h
 owcTXgVhFqvsVQPxTbgGQV6sZN8mhB/gTcKWO3CAw+5CXAPgdb9OpXnS
X-Gm-Gg: AR+sD136wUMQwDSay1TAySN2g8G2UdIVpZj/s0LuAz+YlpY6xLq+JRx7nxnEYIWEZ95
 kl6w7fKrlTUs5dSqkK6YR2ukpt0rNvvVmTUiEpQhdEbxJ6rpXirrGb2obshPbfYsruNgOMNduIN
 PQgFXKYl8q32scpW+MhGFax3mK+Td1lHIur4ugfWhKk1M08wsD0uuHWNwL+cKMcfoelTda6ktbS
 7E3qF9fHBQXVjoVEOTlW3xuVp9p3z/qU7AYyrZF6EHCWRw49iFL/TyY6pRKV/nchJquuZTQNmuh
 gdoJvO+PuarIMGIxHFmaNA1kJdcbxN7OZpLmvxv8vNfr+/1Re26Vhu1H61p1LBT3ZQDaVfDYSQJ
 Pq465MIHXnq7Ej+MQZ3vOyqUTKJ3wGYNGCMqNh0X/rSA0qHvPYexq7e67+T+Ynp8bjOOVm1F7wQ
 F+FXTehR2veZJeqfZLcatL1AKQAUS2bS0tJjB0QXeOh7ps+mEjpdsGXTgWvHfvAtd5SIG1W+Fkm
 YRU9wkLXw==
X-Received: by 2002:a5d:69cd:0:b0:47f:fcff:6b05 with SMTP id
 ffacd0b85a97d-48160799027mr25305749f8f.13.1786927417818; 
 Sun, 16 Aug 2026 17:43:37 -0700 (PDT)
Received: from skylab.fritz.box ([2a06:4944:10fb:f400:4fc8:8418:6988:19b9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2cc81csm28027768f8f.34.2026.08.16.17.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 17:43:37 -0700 (PDT)
From: Gilles Risch <gilles.risch@gmail.com>
To: alexander.deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 lukas@wunner.de, Gilles Risch <gilles.risch@gmail.com>
Subject: [PATCH v6] drm/radeon: fix internal display on iMac11,
 1  (RV770/DCE3.1)
Date: Mon, 17 Aug 2026 02:43:26 +0200
Message-ID: <20260817004326.3192-1-gilles.risch@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <180318e7-0432-403a-b87b-6f9a455bb86a@gmail.com>
References: <180318e7-0432-403a-b87b-6f9a455bb86a@gmail.com>
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

Good morning,

this is v6 of the patch, rebased on top of amd-staging-drm-next
(agd5f/linux).

There are no functional or code changes since v5.

Regarding Lukas Wunner's previous Reviewed-by (which was provided on v2),
I have kept him in CC so he can confirm if his review still stands given
the changes between v2 and v5.

Could you have a look at this when you have a spare moment?

Regards,
Gilles

Changes in v6:
- Rebased on amd-staging-drm-next (no functional/code changes since v5)
---
 drivers/gpu/drm/radeon/atombios_crtc.c     |  5 ++++-
 drivers/gpu/drm/radeon/atombios_encoders.c | 23 ++++++++++++----------
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/radeon/atombios_crtc.c b/drivers/gpu/drm/radeon/atombios_crtc.c
index 2fc0334e0d6c..075eba2d47f3 100644
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
index 5cfd8fcfa5e8..8b3f8303a967 100644
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
 

base-commit: 21c50d41af7c46e138b542dba2dcf6d2a978ae99
-- 
2.47.3

