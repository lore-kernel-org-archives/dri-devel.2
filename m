Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77ACFC44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:15:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87D3B10E6DD;
	Mon, 20 Jul 2026 07:15:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LmqSYfnT";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82EC910E0A1
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 19:04:06 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-495437bb891so22995785e9.1
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 12:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784487845; x=1785092645; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bDZJF2FHgZ0pc0vw2vaEItundHS+IICtSs7RbOX6+08=;
 b=LmqSYfnTryHwNKEMELYqXK8IPHZSSLmHLSH7kBjZ5QTb9E92pe/8rqW0C20POd+7zA
 PW3gEs9Z4jRRSWyHY6sEBSxYYRh977ls7mr7hRwlH7JcoDuJ/vRZVFGqGp5FFW1fildO
 uy1JUCSbBdgWL1xCrjOlK3bKwMXfsVR1iZQe7EA5w/BWS9S8RtB8Vu13RSqd9+Cv9CkF
 m3k0c6apH+6cNSzC338bchoPlJkDZcTg8PX8EjyK9wvWhfnqcBA0KjhGVLjoawe3gk+c
 NIl9u0OP388Z0nUOuS4J37INkdMB2new1qI8my3asUDpLy9LH39iUyRIncxlG6S5qWk5
 WnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784487845; x=1785092645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bDZJF2FHgZ0pc0vw2vaEItundHS+IICtSs7RbOX6+08=;
 b=NbqOpP+ddQ4m7LadwDR3y+bVY6eJlMhvEgKrd8ZDbR6BsggxY774wsKsmuZfX0CwX6
 3mIh/ThAZbJ2WKBbqp0kCouCvqtZJe1O8K/VgG1IUy2yQru7n1hZYmEZk7nQWGmmJ9zF
 gSKpcz5YVB1pUPNJ/lJCfwIsiCs0gQd4WYrZQJYR+aZ7jvWmFxqZNntHnBKAmRcyeoqv
 atPsHZYqi94JyWop0Lv2lSshNp4RapDP8G09fq4+wUiE/2Q2NxTLMFLWzOStoT+1mztY
 EdCq5heWtQyjKee+Qt0rOzThaY7tTQl+I1J0v0gTKmaXq9lHgQErbSYTmGChEtgX634+
 elbQ==
X-Gm-Message-State: AOJu0YzeHLjQjpwPXNiiDuzONkOjC1HC9CFkQ0hm1J3mbmoN45GDPXrm
 dpfCfN2HptVvThlSBuRGIFaOV0I1rLQVQXk7TMIUmi1WDTh+kMrdS6i1
X-Gm-Gg: AfdE7cnW9+SdJkQ7St8qIhgNqPT9TnCaUEONZ19SaX2sd9eme2vzKtkZKobyas/JHIa
 URbu5QtFXcbJjP8gnKHvZ1Ipjk2YrehNvghX6pMSCIE8khEnVKtnwgHmSE6uALYzfdg2Rkjmjod
 7YV/4f3y6yFGhXwHyybVzHens7IIMZQsbP+U+h6w+VRObJleHJOBQ6LyshXVkB9QtJ7BhlVnOdH
 KO/joqRd0t7djycaEd5RHd+k/mXKXEofjxakPKq2lzyy/h70LFe/LlXI2RXzG07dZMQ5fFbJWPn
 GchaU8H41oy+q5aItQ2FIwxDAXnOc5+DhUX2Zi4E1gksFpMlcPbcHxY5v7i9k5kQlQZno0MwTJj
 NqA0ZSp5IejWnKZ1s+2EUvm4wm7lAqtP8eOsXtUkvBDNZbJN6nAkWl5UwXUkajVCOmarY8oYkxr
 /Fhbd1ZtXbNP937Rpt97OMv0e0Zol2u/1bux85zA==
X-Received: by 2002:a05:600c:3b88:b0:495:495f:bc30 with SMTP id
 5b1f17b1804b1-4954a3391femr121619125e9.12.1784487844829; 
 Sun, 19 Jul 2026 12:04:04 -0700 (PDT)
Received: from michalis-linux (adsl-75.176.58.251.tellas.gr. [176.58.251.75])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954a2a2504sm241425285e9.2.2026.07.19.12.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 12:04:04 -0700 (PDT)
From: Michail Tatas <michail.tatas@gmail.com>
To: michael@amarulasolutions.com, neil.armstrong@linaro.org,
 jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, dianders@chromium.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Michail Tatas <michail.tatas@gmail.com>
Subject: [PATCH v2 1/3] drm/panel: ilitek-ili9805: Use _multi variants
Date: Sun, 19 Jul 2026 22:03:55 +0300
Message-ID: <20260719190358.438699-2-michail.tatas@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260719190358.438699-1-michail.tatas@gmail.com>
References: <20260719190358.438699-1-michail.tatas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 20 Jul 2026 07:15:03 +0000
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

