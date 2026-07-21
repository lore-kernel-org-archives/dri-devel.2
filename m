Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D00DC4452D
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 22:11:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D3E710E136;
	Tue, 21 Jul 2026 22:11:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NAxpsbmo";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E09010E391
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 17:27:28 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-49548aebcd8so29984815e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 10:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784654847; x=1785259647; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JLzCAfsGEIgUcEbUqrqY0ww6cKzEJHPvtWy4z538qTk=;
 b=NAxpsbmod1yss2mwscnpbEt3o+G5+fvhNict4zdC9vTUFe7Idk5LUtK653mVTSfnda
 Am36D1nOEO7GobGHjz2nHHAKp2L7/IIDzX3p6HyFfDlRgFOTnJJg0pyn+9ofBisK5g/t
 +AtIz+X4xyNZsifuIgwes7IzJNQICMbldU8bb8nWPFBOoc2bm+UO9WWDk723aX/CB9HJ
 IL0gYTbMVprSqWOT5D5CByKdgXfdmedqfh4I5IDi4Roq7Hq702/pRFRkf6O6fiNCkc1M
 KDyluq69ZV2BWJiZ8SHgKsaMwjmka2o8WTOJDoo4K12RDSONt5j/4qMlpU+Y+G3j+7IH
 cgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784654847; x=1785259647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JLzCAfsGEIgUcEbUqrqY0ww6cKzEJHPvtWy4z538qTk=;
 b=MleNiFfO+/32hCQH9F/ZOYDolhalr9Knj1TEWKX7q1fgtJTOmcESSwJOL/+maci8C6
 bZCJ67aAkOyFV49ihs4bKcjx4+HJ6M5TJtlVGRBwbWe942UyKHVZEH+NDyNILrYbkNBZ
 Ubytvhwu97ufQBr0bAm2/lWJYKo1knVmLI8v8sdQlNTeWDhJs35YJ4uBBk1nvTsZs+7h
 tCfaO36Hyk7V78avJCzBMrD167C9u1YyQ9PQwzHFANTuWI34BA/RIkOcHCQFytfah9+t
 Stg5d1EuZB3MQM4QJj0njv4OwrVUL8PmKopqAgd/6cm6vCluYgP+McOQxSMoSqlxwr1z
 /dGg==
X-Gm-Message-State: AOJu0Yw8454rBmePv6o000pMJQVVIM40DmeAzqo0BWse//R4HnlE3A9p
 nmaCX7bL4a3OfQHrOd/4hQ1uWsSau7Tu19qbKmvmg79C0T1gVI/og7WR
X-Gm-Gg: AfdE7cnxnevoEXyZuvVFB30LGwmB76vWeuwsl6yCR5SpFMSanJYbwuh3znQEk3YaTWv
 If78zWTRpXWIXmHX1uaznpqzTWUUlDGWQV0nLR71xQ5fTFJBmrcItJOK2pZ8dgNJghL53lbng88
 kfY9HDseJU8qIvEGIzvMzQaTLymUCt8MBd7VflTyMhOQPasy9rgq6JNgX43sbzC+e64f0IjNjzL
 KMsAT38KB2wYa3QEYXKcZwDvoql7GvlsBUsSIfREGx2+5A4wj6rqELwi8Di/k8nEW1TI15+jsEz
 oNYzJfnjnN/7xu5YPoYi9Y7LTas+DL6cOkM2xKnJATx7/S7PqfnbMhgHULBp9rZ4Dn0sdjqe8S8
 k5d9r762KHlYU8zrBjYqoo+VG7FfW3TeYvM5VCu1+n4q0DQUZ8exeVXvP3+zYRfkacTW5WRoiz4
 qiLhrAAYph3NOK9hBTh2OSt+UF2sWSZeAVxT8SCLPZ8A3Cuo/t
X-Received: by 2002:a05:600c:3112:b0:495:472c:208d with SMTP id
 5b1f17b1804b1-4954a41307cmr206826185e9.38.1784654846553; 
 Tue, 21 Jul 2026 10:27:26 -0700 (PDT)
Received: from michalis-linux (adsl-75.176.58.251.tellas.gr. [176.58.251.75])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e49500sm43027137f8f.2.2026.07.21.10.27.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 10:27:26 -0700 (PDT)
From: Michail Tatas <michail.tatas@gmail.com>
To: michael@amarulasolutions.com, neil.armstrong@linaro.org,
 jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, dianders@chromium.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Michail Tatas <michail.tatas@gmail.com>
Subject: [PATCH v3 3/3] drm/panel: ilitek-ili9805: make cleanup funcs void
Date: Tue, 21 Jul 2026 20:27:15 +0300
Message-ID: <20260721172715.602196-4-michail.tatas@gmail.com>
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

Make cleanup functions return void since no one is checking
their return values

Signed-off-by: Michail Tatas <michail.tatas@gmail.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9805.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
index 909661f67d26..a8d501be3e9b 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
@@ -150,13 +150,11 @@ static int ili9805_power_on(struct ili9805 *ctx)
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
@@ -190,15 +188,13 @@ static int ili9805_prepare(struct drm_panel *panel)
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

