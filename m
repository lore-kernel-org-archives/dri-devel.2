Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFE1CCFA13
	for <dri-devel@archiver.kernel.org>; Sat,  2 May 2026 03:10:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13A8210F66E;
	Sat,  2 May 2026 03:10:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BvTNY37H";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA9CF10F66E
 for <dri-devel@lists.freedesktop.org>; Sat,  2 May 2026 03:10:55 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-44c4cc7c1cfso19771f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 01 May 2026 20:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777691454; x=1778296254; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x14cL5TrSHKQAUyN3i9iLjKrG5uGps374ukvFEBMnzY=;
 b=BvTNY37H/INQC44H8AOh6KYIpNwGOiZxPYJSAASixOY7FRdHqGVBA+lETH7FZlWuyS
 cIZxqJ1UtfhPPddC6W+QEHqKTiEvlP93FAADfdD3Aexk2Cc2UH2MSzj3vHdXn/3odka7
 Y9/grpqWNImNixTVvDakg1NZWXUGeLWNLl642br5STEFk+6AIFa02Hm9t0cQ7YzG8i26
 ZsMZzfv7Jxsvqm1ly+qY7VDOQ3uM15Dzy5oKU3RhSYhBCsxgmMm+CeUvDozYhSf/iM9g
 jKrxjHEfoi5KuDdeWZBPZSdnizh1uJwS0m4yP/MCgAXE2onw/3p2Foyda3AsoKHPiB1f
 IQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777691454; x=1778296254;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x14cL5TrSHKQAUyN3i9iLjKrG5uGps374ukvFEBMnzY=;
 b=ZArLSRecfzihY5fbp5VcrJyW7SCM9/jnzhefwd6LG2eL4OVD/l5VLEt1Zvx9cX4j5B
 LAmtTmsWcvpL2jB6V5f5AqPYE9OHRDeHQpm5DgDbwN6qj/0OMyspq+UvMmuAUCbL5mxn
 i/ZHboZsS9AFDc5tY4SKbgciuv4RjRHIMKDBol6aaK5CccNvAoToL2BkRkxWpomupgXo
 yCdKCSrkHvchKVA57z6K3DSaUeoReuKGnWJasGW0cQzOPTjunSV4zLOTCrXXlcpeWa9W
 CzaKDmT/UJj3p3wf7vR9zHOY8jOLEw+LozFPg7T8GSTgn6tHlNiuuRUQcHELMw0v93QM
 QJ7Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8XiHPZgvc/asU1SAWCDx3ayroazvNjIBwz8MR8T1aed8PlGNiSt/74aysPlB1pqgtC+CdJjAMs5C0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzA9jXBwa2L530qy7FeQfeRD/Slu8SjOLYRPzy70bqusTPbC0tS
 Z7QG5u3FIoozaFHIveO2XuyUuWrnH1MMosHf1hS7lkcLYvmC+M2DTgrz
X-Gm-Gg: AeBDieucvF3WqyvrKq+rGcy35YKnAARS5+vjo+bR4XtHt7cNzhTukEoknV8RfzMpEfj
 IQpNYtrAqBzQsX56wIxVMraaqf6d6ssaJvH+YZeVAjifNDnqeN1pZbWL4MkIc2LzzXbQFWzMLY7
 YfvvU8m9+ubTbc7Aqo+glUOiveWpEp26/moJCAFjtOidpH3CW5c3K+G4G7nOSpj/3Xc56+3K/MF
 iH7e+JKlnz/bIdwY8mRtZoUXvWFeQwXQeUSDTc9oFtp8RyN51w/UtVfBZvQ5IKvfaAdmzUyK7re
 3lUcOEv3VnRVxaqihQfhfBSPbuNUh0782+upTF+s21vIyuc5/1LcSforKB3ttnyERxvh3yaRbhD
 GId8Fv+GOMWwr3zKTUHCe5XopSxjmhL8JpuSXFUy0d/doS6n7gO0jAipMw48UZ880mH7i8n2ubB
 oIU9J0fCJxDU+Z0x9M7U2BCjZyWB6ZVouyQOXK12K/Q7i7eMB5oUph
X-Received: by 2002:a05:6000:1acb:b0:43d:71f4:7ed4 with SMTP id
 ffacd0b85a97d-44bb3d8a1ecmr2721223f8f.15.1777691454258; 
 Fri, 01 May 2026 20:10:54 -0700 (PDT)
Received: from archlinux ([2a02:6b60:60:a500::100f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44acad8f974sm7111137f8f.23.2026.05.01.20.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 20:10:53 -0700 (PDT)
From: Hussain Qadri <hussain.bqadri@gmail.com>
To: andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Hussain Qadri <hussain.bqadri@gmail.com>
Subject: [PATCH v2] drm/bridge: tc358762: Use mipi_dsi_generic_write_multi()
Date: Sat,  2 May 2026 04:10:08 +0100
Message-ID: <20260502031008.45873-1-hussain.bqadri@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Replace the driver-local error accumulation around
mipi_dsi_generic_write() with mipi_dsi_generic_write_multi()
and struct mipi_dsi_multi_context.

Signed-off-by: Hussain Qadri <hussain.bqadri@gmail.com>
---

Changes in v2:
- Remove extra blank line in tc358762_write().
- Rebase onto current master.

 drivers/gpu/drm/bridge/tc358762.c | 47 +++++++++++--------------------
 1 file changed, 16 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index 98df3e667d4a..739283fc51db 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -76,26 +76,12 @@ struct tc358762 {
 	struct gpio_desc *reset_gpio;
 	struct drm_display_mode mode;
 	bool pre_enabled;
-	int error;
 };
 
-static int tc358762_clear_error(struct tc358762 *ctx)
+static void tc358762_write(struct mipi_dsi_multi_context *dsi_ctx, u16 addr, u32 val)
 {
-	int ret = ctx->error;
-
-	ctx->error = 0;
-	return ret;
-}
-
-static void tc358762_write(struct tc358762 *ctx, u16 addr, u32 val)
-{
-	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
-	ssize_t ret;
 	u8 data[6];
 
-	if (ctx->error)
-		return;
-
 	data[0] = addr;
 	data[1] = addr >> 8;
 	data[2] = val;
@@ -103,9 +89,7 @@ static void tc358762_write(struct tc358762 *ctx, u16 addr, u32 val)
 	data[4] = val >> 16;
 	data[5] = val >> 24;
 
-	ret = mipi_dsi_generic_write(dsi, data, sizeof(data));
-	if (ret < 0)
-		ctx->error = ret;
+	mipi_dsi_generic_write_multi(dsi_ctx, data, sizeof(data));
 }
 
 static inline struct tc358762 *bridge_to_tc358762(struct drm_bridge *bridge)
@@ -115,17 +99,19 @@ static inline struct tc358762 *bridge_to_tc358762(struct drm_bridge *bridge)
 
 static int tc358762_init(struct tc358762 *ctx)
 {
+	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 	u32 lcdctrl;
 
-	tc358762_write(ctx, DSI_LANEENABLE,
+	tc358762_write(&dsi_ctx, DSI_LANEENABLE,
 		       LANEENABLE_L0EN | LANEENABLE_CLEN);
-	tc358762_write(ctx, PPI_D0S_CLRSIPOCOUNT, 5);
-	tc358762_write(ctx, PPI_D1S_CLRSIPOCOUNT, 5);
-	tc358762_write(ctx, PPI_D0S_ATMR, 0);
-	tc358762_write(ctx, PPI_D1S_ATMR, 0);
-	tc358762_write(ctx, PPI_LPTXTIMECNT, LPX_PERIOD);
+	tc358762_write(&dsi_ctx, PPI_D0S_CLRSIPOCOUNT, 5);
+	tc358762_write(&dsi_ctx, PPI_D1S_CLRSIPOCOUNT, 5);
+	tc358762_write(&dsi_ctx, PPI_D0S_ATMR, 0);
+	tc358762_write(&dsi_ctx, PPI_D1S_ATMR, 0);
+	tc358762_write(&dsi_ctx, PPI_LPTXTIMECNT, LPX_PERIOD);
 
-	tc358762_write(ctx, SPICMR, 0x00);
+	tc358762_write(&dsi_ctx, SPICMR, 0x00);
 
 	lcdctrl = LCDCTRL_VSDELAY(1) | LCDCTRL_RGB888 |
 		  LCDCTRL_UNK6 | LCDCTRL_VTGEN;
@@ -136,17 +122,16 @@ static int tc358762_init(struct tc358762 *ctx)
 	if (ctx->mode.flags & DRM_MODE_FLAG_NVSYNC)
 		lcdctrl |= LCDCTRL_VSPOL;
 
-	tc358762_write(ctx, LCDCTRL, lcdctrl);
+	tc358762_write(&dsi_ctx, LCDCTRL, lcdctrl);
 
-	tc358762_write(ctx, SYSCTRL, 0x040f);
+	tc358762_write(&dsi_ctx, SYSCTRL, 0x040f);
 	msleep(100);
 
-	tc358762_write(ctx, PPI_STARTPPI, PPI_START_FUNCTION);
-	tc358762_write(ctx, DSI_STARTDSI, DSI_RX_START);
+	tc358762_write(&dsi_ctx, PPI_STARTPPI, PPI_START_FUNCTION);
+	tc358762_write(&dsi_ctx, DSI_STARTDSI, DSI_RX_START);
 
 	msleep(100);
-
-	return tc358762_clear_error(ctx);
+	return dsi_ctx.accum_err;
 }
 
 static void tc358762_post_disable(struct drm_bridge *bridge,
-- 
2.54.0

