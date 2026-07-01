Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D19C5C43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:58:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAEAE10EFE0;
	Wed,  1 Jul 2026 12:57:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HeiKKlkd";
	dkim-atps=neutral
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE6C710EF9D
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:56:32 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-30bf8b2bd20so1150705eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 05:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782910592; x=1783515392; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mYJA6PpUkT+r3Z/CP3V9ISI0QPawCrDu4twxjtK9E90=;
 b=HeiKKlkdtnGIMTAg8mKr+pjTz6dZMwIabCue6odeCL4S7u0MhsyYt17taQeBig6Pwd
 +0uf2pyMirNicScw1Mc/2JFmlnHnT9dC7QNtWgCLfd6y0USakD7oNLO3Vm0+XX0VOz8R
 tsyY10fgf9ftQbog34c+YlZOnnDAiz76X97YbB4YJ37UKxncDiXwZpTTxi/cdcnUTecC
 cGN2w1tMAGA4nooHUNddyqjAcN9He1Nxpje2ildKNWRZNvthivlSaHWVECNLHvkTyqji
 5TnjMh3H4rrD5EIvCJp3Qh29VL9nJWa+bO2Cf68oY1S9PFfaTQB91PwZQq5Lk/BCYd6P
 S3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782910592; x=1783515392;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mYJA6PpUkT+r3Z/CP3V9ISI0QPawCrDu4twxjtK9E90=;
 b=eoqThUiwg4gnqG1D9beP5/muo3AxfMZAZRWCDNWZY4KOEFJyNlCY3V3Ex9ynwlC0Em
 GppluQHT/1crQHDDNg7zNcAoNXJd0TL0PGKOD3M49fD2sT6Bldu6qLHcQwFncEy2pRoU
 DtcqJpm1WBM4vPcjpB/jPfAqdNJaxZh+Wcvoy67iY06t7Z7ZQvbqL02NlQwR8Wl6+nzd
 0ktK9+ggIUIUUXtPHCT8uCBW5N1A8sYQ8AR62aJy7HzjHiSdWjQmqUoVFe7bP5VAuoA4
 PADx4A7PflDwjnFppq01l+MPi7qQco+5bXiH+z9OWnP/Hv2yFQ6CARoJrUji8JFBUBUJ
 nbTQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr217sCmnWX2C+I1kTEDu/JfGPmjkqqlltQdBsfoWZTFhvg3NqScMMOy3u3PG4dLzESMHtrE4n1jqM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzbK3+CeMm1wzF6C8ElnifYXik3EjF2s9g1CJvojFiNVmt3fj/8
 G2ON6vKMiphn/hOECKrsyWL+T5t5ug06asuswuP8B5sbaL3fOiE+an4=
X-Gm-Gg: AfdE7clQy0VOONg9GAWMtHwecS6l5JS0nl5qIe+S9vT8QrUyANtuiVydNuADGVG/Quv
 yWzEmbTuQ0/FoBNmhQhKPf9NoXi+rmkkKqAGPYrV6zQTV8i/QqQa30PRka0GgTGZ4CNTEoQtM38
 /PhdivE8RxGUwCtAhqLohhV908zB9LwlErU5hsXU4Y/wyjOE5YOYHFmLxYiXK+0uf6Wbvj1JVvU
 GL8ASiUocW9tuzjUmJeClrn44XefmbxGn7hmGEYLHUFXNzJJW2GB9tcn7X9rZW59HTjArF0D5Kp
 o9EknhMgEDjH1h3+Db8jWzD7FIaYXt1hFqOwBqGus9bPIV2nfee6o1IOMsiCahMhQPI1Zqo+A0Y
 +TvuGNdmh7ExO1EAQoM920b9DjZyqkJVHhfvaYe0ZD7CAb/oU92/r6wFxG3mQQBznwgwLI4I9vG
 Cg+GxIixFH/WJUM1ETSXk/UjKrACKWOmGpDvNWgOa8mKRDphv4pQn7ybzwd6r7Ybg+
X-Received: by 2002:a05:7300:2307:b0:2ea:3370:6e51 with SMTP id
 5a478bee46e88-30eff0524cfmr1743055eec.4.1782910592041; 
 Wed, 01 Jul 2026 05:56:32 -0700 (PDT)
Received: from localhost.localdomain ([186.158.238.108])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30efaadc5bfsm7411392eec.28.2026.07.01.05.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 05:56:31 -0700 (PDT)
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
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] drm/panel: novatek-nt37801: Use mipi_dsi_*_multi() functions
Date: Wed,  1 Jul 2026 09:56:06 -0300
Message-ID: <20260701125624.199786-1-nico.antinori.7@gmail.com>
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
Note: I Compile-tested this patch since I don't own the panel to test it.

 drivers/gpu/drm/panel/panel-novatek-nt37801.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt37801.c b/drivers/gpu/drm/panel/panel-novatek-nt37801.c
index d6a37d7e0cc6..daa356bbc182 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt37801.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt37801.c
@@ -128,7 +128,8 @@ static int novatek_nt37801_off(struct novatek_nt37801 *ctx)
 static int novatek_nt37801_prepare(struct drm_panel *panel)
 {
 	struct novatek_nt37801 *ctx = to_novatek_nt37801(panel);
-	struct device *dev = &ctx->dsi->dev;
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 	struct drm_dsc_picture_parameter_set pps;
 	int ret;

@@ -145,15 +146,10 @@ static int novatek_nt37801_prepare(struct drm_panel *panel)

 	drm_dsc_pps_payload_pack(&pps, &ctx->dsc);

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

