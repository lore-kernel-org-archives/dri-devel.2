Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B10ACD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 07:13:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E23C10EABA;
	Tue, 19 May 2026 07:13:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mLDORVs+";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FE2410E8EA
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 21:20:47 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso21735115e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 14:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779139246; x=1779744046; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l6HkySrOlOOhWVUzrMl8CbH2neWfwcax3uYwxu0Tdaw=;
 b=mLDORVs+M4R7b3h0oXE8Om3c1LNU+ruxI2zP00eEG8L4phElBxwaER1wJEzf7ekSSK
 KISqzL7eBxOecexi1h2ZtqCWf4kbhKPNqR0MYpi1Ck+XFVYp2zb2v5421Rrk0nChcZLd
 VBgjwN/k2spMkHlXSAPQyYWOJoEVBptW+sxUTaQFSUomzgxU3XUw3yHLwZheeapTNvAO
 cjoKjTNonMA2k4HK4UonUZUnzbHhPYQR0lT/ABgEfkt9rRaFrNHRSMZJnKnmp66j+CE/
 VAlvOapVqrjG0aVB5QxLnsxSWTWmV0WfjRJFw74Hobpn7MJWHoL++8AtDXaOueoa3le7
 Gu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779139246; x=1779744046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l6HkySrOlOOhWVUzrMl8CbH2neWfwcax3uYwxu0Tdaw=;
 b=EFl1isA1CJN3tfO4p2ApjFpIt7Bch69UeN37lB0tbJ5hgLR0mxwJT7iUDmMTzJHlMH
 ubxqNj73U2KtbjWc7STLTh4k+lshXAMf1m9lzzYmDunWBFpX332VYOmXBO06vFWcNPHS
 /s1i01PETYjJtTIL/9svE72rd33Vp80BoaS0P1Q2A6jEo9XgMypmakAMZ34dvY1wm3hB
 MW1dla/shUSVlWlIC/IwK5MfLHppFot7qAAukl0P33WNLNfloiZjgtvkA1CYyKc6uH4+
 m+gofRQhbPkL4l3z9ot2qnwxqt9k4NVHlAJTapygsKn/4E/3Ke5+yzj+xuVzfq0Jj8ZQ
 qRaw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9aOsKylJ/HcrnvhrPvb7eBrVxoXnLxHoeD0KjiR6ZDJRHwp2600NLgUgxTfQ3jKBjIqY11+gi5aHQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzTbJPRV85AvLY+z2aNeq/wGplDjmUCVYpEbt6WBjgRNcEF3mTN
 q5Al9jz2d8Pieo2rqnPCFF0T+JaVQ1ysIJZIj3Ch7oLOBZQWj8l4CvoC
X-Gm-Gg: Acq92OGFkJ/hckDJEAFqsYGy9Wzmf9QpGgav28rehiR/yN9WuRMJBO2hmI990aG+5mw
 cA0bOnE4oIEiRifQojxLHBV7o7fdoTA2lS8qCXB/weFzn2thebrTJ/a6QZ68lZsHMjJ0EYKBdC+
 mj4BecDViSpKLF5NyffPqlu8pyifBI0KS+gurOLwUxMj1zTrCIyxh1/1r0JUKnEzxbMvum5XElr
 GDgm0nqpoTQwe703wrdVf6L9TF9uzBhJ2OCcG1wKFMVr91U//sLt2NEhIukCCb9FRYEBfSNBTUZ
 wDrE11CDuYjFGZvqhfQxF141YOGK3ErQsFXAzNG3kJ/yUrH6jv3Qomabf5yZQNwjr0QxXH5y+Om
 x+tDH9kW28ynMlqYUUFud1qQ0VRyMRtuEI+gODMMZKXlCPAOAbgBnUjoXDAnhssQ30SQivjrRrg
 +lwV6HYmSs0qmLp7nAn1VeWNlXoxyXpJzzwfNllQ==
X-Received: by 2002:a05:600c:c10b:b0:489:1c2d:211e with SMTP id
 5b1f17b1804b1-48fe5fcdedemr201288435e9.5.1779139245648; 
 Mon, 18 May 2026 14:20:45 -0700 (PDT)
Received: from skylab.fritz.box ([2a06:4944:10fb:f400:564:5711:52c6:59ff])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ed2ffdfsm37133980f8f.15.2026.05.18.14.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:20:45 -0700 (PDT)
From: Gilles Risch <gilles.risch@gmail.com>
To: alexander.deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 lkp@intel.com, Gilles Risch <gilles.risch@gmail.com>
Subject: [PATCH v3 2/2] drm/radeon: fix eDP resume from suspend on iMac11,
 1 / DCE3.1 systems
Date: Mon, 18 May 2026 23:14:13 +0200
Message-ID: <20260518211409.4868-7-gilles.risch@gmail.com>
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

After suspend/resume the internal eDP display on Apple iMac11,1,
stays dark because atombios_set_edp_panel_power() skips panel
power control for anything older than DCE4, and
ATOM_ENCODER_CMD_DP_VIDEO_ON/OFF is required on ths iMac.

Tested on iMac11,1 (Mobility Radeon HD 4850, RV770/DCE3.1).

Signed-off-by: Gilles Risch <gilles.risch@gmail.com>
---
 drivers/gpu/drm/radeon/atombios_encoders.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm/radeon/atombios_encoders.c
index 4e984973c043..0a699a887ee9 100644
--- a/drivers/gpu/drm/radeon/atombios_encoders.c
+++ b/drivers/gpu/drm/radeon/atombios_encoders.c
@@ -1384,7 +1384,8 @@ atombios_set_edp_panel_power(struct drm_connector *connector, int action)
 		goto done;
 
 	if (!ASIC_IS_DCE4(rdev))
-		goto done;
+	    if (!dmi_match(DMI_PRODUCT_NAME, "iMac11,1"))
+		    goto done;
 
 	if ((action != ATOM_TRANSMITTER_ACTION_POWER_ON) &&
 	    (action != ATOM_TRANSMITTER_ACTION_POWER_OFF))
@@ -1707,7 +1708,7 @@ radeon_atom_encoder_dpms_dig(struct drm_encoder *encoder, int mode)
 		if (ENCODER_MODE_IS_DP(atombios_get_encoder_mode(encoder)) && connector) {
 			/* DP_SET_POWER_D0 is set in radeon_dp_link_train */
 			radeon_dp_link_train(encoder, connector);
-			if (ASIC_IS_DCE4(rdev))
+			if (ASIC_IS_DCE4(rdev) || dmi_match(DMI_PRODUCT_NAME, "iMac11,1"))
 				atombios_dig_encoder_setup(encoder, ATOM_ENCODER_CMD_DP_VIDEO_ON, 0);
 		}
 		if (radeon_encoder->devices & (ATOM_DEVICE_LCD_SUPPORT)) {
@@ -1724,7 +1725,7 @@ radeon_atom_encoder_dpms_dig(struct drm_encoder *encoder, int mode)
 	case DRM_MODE_DPMS_SUSPEND:
 	case DRM_MODE_DPMS_OFF:
 
-		if (ASIC_IS_DCE4(rdev)) {
+		if (ASIC_IS_DCE4(rdev) || dmi_match(DMI_PRODUCT_NAME, "iMac11,1")) {
 			if (ENCODER_MODE_IS_DP(atombios_get_encoder_mode(encoder)) && connector)
 				atombios_dig_encoder_setup(encoder, ATOM_ENCODER_CMD_DP_VIDEO_OFF, 0);
 		}
-- 
2.47.3

