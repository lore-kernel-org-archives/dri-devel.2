Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBFBC5B56D
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 07:26:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96F1710EABA;
	Tue, 11 Aug 2026 07:26:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gaugKwxo";
	dkim-atps=neutral
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com
 [74.125.224.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AE3110E042
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 23:45:44 +0000 (UTC)
Received: by mail-yx1-f54.google.com with SMTP id
 956f58d0204a3-667971437d6so2932918d50.2
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 16:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786405543; x=1787010343; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7HG5CwiDv1boZ0L5kG6Cnp/M+Qv7efLzzrooJVO8CU8=;
 b=gaugKwxo46dq1bXGg/bQStBKOo2nblQJZad9e8m5O1+JXNC5ks6wloHjSQgaUajSbt
 ueFmohKWTGgfKYRpx+f6fccZ/lnEKoFknzD06aFj27WopWSq6fPqgbTLYuw36pYYL4BW
 5LHiBb92HuEsXSeLYb4iPc39fQt4kd6nA1DCrxK/nYTKVrf7TnxaUdFaabg7HtpRah5o
 IlC6G/g7croONg4Po+HL3DdV6h9RcPeZLnaTgB2zTg+ji0NhDEfqC5ywkalICNf03RdU
 mrdgsigHg4Vl2WWc6IKsCEnYmTym4wmop0r/FIsiXiP0aZTW0pe5HFv2L2gTGv8y4CdN
 Es+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786405543; x=1787010343;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7HG5CwiDv1boZ0L5kG6Cnp/M+Qv7efLzzrooJVO8CU8=;
 b=IGNQCReesdftbPNutMw5Iqu7/JJaE3RGD+ILpkZy+1KkR8wIKg0SU6ybaP+Qz58G1J
 UeuSNhdRJotjs5cHbiEYsveAzgrhT/4vI4jbsUfh6ie53Dd2qSL2GpFXwRYRDVCdYQCt
 dXdPOfjG3pAyUuumDhSvLajvk0Gcz7f1LMpNaxCQYm66MM7vYLlkoiWPS+B7hhWJzBn+
 yZgU48fJy9J8Gq5+2vNezZS0MK5k2Yw+fDFsHi52CSn23HP8ap5JYEHWR/jDku5GWBOx
 tk13S2LtQfuvvY181zbE8nXvCflTo++7LrKSHUhkIhtOyf/8F9ZQSoYvAL1wsJDeunRX
 JKkg==
X-Gm-Message-State: AOJu0YwySROtsV/f4quHccNrs9DT4VmzlntY5QwnkFfW4HcB9pyI3lvL
 TjtaV8pw1QN9hQhxLUNvlMBV29YdRNXv3TQt3X1CD85BGGVV1agY+uuS
X-Gm-Gg: AR+sD10u96FQZL1+FYIUjZFCVDKEJmRETmHLIyWK5NXGPoIqTJ/QugTL0tqm7gNuIK9
 dARkFhoQrUKa1J9PSFTV5+boUj14e1ENB3azvI3i9GoTqq/O5+pqUn1gnB3+ubOztTFFkoTEYMR
 JnOUc574Vh8ZJ9K5ACLhF3qtWfN9BdRvuJeRRvA0Bl0zbgYBl6SssovuS1BJ4WJUeb/KIgOv9X5
 41VwulElnAr3mrTPvBAcTnuL6ldF0O8HOTPvScMQd1lVniw3kCDIzzHUmaIgjHDKWr+cEgdr6hV
 MbyhIO5eWsWI9B8VAR6Xfb7ctg5v7bcOoEqwAVQayJvKwhBGwD9pzPGa5goGK/8yGBnx4j7qy9o
 EOSD1gXvG0oPoyJwU6WYQf2cexZUatUTU8+9ym7g8x42k1M1E9fjIco8d+F5YJW0BRfB6w1LSy9
 vhYIGWkdg62HuH0bb4ZmQozw0e5v8D1LZRPZjuqN2ZhBjYrcokthVOhumW9g6ipMr8lCMKjqkeV
 UKlQ5bX2x76HYA=
X-Received: by 2002:a53:4906:0:b0:668:9567:db70 with SMTP id
 956f58d0204a3-66b12520805mr2969989d50.40.1786405542722; 
 Mon, 10 Aug 2026 16:45:42 -0700 (PDT)
Received: from [192.168.1.71] ([2600:1702:56e9:4b40:e3a9:78c5:641e:a58c])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66acae62283sm7277044d50.13.2026.08.10.16.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 16:45:41 -0700 (PDT)
From: Akash Sukhavasi <akash.sukhavasi@gmail.com>
Date: Mon, 10 Aug 2026 18:45:40 -0500
Subject: [PATCH v2] drm/panel: samsung-s6d16d0: Use mipi_dsi_*_multi(); fix
 minor bugs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-mipi-dsi-s6d16d0-multi-v2-1-8fcdfbf9bbd2@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQqDMBBFryKz7pQkwqhd9R7iQpJRB4xKYkOLe
 PemXqDL9+C/f0DkIBzhURwQOEmUdclgbgXYqV9GRnGZwShDqlYVetkEXRSM5DQ5hf4174KaKjY
 lcUNEkMdb4EHeV7jtMk8S9zV8rp+kf/ZvMmnUaElXzUBDaZv6Ofpe5rtdPXTneX4BAiD24bwAA
 AA=
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
X-Mailman-Approved-At: Tue, 11 Aug 2026 07:26:09 +0000
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
Changes in v2:
- Keep intermediate dsi variable for readability, per Neil's review.
- Add comment explaining why accum_err is not checked in unprepare().
- Simplify prepare() to a single return path.
- Link to v1: https://lore.kernel.org/r/20260807-mipi-dsi-s6d16d0-multi-v1-1-c6179f6f3c98@gmail.com
---
 drivers/gpu/drm/panel/panel-samsung-s6d16d0.c | 55 +++++++++------------------
 1 file changed, 17 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c b/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
index 54a65abf7e89..e734fffa45a4 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
@@ -48,14 +48,10 @@ static int s6d16d0_unprepare(struct drm_panel *panel)
 {
 	struct s6d16d0 *s6 = panel_to_s6d16d0(panel);
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(s6->dev);
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
-	/* Enter sleep mode */
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret) {
-		dev_err(s6->dev, "failed to enter sleep mode (%d)\n", ret);
-		return ret;
-	}
+	/* Enter sleep mode; error does not prevent power-off */
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
 
 	/* Assert RESET */
 	gpiod_set_value_cansleep(s6->reset_gpio, 1);
@@ -68,6 +64,7 @@ static int s6d16d0_prepare(struct drm_panel *panel)
 {
 	struct s6d16d0 *s6 = panel_to_s6d16d0(panel);
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(s6->dev);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 	int ret;
 
 	ret = regulator_enable(s6->supply);
@@ -83,57 +80,39 @@ static int s6d16d0_prepare(struct drm_panel *panel)
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
 	}
 
-	return 0;
-
-err_power_off:
-	gpiod_set_value_cansleep(s6->reset_gpio, 1);
-	regulator_disable(s6->supply);
-
-	return ret;
+	return dsi_ctx.accum_err;
 }
 
 static int s6d16d0_enable(struct drm_panel *panel)
 {
 	struct s6d16d0 *s6 = panel_to_s6d16d0(panel);
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(s6->dev);
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
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
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(s6->dev);
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
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

