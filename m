Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DAEC624D7
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 21:21:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 329F210F7A5;
	Thu,  3 Sep 2026 21:21:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YiyJRptH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB87C10E53E
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 21:21:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CF9E340890;
 Thu,  3 Sep 2026 21:21:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB5F1F000E9;
 Thu,  3 Sep 2026 21:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788470489;
 bh=UV74f8fQVaemVuXWZeA10D1z6ox5MPCUL7v9atHuKz8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=YiyJRptHPLl+Z9Ai5Y1rhW6EWyC2cOc1mIQEp+5yk4BJNS7knM19KlZd83k1HvQn7
 8bstJyj/n9zeDeOuNtG14+DLhCEHFJ9MhI7/ES3M6z42InKVbD5q4OIgKoap6rO8o3
 zRHFNE+JZYJOkpv5oHXKd8r2ZJH9/yaJY6nRVvBgneETapaD2DEhn2N/dV8i1bkFng
 qW7TARVCovNRwi2WsRljmcra/Cgm0OlJY9hKPPJiT6HCn41+738IA8i8RyhBwJtaXk
 KyFNLTWKzCPuDiP6fi72+NAgTM9c9zBKZH0KsCwKic990nJLJoEwH4xy0+ZSeiZVQa
 CoSbLcfCvQYjA==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 03 Sep 2026 23:21:19 +0200
Subject: [PATCH 1/2] drm/panel: samsung: Add shared test key helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-drm-panels-sofef0-v1-1-9e841645beba@kernel.org>
References: <20260903-drm-panels-sofef0-v1-0-9e841645beba@kernel.org>
In-Reply-To: <20260903-drm-panels-sofef0-v1-0-9e841645beba@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 David Heidelberg <david@ixit.cz>, Dzmitry Sankouski <dsankouski@gmail.com>, 
 Yedaya Katsman <yedaya.ka@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: dri-devel@lists.freedesktop.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
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

Several Samsung display controllers use identical commands to enable
and disable their three levels of test keys. The drivers currently
duplicate these commands in local macros.

Move the commands to typed helpers in a private Samsung DSI header and
use them from the drivers which already identify the commands by their
test key level.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/gpu/drm/panel/panel-samsung-dsi.h          | 38 ++++++++++++
 drivers/gpu/drm/panel/panel-samsung-s6e3fc2x01.c   | 71 +++++++++-------------
 drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c      | 70 +++++++++------------
 .../gpu/drm/panel/panel-samsung-s6e8fc0-m1906f9.c  | 23 +++----
 drivers/gpu/drm/panel/panel-samsung-sofef00.c      | 15 ++---
 5 files changed, 112 insertions(+), 105 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-dsi.h b/drivers/gpu/drm/panel/panel-samsung-dsi.h
new file mode 100644
index 000000000000..65c74dcbb21b
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-samsung-dsi.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _PANEL_SAMSUNG_DSI_H
+#define _PANEL_SAMSUNG_DSI_H
+
+#include <drm/drm_mipi_dsi.h>
+
+static inline void samsung_dsi_test_key_on_lvl1(struct mipi_dsi_multi_context *ctx)
+{
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x9f, 0xa5, 0xa5);
+}
+
+static inline void samsung_dsi_test_key_off_lvl1(struct mipi_dsi_multi_context *ctx)
+{
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x9f, 0x5a, 0x5a);
+}
+
+static inline void samsung_dsi_test_key_on_lvl2(struct mipi_dsi_multi_context *ctx)
+{
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xf0, 0x5a, 0x5a);
+}
+
+static inline void samsung_dsi_test_key_off_lvl2(struct mipi_dsi_multi_context *ctx)
+{
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xf0, 0xa5, 0xa5);
+}
+
+static inline void samsung_dsi_test_key_on_lvl3(struct mipi_dsi_multi_context *ctx)
+{
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xfc, 0x5a, 0x5a);
+}
+
+static inline void samsung_dsi_test_key_off_lvl3(struct mipi_dsi_multi_context *ctx)
+{
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xfc, 0xa5, 0xa5);
+}
+
+#endif /* _PANEL_SAMSUNG_DSI_H */
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e3fc2x01.c b/drivers/gpu/drm/panel/panel-samsung-s6e3fc2x01.c
index e63080204af7..517bb0b83e2b 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e3fc2x01.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e3fc2x01.c
@@ -20,6 +20,8 @@
 #include <drm/drm_panel.h>
 #include <drm/drm_probe_helper.h>
 
+#include "panel-samsung-dsi.h"
+
 #define MCS_ELVSS_ON            0xb1
 
 struct samsung_s6e3fc2x01 {
@@ -41,19 +43,6 @@ struct samsung_s6e3fc2x01 *to_samsung_s6e3fc2x01(struct drm_panel *panel)
 	return container_of(panel, struct samsung_s6e3fc2x01, panel);
 }
 
-#define s6e3fc2x01_test_key_on_lvl1(ctx) \
-	mipi_dsi_dcs_write_seq_multi(ctx, 0x9f, 0xa5, 0xa5)
-#define s6e3fc2x01_test_key_off_lvl1(ctx) \
-	mipi_dsi_dcs_write_seq_multi(ctx, 0x9f, 0x5a, 0x5a)
-#define s6e3fc2x01_test_key_on_lvl2(ctx) \
-	mipi_dsi_dcs_write_seq_multi(ctx, 0xf0, 0x5a, 0x5a)
-#define s6e3fc2x01_test_key_off_lvl2(ctx) \
-	mipi_dsi_dcs_write_seq_multi(ctx, 0xf0, 0xa5, 0xa5)
-#define s6e3fc2x01_test_key_on_lvl3(ctx) \
-	mipi_dsi_dcs_write_seq_multi(ctx, 0xfc, 0x5a, 0x5a)
-#define s6e3fc2x01_test_key_off_lvl3(ctx) \
-	mipi_dsi_dcs_write_seq_multi(ctx, 0xfc, 0xa5, 0xa5)
-
 static void s6e3fc2x01_reset(struct samsung_s6e3fc2x01 *ctx)
 {
 	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
@@ -66,7 +55,7 @@ static int s6e3fc2x01_on(struct samsung_s6e3fc2x01 *ctx)
 {
 	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
 
-	s6e3fc2x01_test_key_on_lvl1(&dsi_ctx);
+	samsung_dsi_test_key_on_lvl1(&dsi_ctx);
 
 	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
 
@@ -75,64 +64,64 @@ static int s6e3fc2x01_on(struct samsung_s6e3fc2x01 *ctx)
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xff, 0x0a);
 	mipi_dsi_usleep_range(&dsi_ctx, 10000, 11000);
 
-	s6e3fc2x01_test_key_off_lvl1(&dsi_ctx);
+	samsung_dsi_test_key_off_lvl1(&dsi_ctx);
 
-	s6e3fc2x01_test_key_on_lvl2(&dsi_ctx);
+	samsung_dsi_test_key_on_lvl2(&dsi_ctx);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb0, 0x01);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xcd, 0x01);
-	s6e3fc2x01_test_key_off_lvl2(&dsi_ctx);
+	samsung_dsi_test_key_off_lvl2(&dsi_ctx);
 
 	mipi_dsi_usleep_range(&dsi_ctx, 15000, 16000);
 
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xff, 0x0f);
 	mipi_dsi_usleep_range(&dsi_ctx, 10000, 11000);
 
-	s6e3fc2x01_test_key_on_lvl1(&dsi_ctx);
+	samsung_dsi_test_key_on_lvl1(&dsi_ctx);
 	mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
-	s6e3fc2x01_test_key_off_lvl1(&dsi_ctx);
+	samsung_dsi_test_key_off_lvl1(&dsi_ctx);
 
-	s6e3fc2x01_test_key_on_lvl2(&dsi_ctx);
+	samsung_dsi_test_key_on_lvl2(&dsi_ctx);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xeb, 0x17,
 					       0x41, 0x92,
 					       0x0e, 0x10,
 					       0x82, 0x5a);
-	s6e3fc2x01_test_key_off_lvl2(&dsi_ctx);
+	samsung_dsi_test_key_off_lvl2(&dsi_ctx);
 
 	/* Column & Page Address Setting */
 	mipi_dsi_dcs_set_column_address_multi(&dsi_ctx, 0x0000, 0x0437);
 	mipi_dsi_dcs_set_page_address_multi(&dsi_ctx, 0x0000, 0x0923);
 
 	/* Horizontal & Vertical sync Setting */
-	s6e3fc2x01_test_key_on_lvl2(&dsi_ctx);
+	samsung_dsi_test_key_on_lvl2(&dsi_ctx);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb0, 0x09);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe8, 0x10, 0x30);
-	s6e3fc2x01_test_key_off_lvl2(&dsi_ctx);
+	samsung_dsi_test_key_off_lvl2(&dsi_ctx);
 
-	s6e3fc2x01_test_key_on_lvl3(&dsi_ctx);
+	samsung_dsi_test_key_on_lvl3(&dsi_ctx);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb0, 0x01);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe3, 0x88);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb0, 0x07);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xed, 0x67);
-	s6e3fc2x01_test_key_off_lvl3(&dsi_ctx);
+	samsung_dsi_test_key_off_lvl3(&dsi_ctx);
 
-	s6e3fc2x01_test_key_on_lvl2(&dsi_ctx);
+	samsung_dsi_test_key_on_lvl2(&dsi_ctx);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb0, 0x07);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb7, 0x01);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb0, 0x08);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb7, 0x12);
-	s6e3fc2x01_test_key_off_lvl2(&dsi_ctx);
+	samsung_dsi_test_key_off_lvl2(&dsi_ctx);
 
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x20);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_POWER_SAVE, 0x00);
 	mipi_dsi_usleep_range(&dsi_ctx, 1000, 2000);
 
-	s6e3fc2x01_test_key_on_lvl2(&dsi_ctx);
+	samsung_dsi_test_key_on_lvl2(&dsi_ctx);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MCS_ELVSS_ON, 0x00, 0x01);
-	s6e3fc2x01_test_key_off_lvl2(&dsi_ctx);
+	samsung_dsi_test_key_off_lvl2(&dsi_ctx);
 
-	s6e3fc2x01_test_key_on_lvl2(&dsi_ctx);
+	samsung_dsi_test_key_on_lvl2(&dsi_ctx);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb3, 0x00, 0xc1);
-	s6e3fc2x01_test_key_off_lvl2(&dsi_ctx);
+	samsung_dsi_test_key_off_lvl2(&dsi_ctx);
 
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xff, 0x78);
 	mipi_dsi_usleep_range(&dsi_ctx, 10000, 11000);
@@ -140,14 +129,14 @@ static int s6e3fc2x01_on(struct samsung_s6e3fc2x01 *ctx)
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x81, 0x90);
 	mipi_dsi_usleep_range(&dsi_ctx, 10000, 11000);
 
-	s6e3fc2x01_test_key_on_lvl2(&dsi_ctx);
+	samsung_dsi_test_key_on_lvl2(&dsi_ctx);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb0, 0x02);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MCS_ELVSS_ON, 0xc6, 0x00, 0x00,
 				     0x21, 0xed, 0x02, 0x08, 0x06, 0xc1, 0x27,
 				     0xfc, 0xdc, 0xe4, 0x00, 0xd9, 0xe6, 0xe7,
 				     0x00, 0xfc, 0xff, 0xea);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MCS_ELVSS_ON, 0x00, 0x00);
-	s6e3fc2x01_test_key_off_lvl2(&dsi_ctx);
+	samsung_dsi_test_key_off_lvl2(&dsi_ctx);
 
 	mipi_dsi_usleep_range(&dsi_ctx, 10000, 11000);
 
@@ -159,9 +148,9 @@ static int s6e3fc2x01_enable(struct drm_panel *panel)
 	struct samsung_s6e3fc2x01 *ctx = to_samsung_s6e3fc2x01(panel);
 	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
 
-	s6e3fc2x01_test_key_on_lvl1(&dsi_ctx);
+	samsung_dsi_test_key_on_lvl1(&dsi_ctx);
 	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
-	s6e3fc2x01_test_key_off_lvl1(&dsi_ctx);
+	samsung_dsi_test_key_off_lvl1(&dsi_ctx);
 
 	return dsi_ctx.accum_err;
 }
@@ -170,27 +159,27 @@ static int s6e3fc2x01_off(struct samsung_s6e3fc2x01 *ctx)
 {
 	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
 
-	s6e3fc2x01_test_key_on_lvl1(&dsi_ctx);
+	samsung_dsi_test_key_on_lvl1(&dsi_ctx);
 
 	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
 
 	mipi_dsi_usleep_range(&dsi_ctx, 10000, 11000);
 
-	s6e3fc2x01_test_key_on_lvl2(&dsi_ctx);
+	samsung_dsi_test_key_on_lvl2(&dsi_ctx);
 	mipi_dsi_usleep_range(&dsi_ctx, 16000, 17000);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb0, 0x50);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb9, 0x82);
-	s6e3fc2x01_test_key_off_lvl2(&dsi_ctx);
+	samsung_dsi_test_key_off_lvl2(&dsi_ctx);
 	mipi_dsi_usleep_range(&dsi_ctx, 16000, 17000);
 
 	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
 
-	s6e3fc2x01_test_key_off_lvl1(&dsi_ctx);
+	samsung_dsi_test_key_off_lvl1(&dsi_ctx);
 
-	s6e3fc2x01_test_key_on_lvl2(&dsi_ctx);
+	samsung_dsi_test_key_on_lvl2(&dsi_ctx);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb0, 0x05);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf4, 0x01);
-	s6e3fc2x01_test_key_off_lvl2(&dsi_ctx);
+	samsung_dsi_test_key_off_lvl2(&dsi_ctx);
 	mipi_dsi_msleep(&dsi_ctx, 160);
 
 	return dsi_ctx.accum_err;
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
index 550e9ef9bb71..f3063fdafd99 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e3ha8.c
@@ -16,6 +16,8 @@
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_panel.h>
 
+#include "panel-samsung-dsi.h"
+
 struct s6e3ha8 {
 	struct drm_panel panel;
 	struct mipi_dsi_device *dsi;
@@ -36,18 +38,6 @@ struct s6e3ha8 *to_s6e3ha8_amb577px01_wqhd(struct drm_panel *panel)
 	return container_of(panel, struct s6e3ha8, panel);
 }
 
-#define s6e3ha8_test_key_on_lvl2(ctx) \
-	mipi_dsi_dcs_write_seq_multi(ctx, 0xf0, 0x5a, 0x5a)
-#define s6e3ha8_test_key_off_lvl2(ctx) \
-	mipi_dsi_dcs_write_seq_multi(ctx, 0xf0, 0xa5, 0xa5)
-#define s6e3ha8_test_key_on_lvl3(ctx) \
-	mipi_dsi_dcs_write_seq_multi(ctx, 0xfc, 0x5a, 0x5a)
-#define s6e3ha8_test_key_off_lvl3(ctx) \
-	mipi_dsi_dcs_write_seq_multi(ctx, 0xfc, 0xa5, 0xa5)
-#define s6e3ha8_test_key_on_lvl1(ctx) \
-	mipi_dsi_dcs_write_seq_multi(ctx, 0x9f, 0xa5, 0xa5)
-#define s6e3ha8_test_key_off_lvl1(ctx) \
-	mipi_dsi_dcs_write_seq_multi(ctx, 0x9f, 0x5a, 0x5a)
 #define s6e3ha8_afc_off(ctx) \
 	mipi_dsi_dcs_write_seq_multi(ctx, 0xe2, 0x00, 0x00)
 
@@ -68,26 +58,26 @@ static int s6e3ha8_amb577px01_wqhd_on(struct s6e3ha8 *priv)
 
 	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
 
-	s6e3ha8_test_key_on_lvl1(&ctx);
+	samsung_dsi_test_key_on_lvl1(&ctx);
 
-	s6e3ha8_test_key_on_lvl2(&ctx);
+	samsung_dsi_test_key_on_lvl2(&ctx);
 	mipi_dsi_compression_mode_multi(&ctx, true);
-	s6e3ha8_test_key_off_lvl2(&ctx);
+	samsung_dsi_test_key_off_lvl2(&ctx);
 
 	mipi_dsi_dcs_exit_sleep_mode_multi(&ctx);
 	usleep_range(5000, 6000);
 
-	s6e3ha8_test_key_on_lvl2(&ctx);
+	samsung_dsi_test_key_on_lvl2(&ctx);
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0xf2, 0x13);
-	s6e3ha8_test_key_off_lvl2(&ctx);
+	samsung_dsi_test_key_off_lvl2(&ctx);
 	usleep_range(10000, 11000);
 
-	s6e3ha8_test_key_on_lvl2(&ctx);
+	samsung_dsi_test_key_on_lvl2(&ctx);
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0xf2, 0x13);
-	s6e3ha8_test_key_off_lvl2(&ctx);
+	samsung_dsi_test_key_off_lvl2(&ctx);
 
 	/* OMOK setting 1 (Initial setting) - Scaler Latch Setting Guide */
-	s6e3ha8_test_key_on_lvl2(&ctx);
+	samsung_dsi_test_key_on_lvl2(&ctx);
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb0, 0x07);
 	/* latch setting 1 : Scaler on/off & address setting & PPS setting -> Image update latch */
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0xf2, 0x3c, 0x10);
@@ -98,31 +88,31 @@ static int s6e3ha8_amb577px01_wqhd_on(struct s6e3ha8 *priv)
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0x2a, 0x00, 0x00, 0x05, 0x9f); /* CASET */
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0x2b, 0x00, 0x00, 0x0b, 0x8f); /* PASET */
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0xba, 0x01); /* scaler setup : scaler off */
-	s6e3ha8_test_key_off_lvl2(&ctx);
+	samsung_dsi_test_key_off_lvl2(&ctx);
 
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0x35, 0x00); /* TE Vsync ON */
 
-	s6e3ha8_test_key_on_lvl2(&ctx);
+	samsung_dsi_test_key_on_lvl2(&ctx);
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0xed, 0x4c); /* ERR_FG */
-	s6e3ha8_test_key_off_lvl2(&ctx);
+	samsung_dsi_test_key_off_lvl2(&ctx);
 
-	s6e3ha8_test_key_on_lvl3(&ctx);
+	samsung_dsi_test_key_on_lvl3(&ctx);
 	/* FFC Setting 897.6Mbps */
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0xc5, 0x0d, 0x10, 0xb4, 0x3e, 0x01);
-	s6e3ha8_test_key_off_lvl3(&ctx);
+	samsung_dsi_test_key_off_lvl3(&ctx);
 
-	s6e3ha8_test_key_on_lvl2(&ctx);
+	samsung_dsi_test_key_on_lvl2(&ctx);
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb9,
 				   0x00, 0xb0, 0x81, 0x09, 0x00, 0x00, 0x00,
 				   0x11, 0x03); /* TSP HSYNC Setting */
-	s6e3ha8_test_key_off_lvl2(&ctx);
+	samsung_dsi_test_key_off_lvl2(&ctx);
 
-	s6e3ha8_test_key_on_lvl2(&ctx);
+	samsung_dsi_test_key_on_lvl2(&ctx);
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb0, 0x03);
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0xf6, 0x43);
-	s6e3ha8_test_key_off_lvl2(&ctx);
+	samsung_dsi_test_key_off_lvl2(&ctx);
 
-	s6e3ha8_test_key_on_lvl2(&ctx);
+	samsung_dsi_test_key_on_lvl2(&ctx);
 	/* Brightness condition set */
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0xca,
 				   0x07, 0x00, 0x00, 0x00, 0x80, 0x80, 0x80,
@@ -138,9 +128,9 @@ static int s6e3ha8_amb577px01_wqhd_on(struct s6e3ha8 *priv)
 				   0x10); /* MPS/ELVSS Setting */
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0xf4, 0xeb, 0x28); /* VINT */
 	mipi_dsi_dcs_write_seq_multi(&ctx, 0xf7, 0x03); /* Gamma, LTPS(AID) update */
-	s6e3ha8_test_key_off_lvl2(&ctx);
+	samsung_dsi_test_key_off_lvl2(&ctx);
 
-	s6e3ha8_test_key_off_lvl1(&ctx);
+	samsung_dsi_test_key_off_lvl1(&ctx);
 
 	return ctx.accum_err;
 }
@@ -151,9 +141,9 @@ static int s6e3ha8_enable(struct drm_panel *panel)
 	struct mipi_dsi_device *dsi = priv->dsi;
 	struct mipi_dsi_multi_context ctx = { .dsi = dsi };
 
-	s6e3ha8_test_key_on_lvl1(&ctx);
+	samsung_dsi_test_key_on_lvl1(&ctx);
 	mipi_dsi_dcs_set_display_on_multi(&ctx);
-	s6e3ha8_test_key_off_lvl1(&ctx);
+	samsung_dsi_test_key_off_lvl1(&ctx);
 
 	return ctx.accum_err;
 }
@@ -164,14 +154,14 @@ static int s6e3ha8_disable(struct drm_panel *panel)
 	struct mipi_dsi_device *dsi = priv->dsi;
 	struct mipi_dsi_multi_context ctx = { .dsi = dsi };
 
-	s6e3ha8_test_key_on_lvl1(&ctx);
+	samsung_dsi_test_key_on_lvl1(&ctx);
 	mipi_dsi_dcs_set_display_off_multi(&ctx);
-	s6e3ha8_test_key_off_lvl1(&ctx);
+	samsung_dsi_test_key_off_lvl1(&ctx);
 	mipi_dsi_msleep(&ctx, 20);
 
-	s6e3ha8_test_key_on_lvl2(&ctx);
+	samsung_dsi_test_key_on_lvl2(&ctx);
 	s6e3ha8_afc_off(&ctx);
-	s6e3ha8_test_key_off_lvl2(&ctx);
+	samsung_dsi_test_key_off_lvl2(&ctx);
 
 	mipi_dsi_msleep(&ctx, 160);
 
@@ -200,9 +190,9 @@ static int s6e3ha8_amb577px01_wqhd_prepare(struct drm_panel *panel)
 
 	drm_dsc_pps_payload_pack(&pps, &priv->dsc);
 
-	s6e3ha8_test_key_on_lvl1(&ctx);
+	samsung_dsi_test_key_on_lvl1(&ctx);
 	mipi_dsi_picture_parameter_set_multi(&ctx, &pps);
-	s6e3ha8_test_key_off_lvl1(&ctx);
+	samsung_dsi_test_key_off_lvl1(&ctx);
 
 	mipi_dsi_msleep(&ctx, 28);
 
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e8fc0-m1906f9.c b/drivers/gpu/drm/panel/panel-samsung-s6e8fc0-m1906f9.c
index 2fae0dc6c424..acaff29d0470 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e8fc0-m1906f9.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e8fc0-m1906f9.c
@@ -17,6 +17,8 @@
 #include <drm/drm_panel.h>
 #include <drm/drm_probe_helper.h>
 
+#include "panel-samsung-dsi.h"
+
 struct s6e8fc0_ctx {
 	struct drm_panel panel;
 	struct mipi_dsi_device *dsi;
@@ -45,20 +47,11 @@ static void s6e8fc0_m1906f9_reset(struct s6e8fc0_ctx *ctx)
 	usleep_range(10000, 11000);
 }
 
-#define s6e8fc0_test_key_on_lvl2(ctx) \
-	mipi_dsi_dcs_write_seq_multi(ctx, 0xf0, 0x5a, 0x5a)
-#define s6e8fc0_test_key_off_lvl2(ctx) \
-	mipi_dsi_dcs_write_seq_multi(ctx, 0xf0, 0xa5, 0xa5)
-#define s6e8fc0_test_key_on_lvl3(ctx) \
-	mipi_dsi_dcs_write_seq_multi(ctx, 0xfc, 0x5a, 0x5a)
-#define s6e8fc0_test_key_off_lvl3(ctx) \
-	mipi_dsi_dcs_write_seq_multi(ctx, 0xfc, 0xa5, 0xa5)
-
 static int s6e8fc0_m1906f9_on(struct s6e8fc0_ctx *ctx)
 {
 	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
 
-	s6e8fc0_test_key_on_lvl3(&dsi_ctx);
+	samsung_dsi_test_key_on_lvl3(&dsi_ctx);
 
 	mipi_dsi_dcs_set_display_brightness_multi(&dsi_ctx, 0x0000);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_CONTROL_DISPLAY,
@@ -71,15 +64,15 @@ static int s6e8fc0_m1906f9_on(struct s6e8fc0_ctx *ctx)
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xed,
 				     0xe4, 0x08, 0x96, 0xa4, 0x2a, 0x72, 0xe2,
 				     0xca, 0x00);
-	s6e8fc0_test_key_off_lvl3(&dsi_ctx);
-	s6e8fc0_test_key_on_lvl2(&dsi_ctx);
-	s6e8fc0_test_key_on_lvl3(&dsi_ctx);
+	samsung_dsi_test_key_off_lvl3(&dsi_ctx);
+	samsung_dsi_test_key_on_lvl2(&dsi_ctx);
+	samsung_dsi_test_key_on_lvl3(&dsi_ctx);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe1, 0x93);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb0, 0x05, 0xf4);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf4, 0x03);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xed, 0x01, 0x81, 0x04);
-	s6e8fc0_test_key_off_lvl2(&dsi_ctx);
-	s6e8fc0_test_key_off_lvl3(&dsi_ctx);
+	samsung_dsi_test_key_off_lvl2(&dsi_ctx);
+	samsung_dsi_test_key_off_lvl3(&dsi_ctx);
 
 	return dsi_ctx.accum_err;
 }
diff --git a/drivers/gpu/drm/panel/panel-samsung-sofef00.c b/drivers/gpu/drm/panel/panel-samsung-sofef00.c
index f07d6533ed69..7c3bb65022a0 100644
--- a/drivers/gpu/drm/panel/panel-samsung-sofef00.c
+++ b/drivers/gpu/drm/panel/panel-samsung-sofef00.c
@@ -18,6 +18,8 @@
 #include <drm/drm_panel.h>
 #include <drm/drm_probe_helper.h>
 
+#include "panel-samsung-dsi.h"
+
 struct sofef00_panel {
 	struct drm_panel panel;
 	struct mipi_dsi_device *dsi;
@@ -37,11 +39,6 @@ struct sofef00_panel *to_sofef00_panel(struct drm_panel *panel)
 	return container_of(panel, struct sofef00_panel, panel);
 }
 
-#define sofef00_test_key_on_lvl2(ctx) \
-	mipi_dsi_dcs_write_seq_multi(ctx, 0xf0, 0x5a, 0x5a)
-#define sofef00_test_key_off_lvl2(ctx) \
-	mipi_dsi_dcs_write_seq_multi(ctx, 0xf0, 0xa5, 0xa5)
-
 static void sofef00_panel_reset(struct sofef00_panel *ctx)
 {
 	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
@@ -62,14 +59,14 @@ static int sofef00_panel_on(struct sofef00_panel *ctx)
 	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
 	mipi_dsi_usleep_range(&dsi_ctx, 10000, 11000);
 
-	sofef00_test_key_on_lvl2(&dsi_ctx);
+	samsung_dsi_test_key_on_lvl2(&dsi_ctx);
 	mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
-	sofef00_test_key_off_lvl2(&dsi_ctx);
+	samsung_dsi_test_key_off_lvl2(&dsi_ctx);
 
-	sofef00_test_key_on_lvl2(&dsi_ctx);
+	samsung_dsi_test_key_on_lvl2(&dsi_ctx);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb0, 0x07);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb6, 0x12);
-	sofef00_test_key_off_lvl2(&dsi_ctx);
+	samsung_dsi_test_key_off_lvl2(&dsi_ctx);
 
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x20);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_POWER_SAVE, 0x00);

-- 
2.55.0

