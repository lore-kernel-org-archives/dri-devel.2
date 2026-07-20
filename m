Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 652E8C44520
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 15:40:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C31B010E1A3;
	Mon, 20 Jul 2026 15:40:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FhRVo7RM";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6B9E10E1A3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 15:40:47 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09aaso6738029f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 08:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784562046; x=1785166846; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+RhVkb1Ieh+bhF0gQzF1Ju+q7qk3GiWptVGwICJBljM=;
 b=FhRVo7RMWViM02K70Zup0ZM4KWssdw9oHZom7hGWpnSJnBsIflp2eaEpfYYyUsCMRX
 WpRhFQXJxGIq3uFXIbicgvKKiA1aoev9zZqSX8LZf+HxzdMj8bJ5Sg74z2R4qTDl+8es
 ErLNOjxln7aI4PvjcPjxJX4oYR+mH9WuH/D6XApRCv1k/xCSKC7RDBDnWJt2hPJV79IQ
 NR5UgT6JWEz9q2iow35qxGKW9j9663ip9Nf3KnHPv+7C0LUrhngC4FJApTnpLlA2DCzE
 gGnzE0/JsqXfmofbGXfN7nQNQ00iCGexEKoXJv5JtT7xqhYaD0xjLWHq5Es0MQ6JpF6O
 GQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784562046; x=1785166846;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+RhVkb1Ieh+bhF0gQzF1Ju+q7qk3GiWptVGwICJBljM=;
 b=E/hMGEirNh78T2hubecBQkgsanCRlhvHUdsAsOA4N6F32QZ+WMHmxlUQTlSjllvrkF
 jUegUDFeILojRP/MdlNQMbQvN9OeWNygHfsKx0XLzjc5S8SykkhnwQWN2f33IN8zOwAo
 YwiL77h47P/7LccWXuGwzeJIM8lThcBMZz/aCMdzrstcuzaAD8UKODAwtb3vvr91m7bV
 6UKoK26+Kl9zQkKpNeV44v826XJ+BCV036c8uUeYWTNdIOlRCdRQXietp7WH2kfj67nu
 cVEUoEDd5lz8FnAar3ZuYp5Ehgxb9ufzk/d4eIU6tWkTlnD+lWxY073mLJOKdkf9eJIT
 YZcQ==
X-Gm-Message-State: AOJu0YxJu0Fo7aa2VO1SBPxWnyYkg+OFE+XKJR0mFnG7ZI0awlyBsi/h
 XkMofJgulBsS1CgZxavWroRWYvBnGlQMKnhcqkk23L8FgTpPPYZO96NJ
X-Gm-Gg: AR+sD10XFYH+fYhAkvrTVXM5KzYLAMFjy/8s0FoXRH68PNISs26KKUyPiWXk/I9zlPT
 kLOGoFI+KtaBpybADIOcfSrkrRaDqKTpIOGYy2F4XuZ9/tt6HGqKXEGC9cb1/EvbG4akIFxNKYQ
 Rngw6OQf53YtKDpcXXYZ7+KnUTMsNWj8ZwBCsI5rQMeWZ5cNdxQ+oy5h5A/ZyOHUs2ctkOfCB/8
 jLZkz9gUEzGtWbHZh+eKfRy0r7tWm7GGETt45Om9tAl4w2DMzTtK+lGHIfXIhZtgX8KMSTLOQdT
 TA03nLeX4wPUya2MIkEdFYsJiNgVvLiiDU6Q/1Ex4xGiWbTBKl/57/w45E4Ioq4rfjbmCul5Vna
 fdYcQcR8HS7jAmKIvZenChm1yfoMp3VQmElW7A+jP9NsCcIIlP2J6mP+RUKfj0DL388IllvVUMC
 hYQfP8F6XN1g==
X-Received: by 2002:a05:6000:4310:b0:47e:b336:6385 with SMTP id
 ffacd0b85a97d-47f622d054fmr17529323f8f.0.1784562045728; 
 Mon, 20 Jul 2026 08:40:45 -0700 (PDT)
Received: from [127.0.0.2] ([2a01:14:111:ccf0:e9c1:2f80:10a9:c708])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f67466e09sm32667936f8f.21.2026.07.20.08.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 08:40:45 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
Subject: [PATCH v2 00/15] drm/drm_simple: remove drm_simple_encoder_init
Date: Mon, 20 Jul 2026 17:40:32 +0200
Message-Id: <20260720-drm_simple_encoder_init-v2-0-5020b630668a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHFBXmoC/3WNyw6CMBBFf4V0bU2pysOV/2EIKdMBxtCWtNhoC
 P8uYFy6PMm958wsoCcM7JrMzGOkQM6uIA8Jg17ZDjnplZkUMhN5WnDtTR3IjAPWaMFp9DVZmrg
 WWanOAHlbNGx9jx5beu3me/Xl8GweCNOm2xY9hcn5956O6bb7Vcq/lZhywVVewEWUeBKZvHVG0
 XAEZ1i1LMsHAbIKNtAAAAA=
X-Change-ID: 20260718-drm_simple_encoder_init-d069a4cc7f8b
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

This series open-codes all remaining drm_simple_encoder_init() users by
calling drm_encoder_init() directly and providing driver-local
drm_encoder_funcs where needed. After the driver conversions, the helper
is removed and the completed DRM todo item is dropped.

Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
---
Changes in v2:
- Change logging to consistently use drm_err()
- Link to v1: https://patch.msgid.link/20260719-drm_simple_encoder_init-v1-0-a78c509e3062@gmail.com

To: Jingoo Han <jingoohan1@gmail.com>
To: Inki Dae <inki.dae@samsung.com>
To: Seung-Woo Kim <sw0312.kim@samsung.com>
To: Kyungmin Park <kyungmin.park@samsung.com>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Krzysztof Kozlowski <krzk@kernel.org>
To: Peter Griffin <peter.griffin@linaro.org>
To: Alim Akhtar <alim.akhtar@samsung.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: Michal Simek <michal.simek@amd.com>
To: Thierry Reding <thierry.reding@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
To: Jonathan Hunter <jonathanh@nvidia.com>
To: Stefan Agner <stefan@agner.ch>
To: Alison Wang <alison.wang@nxp.com>
To: Anitha Chrisanthus <anitha.chrisanthus@intel.com>
To: David Airlie <airlied@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Gurchetan Singh <gurchetansingh@chromium.org>
To: Chia-I Wu <olvaffe@gmail.com>
To: Jyri Sarha <jyri.sarha@iki.fi>
To: Liu Ying <victor.liu@nxp.com>
To: Frank Li <Frank.Li@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
To: Matthias Brugger <matthias.bgg@gmail.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
To: Xinliang Liu <xinliang.liu@linaro.org>
To: Sumit Semwal <sumit.semwal@linaro.org>
To: Yongqin Liu <yongqin.liu@linaro.org>
To: John Stultz <jstultz@google.com>
To: Liviu Dudau <liviu.dudau@arm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Kevin Hilman <khilman@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: Jonathan Corbet <corbet@lwn.net>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org
Cc: virtualization@lists.linux.dev
Cc: imx@lists.linux.dev
Cc: linux-mediatek@lists.infradead.org
Cc: linux-renesas-soc@vger.kernel.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-doc@vger.kernel.org

---
Diogo Silva (15):
      drm/exynos: remove dependency on DRM simple helpers
      drm/xlnx/zynqmp_dpsub: remove dependency on DRM simple helpers
      drm/tegra: remove dependency on DRM simple helpers
      drm/fsl-dcu: remove dependency on DRM simple helpers
      drm/kmb: remove dependency on DRM simple helpers
      drm/virtio: remove dependency on DRM simple helpers
      drm/tidss: remove dependency on DRM simple helpers
      drm/imx: remove dependency on DRM simple helpers
      drm/mediatek: remove dependency on DRM simple helpers
      drm/renesas/shmobile: remove dependency on DRM simple helpers
      drm/hisilicon/kirin: remove dependency on DRM simple helpers
      drm/arm/komeda: remove dependency on DRM simple helpers
      drm/meson: remove dependency on DRM simple helpers
      drm/drm_simple: remove deprecated drm_simple_encoder_init function
      Documentation/gpu: remove completed drm_simple_encoder_init() todo

 Documentation/gpu/todo.rst                        | 15 ---------------
 drivers/gpu/drm/arm/display/komeda/komeda_crtc.c  |  9 +++++++--
 drivers/gpu/drm/drm_simple_kms_helper.c           | 13 ++-----------
 drivers/gpu/drm/exynos/exynos_dp.c                | 13 +++++++++++--
 drivers/gpu/drm/exynos/exynos_drm_dpi.c           | 13 +++++++++++--
 drivers/gpu/drm/exynos/exynos_drm_dsi.c           | 11 +++++++++--
 drivers/gpu/drm/exynos/exynos_drm_vidi.c          | 13 +++++++++++--
 drivers/gpu/drm/exynos/exynos_hdmi.c              | 14 ++++++++++++--
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c         | 10 +++++++---
 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c      |  9 +++++++--
 drivers/gpu/drm/imx/dc/dc-kms.c                   |  8 ++++++--
 drivers/gpu/drm/kmb/kmb_dsi.c                     |  9 +++++++--
 drivers/gpu/drm/mediatek/mtk_dsi.c                | 10 +++++++---
 drivers/gpu/drm/meson/meson_encoder_cvbs.c        | 11 ++++++++---
 drivers/gpu/drm/meson/meson_encoder_dsi.c         | 11 ++++++++---
 drivers/gpu/drm/meson/meson_encoder_hdmi.c        | 11 ++++++++---
 drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c | 10 +++++++---
 drivers/gpu/drm/tegra/dsi.c                       | 16 +++++++++++++---
 drivers/gpu/drm/tegra/rgb.c                       | 15 +++++++++++++--
 drivers/gpu/drm/tidss/tidss_encoder.c             | 10 +++++++---
 drivers/gpu/drm/virtio/virtgpu_display.c          | 12 ++++++++++--
 drivers/gpu/drm/xlnx/zynqmp_kms.c                 | 14 ++++++++++++--
 include/drm/drm_simple_kms_helper.h               |  4 ----
 23 files changed, 183 insertions(+), 78 deletions(-)
---
base-commit: e1113c37ba4f166e37dec74a729e6dfd8cba1687
change-id: 20260718-drm_simple_encoder_init-d069a4cc7f8b

Best regards,
--  
Diogo Silva <diogompaissilva@gmail.com>

