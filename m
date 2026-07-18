Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36502C44521
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 23:36:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FC9F10E179;
	Sat, 18 Jul 2026 23:36:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qSL3IYkw";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D78810E179
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 23:35:59 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-493c19bad03so66211525e9.2
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 16:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784417758; x=1785022558; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fbveywkXEOoKA5l+wqrU0DqqoG4NoX/G8iLvkPe8hb4=;
 b=qSL3IYkw/VYVKzLdPLYvRA6iyjg4HL7gakXyHb40n1gDFVW+49XWNMgrReVXHFBboj
 AMBijoEYj0X3Z5y3W4HkBvICUMd9JKOd8MtOr5xY3BiiMiDhS6VBiD4jY0zmeAlUehG2
 fcIP2BAPrb+DgUnN6jFt71yZHJijvJYmQqFOrQH+RkAcVL+5SZBF/1thKrvSLhvnkCtr
 UFTuFxLvyAvI4QdD6rxokMXWILJO5NZfHDm7XpLAEil3dQfJU4JmC1EMhJFxjBJzIEfu
 4o9lFPFe8sWZjN+B0+ZEXwXEvnQml18HgaaytcHHWdYdTF0GTdwkULTD81CobMBOs/MM
 f1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784417758; x=1785022558;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fbveywkXEOoKA5l+wqrU0DqqoG4NoX/G8iLvkPe8hb4=;
 b=FbS7t6Mu8pycO3MYvYfEk2bhR3LobONLwUVRZ8b/QROVQ93TvfycWGOgwxm07MJ/rx
 Zrjjpaw2vlOtsoQBriwYphAPhloT2FHn0taBggub9Qs57aILJxMB8OOqlOLnQrgkqrAq
 Ulqkq/nAF+EU50e5O8BVMhqas/Z759aJqaHsMz8QVh7B1mjiqWZ2lsYhQJldGjNqFrfX
 A18uiiAetOCrWSoBv3rWQAv5FiYULOWo762HMcxsXZj3/+6qSWFr71NV5jes9DOdTFBf
 9xA+tk6HbDii9L4hT0f04SM2Wzaf5iECqnSDlgGrLwxfjZ+HXeWv6j7r5DV0KQUYEYON
 IsEw==
X-Gm-Message-State: AOJu0YwAeTEDj2+WeucmFh4mGKi+hhcGi7imgMZxbWN4SjT1JnnkbSVp
 S8SY1Gy7x+/l2imH7DQ057n7xAt4HYXjaEVgX1UPHax0tA3nGGR6zSOoMC2dq4Zs
X-Gm-Gg: AfdE7ckT4lfC9PHujHOFcL1Z2P4fo14EgCqgCUskN3gIdzCHQ6M51GZQgO3eeUPdTVp
 u6mmPb2znVlMHjA+NVX6yl6tR1eK4ZE8QkRe2aGat6zgsCikqf3bbR9hxOtIj4Ajoj9WCha349t
 gNV+kuQYfApTI7nfiblpwacecnQ708ZiWRIdJgkv1fDlNOU9GwGyf6JdFzPz2DxtoGf1sOvlLk5
 ungzDc6BVEDh03+yXUAUy9U/UWFXHRil57XfYbS+97WAlurfdEe/+2ak3/sTywBgdMTxsUe2tj3
 FijRQkS75hR1reaBVzoDhIaxQMyfjrXiqB+SWAZkBacoiYyZ9u+JQOQb+VTAMEGOUCEYDUOCzpr
 8c/1hC3jASv81BTVGd1LhSxwuL5dhh6tEoBE4xQBzskk0bBYMat7qQ+xaeQt7fQg8geZm4Wi8Ao
 Dbtt6jXVaVTg==
X-Received: by 2002:a05:600c:1989:b0:495:699:84ca with SMTP id
 5b1f17b1804b1-4954a798f17mr83663665e9.28.1784417757432; 
 Sat, 18 Jul 2026 16:35:57 -0700 (PDT)
Received: from [127.0.0.2] ([2a01:14:111:ccf0:645b:9e5c:7fe3:c09f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954a2a24b6sm160964675e9.3.2026.07.18.16.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jul 2026 16:35:56 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
Subject: [PATCH 00/15] drm/drm_simple: remove drm_simple_encoder_init
Date: Sun, 19 Jul 2026 01:35:31 +0200
Message-Id: <20260719-drm_simple_encoder_init-v1-0-a78c509e3062@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMQNXGoC/yXM0QqCQBBG4VeRuW5hlVDrVSIWnf2tiVxlRiMQ3
 72tLr+LczYyqMDoXGykeInJlDLKQ0F879INTmI2Vb6qfVO2LuoYTMb5iYDEU4QGSbK46OtTd2R
 uhranXM+KQd6/8+X6t639A7x8d7TvHyUPD1h7AAAA
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
 drivers/gpu/drm/exynos/exynos_drm_dpi.c           | 14 ++++++++++++--
 drivers/gpu/drm/exynos/exynos_drm_dsi.c           | 11 +++++++++--
 drivers/gpu/drm/exynos/exynos_drm_vidi.c          | 14 ++++++++++++--
 drivers/gpu/drm/exynos/exynos_hdmi.c              | 15 +++++++++++++--
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c         | 10 +++++++---
 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c      |  9 +++++++--
 drivers/gpu/drm/imx/dc/dc-kms.c                   |  8 ++++++--
 drivers/gpu/drm/kmb/kmb_dsi.c                     |  9 +++++++--
 drivers/gpu/drm/mediatek/mtk_dsi.c                | 10 +++++++---
 drivers/gpu/drm/meson/meson_encoder_cvbs.c        | 11 ++++++++---
 drivers/gpu/drm/meson/meson_encoder_dsi.c         | 11 ++++++++---
 drivers/gpu/drm/meson/meson_encoder_hdmi.c        | 11 ++++++++---
 drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c | 10 +++++++---
 drivers/gpu/drm/tegra/dsi.c                       | 17 ++++++++++++++---
 drivers/gpu/drm/tegra/rgb.c                       | 14 ++++++++++++--
 drivers/gpu/drm/tidss/tidss_encoder.c             | 10 +++++++---
 drivers/gpu/drm/virtio/virtgpu_display.c          | 12 ++++++++++--
 drivers/gpu/drm/xlnx/zynqmp_kms.c                 | 13 +++++++++++--
 include/drm/drm_simple_kms_helper.h               |  4 ----
 23 files changed, 185 insertions(+), 78 deletions(-)
---
base-commit: e55c6b9a3522aaf1441a0662d534c1c7bfa9b860
change-id: 20260718-drm_simple_encoder_init-d069a4cc7f8b

Best regards,
--  
Diogo Silva <diogompaissilva@gmail.com>

