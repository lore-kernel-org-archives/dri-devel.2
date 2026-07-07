Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131E3C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:11:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 630A310EDCD;
	Tue,  7 Jul 2026 15:11:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X2OMVpVV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2082310EDCD;
 Tue,  7 Jul 2026 15:11:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 375DA600BB;
 Tue,  7 Jul 2026 15:11:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AFFE1F000E9;
 Tue,  7 Jul 2026 15:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783437090;
 bh=JjlforA+ziaBJVLx4Cnr7pb3fjV8I7GXKYxgRHaZVMM=;
 h=From:Subject:Date:To:Cc;
 b=X2OMVpVVZIPZgxnKjrKjswDJh0duEmdapPSfE68qiGhWWIKiIDY0RU163wpGKIaDe
 eGem2XLqIyxXzMI7rOMp33ad74vgjmwJNl5or2vF8DICNrz+8otdvm3vmFtBN2R30e
 C2VA3XzVrOXeVfRfw4v8rOgzBJf7Dr2AUBLvtWrahyFfzWeFNty09CqqQPa20BbzlD
 g8Ce8t9oGlLDKtxa1W9CFIqQtY07w04lRVRfqXm2hbvlWi8f9ZNikY5JwSut+Ba1AL
 6pryS3NyKnoiaqPK+HavXoR4vYMCcYwvj/6b/sNgh8zGu/JJho2AbgO392+U7EAx8s
 9aSuchoVMFnDA==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v2 00/37] drm/bridge: Convert all bridges to atomic
Date: Tue, 07 Jul 2026 17:11:07 +0200
Message-Id: <20260707-drm-all-atomic-bridges-v2-0-21d03cbca446@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WOQQ6CMBBFr0Jm7ZgWsRhX3sO4KHTAiZTqtBKM4
 e4CunX5J3lv3hsiCVOEY/YGoYEjh34e+SaD+mr7lpDdvCFXuVFG79GJR9t1aFPwXGMl7FqKWDh
 bNFS6Zn9oYIbvQg2Pq/h8+W6hx3P2p+8RKhsJ6+A9p2O2WD3HGnsaEy7PUJWocljYK8cU5LU2D
 nqFfznlv5xBo8LK7MjstNHGVKcbSU/dNkgLl2maPp8VRM/5AAAA
X-Change-ID: 20260615-drm-all-atomic-bridges-4da4fe7df58f
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>, Joshua Peisach <jpeisach@ubuntu.com>, 
 Sasha Finkelstein <k@chaosmail.tech>, Janne Grunau <j@jannau.net>, 
 asahi@lists.linux.dev, Benson Leung <bleung@chromium.org>, 
 Guenter Roeck <groeck@chromium.org>, chrome-platform@lists.linux.dev, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Ian Ray <ian.ray@gehealthcare.com>, 
 Peter Senna Tschudin <peter.senna@gmail.com>, 
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
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Ian Ray <ian.ray@gehealthcare.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5894; i=mripard@kernel.org;
 h=from:subject:message-id; bh=HI3ffE+ujzSlcnMKd2l9E+SAUa2JXxPL6wEPc8J2u9o=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm+4gJcoUWvVI19WyLDClrCZKtabhWXCV5aIbT3AMdVa
 73aZpaOqSwMwpwMsmKKLE9kwk4vb19c5WC/8gfMHFYmkCEMXJwCMBF/acaGD8+KT92Pu/z8cfKm
 sw3hWnHKQk6bdh5i/mO39m41F/OpVzaFVr5zZ2yZuTYu1aRIn1GNsT7tUmCS/BrLj5m1V9q/FP9
 YY9Qm9ndNyRHJ65k/NTZ6FU+UnfbF7vQ077xOc5/WY7mdvwA=
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
Changes in v2:
- Rebase on top of current drm-misc-next
- Improve commit messages
- Fix the references in the doc
- Link to v1: https://lore.kernel.org/r/20260617-drm-all-atomic-bridges-v1-0-b63e6316166b@kernel.org

---
Maxime Ripard (37):
      drm/adp: mipi: Add atomic bridge state handlers
      drm/bridge: analogix-anx6345: Switch to atomic bridge callbacks
      drm/bridge: analogix-anx78xx: Switch to atomic bridge callbacks
      drm/bridge: aux-bridge: Add atomic bridge state handlers
      drm/bridge: aux-hpd-bridge: Add atomic bridge state handlers
      drm/bridge: chrontel-ch7033: Switch to atomic bridge callbacks
      drm/bridge: cros-ec-anx7688: Add atomic bridge state handlers
      drm/bridge: lontium-lt8713sx: Add atomic bridge state handlers
      drm/bridge: lontium-lt8912b: Switch to atomic bridge callbacks
      drm/bridge: lontium-lt9611uxc: Add atomic bridge state handlers
      drm/bridge: lvds-codec: Switch to atomic bridge callbacks
      drm/bridge: megachips-stdpxxxx-ge-b850v3-fw: Add atomic bridge state handlers
      drm/bridge: microchip-lvds: Add atomic bridge state handlers
      drm/bridge: nxp-ptn3460: Switch to atomic bridge callbacks
      drm/bridge: of-display-mode-bridge: Add atomic bridge state handlers
      drm/bridge: parade-ps8622: Switch to atomic bridge callbacks
      drm/bridge: sii9234: Add atomic bridge state handlers
      drm/bridge: sil-sii8620: Add atomic bridge state handlers
      drm/bridge: simple-bridge: Switch to atomic bridge callbacks
      drm/bridge: tc358764: Switch to atomic bridge callbacks
      drm/bridge: tda998x: Switch to atomic bridge callbacks
      drm/bridge: ti-tfp410: Switch to atomic bridge callbacks
      drm/bridge: ti-tpd12s015: Add atomic bridge state handlers
      drm/bridge: thc63lvd1024: Switch to atomic bridge callbacks
      drm/bridge: waveshare-dsi: Switch to atomic bridge callbacks
      drm/exynos: mic: Switch to atomic bridge callbacks
      drm/mcde: dsi: Add atomic bridge state handlers
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
 drivers/gpu/drm/drm_bridge.c                       |  61 ++++--------
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
 39 files changed, 287 insertions(+), 351 deletions(-)
---
base-commit: 928e01b05e0a147db8df1152f95acbb801630308
change-id: 20260615-drm-all-atomic-bridges-4da4fe7df58f

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

