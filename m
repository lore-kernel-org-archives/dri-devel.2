Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8190C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:02:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CD7B10E84D;
	Tue,  8 Sep 2026 10:02:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="k2QjJN2P";
	dkim-atps=neutral
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 060F710E9E3
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 10:02:41 +0000 (UTC)
Received: from francesco-nb.corp.toradex.com
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
 by mail11.truemail.it (Postfix) with ESMTPA id 955FB2037C;
 Tue,  8 Sep 2026 12:02:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1788861759;
 bh=s44HXDX+ZX1RHp9/nbKIfpiIWQyXK7l4galcUQO1A5g=; h=From:To:Subject;
 b=k2QjJN2PqtVSe4hTRSXLytQvozeeNJY/ZU2WE1WBNR7+sr1vuxLcKYa4vMj3hqOrS
 rAERFZZ8wX2meMOUpxXCHsEZ9IpnIdAZJ09EuJkliOEZKzWNKrN+QIGzkQrNJ4KPEo
 G8FJQcLm/AjDd/hPr4e4i5zDC/LapZNLPb3YMlLDaLK3jZY2VlvI+3sgwkKu1kkxAy
 PhOBEkB+SwOyii4Ijp2tUAbMU9BYTUe45SBefgACypceakRssTv16iRIJZc7XN3S0M
 B5qvZCj//QaGOTG8dvSNg0GcCkZnwTfTZrTA/ILojTqjkCOWlvGugsMXr8nZGIdafm
 Xwy7+wWhKikAQ==
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco@dolcini.it>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 0/3] drm/bridge: Add Thine THC63LVD827 LVDS encoder and
 10inch LVDS panel on Colibri iMX7
Date: Tue,  8 Sep 2026 12:02:24 +0200
Message-ID: <20260908100230.83796-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Francesco Dolcini <francesco.dolcini@toradex.com>

This series adds support for the Thine THC63LVD827 DPI to LVDS encoder and
afterward uses it to add a DT overlay to enable the Toradex 10inch LVDS panel
on Colibri iMX7 / Iris

Francesco Dolcini (3):
  dt-bindings: display: bridge: Add THine THC63LVD827
  drm/bridge: Add THine THC63LVD827 LVDS encoder
  ARM: dts: imx7d-colibri-emmc: Add Toradex Capacitive Touch Display 10"
    LVDS

 .../display/bridge/thine,thc63lvd827.yaml     | 126 ++++++++++++
 MAINTAINERS                                   |   6 +
 arch/arm/boot/dts/nxp/imx/Makefile            |   6 +
 ...emmc-iris-panel-cap-touch-10inch-lvds.dtso |  92 +++++++++
 drivers/gpu/drm/bridge/Kconfig                |  11 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/thc63lvd827.c          | 193 ++++++++++++++++++
 7 files changed, 435 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/thine,thc63lvd827.yaml
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx7d-colibri-emmc-iris-panel-cap-touch-10inch-lvds.dtso
 create mode 100644 drivers/gpu/drm/bridge/thc63lvd827.c

-- 
2.47.3

