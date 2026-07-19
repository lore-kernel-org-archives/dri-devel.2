Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA52C44528
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:16:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7D8710E799;
	Mon, 20 Jul 2026 07:15:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SMkPkUWl";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BDAF10E0A1
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 19:04:12 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4954f5e8020so6304875e9.2
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 12:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784487850; x=1785092650; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V3aUgsK7ZdEPJKADCztW4zoldQTcCtsuXC+DLpNgKn4=;
 b=SMkPkUWl8ZajQJLrOtEb2rRjhz8BB8j6A2sEvifdLrVJ+LC8f0MBadOriqVTR3r13n
 NaFVvzgWgrk/MiES5MpsOB/aCb8oiphIIQyXHJcHe/vAYWM6kq0I7g5hkJrXDb4q6Wfl
 /wyNcXbfBjGcT1b1yxPlFQ6jaIXMEBZeohCtS75wnOnhUKDiVwGt7eFzTyFCy7upr2bL
 emgfYJAc9iQq2bhOGA0kVV9K4y1jJgrB5y5zYesMAPsmfd2GGfwzHiaAKCCsibduWKUi
 OhYAUJdEZPnFXN8sOk/AwLQoi4q5mkxuue7wmE7DLMYP/bBaP0BProMv4iXR/vhxfMhT
 MNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784487850; x=1785092650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=V3aUgsK7ZdEPJKADCztW4zoldQTcCtsuXC+DLpNgKn4=;
 b=UTPA/ku8AYa5XHtl/cQftXJCr8OTnRzbvqQVR/37seFZAxAhjdlc1tHU10hCGPrICQ
 24lTZnUDIKVfUXG/oUZsuVg6x+w8zrDv+EjXx8KZgr4X/wRevoVAY5IV9LsD4LUkHFnN
 AGTiSuMc70OLjPDwjfNqauAHIJyVUkC7G9X9W877DJq7976wmoQ6XgGeigQLMAQgoGSA
 7jAila01l59dL1Une+pjNSRmJIHLxpGdBcAA87aR2eA1vdsCPbZb5rBBRaR+lFiPjLXw
 dCvCUUchkMVrHFn2I6RxRsDNCK1ScTh5lIUodKo7kJ55NbSg0nLX9YLFjfIchAjtkHBm
 zdfg==
X-Gm-Message-State: AOJu0YyHprLfSXG58o08fn3pjf9O8UkI5TL8fxY2+7fGMeYE/Kyhk+rP
 O7xjMAYVLoiBOgSig1z2BYvK2tatAn058Y82U2E/m9JmIATr5/nsaTYU
X-Gm-Gg: AfdE7clPlSlr6Kc+LZUTXCAjeR//g0y8vBe7knJYI6nRYZye/3i3mHa5kWtm1VnpQPm
 4pAgwLgI+wNQClMBNPkn17RAV5yaEZUKrKZjNFiigk2IR9hxpwVcfU5qVoQJveVHt71lbYWp4UT
 3jMfCu4tfzkB63I2kpoLJdfj8VSzLW7xyMEa2uaAQsfRooBBRwLmzMZl73Ta0A7KvShBSbpZQbW
 f72D7EFZhDYlZc/sAE6Kt3mCNkD4eJ+l8dV0v4uY2GPpCEyZ7OAgeu9y9yEJlqw97GWAuCV5BOu
 uYo69nBWbT/kV7lm1tOefKTzzFc/0Q43p+cyZEfis+92aQNjWxlzq5UFvXF14R10aepfQ0kdqyX
 jtkK7AM97bZtbqWfC8gNwZvPZ29Q+uEt0taln8YCt/pzIWSNDCW0gDymNj2+1iEJwrlnE5ucsJK
 LWOEPLrb45QcauzT/6dOtb4sFQcIP7JlLQ1tlucg==
X-Received: by 2002:a05:600c:c1d7:20b0:493:f6f0:d61e with SMTP id
 5b1f17b1804b1-4954a4135c7mr95842725e9.37.1784487850543; 
 Sun, 19 Jul 2026 12:04:10 -0700 (PDT)
Received: from michalis-linux (adsl-75.176.58.251.tellas.gr. [176.58.251.75])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954c841a0dsm181991045e9.5.2026.07.19.12.04.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 12:04:10 -0700 (PDT)
From: Michail Tatas <michail.tatas@gmail.com>
To: michael@amarulasolutions.com, neil.armstrong@linaro.org,
 jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, dianders@chromium.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Michail Tatas <michail.tatas@gmail.com>
Subject: [PATCH v2 3/3] drm/panel: ilitek-ili9805: make cleanup funcs void
Date: Sun, 19 Jul 2026 22:03:57 +0300
Message-ID: <20260719190358.438699-4-michail.tatas@gmail.com>
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

Make cleanup functions return void since no one is checking
their return values

Signed-off-by: Michail Tatas <michail.tatas@gmail.com>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9805.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
index a70b9512746a..64cfaf981e9f 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
@@ -148,13 +148,11 @@ static int ili9805_power_on(struct ili9805 *ctx)
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
@@ -188,15 +186,13 @@ static int ili9805_prepare(struct drm_panel *panel)
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

