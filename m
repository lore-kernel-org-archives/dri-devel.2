Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540B1C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 08:10:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD4E410F6C5;
	Fri,  3 Jul 2026 08:10:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SXwnQSFO";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EA6510F6C5
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 08:10:26 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-4763b0c1dcdso298762f8f.2
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 01:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783066225; x=1783671025; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BgEZk0tfqjsFMjOWFQjsdTyTXUp3gCU0p3CTG/HdZ5o=;
 b=SXwnQSFOXpb8U67PHg23ZeCTIHAEgLVG6Fy+b3EiUc0zxfNof554kR4fxb6+byPPoc
 YdzoT0uoUSRA8I7dMAr4dQ+8GB+MLRI9LTAoB4QP2Pb48LKVTU60dAELHDeTtnwlxqGq
 qqVI5u+NpfReB8zc5y2F7R5J8DGktDyfA40Ftr0/m4zwUnmT90ZEZAQ5k4WgQdmw59sv
 bg4qlKAD90UvZi1sCtIQt5wgcRANo8yi4NTRRUrDkK8rfH+o9u8pzLbv3TmdURwoXE3H
 yQJWi/ZM+rAF/RIcjoK9g6dQlLVKBNk50pYP0E46qJ5TArgAKMM9j75Up+R3HLzEiPXt
 AMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783066225; x=1783671025;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BgEZk0tfqjsFMjOWFQjsdTyTXUp3gCU0p3CTG/HdZ5o=;
 b=SYWgT3lZNbxaktYaNX//TK6EtxhxZmgNJYiseJdVBfMAG3ZlDPZENq14y3A02o/wtS
 af5wrLrlxLws6MYex2XYVnvbnzB0TDkqcHRehrMaObkj9egsQFUXQIU35ntehB4j1Cg7
 YwS7fcD4AZDWZxICeg/zmmOOJqSE4zYAoE6kukswdD7IduK4MeDsPrrH++78JZTR5Qpu
 mJsPFth3MakhOlGDwmJgq4sWJpGvQTn798oqPHQoD+jVQgpgjKaFibkd6VAy4OFkDlqR
 t0pxhvMehSmvRlRPwKO+rFI7RThrcDFsTRIG+TZYGzdroxfqSDQ8XfDrhiFeO4Eag3zU
 8GVA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqRC0nOx9NZw+sOXIWSvFjPVCkaBrNQLg/uQFjPF3pc9DMe9LYr9Y30wwyBMEu1gsheNs3V/gboQ+U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxMsh5GKb8BXmzsChLoR2hpu0iafPnAl0OIF32gAyR0Jkc2LGgr
 PsRj4k9H5t5mZIaWW1VUYqpos2a8f/3FZzzFvu4d7ssBYkQ8NfemPUGKsVdjI264f/8=
X-Gm-Gg: AfdE7cmsoImJCxdSwp36En/nFuE0JYWHEeQDQvqZvT5SWtUC29dUUXxkE7zr8kKWjBM
 DNEg7ZFwWiYWx+LuM4vs3lFtG0H3CbesFoc2IM/neP/rlnDs+hdkHQPcIphr+CTxkOSYLR2pZaI
 B3mPymCGK4MGojU8f0qVPqCzEzphib1ClXqSwdwklbjQ5F99KAVTwMvfkYIouRGFXrz2DKT9iBH
 1yZHEoyX3NK8BDHwCUtVwDTvc6J1hx/FldKQ5eKd1N9AVjCH03GAuJLvcIpFv4et0Mk7Qbs/GJG
 4f65TntcwvCm39k8MV8AQv7/Eju55cmHNz6E15B9Yvw9+v8zfYaaaWpH4dpF+nvi0/RXk1L1ENi
 ZOWet4JhtrLlFqfNPB5WO+bW+Jr6rCNZDLQMYMZd8hAOXLSA8heVjYSzF5WTMmcqp7ToQHNI7du
 LrHfVHGl/lGO8N7S7qXBt17KHvCog=
X-Received: by 2002:adf:ea87:0:b0:472:8c12:b93a with SMTP id
 ffacd0b85a97d-477b5296cf6mr8758338f8f.28.1783066224462; 
 Fri, 03 Jul 2026 01:10:24 -0700 (PDT)
Received: from arrakeen-2.home ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db8a44d7sm14920012f8f.9.2026.07.03.01.10.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 01:10:24 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 03 Jul 2026 10:10:20 +0200
Subject: [PATCH v4 2/2] drm/panel: visionox-vtdr6130: switch to devm panel
 calls and drop remove
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-topic-sm8x50-vtdr6130-dsc-v4-2-9eff51ec717a@linaro.org>
References: <20260703-topic-sm8x50-vtdr6130-dsc-v4-0-9eff51ec717a@linaro.org>
In-Reply-To: <20260703-topic-sm8x50-vtdr6130-dsc-v4-0-9eff51ec717a@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Doug Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1850;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Yyz8hVRuE/i71NBx8+ByVi/xmrQ6crnI+5L7v14sBCQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqR25t+puVMYVgPh8aSCdBB6rtM+sw3nkkuNmv/kpu
 kbcI/nGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCakdubQAKCRB33NvayMhJ0WGxEA
 C2xG1iP6R2BDtrSwkYdjw1KkyFk2c3P7seAfoSeV3+huXSJUWyeTKbdbZ8k7XpZ6IyXrn6bWKWthmS
 GqA4fKQM0hufvCQJeFSqTZEjkYx5daqgLYbavvUYUmEsCDDgymFEVFdvW/kptmIiew/3r1w3tqYIP9
 SugPmDdtd+6GWKlL3NmNGJ6waGkTRl4eBGkRe9vB4ECHJpGR1CX7AeJ0zVe8a1GG/Akh8PQHWK8LBO
 ZrBmOmau4q0ptItQnvTFaIv9wDom5btSCvTFuJmdniNItbKAoXR6IPkWk6Ycj5770St4crUdCZ6eiO
 ed7h/flVOKrIt+vkuDnGxOvZAy5+7qMRBsVjYihCgdK32ACpcb5ItppjJEpWI7jWdelRk3ItQGnFum
 +FHx9CZVUFXhqOZaPghKXB+LLgsmIcBSTTUWzFx4+wTa4MOeDRqDVafA7U3Hpg9xkeBvZCfNGcN3El
 QPZa2vBSqpfiauaywcR8rAZH8iVPaAE/5BF7J8p5VFSQcX3Y8Ng3OvR8bhuqVLZ1WVM1jjaMtMDSE6
 pJzxoVymPmCIr8Gihm09jAQkF3OA1Zzqqutj56a+JsBD5vqpYdQhneyQrsqssipRNj8OcQ0sp6G5Se
 LocVsmzefRc6LAJHLyn1dPriCpsoBco0S8v2MVDe4vyfvS/6HTgIm3RB4/2A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Switch to devm_drm_panel_add() and devm_mipi_dsi_attach() and drop
the remove() callback.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/panel/panel-visionox-vtdr6130.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
index 0cdcdbbc766d..6733e0e1d061 100644
--- a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
+++ b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
@@ -298,28 +298,11 @@ static int visionox_vtdr6130_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(dev, PTR_ERR(ctx->panel.backlight),
 				     "Failed to create backlight\n");
 
-	drm_panel_add(&ctx->panel);
-
-	ret = mipi_dsi_attach(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
-		drm_panel_remove(&ctx->panel);
+	ret = devm_drm_panel_add(dev, &ctx->panel);
+	if (ret)
 		return ret;
-	}
-
-	return 0;
-}
-
-static void visionox_vtdr6130_remove(struct mipi_dsi_device *dsi)
-{
-	struct visionox_vtdr6130 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
 
-	drm_panel_remove(&ctx->panel);
+	return devm_mipi_dsi_attach(dev, dsi);
 }
 
 static const struct of_device_id visionox_vtdr6130_of_match[] = {
@@ -330,7 +313,6 @@ MODULE_DEVICE_TABLE(of, visionox_vtdr6130_of_match);
 
 static struct mipi_dsi_driver visionox_vtdr6130_driver = {
 	.probe = visionox_vtdr6130_probe,
-	.remove = visionox_vtdr6130_remove,
 	.driver = {
 		.name = "panel-visionox-vtdr6130",
 		.of_match_table = visionox_vtdr6130_of_match,

-- 
2.34.1

