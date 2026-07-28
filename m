Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A65C54F4D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:21:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2324010E7D7;
	Tue, 28 Jul 2026 07:21:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ch122/5W";
	dkim-atps=neutral
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com
 [209.85.128.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD12610E4FD
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 01:45:53 +0000 (UTC)
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-80dc4a68e4aso36634537b3.0
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 18:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785203152; x=1785807952; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DS2VB3nCez548riCu/pQt5aDJHBxaRdpnvPnhN6yN9g=;
 b=ch122/5WPPD61+TAWbQ9EI8qDGVeJ6krXjqMIvgrOTPVPnUCo8ygg+6XAJw4wANiCm
 0LwnDLqQHjnv8n+U4uvX3g8ZveZtrJWbjQsLj+yhXjOHaNYoULCKnHbzOh3VjFrn9+R9
 H4CxM7XnkpLyVuB97Avgf+urnmCkg6xifD0u6MSvMt0yQ/wHN/KqlxWBRxs8RoCXdr2k
 Q64rFQtLq0Py/bc42LtqadNb+ylss0rpbR+juPCVpDHVUaLnbgHNXHJ2iBBiGLxxhFVn
 jwLWBRjFhI0M8vZNG/ulneyMAjnGJdS+TN4JIVMEiLWt6xWMf5vUfybQq9mjmUBmJ1j6
 StxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785203152; x=1785807952;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DS2VB3nCez548riCu/pQt5aDJHBxaRdpnvPnhN6yN9g=;
 b=Uxy4PINfH+BYwK+5m/9dUfqRJNPkCQbiV4DS10wz7r4Q1OXnO1PZQAW+63zV+NBWZI
 QKJHj3zh0xFIy+xlgdNQ2CsdO8lhsi9Kgg6+6RuXhlmM0LJWg8zUX2ov345UTAjh+QP8
 aNepoKcD1JUtfbfGr+9VVeSDwOU+MUfCVGyeb9YCNi5fEBW6gSGQiyLiiJH7nqjy7/3W
 M9ZyhmpkVecwz8NNzYHZ4xJ4+SWSs7e6LLqGFKn+npsq2ugoSKfrhwVL+lYGdOF716p9
 82yx1/iZ9tOOehgXngGea1v94MDLS+PJhMeJkqC8wvmy4jaYpCMf4PlwEkm1hk0zpD00
 kHiA==
X-Gm-Message-State: AOJu0Yzx2hxAluHau2EFwcDnhHlX26UJwFasH8iMb2fBSbTEBwh2h7Pc
 HVKf+5tbfCXiPJUeuJ4U7LTsxqkoUfATnNVwvE5KQxROqor/dHh8TNR7
X-Gm-Gg: AR+sD13JpbRrZK4VDFsS0Z2mC2IHwLhJmGYas3HCQtppW6y2d8lpw3Bisc8ctji+Jh8
 +EmOejaZXQolTfK5w6w5JHSrUN5k/oz3nATZxVGjPoHE8jhlRnwJIqvbPk56xwsErPvsFu4Vkq9
 FyuW2iMYHRu8KG9+ps6I3H0r1yaoaIi7922E72BTcioGc/FOVZ3nCcI/x1z4N6wKrjXeeGL1EXi
 UU1OZX7sLCtI2RuIsrvhLaLjkKtQzMV3TgsJD0z2f872ucmrZkkEmqHOAb14nklOtv1fB2sOe5P
 jPdzoK/NCRNCpN2KhM3VsoJv86eRG0cHgrN6zzC6AWevgu/qn0ltTvaW/OPuPLxAFv1Ly8AiW3H
 MCQHQQXiJG6Da8Zyub/8mc/3GMYQIN9ymaXzIOSVehqCmd4XgNbL8uSGkqKBz5Ll5TIU52ilYO7
 csMfjRuer0us5N/cfYOQ==
X-Received: by 2002:a05:690c:7403:b0:814:584f:eaef with SMTP id
 00721157ae682-81f992aa8edmr1329157b3.67.1785203152627; 
 Mon, 27 Jul 2026 18:45:52 -0700 (PDT)
Received: from [192.168.1.71] ([2600:1702:56e9:4b40:e3a9:78c5:641e:a58c])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81f658d3803sm40523707b3.23.2026.07.27.18.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 18:45:52 -0700 (PDT)
From: Akash Sukhavasi <akash.sukhavasi@gmail.com>
Date: Mon, 27 Jul 2026 20:45:50 -0500
Subject: [PATCH v2] drm/panel: tdo-tl070wsh30: Use mipi_dsi_*_multi() functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-mipi-dsi-tl070wsh30-multi-v2-1-f47b937631d3@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Nyw6CMBBFf4XM2jHTIQXqyv8wLHhUmIQCaRE1h
 H+3krh1eU5yz90gWC82wCXZwNtVgkxjBD4l0PTV2FmUNjIwcUY5MzqZBdsguAyU0zP0KaF7DIs
 gk9FsTKtrxRD3s7d3eR3tWxm5l7BM/n1creprf1X9p7oqVJgZlVFdpKZge+1cJcO5mRyU+75/A
 JGHqL3CAAAA
X-Change-ID: 20260722-mipi-dsi-tl070wsh30-multi-2095299d5b12
To: Doug Anderson <dianders@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Akash Sukhavasi <akash.sukhavasi@gmail.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Tue, 28 Jul 2026 07:21:09 +0000
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

The mipi_dsi_dcs_*() functions used by this driver are deprecated in
favor of their _multi() counterparts, as noted in
Documentation/gpu/todo.rst. The _multi() variants record the first
error in a context structure and skip every later call once an error
is set, so the return value no longer has to be checked after each
command. They also log their own failures, which makes the per-call
dev_err() calls redundant.

Convert prepare() and unprepare(), using mipi_dsi_msleep() and
mipi_dsi_usleep_range() for the delays between DSI commands. The
delays in the GPIO reset sequence stay as plain msleep() and
usleep_range(), since they run before any DSI transaction.

unprepare() now disables the regulator unconditionally and returns 0.
Previously a failure of enter_sleep_mode() returned early, leaving the
regulator enabled. drm_panel_unprepare() skips panel->prepared = false
when the callback returns an error, and drm_panel_prepare() returns
early when prepared is already set, so that path left the panel
powered and unable to be brought back up. Both functions return void,
so the error was never propagated to a caller in any case.

Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>
---
Compile tested only, no hardware available. checkpatch and a W=1 build
are clean.

Changes in v2:
- unprepare() disables the regulator unconditionally and returns 0,
  per Sashiko's review on v1. Returning an error left panel->prepared
  set, so the panel could not be prepared again.
- Link to v1: https://lore.kernel.org/r/20260725-mipi-dsi-tl070wsh30-multi-v1-1-69160b83982e@gmail.com
---
 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c | 40 ++++++++++------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
index 13cfe252a838..cd846e5ab2e7 100644
--- a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
+++ b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
@@ -35,6 +35,7 @@ struct tdo_tl070wsh30_panel *to_tdo_tl070wsh30_panel(struct drm_panel *panel)
 static int tdo_tl070wsh30_panel_prepare(struct drm_panel *panel)
 {
 	struct tdo_tl070wsh30_panel *tdo_tl070wsh30 = to_tdo_tl070wsh30_panel(panel);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = tdo_tl070wsh30->link };
 	int err;
 
 	err = regulator_enable(tdo_tl070wsh30->supply);
@@ -51,45 +52,32 @@ static int tdo_tl070wsh30_panel_prepare(struct drm_panel *panel)
 
 	msleep(200);
 
-	err = mipi_dsi_dcs_exit_sleep_mode(tdo_tl070wsh30->link);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to exit sleep mode: %d\n", err);
-		regulator_disable(tdo_tl070wsh30->supply);
-		return err;
-	}
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
 
-	msleep(200);
+	mipi_dsi_msleep(&dsi_ctx, 200);
 
-	err = mipi_dsi_dcs_set_display_on(tdo_tl070wsh30->link);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to set display on: %d\n", err);
-		regulator_disable(tdo_tl070wsh30->supply);
-		return err;
-	}
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
 
-	msleep(20);
+	mipi_dsi_msleep(&dsi_ctx, 20);
 
-	return 0;
+	if (dsi_ctx.accum_err)
+		regulator_disable(tdo_tl070wsh30->supply);
+
+	return dsi_ctx.accum_err;
 }
 
 static int tdo_tl070wsh30_panel_unprepare(struct drm_panel *panel)
 {
 	struct tdo_tl070wsh30_panel *tdo_tl070wsh30 = to_tdo_tl070wsh30_panel(panel);
-	int err;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = tdo_tl070wsh30->link };
 
-	err = mipi_dsi_dcs_set_display_off(tdo_tl070wsh30->link);
-	if (err < 0)
-		dev_err(panel->dev, "failed to set display off: %d\n", err);
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
 
-	usleep_range(10000, 11000);
+	mipi_dsi_usleep_range(&dsi_ctx, 10000, 11000);
 
-	err = mipi_dsi_dcs_enter_sleep_mode(tdo_tl070wsh30->link);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to enter sleep mode: %d\n", err);
-		return err;
-	}
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
 
-	usleep_range(10000, 11000);
+	mipi_dsi_usleep_range(&dsi_ctx, 10000, 11000);
 
 	regulator_disable(tdo_tl070wsh30->supply);
 

---
base-commit: 62cc90241548d5570ee68e01aaba6506964e9811
change-id: 20260722-mipi-dsi-tl070wsh30-multi-2095299d5b12

Best regards,
-- 
Akash Sukhavasi <akash.sukhavasi@gmail.com>

