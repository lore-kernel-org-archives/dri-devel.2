Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B206D606A33D
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 10:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ijmc7MvS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2250510EF79;
	Tue, 10 Nov 2026 10:22:10 +0000 (UTC)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B4C410E7CD
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 08:26:04 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-1a8cc11ac42so1635642c88.0
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 00:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794299163; x=1794903963; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BZM10ogvmfHypgTMnIoHJQjrw7Lff7Vzjvtt2LSRx4Y=;
 b=ijmc7MvSXrtXMfaqCGHnp1/6SXbW6Gis9rKmXtU6vPluTYuKW4nfW771odvKLRlQ0+
 nfpJPIGl3Uw4HfGK3qOEG28uAq7JNc8jtXkGd1DbrVxjYFziaI9BSPc3wJlehy06Gjp6
 U75zRo83TuhHGbYZO4xLAoSou3MU/7OQ6MXRQrBwk9WRfWKljbrEHV2ESW0ivcFCMLfR
 k4mUyRAMIPexlLiliMCKyjNNhUpZgrWMIhOeXYOAVvdhja0jzTL1VqxWJ9bq3ZXYCJRJ
 UFAeSJkoyk5AaUecwsPYIrlPVAhvmuor68L7EO65AdHrK5DOrjS5JzLfDGy3KNJRNYeD
 I98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794299163; x=1794903963;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BZM10ogvmfHypgTMnIoHJQjrw7Lff7Vzjvtt2LSRx4Y=;
 b=Y5/75lUwWAxXXEHkv+XhYDgNUsJY3+kpo2tX3wk628OGkSoql/NopRO+DP812z4iab
 HG5DIeL/16BhEIXTnwtFuzYXj4Lgou8dT7rPZ4oNir0SLTNXiWL8kLCB87TtT7p2Izpz
 tEAkl6TqAb+jRoVC6oBiqotlclZhTmujMpXn0vHBydORisKRZBvR7nP93CYzaJrjbaHP
 GWB70D8n2j2TWR6Ph5Olob6+XCYp6L+p7x8fsGvzI+mk0ClBLTdJhfIW6vzcqxCZ1Lb9
 sgGLOwPaWQsJ1K2ZUe+yj3WC6KQM12wJuZoqyfTpOOFhdrdIgJeH+f7R0anl1yrDxpC5
 8juw==
X-Forwarded-Encrypted: i=1;
 AL+hErHujRXB5hsqfYu7xkQSk+WhSjmcLHA9wgkRdwOyKizqpYXGevEDPmE8dJBWquGgrWKqCH9ivtLZxYY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+uDUS+joZcvHKA/CvOSMdTVrupMzu1g73b5zgsaWwbYL+JWkIa
 qKaHDPMEjCF/IgyYzJrvNew5jcgDTUs7EiKt5Em1/Waf1EKgYoo5CG4R
X-Gm-Gg: AYBFou3NdioPzQ3ILotFm4bhi7DgtQBTxUPwKvbn5u4x2CcmNXehwulyDd12qNMRTyF
 SvWdbqEJUBSR/slglEM+rd2QoD3RfY4M5hPLl5Ic49FHHYtRSn33NZFilOB1hK8gYBcbRGRwIrb
 dkagsokdKBiDo+CNBZslvx6ilZG0LpzO+vCUPobKNVhuMl+j0i8QDrj5YAnsnFyHxGTqFRX5yUN
 ZU+dyHqfwUxmf3c388w0m8YO15Slz66fMWB9wvPr4+xksDJcOiqm79d/Q3y10kemjeI0lHDCAR/
 h+WM9+MwJU8NenqIeGa5AndQ9wlBkzqx4ACrhUpy/3zsOVE+M5O4AqueqK+uMWyFCjWEOTYrpHw
 zqhPrK5nHS6epul3I7bX8+069h6f2+itZNS6kDMFyy/9OjPzaUBPaJZruGkKL/qBtTYmHK0j+Ll
 AXhknMfA9g1hMb7dUUaYSxNWiquZbFh/8rRP/ullCIpIv9fPQ7A1gXJGQL5J4CJTq5GZfImFRKU
 sA7uvTAGpyuUiBVDHPn/Kn8nUVSKgi9hOjWL5kgGIszm7hINWPDElTsyleXKukUEHphdJ5u6TDt
 ijYMxeY4Ct4eHzXrQcWVhZI/BlpBy6aL03k+1NWxHJeFmFPK40qDaLm+k766E2zvTxU=
X-Received: by 2002:a05:7022:f8c:b0:1b2:42eb:7e11 with SMTP id
 a92af1059eb24-1b3b617291fmr3990564c88.26.1794299162848; 
 Tue, 10 Nov 2026 00:26:02 -0800 (PST)
Received: from evo.www.tendawifi.com ([103.98.7.212])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b3b5ba8426sm4680261c88.23.2026.11.10.00.25.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 00:26:02 -0800 (PST)
From: Archit More <architmore303@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Douglas Anderson <dianders@chromium.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Archit More <architmore303@gmail.com>
Subject: [PATCH] drm/panel: kingdisplay-kd097d04: Use mipi_dsi_*_multi()
 functions
Date: Tue, 10 Nov 2026 13:55:35 +0530
Message-Id: <20261110082535.7998-1-architmore303@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 10:21:36 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

    The mipi_dsi_dcs_*() and mipi_dsi_generic_write() functions used
    by this driver are deprecated in favor of their _multi() counterparts,
    as noted in Documentation/gpu/todo.rst.

    Convert disable(), unprepare(), and prepare() to use the _multi() APIs.

Signed-off-by: Archit More <architmore303@gmail.com>
---
 .../drm/panel/panel-kingdisplay-kd097d04.c    | 54 ++++++-------------
 1 file changed, 17 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c b/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
index 893af9b16756..01f5a96f1cfb 100644
--- a/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
+++ b/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
@@ -180,28 +180,21 @@ struct kingdisplay_panel *to_kingdisplay_panel(struct drm_panel *panel)
 static int kingdisplay_panel_disable(struct drm_panel *panel)
 {
 	struct kingdisplay_panel *kingdisplay = to_kingdisplay_panel(panel);
-	int err;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = kingdisplay->link };
 
-	err = mipi_dsi_dcs_set_display_off(kingdisplay->link);
-	if (err < 0)
-		dev_err(panel->dev, "failed to set display off: %d\n", err);
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
 
-	return 0;
+	return dsi_ctx.accum_err;
 }
 
 static int kingdisplay_panel_unprepare(struct drm_panel *panel)
 {
 	struct kingdisplay_panel *kingdisplay = to_kingdisplay_panel(panel);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = kingdisplay->link };
 	int err;
 
-	err = mipi_dsi_dcs_enter_sleep_mode(kingdisplay->link);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to enter sleep mode: %d\n", err);
-		return err;
-	}
-
-	/* T15: 120ms */
-	msleep(120);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 120);
 
 	gpiod_set_value_cansleep(kingdisplay->enable_gpio, 0);
 
@@ -209,12 +202,13 @@ static int kingdisplay_panel_unprepare(struct drm_panel *panel)
 	if (err < 0)
 		return err;
 
-	return 0;
+	return dsi_ctx.accum_err;
 }
 
 static int kingdisplay_panel_prepare(struct drm_panel *panel)
 {
 	struct kingdisplay_panel *kingdisplay = to_kingdisplay_panel(panel);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = kingdisplay->link };
 	int err, regulator_err;
 	unsigned int i;
 
@@ -232,32 +226,18 @@ static int kingdisplay_panel_prepare(struct drm_panel *panel)
 	/* T4: 15ms */
 	usleep_range(15000, 16000);
 
-	for (i = 0; i < ARRAY_SIZE(init_code); i++) {
-		err = mipi_dsi_generic_write(kingdisplay->link, &init_code[i],
-					sizeof(struct kingdisplay_panel_cmd));
-		if (err < 0) {
-			dev_err(panel->dev, "failed write init cmds: %d\n", err);
-			goto poweroff;
-		}
-	}
+	for (i = 0; i < ARRAY_SIZE(init_code); i++)
+		mipi_dsi_generic_write_multi(&dsi_ctx, &init_code[i],
+					     sizeof(struct kingdisplay_panel_cmd));
 
-	err = mipi_dsi_dcs_exit_sleep_mode(kingdisplay->link);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to exit sleep mode: %d\n", err);
-		goto poweroff;
-	}
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 120);
 
-	/* T6: 120ms */
-	msleep(120);
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	mipi_dsi_usleep_range(&dsi_ctx, 10000, 11000);
 
-	err = mipi_dsi_dcs_set_display_on(kingdisplay->link);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to set display on: %d\n", err);
+	if (dsi_ctx.accum_err)
 		goto poweroff;
-	}
-
-	/* T7: 10ms */
-	usleep_range(10000, 11000);
 
 	return 0;
 
@@ -268,7 +248,7 @@ static int kingdisplay_panel_prepare(struct drm_panel *panel)
 	if (regulator_err)
 		dev_err(panel->dev, "failed to disable regulator: %d\n", regulator_err);
 
-	return err;
+	return dsi_ctx.accum_err;
 }
 
 static const struct drm_display_mode default_mode = {
-- 
2.34.1

