Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AA3C5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:37:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6DB310E159;
	Mon, 10 Aug 2026 06:37:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mqCL2PkV";
	dkim-atps=neutral
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com
 [209.85.128.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25C9D10E463
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 22:55:26 +0000 (UTC)
Received: by mail-yw1-f171.google.com with SMTP id
 00721157ae682-8234e9ea616so1314137b3.0
 for <dri-devel@lists.freedesktop.org>; Fri, 07 Aug 2026 15:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786143325; x=1786748125; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RxzpAl5Sab0OuL2z7FHJHf+XVUs9dZdXhmtZd62GOss=;
 b=mqCL2PkV2nRfCfNG7pVuvupfqV/YbveJVHRCrgXvrKqpH55eAXmn+hjjfN8G84x8ys
 SVKJVD0H/MZ06rn6tV3GTqPFxoS1rLqWqKnaCVbjMW5cQv3sTPY9pTxyuSeZ3Jv5GQiH
 GT6plnbB0UW4m8lM+Bub56+fqdjpJ1iB4uYzdfDlKMxDYpdGXpbcCSoCnp8oXwMyHDOp
 9/ekr0czA2cqfiaySL/JZgKLvyKmCkoyIJRvREJ5UG/hpD+fOO6zA69JF4axlQnwVdIm
 rgIuuO//DME1Yrfvn5UjnPeIWx0QpF9eMe2QwnuwyQhyzNASH4aO5waDXY1nM+VUeOlY
 9sRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786143325; x=1786748125;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=RxzpAl5Sab0OuL2z7FHJHf+XVUs9dZdXhmtZd62GOss=;
 b=gXUpJ22nfbnB0F6tpnCnCaSe6g3bzWI7PX+zrQUUqRavVOOp0LHQeP4Y7S+siM/uSK
 DzjPYfgUIIRUX5lZF+j8horxxc7uBOSFzuzV9FV1GBTEgLxWzlsuZpxj9DdhC6ySG10l
 STz/EVdAGxooPORAxN1n7iEGbw65R7/IEPyKYoa5Y5vC+1exPPlGgAoezpsQGi4srHvH
 MFP43FNj9pG6OkgEQxQrpKdb+4PGLXcvTm2a8sht/fQRtcfKOzE4tTSvtrgJxOb0Zu6V
 1dedRdkSHyKjaUcYluyRFMl812wi1NGcoGHpiYqhld6RKYxwoIiiAi+Gz5SW/v5J6m1W
 2iaQ==
X-Gm-Message-State: AOJu0YxObYbylqKLTyGME9wUAgl1LZHlawqHMMaFyvEmK/yaFJZmrlUk
 rYwkPpwwO4oGBfM9158EHcipXWfETG3iBFfIJ3FMBWm/PR3x5lYKFAR7
X-Gm-Gg: AR+sD12XrnSF4KfYt1n+mfxl1f6eNZ39SxqQVf/glpr+VkJw/2qaQEtR26f0/g45JVk
 esiWhZOwzz4xFRgYjYn8Ps/WYH6f4AybIRzK1HUbnrkkt0NGq1LDkfga/8T34dFkXZ+FtdmMU+o
 g2BeeY5ML/8q5uldSKLcY5f+7ZLgtwISiywxQnP1S7nCFm5VERy3u3jjDVTBA+/ramysckzzCgv
 t6j1aqpcM/ghHVAUfxaiGcfYNQgMMBAD3UrgNhyY/kDLiKeWPEam/hUlMG9t4EhP7AG/CiYTsdM
 s9ua5yEmkyNRL7LiKTfMTprQ3aGyNDjBqcXHDdprFf2dSDm0zAkM3w5UxZLAp6+yPDeKJmt69Vz
 +OHX5D8HQe6wNZog7DG7I37/qFFSnbPKJIYjuJ55xWb7V9jMq9gj2UmQ6Cb8XMmLHVR5U4ShRDr
 Fj/vlPLQhHoCCcf4sUz7zA164GGxw6zUgytH2QaZUaKPVtleMZlJuO4Tuu3Q6s1BZSMfgNjZ9lD
 BSZ
X-Received: by 2002:a05:690c:e1e:b0:820:c54:4811 with SMTP id
 00721157ae682-825ef601648mr13529377b3.13.1786143324653; 
 Fri, 07 Aug 2026 15:55:24 -0700 (PDT)
Received: from [192.168.1.71] ([2600:1702:56e9:4b40:e3a9:78c5:641e:a58c])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-823f6a0f012sm18113477b3.40.2026.08.07.15.55.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 15:55:24 -0700 (PDT)
From: Akash Sukhavasi <akash.sukhavasi@gmail.com>
Date: Fri, 07 Aug 2026 17:55:02 -0500
Subject: [PATCH] drm/panel: samsung-s6d16d0: Use mipi_dsi_*_multi(); fix
 minor bugs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-mipi-dsi-s6d16d0-multi-v1-1-c6179f6f3c98@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MywqDMBBG4VeRWTuQRBgvryIuSjOtP3gjo6Ugv
 rvB5bc45yTTBDXqipOS/mBYlwxfFvQeX8tXGTGbggviGlfzjA0cDWwSvUTH8zHtYC+1hkq0FRH
 K8Zb0g/8z7ofrugGUuY3DaAAAAA==
X-Change-ID: 20260807-mipi-dsi-s6d16d0-multi-167e236e9666
To: Doug Anderson <dianders@chromium.org>, Linus Walleij <linusw@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Akash Sukhavasi <akash.sukhavasi@gmail.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

The mipi_dsi_dcs_*() functions used by this driver are deprecated
in favour of their _multi() counterparts, as noted in
Documentation/gpu/todo.rst. The _multi() variants record the
first error in a context structure and skip subsequent calls once
an error is set, removing the need to check the return value
after each command. They also log failures internally, making the
per-call dev_err() calls redundant.

Convert prepare(), enable(), disable(), and unprepare() to use
mipi_dsi_dcs_*_multi().

unprepare() previously returned an error if
mipi_dsi_dcs_enter_sleep_mode() failed, skipping RESET assertion
and regulator_disable(). Because drm_panel_unprepare() does not
clear panel->prepared when the callback returns an error,
drm_panel_prepare() would then return early on the next call,
leaving the panel powered and unable to be re-initialised. The
converted code always asserts RESET, disables the regulator, and
returns 0.

Also fix a typo in a comment ("Enabe" -> "Enable").

Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>
---
Compile tested only, no hardware available. checkpatch and a W=1
build are clean.
---
 drivers/gpu/drm/panel/panel-samsung-s6d16d0.c | 56 ++++++++-------------------
 1 file changed, 16 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c b/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
index 54a65abf7e89..85b4515f443d 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
@@ -47,15 +47,10 @@ static inline struct s6d16d0 *panel_to_s6d16d0(struct drm_panel *panel)
 static int s6d16d0_unprepare(struct drm_panel *panel)
 {
 	struct s6d16d0 *s6 = panel_to_s6d16d0(panel);
-	struct mipi_dsi_device *dsi = to_mipi_dsi_device(s6->dev);
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = to_mipi_dsi_device(s6->dev) };
 
 	/* Enter sleep mode */
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret) {
-		dev_err(s6->dev, "failed to enter sleep mode (%d)\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
 
 	/* Assert RESET */
 	gpiod_set_value_cansleep(s6->reset_gpio, 1);
@@ -67,7 +62,7 @@ static int s6d16d0_unprepare(struct drm_panel *panel)
 static int s6d16d0_prepare(struct drm_panel *panel)
 {
 	struct s6d16d0 *s6 = panel_to_s6d16d0(panel);
-	struct mipi_dsi_device *dsi = to_mipi_dsi_device(s6->dev);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = to_mipi_dsi_device(s6->dev) };
 	int ret;
 
 	ret = regulator_enable(s6->supply);
@@ -83,57 +78,38 @@ static int s6d16d0_prepare(struct drm_panel *panel)
 	gpiod_set_value_cansleep(s6->reset_gpio, 0);
 	msleep(120);
 
-	/* Enabe tearing mode: send TE (tearing effect) at VBLANK */
-	ret = mipi_dsi_dcs_set_tear_on(dsi,
+	/* Enable tearing mode: send TE (tearing effect) at VBLANK */
+	mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx,
 				       MIPI_DSI_DCS_TEAR_MODE_VBLANK);
-	if (ret) {
-		dev_err(s6->dev, "failed to enable vblank TE (%d)\n", ret);
-		goto err_power_off;
-	}
 	/* Exit sleep mode and power on */
-	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
-	if (ret) {
-		dev_err(s6->dev, "failed to exit sleep mode (%d)\n", ret);
-		goto err_power_off;
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	if (dsi_ctx.accum_err) {
+		gpiod_set_value_cansleep(s6->reset_gpio, 1);
+		regulator_disable(s6->supply);
+		return dsi_ctx.accum_err;
 	}
 
 	return 0;
-
-err_power_off:
-	gpiod_set_value_cansleep(s6->reset_gpio, 1);
-	regulator_disable(s6->supply);
-
-	return ret;
 }
 
 static int s6d16d0_enable(struct drm_panel *panel)
 {
 	struct s6d16d0 *s6 = panel_to_s6d16d0(panel);
-	struct mipi_dsi_device *dsi = to_mipi_dsi_device(s6->dev);
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = to_mipi_dsi_device(s6->dev) };
 
-	ret = mipi_dsi_dcs_set_display_on(dsi);
-	if (ret) {
-		dev_err(s6->dev, "failed to turn display on (%d)\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
 
-	return 0;
+	return dsi_ctx.accum_err;
 }
 
 static int s6d16d0_disable(struct drm_panel *panel)
 {
 	struct s6d16d0 *s6 = panel_to_s6d16d0(panel);
-	struct mipi_dsi_device *dsi = to_mipi_dsi_device(s6->dev);
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = to_mipi_dsi_device(s6->dev) };
 
-	ret = mipi_dsi_dcs_set_display_off(dsi);
-	if (ret) {
-		dev_err(s6->dev, "failed to turn display off (%d)\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
 
-	return 0;
+	return dsi_ctx.accum_err;
 }
 
 static int s6d16d0_get_modes(struct drm_panel *panel,

---
base-commit: dc2f9f7fed1a8ea5290f9f60c6310d497e85e666
change-id: 20260807-mipi-dsi-s6d16d0-multi-167e236e9666

Best regards,
-- 
Akash Sukhavasi <akash.sukhavasi@gmail.com>

