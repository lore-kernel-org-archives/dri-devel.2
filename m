Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA69FC531CC
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 20:36:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F39510E0FA;
	Thu, 23 Jul 2026 20:36:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sJzpTDl7";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7DBC10E0FA
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 20:36:09 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-495590ba856so9000545e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 13:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784838968; x=1785443768; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H9I5kwUNdI22d3Rq9mSVERh4Hdo8G6QxFzmLpwrynNI=;
 b=sJzpTDl7m2N903kMOZM7RXvN6J40SY9rWF6e0PVK0lxJDx6pTJgfFcgBWIFHB8eeEV
 DjsJVZ2o/B0Znxmqjyr+KkQyjuioMPk6/BoxZHp7FfbJPOu03ns3bofhzvxdyRinXdM3
 mMqamBgBFzxtjq2Y2wziQvdoqqsNGLpAyFh+AZTpWCjQVWVFSqwQGc7jeNmHZBrCEaMU
 ukIfQMwQEdelhkU6QayWVn/MtG7KeHSg2ts3ioRPENMUDTjL7ovu2qae1qio8UjHARrB
 ygsY3DZXUtPLnPS3fcYcqXoM8v3xIwhiw78ZLe25Ufx9AFa+nx/HPCl/wrWORDvu05Dt
 rYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784838968; x=1785443768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=H9I5kwUNdI22d3Rq9mSVERh4Hdo8G6QxFzmLpwrynNI=;
 b=P4yMg9PNHIG3+QnB4sOCUQWVSKJkUE9scHzREWAJZeG0aUO22vNWa1PRVGMHBW/qq5
 loiI1BwMK6NQQe1Rh0Id02XWddsYhZ+umVYXUrHVE8yhFEvu6KbDXczAS6X0Q3mDq9FU
 odS4Pkd3eGE/B8Pk5SGe3tMrriTDpo5q7O9f+i2+6CkLrshCcohuMM1EHQsMZMPzLXuu
 KSXkvjZgeWrbDwMoYqpfzT2hdlkq2C3PtA3/S/HtgEmr9cJP7DMBd2UI2Ar2lgukxL3Q
 mECFocp61nRPKlsWJnrhgnaTssuXJjwJM8ql0WVVBmfnuEvaOIjaHG1R1DixkKDOQzxQ
 G2bg==
X-Gm-Message-State: AOJu0YxzmG0AaCUX9OsAHWwSqbGx1WcZt6PiOWodAWdvz7EGWhfZjlkf
 zp6g5AouujhqDB6sSojGHWC5rLkAJDP3Q6f5IAIxv5ClXuP4IyNKvLbdn4mMOQ==
X-Gm-Gg: AR+sD10UNKxfDbPu61HXCqYXdzSqnAgeCRtHS8hZnrXfA1H1I71WFQB1LzZTXH0uBCZ
 yI2e2aeaFws38HrA893ND1lOzOZGvNTD9gR9tmKehvXnIgYSopM/QWTFGGMMSGv4BUcbUQqGBG1
 o5KzH/U6iBVwnLbajaizTBIPveyr0gLfYcw58Q5AUAOhTcvmJX2muSyLAok1buOBTcOx+voMjkv
 ipjwoMOj4mc/GQseNYmgfUTWXUbdwTDS+rv+L0upn58qk/rdg5sg8V3MDVa1yIgq1gUT/Jjfk8B
 04FJ2bAUkg4OyVG6qsq7tjTH6DXIC/jeQPO+7KsV60U9XP6+K1kROzYhCTD6GDWbqU5YncQmPJ9
 DgLjIHGX/8D84T46YNKFxHgbomwu7RwvZ+nXCz7vUpRAxUGnH/5JRCBxTqtqKfyNCxKEJuxJMLk
 1X1O52hKxW9ovKRH4owPORF4lOWTdrhWm5ZwTtwz3Th2Cjiz7z
X-Received: by 2002:a05:600c:4ec8:b0:495:4aff:5fdf with SMTP id
 5b1f17b1804b1-49573d0cb53mr49825425e9.28.1784838968069; 
 Thu, 23 Jul 2026 13:36:08 -0700 (PDT)
Received: from michalis-linux (adsl-75.176.58.251.tellas.gr. [176.58.251.75])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957af78a02sm15384335e9.7.2026.07.23.13.36.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 13:36:07 -0700 (PDT)
From: Michail Tatas <michail.tatas@gmail.com>
To: michael@amarulasolutions.com, neil.armstrong@linaro.org,
 jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, dianders@chromium.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Michail Tatas <michail.tatas@gmail.com>
Subject: [PATCH v4 1/3] drm/panel: ilitek-ili9805: Use _multi variants
Date: Thu, 23 Jul 2026 23:35:59 +0300
Message-ID: <20260723203601.806697-2-michail.tatas@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723203601.806697-1-michail.tatas@gmail.com>
References: <20260723203601.806697-1-michail.tatas@gmail.com>
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

Convert functions mipi_dsi_* to mipi_dsi_*_multi as per the
gpu/todo file.
The multi variant of these functions include improved error
handling.

Signed-off-by: Michail Tatas <michail.tatas@gmail.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9805.c | 51 +++++---------------
 1 file changed, 13 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
index e6c483851f1f..7e9587afebbe 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
@@ -159,36 +159,23 @@ static int ili9805_power_off(struct ili9805 *ctx)
 
 static int ili9805_activate(struct ili9805 *ctx)
 {
-	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	int i, ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
+	int i;
 
 	for (i = 0; i < ctx->desc->init_length; i++) {
 		const struct ili9805_instr *instr = &ctx->desc->init[i];
 
-		ret = mipi_dsi_dcs_write_buffer(ctx->dsi, instr->data, instr->len);
-		if (ret < 0)
-			return ret;
+		mipi_dsi_dcs_write_buffer_multi(&dsi_ctx, instr->data, instr->len);
 
 		if (instr->delay > 0)
-			msleep(instr->delay);
-	}
-
-	ret = mipi_dsi_dcs_exit_sleep_mode(ctx->dsi);
-	if (ret) {
-		dev_err(dev, "Failed to exit sleep mode (%d)\n", ret);
-		return ret;
+			mipi_dsi_msleep(&dsi_ctx, instr->delay);
 	}
 
-	usleep_range(5000, 6000);
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_usleep_range(&dsi_ctx, 5000, 6000);
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
 
-	ret = mipi_dsi_dcs_set_display_on(ctx->dsi);
-	if (ret) {
-		dev_err(dev, "Failed to set display ON (%d)\n", ret);
-		return ret;
-	}
-
-	return 0;
+	return dsi_ctx.accum_err;
 }
 
 static int ili9805_prepare(struct drm_panel *panel)
@@ -211,25 +198,13 @@ static int ili9805_prepare(struct drm_panel *panel)
 
 static int ili9805_deactivate(struct ili9805 *ctx)
 {
-	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	int ret;
-
-	ret = mipi_dsi_dcs_set_display_off(ctx->dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set display OFF (%d)\n", ret);
-		return ret;
-	}
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
 
-	usleep_range(5000, 10000);
-
-	ret = mipi_dsi_dcs_enter_sleep_mode(ctx->dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to enter sleep mode (%d)\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	mipi_dsi_usleep_range(&dsi_ctx, 5000, 10000);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
 
-	return 0;
+	return dsi_ctx.accum_err;
 }
 
 static int ili9805_unprepare(struct drm_panel *panel)
-- 
2.43.0

