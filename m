Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C99ACDE002
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 09:34:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CDB810F1E1;
	Thu, 25 Jun 2026 09:34:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WG1QC5FN";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 609F810F1E1
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 09:33:55 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-46cbf263113so1482585f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 02:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782380034; x=1782984834; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oX956Ovy0cEzFC2KbieHkOQE6+VfzcgweLx9ANa2s88=;
 b=WG1QC5FNtLy/P3mtLH86/1khAoqnsVQmQWDNLk/0ZrMU5QN6OEyG1Gf1O51MzOBgzl
 hSjOX5N749RPpiWHxFEK0TaTcylxTL91kXwMbAU0yndMJX5me5ugNXBPDwvZXOxNOvm8
 6K7x2gmaEdktrVMn5tCcTFTVAtHtqd9FnwxFDWH5uiR6xPZmJL2jAH7Yg1S09BU8YESM
 tIdLV19pknSL7e9s10tfwKs8tBO7nDb9mxGToLHZFTYdswo6J7awkV1341vr7FnaNzzg
 BljZNXmdqkz+Xczq+ecNkO3E5vlP/VSavic7os7wm3l4qc9E1pC2a+oyeIvP1fRvW9zZ
 CXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782380034; x=1782984834;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oX956Ovy0cEzFC2KbieHkOQE6+VfzcgweLx9ANa2s88=;
 b=VfcnTrv/hyPTi3FTHmpPt7C0KPFPh+1F7PTllKr8gU66Rzy49/r+DJdLUIzQ5aY4Pt
 kSofWb0LlliwOsLq2lONHUkDPTklvyuwfN8DNvkt2yED2MIqMxlpb8VRMsVZcJMTu+te
 u+h2X4pcJcMlG6WtGhI/OqFVJ6nnqwV8AjH4l8ePXQJTiutmUcQVE6sQKbnGiYMWSd9u
 Z5LCB24S9mKVdJHf75VpeRZjYzZcAvTUfUHTvXQTkkYBpQdX1L/x1Ixfv/6IYqQ6YVaz
 vqzPWhqjxI0VvDDt27tz8P8XO/2qrjDUDFbiEOHZP0HpAMUAEpGXeEclw4/6anDt3vby
 NB5w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/2lFk3paFoxK80ABlGnATgXC72gLICk9SziTZ4HJZIMooukaBU3+ux29PuUzH6FAwqM8glOPESQlk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxPFZzJXNqwo2Zm7lOy7eb93+z11PgdVhbevK4t9t93bZERQVhS
 GYncs4KjEQNLQOlAokWbJCPYrS0xevUdFbN62y3xaDjdQVhzKbxzt72NEdekCSzuQAs=
X-Gm-Gg: AfdE7cn0Z8zsFp8y7Nd0wv7yjHgoqmLab5QSKVgKnh8fp3fCa/ilcpuni1Vdvzwcm2d
 IAijUISH5muzSbsdEUdt0HR9Ktk83BsHgc+s4I0d+qEN8/wNsrI4drY14XF7iXWSDtML1SI1HD7
 KIZrfhFYBpoa8aGNxJc5uzC3gHLI8nsWs8kBeseV2vBzkUAahEE3YFUJAxFob4UO8mk+bTooqyg
 h12l+R58MI36cY86NM2oB7vk5jc2ftys2EVfufH7M8aDbr8j1umoLvrbTpRvAuKS3W2Zm4X1Jz/
 pTp8p8twe53Ck6fByD3xalLqlTEaXkRJVh9Ac91Ol8S7kCoVnafmDUL76Im+f/kyqsmANbz0/8s
 VEAWZ488pNOnwGwr0I47BTck6wLVCYF2s0gsize/EQm3Vruc++GTBVRQx3btYoVgnRZjjRw2bFj
 aB9ebpZKTOCzF4ys+z6WuIe8DyNbSocFERZ3NYlNodYRGA
X-Received: by 2002:a05:600c:3b24:b0:492:3fcb:22fe with SMTP id
 5b1f17b1804b1-492668551dbmr24085265e9.1.1782380033508; 
 Thu, 25 Jun 2026 02:33:53 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492660a32ddsm40154745e9.1.2026.06.25.02.33.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 02:33:53 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 25 Jun 2026 11:33:49 +0200
Subject: [PATCH v2 2/2] drm/panel: visionox-vtdr6130: switch to devm panel
 calls and drop remove
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-topic-sm8x50-vtdr6130-dsc-v2-2-cd375ef0e0ce@linaro.org>
References: <20260625-topic-sm8x50-vtdr6130-dsc-v2-0-cd375ef0e0ce@linaro.org>
In-Reply-To: <20260625-topic-sm8x50-vtdr6130-dsc-v2-0-cd375ef0e0ce@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Doug Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1783;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=f5/dVqkaXjhX6dtp61tSmUjJiQd2J/ejrflXA7Mzdjg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqPPX+4aHjc5CmtFTizCjgBxTKEob1ERvbC85IMHIR
 Ho9pT1GJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCajz1/gAKCRB33NvayMhJ0WWIEA
 C2I/K4cJOYNlTJAoydIMSupmXrYbACAnfJSnPE+mAZTP6xwzzZjhEckIrF0Ng9aFo5Lz3S5ZXsRwYp
 wLunhJs/yDYOIgRtS3I6uTtNKMKb1X2DrQPOq8SwAUYXS5jNzfMV6Aukcxe714oOkXsWbHYM4Lh8tY
 Uv18is9Lnm2ycCicd47KMKwQZHlQ5UtkTJ3pyDBB4MIPJN0eBnQFyB3SdoAhGuQ7MDEpdH7tDkBVbP
 5RXxU97wRI5kfH/BcWpS7BR/If+oNuD1+9wbz6Ge+SD94mJql+2y7rvE2m8+RoAkZne8HYVQ5lrZut
 dVq3Nefi0RACJMZ+7n2w94B1jn8lCNtGgmqW5TigUW9ovVv7wnwdzECAlUX4O9DKEpli+ggkCg3zJq
 sVw9/UEhn7B68y2G3o2N7VD3Q0o7DgJKnZ7SI+KeJ42RmXa4g8y5faMHZELEANBW+cmMMKIa82+HJH
 lbq8hrcM1UxrR9aIeAqJKxPj6zTMQ8mxuPRAK5+JK4kg7JGX2oZ0o3sOgpKxU4UObTxZh0odfJWdAk
 0E+/OvG53z1NEGFwlCickOiZ4ocEm+tLidYw1HzLv8biBTzVY4JX6gKpXPWhgvi7m269hA6lB5M6l8
 8es6hztZv92h0Vl8aXpaczH8UB/S/iQekCu7+tpkOMN60gx3EmneIUgjz6Ng==
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

