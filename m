Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022F9CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:36:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F77110F4B7;
	Mon,  8 Jun 2026 14:36:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jVnuNlwD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8976710F4B7
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:36:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 56C30434B9;
 Mon,  8 Jun 2026 14:36:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F3B1F00893;
 Mon,  8 Jun 2026 14:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780929386;
 bh=GsTDq+HRxdw3n234ip6g0cWAcx0LCpCRxviD69VC1nw=;
 h=From:Subject:Date:To:Cc;
 b=jVnuNlwD7+5kM/vXtwQu5pGlBd6vNrkwn7wCZek0J9x9DjiUyJQalqt9WWZPPByWw
 vKDEY6jHTCFOOc8i9UBI8b0Hd074e/Z59vw+KuksMMZcBje9EC9O78iF8GstWD0b94
 sFbwcdxzbtGu9wzWY1gGZWZbC/nE5mZAcity1h8v2ZooPPWxLQY+0O4njtzAg+VTIw
 izp1WeBIlztyYcNma8Iha7Fn5DF/FnU1rdiRjGLb0ec+Gu9c2NdhgQoi2tUY9cyx/E
 pAyYHNui7BbXc5zkpWDtXXsDAAGKH8u1g46mGIZbvYWgmXNU2XPfe0X1lnJw9CC7h4
 z7bnbmWYcoc8Q==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v2 00/78] drm/bridge: Convert all reset users to create_state
Date: Mon, 08 Jun 2026 16:35:42 +0200
Message-Id: <20260608-drm-no-more-bridge-reset-v2-0-0a91018bf886@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBBFr0Jm7ZgyiBBX3sOwADrCRGnNlDQa0
 rtbOYHL9/P/+xsEVuEAl2ID5ShBvMtAhwLGuXcTo9jMQIbOpq4MWl3QeVy8Mg4qNjeUA6849mR
 szUTNyUCev5Tv8t7Vty7zLGH1+tmfYvlL/5DGEg22TW1bam1VDuP1wer4efQ6QZdS+gJvYyRZw
 QAAAA==
X-Change-ID: 20260530-drm-no-more-bridge-reset-ca20d5e22740
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Liu Ying <victor.liu@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Andy Yan <andy.yan@rock-chips.com>, 
 Phong LE <ple@baylibre.com>, Douglas Anderson <dianders@chromium.org>, 
 Inki Dae <inki.dae@samsung.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Cercueil <paul@crapouillou.net>, linux-mips@vger.kernel.org, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 linux-amlogic@lists.infradead.org, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
 Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>, 
 linux-rockchip@lists.infradead.org, 
 Yannick Fertre <yannick.fertre@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Philippe Cornu <philippe.cornu@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 linux-stm32@st-md-mailman.stormreply.com, Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Michal Simek <michal.simek@amd.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10123; i=mripard@kernel.org;
 h=from:subject:message-id; bh=jEZ6io4SvhHK/SRBUKePCYelb7J9N2xPGLcmhkmnMN0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlql10nV2/s2FIgw/340K0CoxX/FRUf3jx4U7jK/vCC5
 8WcbQfZO6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEJjsz1gexSvS97eljF/ml
 s21RavCBs27RnlMDo4pNT32etIAlLCJ9WbIy3+8bky8/tUhhe/PnAGN9pJuulKjs4UCZNec5/ut
 HHiiwkC+QkvLYefre0vXv+db+jnt58VXVlZJHp865s+7gTj0MAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

Hi, 

All the bridges use reset to create a blank state only and don't use it
to reset the hardware at all. This is what the new atomic_create_state
is exactly supposed to be doing, so we can convert all existing bridge
users to it, and remove the reset hook and helpers.

Let me know what you think,
Maxime 

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Changes in v2:
- Split the return value fix for cadence bridges into their own patches
- Fix bisection
- Collect tags
- Link to v1: https://lore.kernel.org/r/20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org

---
Maxime Ripard (78):
      drm/bridge: cdns-dsi: Return an error pointer on allocation failure
      drm/bridge: cdns-mhdp8546: Return an error pointer on allocation failure
      drm/atomic-state-helper: Rename __drm_atomic_helper_bridge_reset()
      drm/atomic-state-helper: Reorder __drm_atomic_helper_bridge_state_init() arguments
      drm/atomic-state-helper: Drop memset from __drm_atomic_helper_bridge_state_init()
      drm/bridge: Add new atomic_create_state callback
      drm/atomic-state-helper: Add drm_atomic_helper_bridge_create_state()
      drm/bridge: adv7511: Switch to atomic_create_state
      drm/bridge: analogix_dp: Switch to atomic_create_state
      drm/bridge: anx7625: Switch to atomic_create_state
      drm/bridge: chipone-icn6211: Switch to atomic_create_state
      drm/bridge: display-connector: Switch to atomic_create_state
      drm/bridge: fsl-ldb: Switch to atomic_create_state
      drm/bridge: imx8mp-hdmi-pvi: Switch to atomic_create_state
      drm/bridge: imx8qm-ldb: Switch to atomic_create_state
      drm/bridge: imx8qxp-ldb: Switch to atomic_create_state
      drm/bridge: imx8qxp-pixel-combiner: Switch to atomic_create_state
      drm/bridge: imx8qxp-pixel-link: Switch to atomic_create_state
      drm/bridge: imx8qxp-pxl2dpi: Switch to atomic_create_state
      drm/bridge: inno-hdmi: Switch to atomic_create_state
      drm/bridge: ite-it6263: Switch to atomic_create_state
      drm/bridge: ite-it6505: Switch to atomic_create_state
      drm/bridge: ite-it66121: Switch to atomic_create_state
      drm/bridge: lontium-lt9211: Switch to atomic_create_state
      drm/bridge: lontium-lt9611: Switch to atomic_create_state
      drm/bridge: lvds-codec: Switch to atomic_create_state
      drm/bridge: nwl-dsi: Switch to atomic_create_state
      drm/bridge: panel: Switch to atomic_create_state
      drm/bridge: parade-ps8640: Switch to atomic_create_state
      drm/bridge: samsung-dsim: Switch to atomic_create_state
      drm/bridge: sii902x: Switch to atomic_create_state
      drm/bridge: ssd2825: Switch to atomic_create_state
      drm/bridge: dw-dp: Switch to atomic_create_state
      drm/bridge: dw-hdmi-qp: Switch to atomic_create_state
      drm/bridge: dw-hdmi: Switch to atomic_create_state
      drm/bridge: dw-mipi-dsi: Switch to atomic_create_state
      drm/bridge: dw-mipi-dsi2: Switch to atomic_create_state
      drm/bridge: tc358762: Switch to atomic_create_state
      drm/bridge: tc358767: Switch to atomic_create_state
      drm/bridge: tc358768: Switch to atomic_create_state
      drm/bridge: tc358775: Switch to atomic_create_state
      drm/bridge: ti-dlpc3433: Switch to atomic_create_state
      drm/bridge: ti-sn65dsi83: Switch to atomic_create_state
      drm/bridge: ti-sn65dsi86: Switch to atomic_create_state
      drm/bridge: ti-tdp158: Switch to atomic_create_state
      drm/bridge: ti-tfp410: Switch to atomic_create_state
      drm/imx: parallel-display: Switch to atomic_create_state
      drm/ingenic: Switch to atomic_create_state
      drm/mediatek: dp: Switch to atomic_create_state
      drm/mediatek: dpi: Switch to atomic_create_state
      drm/mediatek: dsi: Switch to atomic_create_state
      drm/mediatek: hdmi: Switch to atomic_create_state
      drm/mediatek: hdmi_v2: Switch to atomic_create_state
      drm/meson: encoder_cvbs: Switch to atomic_create_state
      drm/meson: encoder_dsi: Switch to atomic_create_state
      drm/meson: encoder_hdmi: Switch to atomic_create_state
      drm/msm: dp: Switch to atomic_create_state
      drm/msm: hdmi: Switch to atomic_create_state
      drm/omap: hdmi4: Switch to atomic_create_state
      drm/omap: hdmi5: Switch to atomic_create_state
      drm/renesas: rcar-du: lvds: Switch to atomic_create_state
      drm/renesas: rcar-du: mipi_dsi: Switch to atomic_create_state
      drm/renesas: rz-du: mipi_dsi: Switch to atomic_create_state
      drm/rockchip: cdn-dp: Switch to atomic_create_state
      drm/rockchip: rk3066_hdmi: Switch to atomic_create_state
      drm/rockchip: lvds: Switch to atomic_create_state
      drm/stm: lvds: Switch to atomic_create_state
      drm/tests: bridge: Switch to atomic_create_state
      drm/tidss: encoder: Switch to atomic_create_state
      drm/tidss: oldi: Switch to atomic_create_state
      drm/vc4: dsi: Switch to atomic_create_state
      drm/verisilicon: Switch to atomic_create_state
      drm/xlnx: zynqmp_dp: Switch to atomic_create_state
      drm/atomic-state-helper: Remove drm_atomic_helper_bridge_reset()
      drm/bridge: cdns-dsi: Use __drm_atomic_helper_bridge_state_init()
      drm/bridge: cdns-dsi: Switch to atomic_create_state
      drm/bridge: cdns-mhdp8546: Switch to atomic_create_state
      drm/bridge: Remove atomic_reset support

 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       |  2 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |  2 +-
 drivers/gpu/drm/bridge/analogix/anx7625.c          |  2 +-
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c     |  9 +++---
 .../gpu/drm/bridge/cadence/cdns-mhdp8546-core.c    |  8 ++---
 drivers/gpu/drm/bridge/chipone-icn6211.c           |  2 +-
 drivers/gpu/drm/bridge/display-connector.c         |  2 +-
 drivers/gpu/drm/bridge/fsl-ldb.c                   |  2 +-
 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c       |  2 +-
 drivers/gpu/drm/bridge/imx/imx8qm-ldb.c            |  2 +-
 drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c           |  2 +-
 .../gpu/drm/bridge/imx/imx8qxp-pixel-combiner.c    |  2 +-
 drivers/gpu/drm/bridge/imx/imx8qxp-pixel-link.c    |  2 +-
 drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c       |  2 +-
 drivers/gpu/drm/bridge/inno-hdmi.c                 |  2 +-
 drivers/gpu/drm/bridge/ite-it6263.c                |  2 +-
 drivers/gpu/drm/bridge/ite-it6505.c                |  2 +-
 drivers/gpu/drm/bridge/ite-it66121.c               |  2 +-
 drivers/gpu/drm/bridge/lontium-lt9211.c            |  2 +-
 drivers/gpu/drm/bridge/lontium-lt9611.c            |  2 +-
 drivers/gpu/drm/bridge/lvds-codec.c                |  2 +-
 drivers/gpu/drm/bridge/nwl-dsi.c                   |  2 +-
 drivers/gpu/drm/bridge/panel.c                     |  2 +-
 drivers/gpu/drm/bridge/parade-ps8640.c             |  2 +-
 drivers/gpu/drm/bridge/samsung-dsim.c              |  2 +-
 drivers/gpu/drm/bridge/sii902x.c                   |  2 +-
 drivers/gpu/drm/bridge/ssd2825.c                   |  2 +-
 drivers/gpu/drm/bridge/synopsys/dw-dp.c            |  2 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c       |  2 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |  2 +-
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c      |  2 +-
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c     |  2 +-
 drivers/gpu/drm/bridge/tc358762.c                  |  2 +-
 drivers/gpu/drm/bridge/tc358767.c                  |  4 +--
 drivers/gpu/drm/bridge/tc358768.c                  |  2 +-
 drivers/gpu/drm/bridge/tc358775.c                  |  2 +-
 drivers/gpu/drm/bridge/ti-dlpc3433.c               |  2 +-
 drivers/gpu/drm/bridge/ti-sn65dsi83.c              |  2 +-
 drivers/gpu/drm/bridge/ti-sn65dsi86.c              |  2 +-
 drivers/gpu/drm/bridge/ti-tdp158.c                 |  2 +-
 drivers/gpu/drm/bridge/ti-tfp410.c                 |  2 +-
 drivers/gpu/drm/drm_atomic_state_helper.c          | 34 ++++++++++++----------
 drivers/gpu/drm/drm_bridge.c                       |  4 +--
 drivers/gpu/drm/imx/ipuv3/parallel-display.c       |  2 +-
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c          |  2 +-
 drivers/gpu/drm/mediatek/mtk_dp.c                  |  2 +-
 drivers/gpu/drm/mediatek/mtk_dpi.c                 |  2 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c                 |  2 +-
 drivers/gpu/drm/mediatek/mtk_hdmi.c                |  2 +-
 drivers/gpu/drm/mediatek/mtk_hdmi_v2.c             |  2 +-
 drivers/gpu/drm/meson/meson_encoder_cvbs.c         |  2 +-
 drivers/gpu/drm/meson/meson_encoder_dsi.c          |  2 +-
 drivers/gpu/drm/meson/meson_encoder_hdmi.c         |  2 +-
 drivers/gpu/drm/msm/dp/dp_drm.c                    |  4 +--
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c             |  2 +-
 drivers/gpu/drm/omapdrm/dss/hdmi4.c                |  2 +-
 drivers/gpu/drm/omapdrm/dss/hdmi5.c                |  2 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_lvds.c        |  2 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c    |  2 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c     |  2 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.c             |  2 +-
 drivers/gpu/drm/rockchip/rk3066_hdmi.c             |  2 +-
 drivers/gpu/drm/rockchip/rockchip_lvds.c           |  2 +-
 drivers/gpu/drm/stm/lvds.c                         |  2 +-
 drivers/gpu/drm/tests/drm_bridge_test.c            |  2 +-
 drivers/gpu/drm/tidss/tidss_encoder.c              |  2 +-
 drivers/gpu/drm/tidss/tidss_oldi.c                 |  2 +-
 drivers/gpu/drm/vc4/vc4_dsi.c                      |  2 +-
 drivers/gpu/drm/verisilicon/vs_bridge.c            |  4 +--
 drivers/gpu/drm/xlnx/zynqmp_dp.c                   |  2 +-
 include/drm/drm_atomic_state_helper.h              |  6 ++--
 include/drm/drm_bridge.h                           | 33 +++++++--------------
 72 files changed, 112 insertions(+), 120 deletions(-)
---
base-commit: 60dc0946bbad3eef8bc66a5a8b09b98dbc6e09c0
change-id: 20260530-drm-no-more-bridge-reset-ca20d5e22740

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

