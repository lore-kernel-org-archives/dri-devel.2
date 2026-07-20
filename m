Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FBCC4452D
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 15:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12E5810E997;
	Mon, 20 Jul 2026 15:41:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bJhZX1Bx";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 975D210E995
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 15:41:10 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49554ebb87dso19358365e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 08:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784562069; x=1785166869; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/m2It/8MnIxoX8xbOWjx4p2UhJgFTMfhBAqsULip3yI=;
 b=bJhZX1Bx8goJ7KQl7IFBQAxGlMHaiaOwgIp4sQ689U/TlG6VtyNDfN8Z/bgXPbIjJI
 pbRpP64d3OQ3pqckkIPx4nMeZmnWp2yvlEUnZHvOlJVX4yQ3KAJIoFUmFx+YcZZ7WkoE
 UOv75U8P25s0cwlHoVjkTzetYgxkpGlMC3SnsZXQuFh80caYnrC37Cn2mWQ8BjrDDsB8
 RclNWmeJ34C2aQemDf6XzqyhDxpLxkATnzVWO6cmg6xxzmh5sRmBCuKTIXl590clE/Kb
 9AIJg648cScvHVP7h6NRjQZzMiw7CdV9fkAFWmxa7LW4ITU9JyPq2eomrLJhUeNpdC4i
 hylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784562069; x=1785166869;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/m2It/8MnIxoX8xbOWjx4p2UhJgFTMfhBAqsULip3yI=;
 b=Ymu/6Ng7okVc5Hw8ejcKYc4LDWxg2AvakXEktAgzcGQHlYkTmBKDmoMxtqf9Ei+rcK
 cnWWBgRMKYNqFu17bNHEkTDxFIMrHgLZhzZiuDw7vWYOS3F/cLG8xS3yIldiEE3QpqxR
 LNyRkrC8cozkzK7GHEH8l6EzVOTyjqZhsk6RdSE5hi4GBKs/OACKjSFiNw5dkpK8keHa
 i+EzJ/x+jFejSJkSuPi6Pe+dSYI2ybi6jy+ern4pRSi0zRt+FTdb67Us9aOB3Ynr+MW4
 d5XY3Do22bzOSGva3BbuJEkYkBK+CqSmO7I79chqG/suJNuK5ZiYkekO+/fGqRq09CWo
 yFfA==
X-Gm-Message-State: AOJu0Yw0+TSaU+KSbgNJaOCmzlRiwCTHQW/2DhstXlf5fgu3DQIYYzsW
 u5AD/GNR9ZbypByWuQfKVWvS8y8vrCnI61qkKg95L36h6J73c2OjlRsJ
X-Gm-Gg: AfdE7ckt3EZV0ZenZ/jw1ZJ6UNYEtg930Lee1QFxkBwcMFVLL21ulE3UDrBWnhfDEfT
 01qVA+NpHrXixlFx6rZvfSMFhgLeFzX//n01GqqgOy/EvMInf6CnPOlo0mPAr/bV5faiXa/Cm3l
 fkyoVPukqP+PDwQ5AoKc3zpy0A+KiSeRsvL5XDGxtZiSkKF7sFjftVGPqtiAPBOfew7f7vXviCE
 cZQPunjiWxJ1OShHe33wSLjDoejj8/AY/EPw3vEja+gCDvGejF44TsI7Ed3Sj6J3JL7uPsaPamM
 zJOx/gvPUatVbW7xjABHj14c5bf6goxdX7f2f5Rz0IskXazoxgsKbM1xjJD2iLIEtQEopc1W4n0
 w4utpqgrqEdaoryueZaG8eTkDj7ZRoG/bhqOBWzXb+CT8YKmDm6sJd2ivbfugLHQEVtTykYR3bH
 SHLfgn8Fecqg==
X-Received: by 2002:a05:600c:1f8c:b0:493:cefc:d113 with SMTP id
 5b1f17b1804b1-4954a3e6e29mr174459165e9.5.1784562068798; 
 Mon, 20 Jul 2026 08:41:08 -0700 (PDT)
Received: from [127.0.0.2] ([2a01:14:111:ccf0:e9c1:2f80:10a9:c708])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f67466e09sm32667936f8f.21.2026.07.20.08.41.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 08:41:08 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Mon, 20 Jul 2026 17:40:38 +0200
Subject: [PATCH v2 06/15] drm/virtio: remove dependency on DRM simple helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-drm_simple_encoder_init-v2-6-5020b630668a@gmail.com>
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

