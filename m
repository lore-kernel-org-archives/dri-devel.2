Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021EDCD5BAB
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 21:53:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55E4210E56D;
	Thu, 21 May 2026 21:53:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Tr6jXYuj";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8B5610E56D
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 21:53:21 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso86196835e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 14:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779400400; x=1780005200; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sgy9hoPiLGulm4GsLO/GlLiuzebvz4yl3gcJM2iXtwo=;
 b=Tr6jXYuj9pAAtOsFJh45CVVcantlSQwOd4pZ7Ms+PUI88c90LtxxVVuC4ZAc1JWKo1
 fy/PN/XRkWjv8tWO9+R/+KIdJ5XAhnYVMgtoJ7YEZvrx/IuT3WDA2gQgfLm/ft2Lc2Oi
 wjkjiI7x7A4js1kilRpR77DaRmKB0xZa975z8XLSa5oL4Su77wQak2lFaes434GJAqMN
 dw9qDSNUirQZxlX4mNhsyyPF2UG7pZGZxQL3p/+Xcltq7WXQb99DCy8YzG9g7hALlDDy
 LgbT1soE+EuHuMtsl9q9h5+4niB/XUyz6aO1etL3n05OXI5JOaG477WyQhKQEjuRSq4O
 6NDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779400400; x=1780005200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Sgy9hoPiLGulm4GsLO/GlLiuzebvz4yl3gcJM2iXtwo=;
 b=S9/etA2ojTpPoZMr1EHB6hgG4pJcmv6mrojM9m+rS8xmfTA7icNiAVe0f7FPmRcenn
 JC1Oc7y/vKbNiuDJQRvQXD7QLGz5xGubozy37unMaV3qdpUgb7n3nVWPRHRdKGK1Un2x
 7UQGQJRF09jEapu1Rk61s5KPJ4zEbQ9+hS57W3hY8H22mB2iHMpsz3vBuHMTFzdHVtyN
 zlPklgPsiHqlz5pMgbkLsTph/Bd9fJiJ2Etihof5ZiN9jXde8O1Gj1/eCc/dNoyjuB9H
 ksRWAlPUjz1KBTSNdUB0JtjoLkw4kviqv1sd4dvOMg2UGd+dX14SGIqsIzHbOSOSQ3cC
 oVgw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9UTWxndtjgiitSmP/L0tBRrA64kmwPFqEiX+JOLnO5L1bXwxr0fyQ3WdtkfsRzKl2f4Jz7jspqyKQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzAGhRlbSfxA8ONYZONrFwfuHJjFZqyiBxzkgbRpp6k/usN9YGH
 3fxopdPJZMPAqEFofdiJWj+/ZQY8oHmM6k/cIybwE+RQQCbKjM/rpK6t
X-Gm-Gg: Acq92OEqThNEkgZTeR3DeSdW9klnYAPmZ4xrHx4nYq/S+Y8E+iWzp03ifR6AWtYJspq
 Zm3Vxvf/wu34CW/Q41yrjaAPgWOuPj8cYHlRvijtCaAgS5JUWBjDteFgJUZWdY6BMBfRVdCzXaV
 QkJiH1L3W8xzRfrSyWdPMzchnRrE7EujEtgcEJViQqBV9ldNznCAQtuooRws1s2/j3fex9+JsOm
 WQ7DqCQ/O7oP10LRE84b/I1UH5ph1GV3QDcvsjt8FNinuTjkmOu4zX6SCnTQzsD9SaD/t6NJj8X
 bO6UyjBEq1EQ5NgpAO5ovIgBgqMZKSMEQnzWjmXmyBEY6V/zOuO/YjJLdMvl+bo6P3I5nLcikP1
 iPydAC+WFGGKWzhAqRhYq1+L2rx+FD61RmNn38iolRvHNya+0QUnacbZnrN9TR0MWOVvypt6ELZ
 hDUN4VxslVU88vr7o0s9IFyEZPn4h1cpy/JBvjYY34CkRxI90dPXs6C+u7
X-Received: by 2002:a05:600c:4fc4:b0:488:ae6c:42c6 with SMTP id
 5b1f17b1804b1-490426aa52bmr6367315e9.14.1779400400266; 
 Thu, 21 May 2026 14:53:20 -0700 (PDT)
Received: from osama.. ([41.43.100.18]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb4ad03a6sm135136f8f.27.2026.05.21.14.53.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 14:53:19 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: luca.ceresoli@bootlin.com, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH 2/2] drm/bridge: tc358764: use devm for bridge registration
 and DSI attach
Date: Thu, 21 May 2026 23:52:27 +0200
Message-ID: <20260521215228.188615-2-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260521215228.188615-1-osama.abdelkader@gmail.com>
References: <20260521215228.188615-1-osama.abdelkader@gmail.com>
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

Replace manual drm_bridge_remove()/mipi_dsi_detach() in remove with
devm_drm_bridge_add() and devm_mipi_dsi_attach() in probe. Also check
the return value from bridge registration.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/bridge/tc358764.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358764.c b/drivers/gpu/drm/bridge/tc358764.c
index 084e9d898e22..ae652f2eef1b 100644
--- a/drivers/gpu/drm/bridge/tc358764.c
+++ b/drivers/gpu/drm/bridge/tc358764.c
@@ -372,25 +372,17 @@ static int tc358764_probe(struct mipi_dsi_device *dsi)
 	ctx->bridge.of_node = dev->of_node;
 	ctx->bridge.pre_enable_prev_first = true;
 
-	drm_bridge_add(&ctx->bridge);
+	ret = devm_drm_bridge_add(dev, &ctx->bridge);
+	if (ret < 0)
+		return ret;
 
-	ret = mipi_dsi_attach(dsi);
-	if (ret < 0) {
-		drm_bridge_remove(&ctx->bridge);
+	ret = devm_mipi_dsi_attach(dev, dsi);
+	if (ret < 0)
 		dev_err(dev, "failed to attach dsi\n");
-	}
 
 	return ret;
 }
 
-static void tc358764_remove(struct mipi_dsi_device *dsi)
-{
-	struct tc358764 *ctx = mipi_dsi_get_drvdata(dsi);
-
-	mipi_dsi_detach(dsi);
-	drm_bridge_remove(&ctx->bridge);
-}
-
 static const struct of_device_id tc358764_of_match[] = {
 	{ .compatible = "toshiba,tc358764" },
 	{ }
@@ -399,7 +391,6 @@ MODULE_DEVICE_TABLE(of, tc358764_of_match);
 
 static struct mipi_dsi_driver tc358764_driver = {
 	.probe = tc358764_probe,
-	.remove = tc358764_remove,
 	.driver = {
 		.name = "tc358764",
 		.of_match_table = tc358764_of_match,
-- 
2.43.0

