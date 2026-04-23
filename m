Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4685FF9935C
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 09:17:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4E8F10E328;
	Thu, 23 Apr 2026 09:17:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="q5bujtby";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63F6810E310;
 Thu, 23 Apr 2026 09:17:49 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id EEBA81A33BC;
 Thu, 23 Apr 2026 09:17:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B05A060495;
 Thu, 23 Apr 2026 09:17:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8ED6210460A92; 
 Thu, 23 Apr 2026 11:17:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776935862; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=fg+cfL7RFhXRqyxQ+5IEhbipfMHZKY0UpIKJXrJ9fFQ=;
 b=q5bujtbykq4zXmP/ViiTPdoLiG5rI0IaZoAA1hMcWIsLUIjEVEl28d937PxTSzkcMAo/iZ
 FfPwWtnuuqp+IknsHgvp3qm2VGtVpuHNGfMwGTXr2NkdUJOEtPHMV4UHRqdwWxLZYY/52V
 TZjndhPSGi4MLc5sduluxvM9nY9F6d73IxJ7XGYOWbGdcr5LPkjFcaZUqMHKClI3ggDkmt
 vv2RfEgf0BziLtsSNwVeni3K0HcfWG0FFpxhXmTS2A0O9EMNfYm5uB4MovAIlAdrmlJuqv
 x5G5QDqMA5j0QJvF0aKhDcR51xqodoTterNKBN6akBGsCUESvx0TKhaoHu4wbA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v2 00/41] drm/display: bridge-connector: attach encoder to
 the connector
Date: Thu, 23 Apr 2026 11:16:54 +0200
Message-Id: <20260423-drm-bridge-connector-attach_encoder-v2-0-2ae6ca69b390@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIbj6WkC/42OQQ7CIBBFr9KwFkOJhcaV9zCNgWFqx1gwgI2m6
 d2lNe5dvsz/78/MEkbCxI7VzCJOlCj4AnJXMRiMvyInV5hJIZU41Iq7OHIbyZULBO8Rcojc5Gx
 guKCH4DByUE1tQDRaND0rpkfEnl7byrn7cnraW+mu6jUxUCqe9/bGVK+536L+a3GqueBK29a2v
 W21NCcbQr6T30MYWbcsywfd2mBG6gAAAA==
X-Change-ID: 20260416-drm-bridge-connector-attach_encoder-c651ac05705f
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>, Janne Grunau <j@jannau.net>, 
 Liu Ying <victor.liu@nxp.com>, Douglas Anderson <dianders@chromium.org>, 
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Cercueil <paul@crapouillou.net>, 
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, Jingoo Han <jingoohan1@gmail.com>, 
 Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
 Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, 
 Jyri Sarha <jyri.sarha@iki.fi>, Michal Simek <michal.simek@amd.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, asahi@lists.linux.dev, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-mips@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 linux-tegra@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org
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

This series simplifies using the bridge-connector by removing the need to
attach the newly created connector to the encoder.

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
   (only the last one is somewhat non-obvious)

The Cc list is huge due to the many drivers touched. I sent v1 to a reduced
Cc list to ensure there is an agreement about the overall idea. That seems
to be the case, so now it's time to copy all drivers maintainers.

It would be nice to apply all of this series at once to avoid duplicated
calls to drm_connector_attach_encoder() in the interim. That would be
harmless beacuse drm_connector_attach_encoder() is idempotent, but
unpleasant.

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
Changes in v2:
- patch 1: update kdoc
- patch 41: fix by rewriting it fully
- update cover letter
- Link to v1: https://patch.msgid.link/20260417-drm-bridge-connector-attach_encoder-v1-0-67b8b8fb872a@bootlin.com

To: Andrzej Hajda <andrzej.hajda@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Robert Foss <rfoss@kernel.org>
To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
To: Jonas Karlman <jonas@kwiboo.se>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Sasha Finkelstein <fnkl.kernel@gmail.com>
To: Janne Grunau <j@jannau.net>
To: Liu Ying <victor.liu@nxp.com>
To: Douglas Anderson <dianders@chromium.org>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Lucas Stach <l.stach@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
To: Paul Cercueil <paul@crapouillou.net>
To: Anitha Chrisanthus <anitha.chrisanthus@intel.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Kevin Hilman <khilman@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>
To: Dmitry Baryshkov <lumag@kernel.org>
To: Abhinav Kumar <abhinav.kumar@linux.dev>
To: Jessica Zhang <jesszhan0024@gmail.com>
To: Sean Paul <sean@poorly.run>
To: Marijn Suijten <marijn.suijten@somainline.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To: Sandy Huang <hjc@rock-chips.com>
To: Heiko Stübner <heiko@sntech.de>
To: Andy Yan <andy.yan@rock-chips.com>
To: Thierry Reding <thierry.reding@gmail.com>
To: Mikko Perttunen <mperttunen@nvidia.com>
To: Jonathan Hunter <jonathanh@nvidia.com>
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Jingoo Han <jingoohan1@gmail.com>
To: Inki Dae <inki.dae@samsung.com>
To: Seung-Woo Kim <sw0312.kim@samsung.com>
To: Kyungmin Park <kyungmin.park@samsung.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
To: Alim Akhtar <alim.akhtar@samsung.com>
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
To: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
To: Magnus Damm <magnus.damm@gmail.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
To: Marek Vasut <marex@denx.de>
To: Stefan Agner <stefan@agner.ch>
To: Jyri Sarha <jyri.sarha@iki.fi>
To: Michal Simek <michal.simek@amd.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>
Cc: Ian Ray <ian.ray@gehealthcare.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: asahi@lists.linux.dev
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mips@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-arm-msm@vger.kernel.org
Cc: freedreno@lists.freedesktop.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-tegra@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org

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
 drivers/gpu/drm/display/drm_bridge_connector.c    | 11 +++++++++--
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
 drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c | 16 +++++++---------
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
 41 files changed, 25 insertions(+), 117 deletions(-)
---
base-commit: 77fec37c895fcbdefbcec97cefd6d1f5cfdf1e3a
change-id: 20260416-drm-bridge-connector-attach_encoder-c651ac05705f

Best regards,
--  
Luca Ceresoli <luca.ceresoli@bootlin.com>

