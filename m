Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB018F4368B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 09:58:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 009FB10E9AA;
	Fri, 17 Apr 2026 09:58:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="U9UBLlEq";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D5D810E9AA
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 09:58:04 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 093DEC5C3D8;
 Fri, 17 Apr 2026 09:58:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 98D5460497;
 Fri, 17 Apr 2026 09:58:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5BDED104609C5; 
 Fri, 17 Apr 2026 11:57:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776419881; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=9tksX5jngT0NJLPZHJpmsYi263RB3YgCiQVJtTgFpu0=;
 b=U9UBLlEqoXAUQmM/XMtKrnan08gqCSMMUedHIi9Qx9N7/jLIiGkTZ/9AgxiZDGZdv957p7
 wdVXcRclnKQSz4Y/g1MxaKMp6/muBZos4aSNRoQSuLlN5jMoBYoDDxgAs1+v8ZZyvMW/A6
 F2pjKTrGMoJyo52/U3o0RvUmGX8yLD41ktrc/XOjYqr5Igsb3hELAJxJo2sanyKhCZBMQd
 yi+kigGrb0u3gaW5reTR+UQZKJtFsDz4CiHEQc78WYlLqYhSWAe3hetnNCQO13/2L+e88/
 LNkD9jWua9zkPGH4Wc2IwqDNCSDrCk5DNUQjbsOLEYwSTPTXExMEXhjw+Kxsjg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 00/41] drm/display: bridge-connector: attach encoder to the
 connector
Date: Fri, 17 Apr 2026 11:57:48 +0200
Message-Id: <20260417-drm-bridge-connector-attach_encoder-v1-0-67b8b8fb872a@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAB0E4mkC/yWN0QrCMAxFf2Xk2UA7bAV/RUS6NHMRTCWtIoz9u
 1UfD4d77gqVTbjCcVjB+CVVinbwuwFoSXpllNwZRjdGt/cRs91xMsndUFFlasUwtZZoubBSyWx
 IMfhELhxcmKGXHsazvH8vp/Of63O69e03Ddv2ATJD5WmHAAAA
X-Change-ID: 20260416-drm-bridge-connector-attach_encoder-c651ac05705f
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
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

This series removes the need for all users of the bridge-connector to
attach the encoder to the newly created connector.

== Series description

Currently all users of the bridge-connector must call
drm_connector_attach_encoder() immediately after a successful
drm_bridge_connector_init().

This is an unnecessary burden for users. Move the call to the end of
drm_bridge_connector_init() so all callers can be simplified.

 * Patch 1 adds a drm_connector_attach_encoder() call at the end of
   drm_bridge_connector_init()
 * The other patches remove drm_connector_attach_encoder() after all
   drm_bridge_connector_init() calls, ordered from the simplest ones
   the the slightly more complex (very few)

The Cc list would be huge due to the many drivers touched. I'm sending this
v1 only to the short Cc list that applies to drm_bridge_connector.c, in
order to allow discussing the idea without too much spam. If the idea is OK
I can send v2 to all driver owners too.

It would be nice to apply all of this series at once to avoid duplicated
calls to drm_connector_attach_encoder() in the interim. That would be
harmless [drm_connector_attach_encoder() is idempotent] but unpleasant.

== Additional rationale (for the curious)

Besides making the usage of the bridge-connector a bit simpler, this series
is in preparation for DRM bridge hotplug. Here's why, feel free to skip if
you don't care.

The old bridge hotplug proposals I have sent in the past [1] were based on
a hotplug-bridge driver to sit between the last fixed bridge and the first
hotplugged bridge. Discussion with the community led to the need of
removing the hotplug-bridge and let common DRM code handle hotplug. The
common place of code that appears the most suitable for hotplug handling is
the bridge-connector, which is by now the recommended way to handle
connector instantiation after a bridge chain.

So I'm in the process of extending the bridge-connector to be the central
point to handle bridge hotplug. Turns out the need to call
drm_connector_attach_encoder() after drm_bridge_connector_init() has
returned is adding big headaches to such work. So I'm send this long but
simple series to both simplify bridge-connector usage and remove one
obstacle from the bridge hotplug work. This series is relevant by itself
anyway.

[1] https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-26-9d6f2c9c3058@bootlin.com/

== Grand plan

This is part of the work to support hotplug of DRM bridges. The grand plan
was discussed in [0].

Here's the work breakdown (➜ marks the current series):

 1. … add refcounting to DRM bridges struct drm_bridge,
      based on devm_drm_bridge_alloc()
    A. ✔ add new alloc API and refcounting (v6.16)
    B. ✔ convert all bridge drivers to new API (v6.17)
    C. ✔ kunit tests (v6.17)
    D. ✔ add get/put to drm_bridge_add/remove() + attach/detach()
         and warn on old allocation pattern (v6.17)
    E. … add get/put on drm_bridge accessors
       1. ✔ drm_bridge_chain_get_first_bridge(), add cleanup action (v6.18)
       2. ✔ drm_bridge_get_prev_bridge() (v6.18)
       3. ✔ drm_bridge_get_next_bridge() (v6.19)
       4. ✔ drm_for_each_bridge_in_chain() (v6.19)
       5. ✔ drm_bridge_connector_init (v6.19)
       6. ✔ protect encoder bridge chain with a mutex (v7.2)
       7. … of_drm_find_bridge
          a. ✔ add of_drm_get_bridge() (v7.0),
	       convert basic direct users (v7.0-v7.1)
	  b. ✔ convert direct of_drm_get_bridge() users, part 2 (v7.0)
	  c. ✔ convert direct of_drm_get_bridge() users, part 3 (v7.0)
	  d. ✔ convert direct of_drm_get_bridge() users, part 4 (v7.1-v7.2)
	  e. … convert bridge-only drm_of_find_panel_or_bridge() users
       8. drm_of_find_panel_or_bridge, *_of_get_bridge
       9. ✔ enforce drm_bridge_add before drm_bridge_attach (v6.19)
    F. ✔ debugfs improvements
       1. ✔ add top-level 'bridges' file (v6.16)
       2. ✔ show refcount and list lingering bridges (v6.19)
 2. … handle gracefully atomic updates during bridge removal
    A. ✔ Add drm_bridge_enter/exit() to protect device resources (v7.0)
    B. … protect private_obj removal from list
    C. ✔ Add drm_bridge_clear_and_put() (v7.1)
 3. … DSI host-device driver interaction
 4. ✔ removing the need for the "always-disconnected" connector
 5. ✔ Migrate i.MX LCDIF driver to bridge-connector (v7.2)
 6. ➜ DRM bridge hotplug
    A. ➜ Bridge hotplug management in the DRM core
       1. ➜ bridge-connector: attach encoder to the connector
    B.   Device tree description

[0] https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-0-9d6f2c9c3058@bootlin.com/#t

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Luca Ceresoli (41):
      drm/display: bridge-connector: attach the encoder to the created connector
      drm: adp: remove now-redundant call to drm_connector_attach_encoder()
      drm/bridge: adv7511: remove now-redundant call to drm_connector_attach_encoder()
      drm/bridge: ite-it6263: remove now-redundant call to drm_connector_attach_encoder()
      drm/bridge: ti-sn65dsi86: remove now-redundant call to drm_connector_attach_encoder()
      drm/imx/dcss: remove now-redundant call to drm_connector_attach_encoder()
      drm/imx: ldb: remove now-redundant call to drm_connector_attach_encoder()
      drm/imx: parallel-display: remove now-redundant call to drm_connector_attach_encoder()
      drm/imx/lcdc: remove now-redundant call to drm_connector_attach_encoder()
      drm/ingenic: remove now-redundant call to drm_connector_attach_encoder()
      drm/kmb/dsi: remove now-redundant call to drm_connector_attach_encoder()
      drm/mediatek: mtk_dpi: remove now-redundant call to drm_connector_attach_encoder()
      drm/mediatek: mtk_dsi: remove now-redundant call to drm_connector_attach_encoder()
      drm/meson: encoder_cvbs: remove now-redundant call to drm_connector_attach_encoder()
      drm/meson: encoder_hdmi: remove now-redundant call to drm_connector_attach_encoder()
      drm/msm/dp: remove now-redundant call to drm_connector_attach_encoder()
      drm/msm/hdmi: remove now-redundant call to drm_connector_attach_encoder()
      drm/omapdrm: remove now-redundant call to drm_connector_attach_encoder()
      rm/rockchip: cdn-dp: remove now-redundant call to drm_connector_attach_encoder()
      drm/rockchip: rk3066_hdmi: remove now-redundant call to drm_connector_attach_encoder()
      drm/tegra: hdmi: remove now-redundant call to drm_connector_attach_encoder()
      drm/tegra: rgb: remove now-redundant call to drm_connector_attach_encoder()
      drm/tests: bridge: remove now-redundant call to drm_connector_attach_encoder()
      drm: verisilicon: remove now-redundant call to drm_connector_attach_encoder()
      drm/exynos: exynos_dp: remove now-redundant call to drm_connector_attach_encoder()
      drm: rcar-du: encoder: remove now-redundant call to drm_connector_attach_encoder()
      drm: renesas: rz-du: rzg2l_du_encoder: remove now-redundant call to drm_connector_attach_encoder()
      drm/rockchip: analogix_dp: remove now-redundant call to drm_connector_attach_encoder()
      drm/rockchip: dw_dp: remove now-redundant call to drm_connector_attach_encoder()
      drm/rockchip: dw_hdmi_qp: remove now-redundant call to drm_connector_attach_encoder()
      drm/rockchip: inno-hdmi: remove now-redundant call to drm_connector_attach_encoder()
      drm/msm/mdp4: remove now-redundant call to drm_connector_attach_encoder()
      drm/msm/dsi: remove now-redundant call to drm_connector_attach_encoder()
      drm/mxsfb/lcdif: remove now-redundant call to drm_connector_attach_encoder()
      drm/rockchip: lvds: remove now-redundant call to drm_connector_attach_encoder()
      drm/tidss: remove now-redundant call to drm_connector_attach_encoder()
      drm/tilcdc: remove now-redundant call to drm_connector_attach_encoder()
      drm: zynqmp_kms: remove now-redundant call to drm_connector_attach_encoder()
      drm/imx: remove now-redundant call to drm_connector_attach_encoder()
      drm/rockchip: rgb: remove now-redundant call to drm_connector_attach_encoder()
      drm: renesas: shmobile: remove now-redundant call to drm_connector_attach_encoder()

 drivers/gpu/drm/adp/adp_drv.c                     |  2 --
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c      |  2 --
 drivers/gpu/drm/bridge/ite-it6263.c               |  2 --
 drivers/gpu/drm/bridge/ti-sn65dsi86.c             |  2 --
 drivers/gpu/drm/display/drm_bridge_connector.c    |  4 ++++
 drivers/gpu/drm/exynos/exynos_dp.c                |  2 +-
 drivers/gpu/drm/imx/dc/dc-kms.c                   |  8 +-------
 drivers/gpu/drm/imx/dcss/dcss-kms.c               |  2 --
 drivers/gpu/drm/imx/ipuv3/imx-ldb.c               |  2 --
 drivers/gpu/drm/imx/ipuv3/parallel-display.c      |  2 --
 drivers/gpu/drm/imx/lcdc/imx-lcdc.c               |  2 --
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c         |  2 --
 drivers/gpu/drm/kmb/kmb_dsi.c                     |  2 +-
 drivers/gpu/drm/mediatek/mtk_dpi.c                |  1 -
 drivers/gpu/drm/mediatek/mtk_dsi.c                |  1 -
 drivers/gpu/drm/meson/meson_encoder_cvbs.c        |  2 --
 drivers/gpu/drm/meson/meson_encoder_hdmi.c        |  2 --
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c          |  7 -------
 drivers/gpu/drm/msm/dp/dp_drm.c                   |  2 --
 drivers/gpu/drm/msm/dsi/dsi_manager.c             |  4 ----
 drivers/gpu/drm/msm/hdmi/hdmi.c                   |  2 --
 drivers/gpu/drm/mxsfb/lcdif_drv.c                 |  6 ------
 drivers/gpu/drm/omapdrm/omap_drv.c                |  2 --
 drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c |  2 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c  |  2 +-
 drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c | 13 +++++++------
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c   |  2 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.c            |  2 --
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c         |  2 +-
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c    |  2 +-
 drivers/gpu/drm/rockchip/inno_hdmi-rockchip.c     |  2 +-
 drivers/gpu/drm/rockchip/rk3066_hdmi.c            |  2 --
 drivers/gpu/drm/rockchip/rockchip_lvds.c          |  6 ------
 drivers/gpu/drm/rockchip/rockchip_rgb.c           |  9 ---------
 drivers/gpu/drm/tegra/hdmi.c                      |  2 --
 drivers/gpu/drm/tegra/rgb.c                       |  2 --
 drivers/gpu/drm/tests/drm_bridge_test.c           |  2 --
 drivers/gpu/drm/tidss/tidss_encoder.c             |  6 ------
 drivers/gpu/drm/tilcdc/tilcdc_encoder.c           |  6 ------
 drivers/gpu/drm/verisilicon/vs_bridge.c           |  1 -
 drivers/gpu/drm/xlnx/zynqmp_kms.c                 |  6 ------
 41 files changed, 20 insertions(+), 112 deletions(-)
---
base-commit: ca8106ff745b2f20c6cef4d731c585b812f41fc2
change-id: 20260416-drm-bridge-connector-attach_encoder-c651ac05705f

Best regards,
--  
Luca Ceresoli <luca.ceresoli@bootlin.com>

