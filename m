Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C26CD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 13:14:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3C8010E5C8;
	Thu,  7 May 2026 13:14:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="Yi3RTdkt";
	dkim-atps=neutral
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 768AD89209
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 13:14:23 +0000 (UTC)
Received: from francesco-nb.. (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 7E6761FC43;
 Thu,  7 May 2026 15:14:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1778159661;
 bh=7q/GOfURGrYy6w3lpTO3am2wZSTklcdRe59RfBOMkbc=; h=From:To:Subject;
 b=Yi3RTdkt+G5wqFpDmEgl5PRTIJXcQGaHdazkLzlrOZuQkq51iBg/ruC24bk5wiYAY
 S0j4ExCRXd0ytT8keR993Ve1GjMRWlCcJOqZNu/bsy6eu859ACplyM5P1DlzZqw67n
 HH2i0XaNDr0nEPxBIOXDSBuhfzDUY7PF2+foSERbXUCRGNCLQ0fmaWXjFWEC7Y1SSZ
 ZIF2isoel2+wwvUj0PaeF8N47fFSBBuI/m6S4/yExqbE54HNHp17eu7+IXVZeUpx9I
 pxt61J89eWOP04edIaobQjDCq+KdkCpWbRJi0XJZLZVZvq9YNBUCRN4Qr8peytFlPo
 FSyw0OG+vqISA==
From: Francesco Dolcini <francesco@dolcini.it>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add entry for Toshiba TC358768/TC358778 DRM
 bridge
Date: Thu,  7 May 2026 15:14:06 +0200
Message-ID: <20260507131407.77711-1-francesco@dolcini.it>
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

Add a MAINTAINERS entry for the Toshiba TC358768/TC358778
parallel RGB to MIPI-DSI bridge DRM driver and associated DT
bindings.

The driver has active users and ongoing maintenance activity.
I have been working on the driver for some time and have access
to the Toshiba hardware documentation as well as hardware using
the bridge in different display configurations, including setups
using LT8912B and TI DSI bridge devices.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c61ef65d71ef..73a6b240ff78 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8465,6 +8465,12 @@ R:	Douglas Anderson <dianders@chromium.org>
 F:	Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
 F:	drivers/gpu/drm/bridge/ti-sn65dsi86.c
 
+DRM DRIVER FOR TOSHIBA TC358768/TC358778 PARALLEL RGB TO MIPI-DSI BRIDGE
+M:	Francesco Dolcini <francesco@dolcini.it>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
+F:	drivers/gpu/drm/bridge/tc358768.c
+
 DRM DRIVER FOR TPO TPG110 PANELS
 M:	Linus Walleij <linusw@kernel.org>
 S:	Maintained
-- 
2.47.3

