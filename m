Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0421C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:44:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AFF410E167;
	Mon,  6 Jul 2026 22:44:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A0WKqa2Y";
	dkim-atps=neutral
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com
 [209.85.210.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25DC810E167
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 22:44:37 +0000 (UTC)
Received: by mail-ot1-f54.google.com with SMTP id
 46e09a7af769-7eb64371a2aso2371753a34.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 15:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783377876; x=1783982676; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=G77zae6W1Y+lDMJG5BxknAhTRS5mZtGYTolxw07uXkA=;
 b=A0WKqa2YlPMeJBb5Vl3coJypzXsK+Qh9K1vGBEXCjKGLA11Nll7K3EKW1n4bc+2Rox
 +C0xQkPFXKkyDXrAqU8BLsExfRZ0A7ltQDN2GXUV4Ie5P3sHsZD4lZ6/Xc6DYq9XBCk/
 vGMRA4w7q+jbwoNIpfSMNGh8KrA0C3ha25F+tdr6Wi51/kCr9xSVrrQz6FFAunbr9M8r
 p+zGMpvkj5EQlYTBdij9LLe5mn4E+1eCUatQqZdvP5yIDKxt0uUnYd6QbelazEsD5aW8
 quVEs7Tl0vAyEvtHuXRj4YXjpgsPzsv+JvMRzBTHGLIjtzwq1+21OuxOwGla5QQDv1Fh
 NenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377876; x=1783982676;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=G77zae6W1Y+lDMJG5BxknAhTRS5mZtGYTolxw07uXkA=;
 b=TkjdJKf6/F+7OP8vOVI4DC6uvXbSwynjZAML/JrIWZNavJDPtx1d7eIGULLkX9Er4s
 CQZ8qZ5FNfMVpWDcUO0MBk7n/ugK/jXtUDM3STidcn0AbxDAeS0a6FCBZ6sYp0sKUwg2
 dZTxEfv1B444HLGmUWHe4fgPMknwKQ3sNw7zvYCJEAE/BskWu8rInQ1SDvZnVg9Iczad
 7+hz2xUGhbDnZxy6UCiDSzLqgXL/8E2vbIO5UgnjBOBN8CnxE6sgzG78tuloGLZUqwDt
 3+VfnLH5Hg/+HgA3Hw985ipqm24BvrbsBjA91KLA12zp6qBCyNcdXlp1ef5XZRtW53Al
 DUNw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9bFX/pxHO8xvbpu7jzJYE60peHebRjS3v0R2rgk5EapCMdQqpktawBJ44L31iFoLhFLrRK4TmwsWY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzoqSEkwd7PHGFmBccZ6NBPE7RTpBokzXibR/i/Jqzs+5Ph9//M
 sLJlMqzP67n/Rscgz+3zcKbfAOttbUHBr1wrP24i2tgG90U77lP2Kt0=
X-Gm-Gg: AfdE7cmwn86h2MGuo2hRec+P7XJ2hxqMhF2wpubpufI09vuJ4cl0itHn25awueklBeo
 tApyDiyq0abgeG7TS32+yfXVeQfW1uBLgp+30F+S0pkeofAT84SDc61SGLnaBlbXs5FovwNCNtI
 km1C5eFtvpBvxdPnFhI2K6PuKl2sop0vcHwPN1daoxeWsgKkUMVOrojri1SXvOykcvBBaa2tK7A
 T2VGymdfzfBsGNfU68QJj2avFtbmb63wWWJ8xnI24QIx7oNve2fftiR54bcBuVP9JOaxkc/bihE
 OVgUOeEr+8GZ3tKS1tLXYUh54jjVhGodKx0nRYB6rKHwoTFS7bPlQeFDNPpciVZkPHY1x40Ph/H
 rKI1+YXawRa/RRnZLmjyWZ42J3vIfjdmUc1EpKoo2ex8kcD/KDQPXsz0gfgwt2Z1p40L9F4oVTH
 z9IS8bGrP2evUXycORJxm8QCrOyVg3KfBbvvBLnDhlOkb070768lIqqurXNXEHt3i8
X-Received: by 2002:a05:6820:2d03:b0:6a3:1063:1a8f with SMTP id
 006d021491bc7-6a355392306mr1575891eaf.19.1783377875878; 
 Mon, 06 Jul 2026 15:44:35 -0700 (PDT)
Received: from localhost.localdomain ([186.158.238.108])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a31fd2cf7asm7510942eaf.4.2026.07.06.15.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:44:35 -0700 (PDT)
From: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>,
 Brigham Campbell <me@brighamcampbell.com>,
 David Airlie <airlied@gmail.com>, Douglas Anderson <dianders@chromium.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: [PATCH v2] drm/panel: novatek-nt37801: Use mipi_dsi_*_multi()
 functions
Date: Mon,  6 Jul 2026 19:43:35 -0300
Message-ID: <20260706224414.1015766-1-nico.antinori.7@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Replace mipi_dsi_* functions with their non-deprecated mipi_dsi_*_multi
counterparts. This change reduces error-checking boilerplate and improves
readability.

Signed-off-by: Nicolás Antinori <nico.antinori.7@gmail.com>
---
Changelog:
v2:
Implement feedback from the previous thread to simplify code in the
novatek_nt37801_prepare() function. This converts novatek_nt37801_on() to
return void and passes the mipi_dsi_multi_context struct directly as an
argument.

v1:
https://lore.kernel.org/dri-devel/20260701125624.199786-1-nico.antinori.7@gmail.com/T/#u

 drivers/gpu/drm/panel/panel-novatek-nt37801.c | 110 ++++++++----------
 1 file changed, 48 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt37801.c b/drivers/gpu/drm/panel/panel-novatek-nt37801.c
index d6a37d7e0cc6..139cbf9833c7 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt37801.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt37801.c
@@ -52,61 +52,56 @@ static void novatek_nt37801_reset(struct novatek_nt37801 *ctx)
 	mipi_dsi_dcs_write_seq_multi((dsi_ctx), NT37801_DCS_SWITCH_PAGE, \
 				     0x55, 0xaa, 0x52, 0x08, (page))

-static int novatek_nt37801_on(struct novatek_nt37801 *ctx)
+static void novatek_nt37801_on(struct mipi_dsi_multi_context *dsi_ctx)
 {
-	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
-
-	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
-
-	novatek_nt37801_switch_page(&dsi_ctx, 0x01);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x01);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc5, 0x0b, 0x0b, 0x0b);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xff, 0xaa, 0x55, 0xa5, 0x80);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x02);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf5, 0x10);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x1b);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf4, 0x55);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x18);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf8, 0x19);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x0f);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfc, 0x00);
-	mipi_dsi_dcs_set_column_address_multi(&dsi_ctx, 0x0000, 0x059f);
-	mipi_dsi_dcs_set_page_address_multi(&dsi_ctx, 0x0000, 0x0c7f);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x90, 0x03, 0x03);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x91,
+	dsi_ctx->dsi->mode_flags |= MIPI_DSI_MODE_LPM;
+
+	novatek_nt37801_switch_page(dsi_ctx, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x6f, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xc5, 0x0b, 0x0b, 0x0b);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0xaa, 0x55, 0xa5, 0x80);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x6f, 0x02);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf5, 0x10);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x6f, 0x1b);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf4, 0x55);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x6f, 0x18);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf8, 0x19);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x6f, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xfc, 0x00);
+	mipi_dsi_dcs_set_column_address_multi(dsi_ctx, 0x0000, 0x059f);
+	mipi_dsi_dcs_set_page_address_multi(dsi_ctx, 0x0000, 0x0c7f);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x90, 0x03, 0x03);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x91,
 				     0x89, 0x28, 0x00, 0x28, 0xc2, 0x00, 0x02,
 				     0x68, 0x04, 0x6c, 0x00, 0x0a, 0x02, 0x77,
 				     0x01, 0xe9, 0x10, 0xf0);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xff, 0xaa, 0x55, 0xa5, 0x81);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x23);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfb,
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0xaa, 0x55, 0xa5, 0x81);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x6f, 0x23);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xfb,
 				     0x00, 0x01, 0x00, 0x11, 0x33, 0x33, 0x33,
 				     0x55, 0x57, 0xd0, 0x00, 0x00, 0x44, 0x56,
 				     0x77, 0x78, 0x9a, 0xbc, 0xdd, 0xf0);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x06);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf3, 0xdc);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_SET_GAMMA_CURVE, 0x00);
-	mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3b, 0x00, 0x18, 0x00, 0x10);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_CONTROL_DISPLAY,
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x6f, 0x06);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf3, 0xdc);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MIPI_DCS_SET_GAMMA_CURVE, 0x00);
+	mipi_dsi_dcs_set_tear_on_multi(dsi_ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x3b, 0x00, 0x18, 0x00, 0x10);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MIPI_DCS_WRITE_CONTROL_DISPLAY,
 				     0x20);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x51,
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x51,
 				     0x07, 0xff, 0x07, 0xff, 0x0f, 0xff);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5a, 0x01);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x9c, 0x01);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_MEMORY_START);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2f, 0x00);
-
-	novatek_nt37801_switch_page(&dsi_ctx, 0x01);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb2, 0x55, 0x01, 0xff, 0x03);
-	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
-	mipi_dsi_msleep(&dsi_ctx, 120);
-	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
-	mipi_dsi_msleep(&dsi_ctx, 20);
-
-	return dsi_ctx.accum_err;
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x5a, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x5f, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x9c, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, MIPI_DCS_WRITE_MEMORY_START);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x2f, 0x00);
+
+	novatek_nt37801_switch_page(dsi_ctx, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb2, 0x55, 0x01, 0xff, 0x03);
+	mipi_dsi_dcs_exit_sleep_mode_multi(dsi_ctx);
+	mipi_dsi_msleep(dsi_ctx, 120);
+	mipi_dsi_dcs_set_display_on_multi(dsi_ctx);
+	mipi_dsi_msleep(dsi_ctx, 20);
 }

 static int novatek_nt37801_off(struct novatek_nt37801 *ctx)
@@ -128,7 +123,8 @@ static int novatek_nt37801_off(struct novatek_nt37801 *ctx)
 static int novatek_nt37801_prepare(struct drm_panel *panel)
 {
 	struct novatek_nt37801 *ctx = to_novatek_nt37801(panel);
-	struct device *dev = &ctx->dsi->dev;
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 	struct drm_dsc_picture_parameter_set pps;
 	int ret;

@@ -138,22 +134,12 @@ static int novatek_nt37801_prepare(struct drm_panel *panel)
 		return ret;

 	novatek_nt37801_reset(ctx);
-
-	ret = novatek_nt37801_on(ctx);
-	if (ret < 0)
-		goto err;
-
+	novatek_nt37801_on(&dsi_ctx);
 	drm_dsc_pps_payload_pack(&pps, &ctx->dsc);
-
-	ret = mipi_dsi_picture_parameter_set(ctx->dsi, &pps);
-	if (ret < 0) {
-		dev_err(panel->dev, "failed to transmit PPS: %d\n", ret);
-		goto err;
-	}
-
-	ret = mipi_dsi_compression_mode(ctx->dsi, true);
-	if (ret < 0) {
-		dev_err(dev, "failed to enable compression mode: %d\n", ret);
+	mipi_dsi_picture_parameter_set_multi(&dsi_ctx, &pps);
+	mipi_dsi_compression_mode_multi(&dsi_ctx, true);
+	if (dsi_ctx.accum_err) {
+		ret = dsi_ctx.accum_err;
 		goto err;
 	}

--
2.47.3

