Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C437606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P5yeRSqw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A59310EB8A;
	Wed,  4 Nov 2026 08:58:41 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DE9A10E83C
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 07:38:25 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a35db1f202so2108545e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 23:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793777904; x=1794382704; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bfQkbGmxkZ9/E2Cz55EueAzwIal30Q7LNxKxPAHeTlQ=;
 b=P5yeRSqwUX46LYiyCVTbm8TRC2cREWD/Hip4aziUNnssmwzoeVcmnCtox3QukZAZTO
 sXLEPtPvfgsWyrDFMLjDgZiJS+o0qIDv+sQYgtW79LNnPZaYbfxQlTeTmv7XRB+VldKm
 I7cqyaz8hx0XmAECgZmBmPom8UMD62o++s5Yf7Lt16xviiVMrEAEBpeHVKhQmg8AWnVA
 L6CoR09EAVpH7yOJULQMiemg74YLKQUk89Mh5t3G+4R/PP8mita73PQygpQK8+WY1q0A
 l8gusbJL4MiWw6IPFEZYBXp1pwamfBx/RdVDD7lQSzBp1Hm5yaai/W/6TsbcQZfy+yh7
 uetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793777904; x=1794382704;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bfQkbGmxkZ9/E2Cz55EueAzwIal30Q7LNxKxPAHeTlQ=;
 b=gDKD8+oi3/TdHZXSoKO2Zw9PmM4/a6eyDVByUKZCT5auusruwZBvs0lDEx7GDMlIqv
 NMNmKNA/I2zvqy3+QGQWVJCX8zL7vHCRfpyThAZ7Be0TFRQKwA1v8L7Ahw20asulW44W
 GcHqSMcRLTz8mG0gpOzchfXOyF6W5qbobU2VIVOoI7oFrLFUCsBxcS+h0WXzHjXw1t06
 ROpHELzEM96toDU/kvzVBI5vhbltxHJhvmZvdKYHNMNk9vd3fnufAboKSD0G8nE5RDSs
 EYxx4WnysHCR88Yeu5SR3nEoEQ2E0IQVeWNl25+PSqB/FQZDGkwUw9TFHYyWeSHqTQOw
 Yoow==
X-Forwarded-Encrypted: i=1;
 AKwUvBwPFBsxXby2OBzrm+7v6dCFgrSNsDC0bJcJWtfPOOqiRo8QkMntfwT68cW3Qjd6i0J9eHMxrvuz67I=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/ztRcTSEx8Tg8gsJy8osfbZFskco/r5sX/MRSXft1O9AGeEg+T
 +GTVm6lO2X2DN+knwLz1ak6q4KdSre+R3ELaSKEOC0V7id6Bc92mY+I=
X-Gm-Gg: AYBFou16F/e1vK6HzyKoucxRJoFf2r/FJA3plnP46fpf551h5Rb1ir76V6f24zkhTTM
 qy5nU7SD5c900ks0EiCGH96eRrnm6aCAhVaZW39f+QNRzBt7JWcX5lqCJtsiraJ9m1oIN44NWKk
 7N7yeC44n/jga+WQagZ+B3vnhi3+11wsipznBjDaQwrYWVoVgvlOclHkORM5cMV7k6PdGPnkYfY
 U31gbhCcrRlct4sCaGA29Lz00BkO5YNFkvfoybXkUsir+q8m1BJTZyKO57L2kkTlJB5w70m6dYK
 rXkCH8zA5qBaM7g1eu7yiDdcZaP8OShbHOQMQ9mZgLEI5fdj1sAlfC7H9VhKfUa5SwlT06zyL1p
 jU0sL6SYmuj+A2zbw6IMkWc2/RN/vlJeePoxulrw4jf1X0M/R4n7+ARQesGV14UVw4nCHZlEPR0
 CzLtw32PhcvueLtYEnAVHnszb2oHKNK9mPaOiHMSkS4WJgdb/wJ33Wxkv8Qjix4rC4TzGfU4mba
 qJvwd0GtU8yBaqEkrepXA4VVdjAZPgTqsGzcu6N1H9x9aF9KmccPZWOc8340olAjzIyp8y4tyjm
 kagZxDhE6JXRncMk2AIGsLmsdB1CbddHtrPKNBudZ3jRpz5F1VuFLILYaGZgiLKeWETEqY8++I2
 I6QDLI1KHl8zAfBoWAcpy8DNkq4JMgrSfPe5r4dMWGPZor6Ne7AM=
X-Received: by 2002:a05:600c:46d2:b0:4a1:d537:1c8d with SMTP id
 5b1f17b1804b1-4ac187a6a38mr353371115e9.19.1793777903551; 
 Tue, 03 Nov 2026 23:38:23 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:6680:2104:2097:c9b1:3ad5:7d89:fd1d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a80e184esm124190015e9.2.2026.11.03.23.38.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Nov 2026 23:38:23 -0800 (PST)
From: amit <amittibi123@gmail.com>
To: neil.armstrong@linaro.org
Cc: hanxu5@huaqin.corp-partner.google.com, jesszhan0024@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, icenowy@aosc.io,
 jagan@amarulasolutions.com, linusw@kernel.org, robert.chiras@nxp.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amit <amittibi123@gmail.com>
Subject: [PATCH] drm/panel: Replace deprecated DCS display-on calls
Date: Wed,  4 Nov 2026 09:38:13 +0200
Message-ID: <20261104073813.42429-1-amittibi123@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Nov 2026 08:58:01 +0000
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

Signed-off-by: amit <amittibi123@gmail.com>
---
 drivers/gpu/drm/panel/panel-boe-himax8279d.c       | 14 ++++++++++++--
 drivers/gpu/drm/panel/panel-dsi-cm.c               |  7 ++++++-
 drivers/gpu/drm/panel/panel-feixin-k101-im2ba02.c  |  7 +++++--
 .../gpu/drm/panel/panel-feiyang-fy07024di26a30d.c  |  6 +++++-
 drivers/gpu/drm/panel/panel-innolux-p079zca.c      |  7 ++++++-
 drivers/gpu/drm/panel/panel-khadas-ts050.c         |  7 ++++++-
 drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c |  7 ++++++-
 drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.c |  7 ++++++-
 drivers/gpu/drm/panel/panel-newvision-nv3051d.c    |  7 ++++++-
 drivers/gpu/drm/panel/panel-novatek-nt35510.c      |  7 ++++++-
 drivers/gpu/drm/panel/panel-raydium-rm67191.c      |  7 ++++++-
 drivers/gpu/drm/panel/panel-raydium-rm68200.c      |  7 ++++++-
 drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c   |  7 ++++++-
 drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c    |  7 ++++++-
 14 files changed, 88 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-himax8279d.c b/drivers/gpu/drm/panel/panel-boe-himax8279d.c
index 4a8560b4b..a4b35e042 100644
--- a/drivers/gpu/drm/panel/panel-boe-himax8279d.c
+++ b/drivers/gpu/drm/panel/panel-boe-himax8279d.c
@@ -155,7 +155,12 @@ static int boe_panel_prepare(struct drm_panel *panel)
 	/* T6: 120ms - 121ms */
 	usleep_range(120000, 121000);
 
-	err = mipi_dsi_dcs_set_display_on(pinfo->link);
+	struct mipi_dsi_multi_context dsi_ctx = {
+		.dsi = pinfo->link,
+	};
+
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	err = dsi_ctx.accum_err;
 	if (err < 0) {
 		dev_err(panel->dev, "failed to set display on: %d\n", err);
 		goto poweroff;
@@ -178,7 +183,12 @@ static int boe_panel_enable(struct drm_panel *panel)
 
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
index ae6e9ffc4..37dd2961a 100644
--- a/drivers/gpu/drm/panel/panel-dsi-cm.c
+++ b/drivers/gpu/drm/panel/panel-dsi-cm.c
@@ -289,6 +289,10 @@ static int dsicm_power_on(struct panel_drv_data *ddata)
 
 	ddata->dsi->mode_flags |= MIPI_DSI_MODE_LPM;
 
+	struct mipi_dsi_multi_context ctx = {
+		.dsi = ddata->dsi,
+	};
+
 	r = dsicm_sleep_out(ddata);
 	if (r)
 		goto err;
@@ -314,7 +318,8 @@ static int dsicm_power_on(struct panel_drv_data *ddata)
 	if (r)
 		goto err;
 
-	r = mipi_dsi_dcs_set_display_on(ddata->dsi);
+	mipi_dsi_dcs_set_display_on_multi(&ctx);
+	r = ctx.accum_err;
 	if (r)
 		goto err;
 
diff --git a/drivers/gpu/drm/panel/panel-feixin-k101-im2ba02.c b/drivers/gpu/drm/panel/panel-feixin-k101-im2ba02.c
index 8c3a231c1..baa64b7ae 100644
--- a/drivers/gpu/drm/panel/panel-feixin-k101-im2ba02.c
+++ b/drivers/gpu/drm/panel/panel-feixin-k101-im2ba02.c
@@ -344,12 +344,15 @@ static int k101_im2ba02_enable(struct drm_panel *panel)
 {
 	struct k101_im2ba02 *ctx = panel_to_k101_im2ba02(panel);
 	const struct k101_im2ba02_init_cmd *cmd = &timed_cmds[1];
+	struct mipi_dsi_multi_context dsi_ctx = {
+		.dsi = ctx->dsi,
+	};
 	int ret;
 
 	msleep(150);
 
-	ret = mipi_dsi_dcs_set_display_on(ctx->dsi);
-	if (ret < 0)
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	if (dsi_ctx.accum_err)
 		return ret;
 
 	msleep(50);
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

