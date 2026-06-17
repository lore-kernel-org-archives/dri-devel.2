Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E80FCD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 10:14:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E094910EF38;
	Wed, 17 Jun 2026 10:14:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Hm5GbP5l";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31BC210EF38;
 Wed, 17 Jun 2026 10:14:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 62645600AA;
 Wed, 17 Jun 2026 10:14:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D18A1F000E9;
 Wed, 17 Jun 2026 10:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781691290;
 bh=Eaa6hysqpPiDJEqUBAFSr3eeLO0CbBPtefrObtR96og=;
 h=From:Subject:Date:To:Cc;
 b=Hm5GbP5loI4zSx0axhqRh95HBZNpLKSFjgkKZE0oqwDjcXK0EVpS1zZeBVq3zgAQw
 vrQYg8lVu5nfTrLRc8pseODvMTpfJWzX8XrJ0lxx5a7E1LimNQy9stWpgGUW0cQGKJ
 EqmBt4I8EtiNDCMPd8geV65T0IRJ5n0fNVusL6k07QIIK8CON3QQjOMleb/2DwYbhd
 pTv92KNcGlzFtZ8MLCvZPZ4R0s+mqrvp5byNVuwE1r37sn0cEueFnIv8IXpMKlM5P+
 S/9dL6HG6KZxpTDUtXvx68PM19A8FeirS5ow4VTX6fzLfWvIMO8G098wUiJjJU/i0Y
 nAeJBEV2kMDqg==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH 00/37] drm/bridge: Convert all bridges to atomic
Date: Wed, 17 Jun 2026 12:14:25 +0200
Message-Id: <20260617-drm-all-atomic-bridges-v1-0-b63e6316166b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02Nyw6CMBBFf6WZtZPU2hblVwyLPqbYhFJtkZgQ/
 l0CLlyem9xzFqhUIlVo2QKF5lhjHjc4nxi4hxl7wug3BsGF5vqs0JeEZhjQTDlFh7ZE31NF6Y0
 M1PigrgG287NQiJ9dfO8OLvR6b/7pGMGaSuhySnFqmebe8ZvU1hoP/+2W7WV14Xt5zJhyoV8WC
 1Wa0BnBvSIhGsnbWUC3rl+1JtrY2AAAAA==
X-Change-ID: 20260615-drm-all-atomic-bridges-4da4fe7df58f
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>, Sasha Finkelstein <k@chaosmail.tech>, 
 Janne Grunau <j@jannau.net>, asahi@lists.linux.dev, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 chrome-platform@lists.linux.dev, Francesco Dolcini <francesco@dolcini.it>, 
 Peter Senna Tschudin <peter.senna@gmail.com>, Ian Ray <ian.ray@ge.com>, 
 Martyn Welch <martyn.welch@collabora.co.uk>, 
 Manikandan Muralidharan <manikandan.m@microchip.com>, 
 Dharma Balasubiramani <dharma.b@microchip.com>, 
 Russell King <linux@armlinux.org.uk>, Inki Dae <inki.dae@samsung.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-mediatek@lists.infradead.org, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 freedreno@lists.freedesktop.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10819; i=mripard@kernel.org;
 h=from:subject:message-id; bh=l45ATxpNcC61gCiINfNL0ijq8s18ot8yNP+uMqYYJ4c=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlGxW1bNlk+99/+01Lky+0FxtucdAQvciQrhhSbzfp4w
 Pn1K57rHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiKqcYG+Y8KEwoXLx1V9im
 tZrv+oQW7q/UL/eX3Kn9427NlL+dx2rKOv32LfJ5eX1d9MKpUhxzfRir2aVXv9m8hX3asatuxrk
 O7Rs+Tz/vs9ph39RrKUsXdGmaK/6YpfKjpuDxiS9qM2ebqChaAgA=
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

Over the years, most of the bridges have been converted to atomic
modesetting and hooks, but not all of them. This forces us to maintain
two different code path in quite a few places, which is pretty
bothersome. The switch to atomic modesetting for legacy bridges though
is pretty trivial, and we don't have a lot of drivers still using the
legacy path.

This series converts all bridges to atomic modesetting and drops the
legacy codepaths where relevant.

Let me know what you think,
Maxime

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Maxime Ripard (37):
      drm/adp: mipi: Switch to atomic bridge callbacks
      drm/bridge: analogix-anx6345: Switch to atomic bridge callbacks
      drm/bridge: analogix-anx78xx: Switch to atomic bridge callbacks
      drm/bridge: aux-bridge: Switch to atomic bridge callbacks
      drm/bridge: aux-hpd-bridge: Switch to atomic bridge callbacks
      drm/bridge: chrontel-ch7033: Switch to atomic bridge callbacks
      drm/bridge: cros-ec-anx7688: Switch to atomic bridge callbacks
      drm/bridge: lontium-lt8713sx: Switch to atomic bridge callbacks
      drm/bridge: lontium-lt8912b: Switch to atomic bridge callbacks
      drm/bridge: lontium-lt9611uxc: Switch to atomic bridge callbacks
      drm/bridge: lvds-codec: Switch to atomic bridge callbacks
      drm/bridge: megachips-stdpxxxx-ge-b850v3-fw: Switch to atomic bridge callbacks
      drm/bridge: microchip-lvds: Switch to atomic bridge callbacks
      drm/bridge: nxp-ptn3460: Switch to atomic bridge callbacks
      drm/bridge: of-display-mode-bridge: Switch to atomic bridge callbacks
      drm/bridge: parade-ps8622: Switch to atomic bridge callbacks
      drm/bridge: sii9234: Switch to atomic bridge callbacks
      drm/bridge: sil-sii8620: Switch to atomic bridge callbacks
      drm/bridge: simple-bridge: Switch to atomic bridge callbacks
      drm/bridge: tc358764: Switch to atomic bridge callbacks
      drm/bridge: tda998x: Switch to atomic bridge callbacks
      drm/bridge: ti-tfp410: Switch to atomic bridge callbacks
      drm/bridge: ti-tpd12s015: Switch to atomic bridge callbacks
      drm/bridge: thc63lvd1024: Switch to atomic bridge callbacks
      drm/bridge: waveshare-dsi: Switch to atomic bridge callbacks
      drm/exynos: mic: Switch to atomic bridge callbacks
      drm/mcde: dsi: Switch to atomic bridge callbacks
      drm/mediatek: dpi: Switch to atomic bridge callbacks
      drm/msm: dsi: Switch to atomic bridge callbacks
      drm/omap: dpi: Switch to atomic bridge callbacks
      drm/omap: dsi: Switch to atomic bridge callbacks
      drm/omap: sdi: Switch to atomic bridge callbacks
      drm/omap: venc: Switch to atomic bridge callbacks
      drm/sti: dvo: Switch to atomic bridge callbacks
      drm/sti: hda: Switch to atomic bridge callbacks
      drm/sti: hdmi: Switch to atomic bridge callbacks
      drm/bridge: Remove legacy bridge callback support

 drivers/gpu/drm/adp/adp-mipi.c                     |   4 +
 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c |  13 ++-
 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c |  13 ++-
 drivers/gpu/drm/bridge/aux-bridge.c                |   4 +
 drivers/gpu/drm/bridge/aux-hpd-bridge.c            |   4 +
 drivers/gpu/drm/bridge/chrontel-ch7033.c           |  13 ++-
 drivers/gpu/drm/bridge/cros-ec-anx7688.c           |   4 +
 drivers/gpu/drm/bridge/lontium-lt8713sx.c          |   4 +
 drivers/gpu/drm/bridge/lontium-lt8912b.c           |   8 +-
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c         |   3 +
 drivers/gpu/drm/bridge/lvds-codec.c                |  10 +-
 .../drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c   |   3 +
 drivers/gpu/drm/bridge/microchip-lvds.c            |   3 +
 drivers/gpu/drm/bridge/nxp-ptn3460.c               |  17 ++--
 drivers/gpu/drm/bridge/of-display-mode-bridge.c    |   4 +
 drivers/gpu/drm/bridge/parade-ps8622.c             |  18 ++--
 drivers/gpu/drm/bridge/sii9234.c                   |   4 +
 drivers/gpu/drm/bridge/sil-sii8620.c               |   4 +
 drivers/gpu/drm/bridge/simple-bridge.c             |  13 ++-
 drivers/gpu/drm/bridge/tc358764.c                  |  13 ++-
 drivers/gpu/drm/bridge/tda998x_drv.c               |  13 ++-
 drivers/gpu/drm/bridge/thc63lvd1024.c              |  14 ++-
 drivers/gpu/drm/bridge/ti-tfp410.c                 |  10 +-
 drivers/gpu/drm/bridge/ti-tpd12s015.c              |   4 +
 drivers/gpu/drm/bridge/waveshare-dsi.c             |  14 ++-
 drivers/gpu/drm/drm_bridge.c                       |  27 +-----
 drivers/gpu/drm/exynos/exynos_drm_mic.c            |  14 ++-
 drivers/gpu/drm/mcde/mcde_dsi.c                    |   3 +
 drivers/gpu/drm/mediatek/mtk_dpi.c                 |  10 +-
 drivers/gpu/drm/msm/dsi/dsi_manager.c              |  13 ++-
 drivers/gpu/drm/omapdrm/dss/dpi.c                  |  14 ++-
 drivers/gpu/drm/omapdrm/dss/dsi.c                  |  14 ++-
 drivers/gpu/drm/omapdrm/dss/sdi.c                  |  14 ++-
 drivers/gpu/drm/omapdrm/dss/venc.c                 |  14 ++-
 drivers/gpu/drm/sti/sti_dvo.c                      |  20 ++--
 drivers/gpu/drm/sti/sti_hda.c                      |  20 ++--
 drivers/gpu/drm/sti/sti_hdmi.c                     |  20 ++--
 drivers/gpu/drm/tests/drm_bridge_test.c            | 104 ---------------------
 include/drm/drm_bridge.h                           | 103 --------------------
 39 files changed, 272 insertions(+), 332 deletions(-)
---
base-commit: 60dc0946bbad3eef8bc66a5a8b09b98dbc6e09c0
change-id: 20260615-drm-all-atomic-bridges-4da4fe7df58f
prerequisite-change-id: 20260530-drm-no-more-bridge-reset-ca20d5e22740:v2
prerequisite-patch-id: 8a8fbf1313a047a4a519f531a71c6c6f87b9bc83
prerequisite-patch-id: a4e58ec70eaf69e00dba8b06a9ea276476d99743
prerequisite-patch-id: d352592969ab04b77b981b3f214f2564e03adbb5
prerequisite-patch-id: 12209462a46aa438a0e5c415de008e2328128fe5
prerequisite-patch-id: 6193aa414873bcc7fa5d1062ed34cc124838ea6a
prerequisite-patch-id: 076dae12bdbc2c270f30588a8d6e95563359b309
prerequisite-patch-id: ffc56b19b1cd7ca4e909224903d8d43b39ae7fc6
prerequisite-patch-id: 5dfc850e535eea05740da327f1ec8ab1a57a3218
prerequisite-patch-id: 128438e2c3f56d29d05cf98486786c307441678b
prerequisite-patch-id: 9f030232058e7b6c6eb9978c0e2ea8baebadbfd8
prerequisite-patch-id: 9aa995e299738e71811fce508043e049216dbee8
prerequisite-patch-id: 3c8c77a634ee316df7d077926b84f97f75ce3b9d
prerequisite-patch-id: d60457e4989ffd8315fc5dfa0fe938f20ba5769e
prerequisite-patch-id: d8aca430669a3514e9c7c8071392fd975c729943
prerequisite-patch-id: f13b78cddc8e1d0a24ad2f07822cddcc2f349d56
prerequisite-patch-id: 274645e4a50795892bba19c49b7228223837e4ee
prerequisite-patch-id: b6e9e252c6b97ff453c31e7ce9f0c7e30af226ad
prerequisite-patch-id: eaf8dc37e5fa9671a749287932de5cedeaa19367
prerequisite-patch-id: ed140d0015fe32b1a312902d6a49dfa505d0c062
prerequisite-patch-id: 1798291a06b97eb5e44521dcb1d2db22266b7322
prerequisite-patch-id: 643d01d3dbe83950d3b3f1cec7adddc297163f24
prerequisite-patch-id: 3e63f40fbd7b98e342da46b1aa377e39fb4e20fe
prerequisite-patch-id: 83a906dc9533cfd63233328737c13092b0117164
prerequisite-patch-id: 24f53e9c4f55a4e879fa5a32b30910ed6c1cd269
prerequisite-patch-id: bd7e4106e2f0ef8608121b0408eac85d0f17b4df
prerequisite-patch-id: 2b76a8943c04e7be9da62a78caa5fc86437d87e3
prerequisite-patch-id: 59b0884a01a819a1d67e9135ea8e313a97bbb4fc
prerequisite-patch-id: bb66b9cc8daa47a2ebedbf0b8bfe67b3f5afc193
prerequisite-patch-id: 476834604d587da752945e53b2e4c6e0aba74b38
prerequisite-patch-id: 0d0c0d400e2dda1b2a2143c2bd34d6a361b97f13
prerequisite-patch-id: 27768e65101e85d23f008b22c9e34e8556334e1c
prerequisite-patch-id: 8ee093b3d6884c6c7dcd5072893c58dad092fda6
prerequisite-patch-id: 9ed3a66dc12bd099b09a495bd8148ecc363d3779
prerequisite-patch-id: 288c493e2466e08e8a7b3137fbb443e17a99e510
prerequisite-patch-id: 6f00079c63b96a7de1603f1524f06c0ad27c2cd3
prerequisite-patch-id: f5c58ba609d0b609afd627e0452d6de34bb12f4e
prerequisite-patch-id: 7f22cb2b55bd93af027ca50709fbbda072c15a06
prerequisite-patch-id: 922a3d5ceb0607718a290ffd1f02e3e573a49cf4
prerequisite-patch-id: 1d79eb945c8ca7ecae7b9d94b3ea07883c0337a9
prerequisite-patch-id: 2f97212d2d87fabca5724d003cc6c70ae1e026b0
prerequisite-patch-id: f667fac52310410fc067bebcf2c12e5757edbc51
prerequisite-patch-id: ddc5ac03c75f6c6bd080e379b1c86c0024f09010
prerequisite-patch-id: 1811f9a95469f9ab89faacc8fa23af3a8def0e10
prerequisite-patch-id: 29684ab02ba8bf4ee366a56627c02ff4ef0d5af3
prerequisite-patch-id: 00ebcbd12168a25f625d41dc4e0fc11659e00773
prerequisite-patch-id: 1c570484a5d1a5209db2290b991dd7914e219e1c
prerequisite-patch-id: 740c4469f788188f0e08fcbe9772ab2654892638
prerequisite-patch-id: 2fb23f6f9a41c7ddf94480c904ad7ec22c161f95
prerequisite-patch-id: d7f382a50b8db0525f2341a86705d01cdfbd9b56
prerequisite-patch-id: d7243d13750efb81a0e93d223f1afd7e30bcae24
prerequisite-patch-id: 6fd0d1296c2b01204a703d740cded71e448f7514
prerequisite-patch-id: e093cf415c55b339b04562e3dc970361a971b226
prerequisite-patch-id: 5f2c35278a4eb15ccf7f388b996a2ae2ba9b7396
prerequisite-patch-id: 9c732ea87d43b26c1e16377fe3a4de42f603f153
prerequisite-patch-id: 0d06852811ed3d3b52b701be99df135772b22d86
prerequisite-patch-id: 972a1fe51fc62083eee9af1ba4cccc2350f87820
prerequisite-patch-id: f78004b914048a14f48f9efbcf95586d84b33f23
prerequisite-patch-id: cd38c76c499c1e9722889d97938b0406eff31940
prerequisite-patch-id: 0777475583042460d0ef343533d8e2c37d3d2c4b
prerequisite-patch-id: 2e535f65d1b8e0e768e8f897f779f06c31d128a6
prerequisite-patch-id: ee47825cdbe1d4b937a6775fca324171015282d1
prerequisite-patch-id: 1e4c68816dc7d1672dfd7e7175a1680a40ab18ae
prerequisite-patch-id: 7509918098c4aabff7639a8f3849f4b2c56fca53
prerequisite-patch-id: fd07b55c2a713e73540f3049818d996fcd5ef966
prerequisite-patch-id: 5b269160fdaa636392cb2f1bf362c0cc393f08b8
prerequisite-patch-id: 021c28b68be7ccbab88067648f9730be2c70cdf6
prerequisite-patch-id: 8b208c636fb9439764239b991fd123ffc1addf1f
prerequisite-patch-id: dd6127d8825c9225abe959d6720b58bbac72a978
prerequisite-patch-id: 0001484c6655bfd60677b5af414aac14cbcf7431
prerequisite-patch-id: 592c6729eac409319be242a8358b469236f159b3
prerequisite-patch-id: dfcbcf6d807e482d41bf04ac4e65227e8ab5f39d
prerequisite-patch-id: 9817811602db4b50fed170d50d43c1989dc06202
prerequisite-patch-id: 6f932774c07dbe23e95a0fa35cdb1d3d9122e84b
prerequisite-patch-id: 70d2333469ba724002e019f785ca50b6fe636648
prerequisite-patch-id: f29fad83d6c2e4bf4e9c4606b7bf1e150f2be3c6
prerequisite-patch-id: d4c58215c22b28a9b7488f666004e399b47dac8b
prerequisite-patch-id: 14734115bea19a7d037f8f68899ac8a4016b3b43
prerequisite-patch-id: 8e74affd6c728fd5096ce92e57bbff3126685151

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

