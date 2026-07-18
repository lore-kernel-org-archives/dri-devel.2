Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B07C4450A
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 23:36:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8581210E577;
	Sat, 18 Jul 2026 23:36:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AI57KZ6g";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C30DE10E577
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 23:36:10 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4954d383e64so7921115e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 16:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784417769; x=1785022569; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3FjNP86ptWMOuru/pKfvMOeLrB2j6SXLcAuojoL3wm4=;
 b=AI57KZ6gHUeiiL1+kJj2/P0ZKRYQA/ygx1lIsZRnO1HpNZqorYengfhm0EB6A+oR47
 DE5gQwrMyrxi6pIJRNiqET2GXl1dfIYGK4kgcjX0CybE7ESiivsTlTN7lgfYQWVldIJF
 hiawXbtJj3PMEMqlj5J09Shy2etz5eTSf5X6ZdOR83zij7/bJ5KXoaPnGyznmp26orgs
 D3ThWsvdXegcoWzJExIWpybcVZuajGa7yA9MafSS7Oy9TjvRUWNrl432YRg2XBdB2lYp
 ufry3N7SEvCS7pvlRG7xQmE+ediP3R0I1Pn9DGb9r5RtIDQMRowoxQ21b7EywHAn4UTe
 hPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784417769; x=1785022569;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3FjNP86ptWMOuru/pKfvMOeLrB2j6SXLcAuojoL3wm4=;
 b=ODG6Q8Z6D18e6d9CVJe7iM5wfwC/51TzDcdPHss9/a0I19Mt+iYKwNC19ooPLEn5cS
 56XpzEnE74ULDhzwcZpkBw38QaxHexkbabooLgbfhf0VYYXwvQZosmyw0t4gh3YUOOR2
 ocN2rCItXi17cC4qIaw9uDu4PR5E01hS7q0cQE/85Ngc3n4u88StLJ77DrW9+qqyixKQ
 TmzkTR3JREUkXnW8qU2R1N2r0twY2OKO+5YPvIbijPjkCPKwNMYq12O6eSd/5iHEZazQ
 EWkXpB2DCOIl/f/86E+MLKLdPU00YLs0RV1qFREkltH6+E8CLmCUJcQThYnZFwMsy8EH
 PLeg==
X-Gm-Message-State: AOJu0YyOd3GUOLfcujK0DBk+MGrniAel03eu746cNBZgD3YE1ApTyBdO
 cq+GH5nZ9Jdec3/cRSePO21o3WkBFz6BuLUbfrNZ59JStRiQ/BZfh8eX
X-Gm-Gg: AfdE7cnvaJmu2Q74LslqrbjPY69y7AkymvvAmROa1jAT3O9Y5jBfsP7MnL1pzR1M543
 /01kCUH2LUsrI7naqqPgnHy8owQf/3FxmHeAzf8x2zmzAaUKVrjYNaWjwko02fj9iiD6rpuoOAd
 Yr45fc8EeBb5VjUWmKxjSuYAMSs2YL97zZmSWwjMc2Hsyw/vkzQAb6mVZnQ3nXL92qGHpSL8l15
 CMKx0MmI7a6BsZCjxD8sfZ6IgHHikXkU3bEtyC/mGVB9tULdDlkdOx+bMJN0ANXl4PqHQjIoSsl
 6WgN8SzndsySeQKta5c16k/L+es05p/o3AY0KN94cFCA7zCjzVU5FDDwqVyLnji+JWVQuBwPNWE
 Y3MGDm0TEQCcTr6VTN09MhHLn65PhqY3TJSLrK6uqFGd9THzSQ35QH7c4zJo4cLRwkbirutRosN
 Vw6VIO9LKz43xEmV5auYXY
X-Received: by 2002:a7b:ce84:0:b0:495:4487:61af with SMTP id
 5b1f17b1804b1-4954a51659emr61464735e9.36.1784417768965; 
 Sat, 18 Jul 2026 16:36:08 -0700 (PDT)
Received: from [127.0.0.2] ([2a01:14:111:ccf0:645b:9e5c:7fe3:c09f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954a2a24b6sm160964675e9.3.2026.07.18.16.36.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jul 2026 16:36:07 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Sun, 19 Jul 2026 01:35:34 +0200
Subject: [PATCH 03/15] drm/tegra: remove dependency on DRM simple helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-drm_simple_encoder_init-v1-3-a78c509e3062@gmail.com>
References: <20260719-drm_simple_encoder_init-v1-0-a78c509e3062@gmail.com>
In-Reply-To: <20260719-drm_simple_encoder_init-v1-0-a78c509e3062@gmail.com>
To: Jingoo Han <jingoohan1@gmail.com>, Inki Dae <inki.dae@samsung.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Michal Simek <michal.simek@amd.com>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Stefan Agner <stefan@agner.ch>, 
 Alison Wang <alison.wang@nxp.com>, 
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>, 
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>, 
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Xinliang Liu <xinliang.liu@linaro.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Yongqin Liu <yongqin.liu@linaro.org>, John Stultz <jstultz@google.com>, 
 Liviu Dudau <liviu.dudau@arm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, virtualization@lists.linux.dev, 
 imx@lists.linux.dev, linux-mediatek@lists.infradead.org, 
 linux-renesas-soc@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-doc@vger.kernel.org, Diogo Silva <diogompaissilva@gmail.com>
X-Mailer: b4 0.15.2
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

The simple KMS helpers are deprecated because they only add an
intermediate layer between drivers and atomic modesetting.

Open-code drm_simple_encoder_init() by calling drm_encoder_init()
directly and providing driver-local drm_encoder_funcs.
Also check the return value from drm_encoder_init() to avoid silent
failures.

Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
---
 drivers/gpu/drm/tegra/dsi.c | 17 ++++++++++++++---
 drivers/gpu/drm/tegra/rgb.c | 14 ++++++++++++--
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
index e7fdd8c7ac12..840e118716b2 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -20,11 +20,11 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_debugfs.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_file.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "dc.h"
 #include "drm.h"
@@ -1055,6 +1055,10 @@ tegra_dsi_encoder_atomic_check(struct drm_encoder *encoder,
 	return err;
 }
 
+static const struct drm_encoder_funcs tegra_dsi_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static const struct drm_encoder_helper_funcs tegra_dsi_encoder_helper_funcs = {
 	.disable = tegra_dsi_encoder_disable,
 	.enable = tegra_dsi_encoder_enable,
@@ -1078,8 +1082,15 @@ static int tegra_dsi_init(struct host1x_client *client)
 					 &tegra_dsi_connector_helper_funcs);
 		dsi->output.connector.dpms = DRM_MODE_DPMS_OFF;
 
-		drm_simple_encoder_init(drm, &dsi->output.encoder,
-					DRM_MODE_ENCODER_DSI);
+		err = drm_encoder_init(drm, &dsi->output.encoder,
+				       &tegra_dsi_encoder_funcs,
+				       DRM_MODE_ENCODER_DSI, NULL);
+		if (err) {
+			dev_err(dsi->dev, "failed to initialize encoder: %d\n",
+				err);
+			return err;
+		}
+
 		drm_encoder_helper_add(&dsi->output.encoder,
 				       &tegra_dsi_encoder_helper_funcs);
 
diff --git a/drivers/gpu/drm/tegra/rgb.c b/drivers/gpu/drm/tegra/rgb.c
index e67fbb2362e6..337925c30d67 100644
--- a/drivers/gpu/drm/tegra/rgb.c
+++ b/drivers/gpu/drm/tegra/rgb.c
@@ -9,7 +9,7 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge_connector.h>
-#include <drm/drm_simple_kms_helper.h>
+#include <drm/drm_encoder.h>
 
 #include "drm.h"
 #include "dc.h"
@@ -194,6 +194,10 @@ tegra_rgb_encoder_atomic_check(struct drm_encoder *encoder,
 	return err;
 }
 
+static const struct drm_encoder_funcs tegra_rgb_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static const struct drm_encoder_helper_funcs tegra_rgb_encoder_helper_funcs = {
 	.disable = tegra_rgb_encoder_disable,
 	.enable = tegra_rgb_encoder_enable,
@@ -305,7 +309,13 @@ int tegra_dc_rgb_init(struct drm_device *drm, struct tegra_dc *dc)
 	if (!dc->rgb)
 		return -ENODEV;
 
-	drm_simple_encoder_init(drm, &output->encoder, DRM_MODE_ENCODER_LVDS);
+	err = drm_encoder_init(drm, &output->encoder, &tegra_rgb_encoder_funcs,
+			       DRM_MODE_ENCODER_LVDS, NULL);
+	if (err) {
+		dev_err(output->dev, "failed to initialize encoder: %d\n", err);
+		return err;
+	}
+
 	drm_encoder_helper_add(&output->encoder,
 			       &tegra_rgb_encoder_helper_funcs);
 

-- 
2.54.0

