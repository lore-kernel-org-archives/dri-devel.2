Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 949B7C4452D
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 15:41:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E72FF10E99A;
	Mon, 20 Jul 2026 15:41:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j8fGVeAF";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14D7810E9A1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 15:41:41 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-47df43bfb07so2743628f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 08:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784562099; x=1785166899; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LYdVSEJYSxlpPRyHCi7r5tN2RJPa+UFv81a3Ufh1joM=;
 b=j8fGVeAFbbyHWrNkbvNJ798ths+8jcvujEidrE3wnkeTotaleMmOyeA+KWdL6pv/sZ
 ZPF09O4WoQZwiqSrbi4v0STFEwtZjE/8wViPjiqdlHWGUytHCYm9NxaMI0ihTL7ZyxJb
 XFHUwDQEyQMgbnnS+X5gbXnqN5SHHcUAmujaIuqFe/BFQ7qFzCaX8pduiiOLdKB19r0U
 6Zm69W7S8a/H20iDVxyTq4RMITMejG9BQgUW0TsmD8SXzNdingjxwwwQuE5M6ZYTJmmA
 zPygRyjqvJdW/kxo8JCYZqFWf3e97A0QOleVPrPN9jOFbnzg1ji5hgLEUH5UAndhTxKn
 K70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784562099; x=1785166899;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LYdVSEJYSxlpPRyHCi7r5tN2RJPa+UFv81a3Ufh1joM=;
 b=pDIj+/NU0IDmzGjecZiSukIKXZz8u7ATlFil+9mrecOy+s8DU4/dmrFn75OlRWo8os
 WO79y/6T8d/CfAcSpOryvvWoheak+Onp2phgFa6kK5yOC/uPt3SnPv4wvdDnvh2lHnp4
 7o68QbtSMXhWvkz6erEvS3QW6HJ6NdY00ThDvJ5g35HLLNN/7u0Ms466syJmMCbhCLHP
 DS1lZ5TY6MpRaJwYUgoNTyjsVoStHAVK2zwJB0d7qR+WS/+9cInkYV/BWfOy8pW/ZdFx
 /ZT1SEt/Xlo930B7ywoMt4UgMX9H6RDo0oMIhK9ZB7sUJ9PXvsgt4o9ttg1X9V+qpBT+
 fkMg==
X-Gm-Message-State: AOJu0YwsMaaMlJpvuAVLuSi4ihh5fmTlYvHHMNztQzZQKXuJpHK1Ms7f
 U4lwbD2dTYzOWl5eCfLhQBz6fUgZNmjRTJUtKkFm3kdNDqUU2tKSI5yc
X-Gm-Gg: AR+sD10FL0C/lfaiFG3a5xBRuMS86tEfLDoNGsfIXgEQ0qhldzNtQJWGuhj3xDsE8q6
 QYi7U113Jl4XIpHhTkNefegnXWdm9lfojmyUATDWYQPxEDNCoev0XXh6bFDRntyrm8Kyf/u5Del
 C8fAGFaF3K9YKqxepahB9/B2+Zizfu0j9EmTqK0/I7ZQ3soXgIhpapRnvkKxHwXcViLiMIjdg1z
 wZKh2K8qeccZu5P34AXHARa1E+HU2QGgBbYhR+0HyQcrV3nQHd16dkPHB7YBViXEWKwt06fShS0
 x4+2gzpQ+OM4EuZdzjiKmn/zt+LQUdIMIzlxTwUOsSYiwHYsF0vRZIX8+C2w0xL7hCe6EAvlLBe
 lMEnzVM9Uj9JnXV93Gg7vwZEPAgNk6MqEuvpW+oab5wkR5W7fELYUYY58TM/t39cgcaYKz3/oUb
 aEyxrvJMq55g==
X-Received: by 2002:a5d:5f91:0:b0:46f:7d90:8121 with SMTP id
 ffacd0b85a97d-47f62305661mr18563371f8f.14.1784562099337; 
 Mon, 20 Jul 2026 08:41:39 -0700 (PDT)
Received: from [127.0.0.2] ([2a01:14:111:ccf0:e9c1:2f80:10a9:c708])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f67466e09sm32667936f8f.21.2026.07.20.08.41.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 08:41:38 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Mon, 20 Jul 2026 17:40:46 +0200
Subject: [PATCH v2 14/15] drm/drm_simple: remove deprecated
 drm_simple_encoder_init function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-drm_simple_encoder_init-v2-14-5020b630668a@gmail.com>
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

All driver users of drm_simple_encoder_init() have been converted to
drm_encoder_init(). Drop the helper and open-code its remaining internal
use in drm_simple_display_pipe_init() to prevent new users.

Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
---
 drivers/gpu/drm/drm_simple_kms_helper.c | 13 ++-----------
 include/drm/drm_simple_kms_helper.h     |  4 ----
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/drm_simple_kms_helper.c
index 8e1d07b9f1e3..7878b9d7d524 100644
--- a/drivers/gpu/drm/drm_simple_kms_helper.c
+++ b/drivers/gpu/drm/drm_simple_kms_helper.c
@@ -20,16 +20,6 @@ static const struct drm_encoder_funcs drm_simple_encoder_funcs_cleanup = {
 	.destroy = drm_encoder_cleanup,
 };
 
-int drm_simple_encoder_init(struct drm_device *dev,
-			    struct drm_encoder *encoder,
-			    int encoder_type)
-{
-	return drm_encoder_init(dev, encoder,
-				&drm_simple_encoder_funcs_cleanup,
-				encoder_type, NULL);
-}
-EXPORT_SYMBOL(drm_simple_encoder_init);
-
 void *__drmm_simple_encoder_alloc(struct drm_device *dev, size_t size,
 				  size_t offset, int encoder_type)
 {
@@ -363,7 +353,8 @@ int drm_simple_display_pipe_init(struct drm_device *dev,
 		return ret;
 
 	encoder->possible_crtcs = drm_crtc_mask(crtc);
-	ret = drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_NONE);
+	ret = drm_encoder_init(dev, encoder, &drm_simple_encoder_funcs_cleanup,
+			       DRM_MODE_ENCODER_NONE, NULL);
 	if (ret || !connector)
 		return ret;
 
diff --git a/include/drm/drm_simple_kms_helper.h b/include/drm/drm_simple_kms_helper.h
index cb672ce0e856..c95f86ff355f 100644
--- a/include/drm/drm_simple_kms_helper.h
+++ b/include/drm/drm_simple_kms_helper.h
@@ -68,10 +68,6 @@ int drm_simple_display_pipe_init(struct drm_device *dev,
 			const uint64_t *format_modifiers,
 			struct drm_connector *connector);
 
-int drm_simple_encoder_init(struct drm_device *dev,
-			    struct drm_encoder *encoder,
-			    int encoder_type);
-
 void *__drmm_simple_encoder_alloc(struct drm_device *dev, size_t size,
 				  size_t offset, int encoder_type);
 

-- 
2.54.0

