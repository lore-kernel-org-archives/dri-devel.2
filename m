Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6F9C531CC
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 20:36:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8462610F1FB;
	Thu, 23 Jul 2026 20:36:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ilv+EGUO";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53F1B10F1FF
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 20:36:14 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49553515a8bso11337815e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 13:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784838973; x=1785443773; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DwNxvM9CJK8bMuUmsIAvG3AvDYoIwDFf/21jduK2/+U=;
 b=ilv+EGUOQMu5Y1rW+53CC4Q0V/WuOkzuqWMwqgYXYU3G4yOwZhWVtsSnCliLqPmYQG
 rgrQj9Q0iMRORJ9P3KuCOX46GY1qn1aToiK8BKsm0HhNicLhzRzkDj6BVT4LfbD6Mq28
 THbWnz578/SZjUZIOKztW5ZpqGWZOMiZW930bab/ivkV7UJLX30wS+Bv4rsNeA9RhXvW
 zVkWu0anYAhhApYTKQPW9e3o4oyD+6DsA2gN7+32jKJcufKkDpXb1YxsxORy9efqOZWA
 wbJl3qipJ/QNJumkIEXdPeIUx79t8VaV5n3CvjRzy6udYURgv55e5psoEL+neui3Jb67
 H0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784838973; x=1785443773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DwNxvM9CJK8bMuUmsIAvG3AvDYoIwDFf/21jduK2/+U=;
 b=R0XNd4xtOsAEvaQu47PugtZ5BkuW84rPm+kuYkx4w8Z5dB4xe2YXgo8dy82iqrSsge
 kccZlwjxHHVRQcpNOnR7bkAtF4TEgnkPphUBq478qBtQ+W9K8QxDO1fHQFKfU3lNkwgr
 8en7jqceiYmDHfTKmtUErvKWJnx7XO4bYwN2Lyf3B1DbSEaoPHCyMeVZ9+fBh95bgpXW
 kuLMGmrYYAI80zPgGG8Y3g6pzHBmEZhKtSDceX1tYBCinQ9S9nlPH13+Z2e4rn9E9OKN
 2acYy2xxb90vNx6q75fJYiJhC7/zTvCOydOlXj86LAeyPLxXbuqpwiyht8qZG4IN8Ecj
 JgRQ==
X-Gm-Message-State: AOJu0YzghWzKvOCPWjOm2UTvPgAfQbYQaWyocOYYSqv48VVIsQlNIhm3
 XEWEKRleTLrMFoCuJ1k34B12SCrqqe8W17VnX5+mAA56q20YT5f1wxlO
X-Gm-Gg: AR+sD12BFbBQqAU+oiC3sIzzH5sfJHCvrUuIIg9QQrKC4qZZadLVmzGzNSdZlE1Mm1t
 6XH1/CMRjGFsv42vKMuSxQCZYP4y0RzDf8MQpN4REM7sp76pOrx9PtdRq5LbkAvJXQ/8EwK0dod
 +RzxUH6wCPyk8Ci4JIcIaQ4x3e/t9Jz7VUQTfGxW9FW3NNTCPWaN31yqlcIIZjOerPs+M4HoSse
 Y86s0meD4E580yPLeMN84xtsEE8z4NtprlA2lBaTdO80gVdK2LkfOMtR0qh2j8jaEzKp4QIwAGB
 U0f0rAGSgsYg7FYHCn+eFGmtHU7UkPp3/ulRStwAh+wVavODBczGwUeAVxpvGr9YaQo5JCb+Ucc
 4OpX2ASGnFQkZA6J3AYb4RMDdveJWJrDpthiiIL+8CGUtJGHWg7nFOkLBqOQwxLnoEo8xsBQunG
 7OGaOyPR1e06QYXDPAPrOcrhClUWmYkrXr1I8l6Q==
X-Received: by 2002:a05:600c:474e:b0:493:ee2b:c876 with SMTP id
 5b1f17b1804b1-49573d22ee7mr63027595e9.35.1784838972675; 
 Thu, 23 Jul 2026 13:36:12 -0700 (PDT)
Received: from michalis-linux (adsl-75.176.58.251.tellas.gr. [176.58.251.75])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f96d4656bsm158653f8f.21.2026.07.23.13.36.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 13:36:12 -0700 (PDT)
From: Michail Tatas <michail.tatas@gmail.com>
To: michael@amarulasolutions.com, neil.armstrong@linaro.org,
 jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, dianders@chromium.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Michail Tatas <michail.tatas@gmail.com>
Subject: [PATCH v4 3/3] drm/panel: ilitek-ili9805: make cleanup funcs void
Date: Thu, 23 Jul 2026 23:36:01 +0300
Message-ID: <20260723203601.806697-4-michail.tatas@gmail.com>
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

Make cleanup functions return void since no one is checking
their return values

Signed-off-by: Michail Tatas <michail.tatas@gmail.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9805.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
index 1339604a0c94..5610a225f77b 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
@@ -149,13 +149,11 @@ static int ili9805_power_on(struct ili9805 *ctx)
 	return 0;
 }
 
-static int ili9805_power_off(struct ili9805 *ctx)
+static void ili9805_power_off(struct ili9805 *ctx)
 {
 	gpiod_set_value(ctx->reset_gpio, 0);
 	regulator_disable(ctx->dvdd);
 	regulator_disable(ctx->avdd);
-
-	return 0;
 }
 
 static int ili9805_activate(struct ili9805 *ctx)
@@ -189,15 +187,13 @@ static int ili9805_prepare(struct drm_panel *panel)
 	return 0;
 }
 
-static int ili9805_deactivate(struct ili9805 *ctx)
+static void ili9805_deactivate(struct ili9805 *ctx)
 {
 	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
 
 	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
 	mipi_dsi_usleep_range(&dsi_ctx, 5000, 10000);
 	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
-
-	return dsi_ctx.accum_err;
 }
 
 static int ili9805_unprepare(struct drm_panel *panel)
-- 
2.43.0

