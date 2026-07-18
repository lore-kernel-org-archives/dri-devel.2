Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6487FC44524
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 23:36:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7887510E60B;
	Sat, 18 Jul 2026 23:36:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m+NMQtHz";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3375310E577
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 23:36:14 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49557167508so2714965e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 16:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784417772; x=1785022572; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Hoju8K5XWFY53znMwRCcUMP/RKb2Y+W04UW3kIqcXC0=;
 b=m+NMQtHzmKsmCtC6xBYost8Qey0W3xFg3l89SicQtm3WcO3etCDrxsdfsleejKSntI
 YGUhZT4Q15ppwKv2aXt6r3vh1yXk1nsO3DSOhs5Hh8nTGGIhGHVxSVlGzYHsm2R3hNHg
 ZHdJN7bU0DQmPtaCxGRoZM9sy60VtO2nvpGfY2fsxolCVL1yGAdjQ4aCZTHoPWEebTtw
 3ODKlALckZxQvUWQtL3xQu+Xeh9lCP8Rh56nWuCxjYjlYx8OdhHs2pdRwyXdPFEDg8xr
 KxCZ7oxYDrpp3BFOOgzPaW15ObYvZidM/AvXJqYDN7qW/hQrKQxtkNoYRPazhYkh0erp
 lsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784417772; x=1785022572;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Hoju8K5XWFY53znMwRCcUMP/RKb2Y+W04UW3kIqcXC0=;
 b=erPHVC2ehOjrQU8zmSmq9mGZUuQxwi1vZPqSsYn23harb3MXNZi1dQ4xEOZsKcIIVP
 ayqKq70Och48IeUQAE1obpESOxDyo3x7xRLik25NdrRwmD+e5s2+496whgaySjzqUcLC
 x3EhLHdRCnuXUU0wcORqmudOsuell+9GAV+AguufXBK2/5OkWji/I9Z0LLHtCoUsRfaI
 49jF+qH4ZV70zvnQJO/G1y2bnrRPbCMyM86LgduFn1KAq+OU9UFd2HnXQXIlPwaehw1l
 KkcxccdaEeHZewkXKFh26FWzMvljwXrFd14e0U5H/5mITRz22YC7BfUyVRA1L4YPPLVc
 7ngg==
X-Gm-Message-State: AOJu0YykUITVBzRyOhJx5FsektLPvESM80kYW/Gk+aseI12yNxwkKTw5
 0YKhOC6T2v+k5IrnNhPdKeGhuhqtxX2hB0eaeI11sKw5AQOSOhWI59oc
X-Gm-Gg: AfdE7cmwj1xXgxAL5ivac70KDUzhZRMaAAt4WkXjXXIhGP3p+NzT8y+y1zZQi7MAqvw
 +nl+HqMJSpKPbODziJ+d1q3Rkww1yEjYdO8pEX+wmxSvLT+06po+vn/Ibek4Ja/ZmxEqWcVkT2e
 XUO8tk/Rl19WGeoH1CirJg+cHUQ63245CsOl8t3SrUSLOhDq7/aVnImugUQmAktJawWWhlNBPvp
 7SEoLnjLyUm4N3URPLo8WkSnJGkiwkJZ/sTjtpPnRMCrM7yEuKMQdmzXiNZzaiM4haDeKSbiFMz
 mtuFmDtLASWkWoMSGwgp/ipbFig47ZC0oF9VY1prOfuSYIoHaEVgwrAOmyiEXU3BAuo54wATzEZ
 PUFWLwKT0Un8mAD8EdrE6iNFPdtGn1/I+5OuZjYtYIVsp1qwJuQCs76wvmUBL1nlNC/AvmUUBkV
 l3km+5WMEXsQ==
X-Received: by 2002:a05:600c:b85:b0:495:5365:c0d1 with SMTP id
 5b1f17b1804b1-49553d85ea0mr35374355e9.14.1784417772455; 
 Sat, 18 Jul 2026 16:36:12 -0700 (PDT)
Received: from [127.0.0.2] ([2a01:14:111:ccf0:645b:9e5c:7fe3:c09f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954a2a24b6sm160964675e9.3.2026.07.18.16.36.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jul 2026 16:36:11 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Sun, 19 Jul 2026 01:35:35 +0200
Subject: [PATCH 04/15] drm/fsl-dcu: remove dependency on DRM simple helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-drm_simple_encoder_init-v1-4-a78c509e3062@gmail.com>
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

Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
index 84eff7519e32..c2b788bfa8f9 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
@@ -11,14 +11,18 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "fsl_dcu_drm_drv.h"
 #include "fsl_tcon.h"
 
+static const struct drm_encoder_funcs fsl_dcu_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 int fsl_dcu_drm_encoder_create(struct fsl_dcu_drm_device *fsl_dev,
 			       struct drm_crtc *crtc)
 {
@@ -31,8 +35,8 @@ int fsl_dcu_drm_encoder_create(struct fsl_dcu_drm_device *fsl_dev,
 	if (fsl_dev->tcon)
 		fsl_tcon_bypass_enable(fsl_dev->tcon);
 
-	ret = drm_simple_encoder_init(fsl_dev->drm, encoder,
-				      DRM_MODE_ENCODER_LVDS);
+	ret = drm_encoder_init(fsl_dev->drm, encoder, &fsl_dcu_encoder_funcs,
+			       DRM_MODE_ENCODER_LVDS, NULL);
 	if (ret < 0)
 		return ret;
 

-- 
2.54.0

