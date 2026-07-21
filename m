Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88EB4C44536
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 22:11:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 523C810EBA5;
	Tue, 21 Jul 2026 22:11:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cV3EgqGd";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C3C710EAD1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 17:27:23 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4953de5be0aso41530585e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 10:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784654842; x=1785259642; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H9I5kwUNdI22d3Rq9mSVERh4Hdo8G6QxFzmLpwrynNI=;
 b=cV3EgqGdN7xCUPfzCWBASjWKa4giQupOrno6e4dwFAIoU1IYCdeR783Qmfp3vz1Q8R
 NFZU9bwOIaxdR/0FTnYqgVAzwIWI/mODGj71eX3IalPL4m0K9Ph2uLRBg3JCVb8r8xPB
 1qjZp5yz2BL+Fi3K/vHzxcKSUCCVlTzHLqzNg0JpGlw7+3OGOnGzT+XjMtFgAZZrGxVG
 afEbA+EHhfkQI5jpgqGXsU5vTPcX+Xy3i6/b7Q6QK7QA/dlfTmlVbzYywPLEf87vLJrj
 hczrb6vCm5Sxc3jdg7UvNdQJj2pGEgjkoKupgVWXfyQduGSXQ/qpSLXGQWSh+3Z7Dvvk
 xdhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784654842; x=1785259642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=H9I5kwUNdI22d3Rq9mSVERh4Hdo8G6QxFzmLpwrynNI=;
 b=o0GUqJDaGkrrfk+Q3zGCrMhxa8Ew3nCsOwNkYYq+ZhQ3mE1jfmwFhTLkUG5X3I22Po
 TkMzsrvkNsj7P6yNXOrQkdqMuH5zKQYw7Wt1HGflqWbrJQzpmxlnuXGnr9IpOW8YdcFa
 sFcfwh2gSo8U1qsH5zKShV6O7fQMqBKWYBMlJsrP0rqLH2oVgOf61kmxKlHajshxs129
 bIDuFz+7WtNok2McGce2co+1xsV00PEO1cEWUyBYMkXALDiNglU0htawb8zCmcvuuowk
 +qSSTHs5IU9WzmtSdsXS4ztBLs98G3o8NPCIguICpzRHlZ9zr4gu4HN/c87IoXqv18oc
 kyVA==
X-Gm-Message-State: AOJu0YxX2IQcnYbPXnI8TueW4FaJdmId6OWHP4dllcvdZyHocCKldvqL
 6KeK6JcIcy+Z9dQ25dVuD7QoQQwqaCFIzN/8w7Yt1RIAyDwpdp5yxfKvHMuFAA==
X-Gm-Gg: AfdE7cmjRxgd7R0S/lm/Gfs1RT9VhuVvwjp4N6bgwbxqLAn//TtTe5bbe1k7w1FwTIM
 eIvlRoXv0MqG6gXK3JSDu3PW+stwvmr3vMaSZSaT7RkdRkZ93UhymNfJvzFa3G+e9nisfd7vR3n
 4k/irdKRQkBmptPwx2uZJYlfYLj9Jhswh9iNHt2A3XnmCzM13brs9M+mfooyXYxRX2a3zxbu9aH
 h6cdce6GyayLwshfq0I1MWUkcJkQ7F8qAtYzphGKrDBYOmPtdWzuWTXfuwLd4lOBJgqzOuFPIs5
 4TEL8bB0OABDZQFOtpb0FyCIFdCBWIuDVsYcloAeaFRv0WihO7bnkr5n56XOTl5q0MtukzhY7hQ
 mRuJRV4O8gaaE11Jh6eksI5D7yGaDL2LodYPyOwJ3SyHQPavMLgVP324b37vW1IRMzDTU52RseD
 Uidm1CfinEYqs6Vsdv8LrQWasoAPM7sk55iMw7q5kxakcwh199
X-Received: by 2002:a05:600c:8284:b0:495:5d6d:d4f7 with SMTP id
 5b1f17b1804b1-4955d6dd523mr129158855e9.24.1784654841621; 
 Tue, 21 Jul 2026 10:27:21 -0700 (PDT)
Received: from michalis-linux (adsl-75.176.58.251.tellas.gr. [176.58.251.75])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a4f9a11sm7593595e9.4.2026.07.21.10.27.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 10:27:21 -0700 (PDT)
From: Michail Tatas <michail.tatas@gmail.com>
To: michael@amarulasolutions.com, neil.armstrong@linaro.org,
 jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, dianders@chromium.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Michail Tatas <michail.tatas@gmail.com>
Subject: [PATCH v3 1/3] drm/panel: ilitek-ili9805: Use _multi variants
Date: Tue, 21 Jul 2026 20:27:13 +0300
Message-ID: <20260721172715.602196-2-michail.tatas@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721172715.602196-1-michail.tatas@gmail.com>
References: <20260721172715.602196-1-michail.tatas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Jul 2026 22:11:24 +0000
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

