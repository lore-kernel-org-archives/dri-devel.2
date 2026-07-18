Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D5CC4450A
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 23:36:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6235210E374;
	Sat, 18 Jul 2026 23:36:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eAXk0GhU";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDB4D10E374
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 23:36:20 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4953ddae026so28559825e9.3
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 16:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784417779; x=1785022579; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/m2It/8MnIxoX8xbOWjx4p2UhJgFTMfhBAqsULip3yI=;
 b=eAXk0GhUnOaSVe6TSZP3W+cDIR1TabdzsT2HT8mzFxIuNVVidSi7c2+3D5q57yVVki
 jiVdM43OsVwnwfiPXqLGjLkHzUNV/QsqVYGNGbssq01zvSt+lBTARIob8WXQ8IPT9KDS
 +28VKhCxQ4X10AuHNd5zHg8/qmUSeGLRHJb85BvvH+9iWjT36MC3zPlRweUxxQJOvIlG
 OskOBDYC+IEGgjb9iR9zy1+TBPXOFkW8wiWepaAVNeiXPyhptAE2eFZ9sYRXGK5i7JjU
 yQFPmgl6qamzFc40EqOaMH/C7qshtuXb44CP94U8/0sUNhuNzYbsg8YQrT5hAuoVAase
 XGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784417779; x=1785022579;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/m2It/8MnIxoX8xbOWjx4p2UhJgFTMfhBAqsULip3yI=;
 b=B9wMuqctMbpbbPLuKQGC8ylEpg/9AK/CNE8Tx4M76HWVRQ29h021MFPsDxuf5uqufG
 yR8Dl5RMxm4z3nSCo2rVcjyUvPlmLfCPiNlhXfzhZWBQmWuUkmf26BPgQnWVqXHSrwFq
 IoZJ/NjrWzsGCdplyS+OMksIAasdy+t7L6P/Y9P8x55KmWz1IrX4GZDX+qOBo7rIGQqK
 baGqeN5iudf+XCRGOVc6aIRFJ+VKiKzz1xqlzKanQqbLguuJAe1NtU//QbWeecv7vO4L
 Ja00gFMw2XV9F5tNG+vbff1O2U2UWurscnGat4stEWuZxaSXRO4SvfHqvw5h9RlBZAEX
 eylg==
X-Gm-Message-State: AOJu0YyZ8225xiLDkwfjdxBN+7ACLYzzThBzQZycBgyVWA3vKiqJZIEF
 o3sAa2nIqnBJGxh/81TFhbT3LuGBEpPSB0PmQt7Uajmx4TNdr+Yuvp29
X-Gm-Gg: AfdE7cmyKJ7OyUyIns8cuKY5RjhgWvkgPeanHcHgp3r2oTYkYUS+36OmtNqyQWuqCfT
 ALsIy28eHYiOQtkLdgW5H3/VXBDYcCbue774xrBEdu03oQ7DN9o1h+m/zBI4UoD38rsMV/w5/gE
 OQqUp9nqKvbZVjGOX0LaBojhJG+YM6GRn6GESPVM2qCAts85w+5hcFVlROj9i0D03KY6pPjK7Xq
 CAE3YnJHdz375wUJyg/V4WBR+kyvGRngJ8cxrN+g9G6mR6vAY4j6S/D+HUH6Y7wB/55ijyboqqs
 kmzyDzrgYM8WSU37/cvzL3KjYeFR5PM9X/IpyvYON1oq8nOKgLAxemrp+14joxiODhHDp/gZmxg
 MukS7o5YYEktgKDAJFTI4NwcDWJPf/3FAufSwN9c5VcLS2pCwx/MW23I/EjvTpER0ekgmFWS1Mw
 ISvTsryD/tP5P9OTCqeYuN
X-Received: by 2002:a7b:ca50:0:b0:495:3fe1:4ce4 with SMTP id
 5b1f17b1804b1-4954a40c110mr70449165e9.26.1784417779234; 
 Sat, 18 Jul 2026 16:36:19 -0700 (PDT)
Received: from [127.0.0.2] ([2a01:14:111:ccf0:645b:9e5c:7fe3:c09f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954a2a24b6sm160964675e9.3.2026.07.18.16.36.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jul 2026 16:36:18 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Sun, 19 Jul 2026 01:35:37 +0200
Subject: [PATCH 06/15] drm/virtio: remove dependency on DRM simple helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-drm_simple_encoder_init-v1-6-a78c509e3062@gmail.com>
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
 drivers/gpu/drm/virtio/virtgpu_display.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index 44ffffec550f..67023d91d40b 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -28,11 +28,11 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_edid.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 #include <drm/drm_vblank.h>
 #include <drm/drm_vblank_helper.h>
 
@@ -232,6 +232,10 @@ static enum drm_mode_status virtio_gpu_conn_mode_valid(struct drm_connector *con
 	return MODE_BAD;
 }
 
+static const struct drm_encoder_funcs virtio_gpu_enc_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static const struct drm_encoder_helper_funcs virtio_gpu_enc_helper_funcs = {
 	.mode_set   = virtio_gpu_enc_mode_set,
 	.enable     = virtio_gpu_enc_enable,
@@ -306,7 +310,11 @@ static int vgdev_output_init(struct virtio_gpu_device *vgdev, int index)
 	if (vgdev->has_edid)
 		drm_connector_attach_edid_property(connector);
 
-	drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_VIRTUAL);
+	ret = drm_encoder_init(dev, encoder, &virtio_gpu_enc_funcs,
+			       DRM_MODE_ENCODER_VIRTUAL, NULL);
+	if (ret)
+		return ret;
+
 	drm_encoder_helper_add(encoder, &virtio_gpu_enc_helper_funcs);
 	encoder->possible_crtcs = 1 << index;
 

-- 
2.54.0

