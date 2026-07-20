Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD9E3C4452B
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 15:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12AFE10E995;
	Mon, 20 Jul 2026 15:41:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EfJaq19G";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7129410E995
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 15:41:14 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-4799b3f7c83so7476404f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 08:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784562073; x=1785166873; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ATiv+bDbiK4r8/Ev/Mp3rnzRTm75IqK6z6i5srau5Es=;
 b=EfJaq19GRzzh2zXPr4Oq0qu7E0WSB1Ses+ZgO7wANt0Uk/9+CmR9cPFCKNmpcXsp0B
 84ixBCt3vCOWgRpAwb+8ylI9xv6rI60a2Wzq6FaWslRJ9bZ3hog4trGEocZXTrOkVEh2
 KPeSheFy7W0vAgIabj1RY/OHuWYU5tKbSVe7mF0s6niF42xkYxVMCJjIi7O8X9uVn+dE
 xzpucxGMNSwz9iCTZzxiysN32Ovu3zVv/Psqyhupu7qTqPLJYb1+ME3K9pnb1FumyCS+
 XYFh20yZEB0/wIezhiRq+YqnOCpaOhfrwrCN7+jvRBjB44t975wEk7tLC7tfxRowh8qn
 N4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784562073; x=1785166873;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ATiv+bDbiK4r8/Ev/Mp3rnzRTm75IqK6z6i5srau5Es=;
 b=o2UL75NvrYBi4SZOwO7B3BT4WHBeM72ay0V70ESSPh1nVXu0lBcnA9/Dle297bXlxU
 ZcXC3/hSBPvJVlvLDeW9VkF+x9ZpHp/zhmlcBQm2Sb98hresx4727aDgBiRL6lvAsqvZ
 0ft5VfjbadX4sRIZxOfHp8pxDiC5G1Hp1/C4rkwmRpNjFfOAjlDuNlfZkzWb3iIwtYvU
 gU3Bv2EvADvXw+vT0CE+J+Sh1Bg2pzAgbsV45VCIdFR9hZTygvNGwquMyqNHvMP5g3Zw
 Cj92/EQ4sZtc8ry9Srmv6fFUF5jDbHmXvrLVJagPe0YyGMwrat2NekQJP9YnT8Ghn1Pt
 O7jg==
X-Gm-Message-State: AOJu0Yxuvb9UR8Wg3H82lJGiXL055abiO8wmjSF/OPsMRXlIH+gaW9ws
 MqQbqrwpOiIVDlmWd4ANuN4RQBf4mH6aeweNJ3VY+aDXi7MPGrogbJJl
X-Gm-Gg: AR+sD10SHeaiPy4TYUxTXaAwsb1Hq/ZnqY//3f8vAFL6NtAVwDQPqTeczByFykuMKe4
 h0VClAGhNTBsJsihWhKkFFkM7mIVq5MtW2zamJ0rVbQrx+m2F7AZwp/gqrCqlXCAxSuKYGNpQll
 pZFfcJwwCFPFU1/nbx0rsxPmg87oppPqUWQu2qoucKgDPjuMDOZnd1U+lqsK1esz4GCRg+Bftb4
 MzV/QrYJoeWEEblaDyV1jwdrmIwK62kKh1VbsdWfyYj/BHZHOr0X8nSHA6qi/pKYjiDq44Arg7E
 U18nrpARzvUV5Hr6AlZZRqEsQ5h6rBAEwQFGbhAEqEokmdpcvQmE9RIwe9Yt8obYnNDE8G8jeg0
 olMTPyL7L6t52CD+ytdVelQwVQihgythm+vKvZxccIwoZg75UIqbEXHhjiDPL6mLDit0mvb/qPK
 XvWFf4JhPYKw==
X-Received: by 2002:a5d:5d0e:0:b0:47d:eedb:ee62 with SMTP id
 ffacd0b85a97d-47f6230389fmr18153184f8f.14.1784562072745; 
 Mon, 20 Jul 2026 08:41:12 -0700 (PDT)
Received: from [127.0.0.2] ([2a01:14:111:ccf0:e9c1:2f80:10a9:c708])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f67466e09sm32667936f8f.21.2026.07.20.08.41.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 08:41:12 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Mon, 20 Jul 2026 17:40:39 +0200
Subject: [PATCH v2 07/15] drm/tidss: remove dependency on DRM simple
 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-drm_simple_encoder_init-v2-7-5020b630668a@gmail.com>
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
 drivers/gpu/drm/tidss/tidss_encoder.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_encoder.c b/drivers/gpu/drm/tidss/tidss_encoder.c
index 698f8d964ca0..10dbcc6cdf6a 100644
--- a/drivers/gpu/drm/tidss/tidss_encoder.c
+++ b/drivers/gpu/drm/tidss/tidss_encoder.c
@@ -9,11 +9,11 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_bridge_connector.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_of.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "tidss_crtc.h"
 #include "tidss_drv.h"
@@ -81,6 +81,10 @@ static const struct drm_bridge_funcs tidss_bridge_funcs = {
 	.atomic_destroy_state		= drm_atomic_helper_bridge_destroy_state,
 };
 
+static const struct drm_encoder_funcs tidss_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 int tidss_encoder_create(struct tidss_device *tidss,
 			 struct drm_bridge *next_bridge,
 			 u32 encoder_type, u32 possible_crtcs)
@@ -95,8 +99,8 @@ int tidss_encoder_create(struct tidss_device *tidss,
 	if (IS_ERR(t_enc))
 		return PTR_ERR(t_enc);
 
-	ret = drm_simple_encoder_init(&tidss->ddev, &t_enc->encoder,
-				      encoder_type);
+	ret = drm_encoder_init(&tidss->ddev, &t_enc->encoder,
+			       &tidss_encoder_funcs, encoder_type, NULL);
 	if (ret)
 		return ret;
 

-- 
2.54.0

