Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476A7606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 09:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OC6ImU3g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB27810F78F;
	Wed, 18 Nov 2026 09:48:15 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 059AE10F77B
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 09:48:09 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4bb6ba3b244so7770045e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 01:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794995287; x=1795600087; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y/FxbstXMfwl0k3KeZBg3l+qLQNGUZ6Y/zs9J8m1BZM=;
 b=OC6ImU3gPdowyYMC+CrHKvbWUYJz5gjUq5pU4eFH0Q9oVf/o74F4gYifEtmmRH1eRm
 +1afMYijCRpxRO7+8i1514yhAQOT82Gzic8xgSgPD9qlR+xdvmQcAjUNVMLFdrFvgF1p
 BNa1dBx74YWIht+6+ZPBMLRpH+SOBOpIYkOUq94evtPaxRGoQCL2fw0+dhCBaj6eHn52
 DaJHlcIcGkWW8XqyWgh/p4yLqXvip7IO5IqXExBIt3rrs+9iMg9ZM0jHSeGDyjtulBa7
 zt6tYcTVK1s+9UP5+KdSjNX7yo1w/4qsNFHxjJzX5zGt85lAHFI6qGkKoHgWsn3ZIy3v
 seHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794995287; x=1795600087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=y/FxbstXMfwl0k3KeZBg3l+qLQNGUZ6Y/zs9J8m1BZM=;
 b=MKpoNEBemuy51XigcXdGuEWTgJiiL+aRLHBqV1zbazFS1DSJjfiKNTKgjDegEnokcY
 390LltSfLqdjmZdcow6qTAwkk8MMHjZDnPqH2jzS7VGy9keioxlr0KJFnTqZw0z64fwv
 QdCHxHRnKHKWmGHMtTGNWo9EISbRF6LmHZCZXuIFTGFwPLVZVczpPAcct7ZEXyF8Ebx0
 0Vl+2tnEklvlA0O34695SFz5SGBRXfSe/Ax+p4NcaLiOCylfFbbuAjhBm7z1J7brxS8X
 KvfisOVQgBoMPSJPNXe3qFKYDQog4ywiqwunCOGmfgkk/kL7zWEYNMZZHisqf19qrtWS
 Kpug==
X-Forwarded-Encrypted: i=1;
 AL+hErHhoiFkP/MjLOP/2xGNCbih2JU/kgsFXhhv3ILA9xToD58IejnHQSPFBKpEahWUWZPbDHL25LzSGOY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/APQVKV4edsjN0OIlHZivSOfHL7WtsZb4h4louFmwURpQQHTjc
 iTLfywy3JJRbsF+8+1HV6+WGJpfIfJ6hFq8Mwro+9/KnRrRaL+YgU8M=
X-Gm-Gg: AYBFou1afWIdvCQObk5oWrZPKZrL3Gnf4AeKR+uGAF1e+qisPUnu0vLPFFvBGW5yNbK
 WDLIMaPRxnWwf1fkufItGBIJ7OMkOes7d6eI+zyE2VhxcUh/12QZTD8FpcHbRvsnohZfpqO03Pv
 99NmWAqSxvFyd/xx7Lzbg6pKQ3rui6KPI1XCL1yIvdofejelxeF1uGKnFSnANwPS3Hj4aiJcQQV
 ninEBzBEC1zxRW326TbS2bcKoXW6m6LNoar/LnEEGG5HsCmwcfq0Ga3Ray8I0JrIPThmKEqU1pE
 o+upXQVfCJchkVXOgcfQn5Q84NywZsFXaZfOUAGjLlFZ7cqV+SJvOUx/k44LwAtQw4dV7b13kVs
 Z9U5hJqGWcgcQJNNVfZyD84CJKuRLOKeLRIEdjqlukVCHNuUlJ5aKU90iikt+5crxbOT87bL7Sl
 GJRX0gJJgpk2/8q3vqs3riSUlSu83VME5TYy4HA1IYO1BhgGTVfhyEu5hGNwGdzpC/cThF0e70e
 rYS0vbtTg2P1+8pkvW+zExERwn6mxZ4Qrx9ImyOwfBLqurkgIoxblnQEpKj9/4kYuuSulHO9FUD
 s41p386Qo9gGnTyzOPHVsF/vYyZxK63AysSMN9dBoYRjzW7q3L67VWAd3SDxU3bVQCPnc/xxFFe
 zj2MqN+wjGLUi8PBC+xT0GvTq2djitDMH3W6z/yzbgjvB0g==
X-Received: by 2002:a05:600c:19d2:b0:4bb:647d:dabe with SMTP id
 5b1f17b1804b1-4bb7d5d65ffmr41495665e9.3.1794995287100; 
 Wed, 18 Nov 2026 01:48:07 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:6680:243e:8149:bd5e:fad5:e552:e82e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7ddd4614sm42027355e9.6.2026.11.18.01.48.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Nov 2026 01:48:06 -0800 (PST)
From: amit <amittibi123@gmail.com>
To: neil.armstrong@linaro.org
Cc: jesszhan0024@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, amit <amittibi123@gmail.com>
Subject: [PATCH v2] drm/panel: Replace deprecated DCS display-on calls
Date: Wed, 18 Nov 2026 11:48:00 +0200
Message-ID: <20261118094800.54292-1-amittibi123@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <1794145178-999776-mlmmj-06e01102@vger.kernel.org>
References: <1794145178-999776-mlmmj-06e01102@vger.kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace deprecated mipi_dsi_dcs_set_display_on() calls with their multi-context equivalents across DRM panel drivers.

Use the MIPI DSI multi-context API to handle errors returned by the new helpers.
---
 drivers/gpu/drm/panel/panel-boe-himax8279d.c  | 58 +++++++++++------
 drivers/gpu/drm/panel/panel-dsi-cm.c          | 64 +++++++++++--------
 .../gpu/drm/panel/panel-feixin-k101-im2ba02.c | 18 ++++--
 .../drm/panel/panel-feiyang-fy07024di26a30d.c |  6 +-
 drivers/gpu/drm/panel/panel-innolux-p079zca.c |  7 +-
 drivers/gpu/drm/panel/panel-khadas-ts050.c    |  7 +-
 .../drm/panel/panel-kingdisplay-kd097d04.c    |  7 +-
 .../drm/panel/panel-leadtek-ltk500hd1829.c    |  7 +-
 .../gpu/drm/panel/panel-newvision-nv3051d.c   |  7 +-
 drivers/gpu/drm/panel/panel-novatek-nt35510.c |  7 +-
 drivers/gpu/drm/panel/panel-raydium-rm67191.c |  7 +-
 drivers/gpu/drm/panel/panel-raydium-rm68200.c |  7 +-
 .../gpu/drm/panel/panel-samsung-s6e63j0x03.c  |  7 +-
 .../gpu/drm/panel/panel-sharp-lq101r1sx01.c   |  7 +-
 14 files changed, 152 insertions(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-himax8279d.c b/drivers/gpu/drm/panel/panel-boe-himax8279d.c
index 4a8560b4b..322f6801e 100644
--- a/drivers/gpu/drm/panel/panel-boe-himax8279d.c
+++ b/drivers/gpu/drm/panel/panel-boe-himax8279d.c
@@ -65,14 +65,16 @@ static int send_mipi_cmds(struct drm_panel *panel, const struct panel_cmd *cmds)
 {
 	struct panel_info *pinfo = to_panel_info(panel);
 	unsigned int i = 0;
-	int err;
+	struct mipi_dsi_multi_context dsi_ctx = {
+		.dsi = pinfo->link,
+	};
 
 	for (i = 0; i < pinfo->desc->on_cmds_num; i++) {
-		err = mipi_dsi_dcs_write_buffer(pinfo->link, &cmds[i],
+		mipi_dsi_dcs_write_buffer_multi(&dsi_ctx, &cmds[i],
 						sizeof(struct panel_cmd));
 
-		if (err < 0)
-			return err;
+		if (dsi_ctx.accum_err < 0)
+			return dsi_ctx.accum_err;
 	}
 
 	return 0;
@@ -81,12 +83,14 @@ static int send_mipi_cmds(struct drm_panel *panel, const struct panel_cmd *cmds)
 static int boe_panel_disable(struct drm_panel *panel)
 {
 	struct panel_info *pinfo = to_panel_info(panel);
-	int err;
-
-	err = mipi_dsi_dcs_set_display_off(pinfo->link);
-	if (err < 0) {
-		dev_err(panel->dev, "failed to set display off: %d\n", err);
-		return err;
+	struct mipi_dsi_multi_context dsi_ctx = {
+		.dsi = pinfo->link,
+	};
+
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	if (dsi_ctx.accum_err < 0) {
+		dev_err(panel->dev, "failed to set display off: %d\n", dsi_ctx.accum_err);
+		return dsi_ctx.accum_err;
 	}
 
 	return 0;
@@ -95,15 +99,17 @@ static int boe_panel_disable(struct drm_panel *panel)
 static int boe_panel_unprepare(struct drm_panel *panel)
 {
 	struct panel_info *pinfo = to_panel_info(panel);
-	int err;
+	struct mipi_dsi_multi_context dsi_ctx = {
+		.dsi = pinfo->link,
+	};
 
-	err = mipi_dsi_dcs_set_display_off(pinfo->link);
-	if (err < 0)
-		dev_err(panel->dev, "failed to set display off: %d\n", err);
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	if (dsi_ctx.accum_err < 0)
+		dev_err(panel->dev, "failed to set display off: %d\n", dsi_ctx.accum_err);
 
-	err = mipi_dsi_dcs_enter_sleep_mode(pinfo->link);
-	if (err < 0)
-		dev_err(panel->dev, "failed to enter sleep mode: %d\n", err);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
+	if (dsi_ctx.accum_err < 0)
+		dev_err(panel->dev, "failed to enter sleep mode: %d\n", dsi_ctx.accum_err);
 
 	/* sleep_mode_delay: 1ms - 2ms */
 	usleep_range(1000, 2000);
@@ -118,6 +124,10 @@ static int boe_panel_prepare(struct drm_panel *panel)
 	struct panel_info *pinfo = to_panel_info(panel);
 	int err;
 
+	struct mipi_dsi_multi_context dsi_ctx = {
+		.dsi = pinfo->link,
+	};
+
 	gpiod_set_value(pinfo->pp18_gpio, 1);
 	/* T1: 5ms - 6ms */
 	usleep_range(5000, 6000);
@@ -146,7 +156,8 @@ static int boe_panel_prepare(struct drm_panel *panel)
 		goto poweroff;
 	}
 
-	err = mipi_dsi_dcs_exit_sleep_mode(pinfo->link);
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	err = dsi_ctx.accum_err;
 	if (err < 0) {
 		dev_err(panel->dev, "failed to exit sleep mode: %d\n", err);
 		goto poweroff;
@@ -155,7 +166,9 @@ static int boe_panel_prepare(struct drm_panel *panel)
 	/* T6: 120ms - 121ms */
 	usleep_range(120000, 121000);
 
-	err = mipi_dsi_dcs_set_display_on(pinfo->link);
+
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	err = dsi_ctx.accum_err;
 	if (err < 0) {
 		dev_err(panel->dev, "failed to set display on: %d\n", err);
 		goto poweroff;
@@ -178,7 +191,12 @@ static int boe_panel_enable(struct drm_panel *panel)
 
 	usleep_range(120000, 121000);
 
-	ret = mipi_dsi_dcs_set_display_on(pinfo->link);
+	struct mipi_dsi_multi_context dsi_ctx = {
+		.dsi = pinfo->link,
+	};
+
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	ret = dsi_ctx.accum_err;
 	if (ret < 0) {
 		dev_err(panel->dev, "failed to set display on: %d\n", ret);
 		return ret;
diff --git a/drivers/gpu/drm/panel/panel-dsi-cm.c b/drivers/gpu/drm/panel/panel-dsi-cm.c
index ae6e9ffc4..90a0641a5 100644
--- a/drivers/gpu/drm/panel/panel-dsi-cm.c
+++ b/drivers/gpu/drm/panel/panel-dsi-cm.c
@@ -120,13 +120,15 @@ static int dsicm_dcs_write_1(struct panel_drv_data *ddata, u8 dcs_cmd, u8 param)
 static int dsicm_sleep_in(struct panel_drv_data *ddata)
 
 {
-	int r;
+	struct mipi_dsi_multi_context dsi_ctx ={
+		.dsi = ddata->dsi,
+	};
 
 	hw_guard_wait(ddata);
 
-	r = mipi_dsi_dcs_enter_sleep_mode(ddata->dsi);
-	if (r)
-		return r;
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
+	if (dsi_ctx.accum_err)
+		return dsi_ctx.accum_err;
 
 	hw_guard_start(ddata, 120);
 
@@ -137,13 +139,15 @@ static int dsicm_sleep_in(struct panel_drv_data *ddata)
 
 static int dsicm_sleep_out(struct panel_drv_data *ddata)
 {
-	int r;
+	struct mipi_dsi_multi_context dsi_ctx ={
+		.dsi = ddata->dsi,
+	};
 
 	hw_guard_wait(ddata);
 
-	r = mipi_dsi_dcs_exit_sleep_mode(ddata->dsi);
-	if (r)
-		return r;
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	if (dsi_ctx.accum_err)
+		return dsi_ctx.accum_err;
 
 	hw_guard_start(ddata, 120);
 
@@ -171,16 +175,17 @@ static int dsicm_get_id(struct panel_drv_data *ddata, u8 *id1, u8 *id2, u8 *id3)
 
 static int dsicm_set_update_window(struct panel_drv_data *ddata)
 {
-	struct mipi_dsi_device *dsi = ddata->dsi;
-	int r;
+	struct mipi_dsi_multi_context dsi_ctx = {
+		.dsi = ddata->dsi,
+	};
 
-	r = mipi_dsi_dcs_set_column_address(dsi, 0, ddata->mode.hdisplay - 1);
-	if (r < 0)
-		return r;
+	mipi_dsi_dcs_set_column_address_multi(&dsi_ctx, 0, ddata->mode.hdisplay - 1);
+	if (dsi_ctx.accum_err < 0)
+		return dsi_ctx.accum_err;
 
-	r = mipi_dsi_dcs_set_page_address(dsi, 0, ddata->mode.vdisplay - 1);
-	if (r < 0)
-		return r;
+	mipi_dsi_dcs_set_page_address_multi(&dsi_ctx, 0, ddata->mode.vdisplay - 1);
+	if (dsi_ctx.accum_err < 0)
+		return dsi_ctx.accum_err;
 
 	return 0;
 }
@@ -289,6 +294,10 @@ static int dsicm_power_on(struct panel_drv_data *ddata)
 
 	ddata->dsi->mode_flags |= MIPI_DSI_MODE_LPM;
 
+	struct mipi_dsi_multi_context dsi_ctx = {
+		.dsi = ddata->dsi,
+	};
+
 	r = dsicm_sleep_out(ddata);
 	if (r)
 		goto err;
@@ -306,7 +315,8 @@ static int dsicm_power_on(struct panel_drv_data *ddata)
 	if (r)
 		goto err;
 
-	r = mipi_dsi_dcs_set_pixel_format(ddata->dsi, MIPI_DCS_PIXEL_FMT_24BIT);
+	mipi_dsi_dcs_set_pixel_format_multi(&dsi_ctx, MIPI_DCS_PIXEL_FMT_24BIT);
+	r = dsi_ctx.accum_err;
 	if (r)
 		goto err;
 
@@ -314,16 +324,14 @@ static int dsicm_power_on(struct panel_drv_data *ddata)
 	if (r)
 		goto err;
 
-	r = mipi_dsi_dcs_set_display_on(ddata->dsi);
-	if (r)
-		goto err;
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
 
-	if (ddata->panel_data->te_support) {
-		r = mipi_dsi_dcs_set_tear_on(ddata->dsi, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
-		if (r)
-			goto err;
-	}
+	if (ddata->panel_data->te_support)
+		mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
 
+	r = dsi_ctx.accum_err;
+	if (r)
+		goto err;
 	/* possible panel bug */
 	msleep(100);
 
@@ -349,10 +357,14 @@ static int dsicm_power_on(struct panel_drv_data *ddata)
 static int dsicm_power_off(struct panel_drv_data *ddata)
 {
 	int r;
+	struct mipi_dsi_multi_context dsi_ctx = {
+		.dsi = ddata->dsi,
+	};
 
 	ddata->enabled = false;
 
-	r = mipi_dsi_dcs_set_display_off(ddata->dsi);
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	r = dsi_ctx.accum_err;
 	if (!r)
 		r = dsicm_sleep_in(ddata);
 
diff --git a/drivers/gpu/drm/panel/panel-feixin-k101-im2ba02.c b/drivers/gpu/drm/panel/panel-feixin-k101-im2ba02.c
index 8c3a231c1..f720b931d 100644
--- a/drivers/gpu/drm/panel/panel-feixin-k101-im2ba02.c
+++ b/drivers/gpu/drm/panel/panel-feixin-k101-im2ba02.c
@@ -304,9 +304,11 @@ static const struct k101_im2ba02_init_cmd timed_cmds[] = {
 static int k101_im2ba02_prepare(struct drm_panel *panel)
 {
 	struct k101_im2ba02 *ctx = panel_to_k101_im2ba02(panel);
-	struct mipi_dsi_device *dsi = ctx->dsi;
 	unsigned int i;
 	int ret;
+	struct mipi_dsi_multi_context dsi_ctx ={
+		.dsi = ctx->dsi,
+	};
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
 	if (ret)
@@ -326,8 +328,8 @@ static int k101_im2ba02_prepare(struct drm_panel *panel)
 	for (i = 0; i < ARRAY_SIZE(k101_im2ba02_init_cmds); i++) {
 		const struct k101_im2ba02_init_cmd *cmd = &k101_im2ba02_init_cmds[i];
 
-		ret = mipi_dsi_dcs_write_buffer(dsi, cmd->data, K101_IM2BA02_INIT_CMD_LEN);
-		if (ret < 0)
+		mipi_dsi_dcs_write_buffer_multi(&dsi_ctx, cmd->data, K101_IM2BA02_INIT_CMD_LEN);
+		if (dsi_ctx.accum_err < 0)
 			goto powerdown;
 	}
 
@@ -344,14 +346,16 @@ static int k101_im2ba02_enable(struct drm_panel *panel)
 {
 	struct k101_im2ba02 *ctx = panel_to_k101_im2ba02(panel);
 	const struct k101_im2ba02_init_cmd *cmd = &timed_cmds[1];
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = {
+		.dsi = ctx->dsi,
+	};
 
 	msleep(150);
 
-	ret = mipi_dsi_dcs_set_display_on(ctx->dsi);
-	if (ret < 0)
-		return ret;
 
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	if (dsi_ctx.accum_err)
+		return dsi_ctx.accum_err;
 	msleep(50);
 
 	return mipi_dsi_dcs_write_buffer(ctx->dsi, cmd->data, K101_IM2BA02_INIT_CMD_LEN);
diff --git a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
index c1d8ca5ca..070faf55f 100644
--- a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
+++ b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
@@ -93,11 +93,15 @@ static int feiyang_prepare(struct drm_panel *panel)
 static int feiyang_enable(struct drm_panel *panel)
 {
 	struct feiyang *ctx = panel_to_feiyang(panel);
+	struct mipi_dsi_multi_context dsi_ctx = {
+		.dsi = ctx->dsi,
+	};
 
 	/* T12 (video & logic signal rise + backlight rise) T12 >= 200ms */
 	msleep(200);
 
-	return mipi_dsi_dcs_set_display_on(ctx->dsi);
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	return dsi_ctx.accum_err;
 }
 
 static int feiyang_disable(struct drm_panel *panel)
diff --git a/drivers/gpu/drm/panel/panel-innolux-p079zca.c b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
index 80afeeab9..300cb5a3c 100644
--- a/drivers/gpu/drm/panel/panel-innolux-p079zca.c
+++ b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
@@ -117,7 +117,12 @@ static int innolux_panel_prepare(struct drm_panel *panel)
 	/* T6: 120ms - 1000ms*/
 	msleep(120);
 
-	err = mipi_dsi_dcs_set_display_on(innolux->link);
+	struct mipi_dsi_multi_context dsi_ctx = {
+		.dsi = innolux->link,
+	};
+
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	err = dsi_ctx.accum_err;
 	if (err < 0) {
 		dev_err(panel->dev, "failed to set display on: %d\n", err);
 		goto poweroff;
diff --git a/drivers/gpu/drm/panel/panel-khadas-ts050.c b/drivers/gpu/drm/panel/panel-khadas-ts050.c
index 67ca055f0..1dca6c592 100644
--- a/drivers/gpu/drm/panel/panel-khadas-ts050.c
+++ b/drivers/gpu/drm/panel/panel-khadas-ts050.c
@@ -694,7 +694,12 @@ static int khadas_ts050_panel_prepare(struct drm_panel *panel)
 		goto poweroff;
 	}
 
-	err = mipi_dsi_dcs_set_display_on(khadas_ts050->link);
+	struct mipi_dsi_multi_context dsi_ctx = {
+		.dsi = khadas_ts050->link,
+	};
+
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	err = dsi_ctx.accum_err;
 	if (err < 0) {
 		dev_err(panel->dev, "failed to set display on: %d\n", err);
 		goto poweroff;
diff --git a/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c b/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
index 893af9b16..deb82404d 100644
--- a/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
+++ b/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
@@ -250,7 +250,12 @@ static int kingdisplay_panel_prepare(struct drm_panel *panel)
 	/* T6: 120ms */
 	msleep(120);
 
-	err = mipi_dsi_dcs_set_display_on(kingdisplay->link);
+	struct mipi_dsi_multi_context dsi_ctx = {
+		.dsi = kingdisplay->link,
+	};
+
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	err = dsi_ctx.accum_err;
 	if (err < 0) {
 		dev_err(panel->dev, "failed to set display on: %d\n", err);
 		goto poweroff;
diff --git a/drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c b/drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c
index ff35b62a3..f1d9e4eed 100644
--- a/drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c
+++ b/drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c
@@ -553,7 +553,12 @@ static int ltk500hd1829_prepare(struct drm_panel *panel)
 	/* 120ms to exit sleep mode */
 	msleep(120);
 
-	ret = mipi_dsi_dcs_set_display_on(dsi);
+	struct mipi_dsi_multi_context dsi_ctx = {
+		.dsi = dsi
+	};
+
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	ret = dsi_ctx.accum_err;
 	if (ret < 0) {
 		dev_err(panel->dev, "failed to set display on: %d\n", ret);
 		goto disable_iovcc;
diff --git a/drivers/gpu/drm/panel/panel-newvision-nv3051d.c b/drivers/gpu/drm/panel/panel-newvision-nv3051d.c
index 22560384e..eeb18ad87 100644
--- a/drivers/gpu/drm/panel/panel-newvision-nv3051d.c
+++ b/drivers/gpu/drm/panel/panel-newvision-nv3051d.c
@@ -303,7 +303,12 @@ static int panel_nv3051d_prepare(struct drm_panel *panel)
 
 	msleep(200);
 
-	ret = mipi_dsi_dcs_set_display_on(dsi);
+	struct mipi_dsi_multi_context dsi_ctx = {
+		.dsi = dsi
+	};
+
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	ret = dsi_ctx.accum_err;
 	if (ret < 0) {
 		dev_err(ctx->dev, "Failed to set display on: %d\n", ret);
 		goto disable_vdd;
diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35510.c b/drivers/gpu/drm/panel/panel-novatek-nt35510.c
index 3189d89c7..d977b9f28 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35510.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35510.c
@@ -1039,7 +1039,12 @@ static int nt35510_prepare(struct drm_panel *panel)
 			return ret;
 	}
 
-	ret = mipi_dsi_dcs_set_display_on(dsi);
+	struct mipi_dsi_multi_context dsi_ctx = {
+		.dsi = dsi
+	};
+
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	ret = dsi_ctx.accum_err;
 	if (ret) {
 		dev_err(nt->dev, "failed to turn display on (%d)\n", ret);
 		return ret;
diff --git a/drivers/gpu/drm/panel/panel-raydium-rm67191.c b/drivers/gpu/drm/panel/panel-raydium-rm67191.c
index 2af6aa47a..bf9644424 100644
--- a/drivers/gpu/drm/panel/panel-raydium-rm67191.c
+++ b/drivers/gpu/drm/panel/panel-raydium-rm67191.c
@@ -371,7 +371,12 @@ static int rad_panel_enable(struct drm_panel *panel)
 
 	usleep_range(5000, 7000);
 
-	ret = mipi_dsi_dcs_set_display_on(dsi);
+	struct mipi_dsi_multi_context dsi_ctx = {
+		.dsi = dsi
+	};
+
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	ret = dsi_ctx.accum_err;
 	if (ret < 0) {
 		dev_err(dev, "Failed to set display ON (%d)\n", ret);
 		goto fail;
diff --git a/drivers/gpu/drm/panel/panel-raydium-rm68200.c b/drivers/gpu/drm/panel/panel-raydium-rm68200.c
index c535dc931..38993f821 100644
--- a/drivers/gpu/drm/panel/panel-raydium-rm68200.c
+++ b/drivers/gpu/drm/panel/panel-raydium-rm68200.c
@@ -281,7 +281,12 @@ static int rm68200_prepare(struct drm_panel *panel)
 
 	msleep(125);
 
-	ret = mipi_dsi_dcs_set_display_on(dsi);
+	struct mipi_dsi_multi_context dsi_ctx = {
+		.dsi = dsi
+	};
+
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	ret = dsi_ctx.accum_err;
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c b/drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c
index 1f825d995..36edb80b1 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c
@@ -389,7 +389,12 @@ static int s6e63j0x03_enable(struct drm_panel *panel)
 	if (ret < 0)
 		return ret;
 
-	ret = mipi_dsi_dcs_set_display_on(dsi);
+	struct mipi_dsi_multi_context dsi_ctx = {
+		.dsi = dsi
+	};
+
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	ret = dsi_ctx.accum_err;
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c b/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c
index d159b0e4f..e462c47f6 100644
--- a/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c
+++ b/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c
@@ -206,7 +206,12 @@ static int sharp_panel_prepare(struct drm_panel *panel)
 		goto poweroff;
 	}
 
-	err = mipi_dsi_dcs_set_display_on(sharp->link1);
+	struct mipi_dsi_multi_context dsi_ctx = {
+		.dsi = sharp->link1,
+	};
+
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	err = dsi_ctx.accum_err;
 	if (err < 0) {
 		dev_err(panel->dev, "failed to set display on: %d\n", err);
 		goto poweroff;
-- 
2.54.0

