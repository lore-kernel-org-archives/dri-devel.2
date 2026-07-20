Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB0EBC44520
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 15:41:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01E9410E1E7;
	Mon, 20 Jul 2026 15:41:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ey9CJQbS";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BD7810E1E7
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 15:41:07 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4954dff6536so18773645e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 08:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784562065; x=1785166865; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Vjd+2BbZ6IkIhW8JUSKZxdlN+XT2WH08r3urmJQpGFU=;
 b=Ey9CJQbSLXELvK/tF2WmwincOpFhBU/QsPp+Q85r5QPWZvq8/bcG5qWgUkV0UqHtY1
 LmNx72faau0Nx9hZ7oczXnLAAYTtyBW0r+WWY4FNGe+oBP0y55ROICO57ECLdXs2LHnd
 QU2sVMsxWhm/FkEv7XFDXm6Blv9yTyDAUwSjyvxZxD+byHRMKMSe9y/3RWDc4mIlDW9J
 pvGOiVxNATMuYkmyk13eSbPEWUNTeL38Q1F63IpiSiCshkp1rydWshsqCvG4EUrhkkUW
 u/EQSQKLgCxdI+BdPl3mAHL8tOkvwqK59dut1mf6f8QilcE6ibDDvlCkYVkGPwZyPbu8
 uAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784562065; x=1785166865;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vjd+2BbZ6IkIhW8JUSKZxdlN+XT2WH08r3urmJQpGFU=;
 b=QeywswU3Zs3ca3bUACaALI6OB9PIOmIOe+UOWn55Se5lTKJE7VYX6VkFAeU49RJwNX
 ewm125ihl/TKcwa+KV0Oxe/u1gPZaWy8t+OzPBg9g4+tWWw0i3gsIvk3UI6F2Zxr9Grf
 OYnzsqzfemxP9dMeolgh+bQ0vloNxQ/vBvJ/cI7YIi+3UPKcyy3sosAG0KNVg4/2I2lE
 QWRgVWVZGPT8L0UYwrb+RVzExa/k/Q0hRzWHZO9p2nLk99EVwZD+uSpiI5zuvxZ3gyUr
 LmFfqVeZWb8hRkiFcEGXOlSFpPiWEVWaX/f3j9IiY6mu0PPsGuJVAWkgRRAl2JB0+exJ
 9pfw==
X-Gm-Message-State: AOJu0YwNt7YYtMYUca9BIV13E0ItYV56zl/uM8g9EtVZXH3ssAjp/PA+
 roegN0N5bZWJ8FWOu8Mqamr9xRcFb00oetyHRAo5M08mZSGigjUtrk7C
X-Gm-Gg: AfdE7claeq0Gq9R1v70+j8w2p4qNl+3MgkjUPRTAPn5nxn5B5rOSUjYnmL9bSDN4DR2
 8ytyoonDP9pSKFrYx7pdzCvKoMcct6v1J4sh5zUvDe5wDzx0A/knkkLY3Lj9D7eEsKfBltyKQgh
 IVtQKuJkmIwneickjpobn1IN7gxB0bzV9f09FCSK4OV/ggdEQTO+eYOpFfTVqstPwcg1y30iZWn
 LSi7UQ0fWlW2ojrft4eXbnCSZif+YFB+fSXnf8nIC5u9lLxL+WuY6QnSzgVnDeo3cjMpUw4C/rA
 mPdNQdmgoFKzP4qUCbWbyxhcNTysxfFDKbXurRsxMiGmwm9et6MyOyGDmzl4Wb4PhN18cVDZ2NZ
 a73qubTQt07MM2wocIN9ROD5MmHRvwwPtLfjSK0F/4e4TkR0rP2RWQntzcieW2Pj5lcR2x/ekZF
 g7o4RP952luw==
X-Received: by 2002:a05:600c:1d1b:b0:493:f7c8:eae2 with SMTP id
 5b1f17b1804b1-4954a3db7dbmr155975945e9.15.1784562065028; 
 Mon, 20 Jul 2026 08:41:05 -0700 (PDT)
Received: from [127.0.0.2] ([2a01:14:111:ccf0:e9c1:2f80:10a9:c708])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f67466e09sm32667936f8f.21.2026.07.20.08.41.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 08:41:04 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Mon, 20 Jul 2026 17:40:37 +0200
Subject: [PATCH v2 05/15] drm/kmb: remove dependency on DRM simple helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-drm_simple_encoder_init-v2-5-5020b630668a@gmail.com>
References: <20260720-drm_simple_encoder_init-v2-0-5020b630668a@gmail.com>
In-Reply-To: <20260720-drm_simple_encoder_init-v2-0-5020b630668a@gmail.com>
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

Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
---
 drivers/gpu/drm/kmb/kmb_dsi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/kmb/kmb_dsi.c b/drivers/gpu/drm/kmb/kmb_dsi.c
index 59d0e856392f..13adba96bc78 100644
--- a/drivers/gpu/drm/kmb/kmb_dsi.c
+++ b/drivers/gpu/drm/kmb/kmb_dsi.c
@@ -14,8 +14,8 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_bridge_connector.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_mipi_dsi.h>
-#include <drm/drm_simple_kms_helper.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 
@@ -1427,6 +1427,10 @@ struct kmb_dsi *kmb_dsi_init(struct platform_device *pdev)
 	return kmb_dsi;
 }
 
+static const struct drm_encoder_funcs kmb_dsi_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 int kmb_dsi_encoder_init(struct drm_device *dev, struct kmb_dsi *kmb_dsi)
 {
 	struct drm_encoder *encoder;
@@ -1437,7 +1441,8 @@ int kmb_dsi_encoder_init(struct drm_device *dev, struct kmb_dsi *kmb_dsi)
 	encoder->possible_crtcs = 1;
 	encoder->possible_clones = 0;
 
-	ret = drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_DSI);
+	ret = drm_encoder_init(dev, encoder, &kmb_dsi_encoder_funcs,
+			       DRM_MODE_ENCODER_DSI, NULL);
 	if (ret) {
 		dev_err(kmb_dsi->dev, "Failed to init encoder %d\n", ret);
 		return ret;

-- 
2.54.0

