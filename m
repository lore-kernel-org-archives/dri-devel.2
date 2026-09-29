Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D5FCA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:36:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B18A10E1A3;
	Tue, 29 Sep 2026 10:36:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="wCR4TJCZ";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3734B10E1A3
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 10:36:49 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id C021C4E410B7;
 Tue, 29 Sep 2026 10:36:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 883CE601BD;
 Tue, 29 Sep 2026 10:36:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5D5D8103295E3; 
 Tue, 29 Sep 2026 12:36:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790678205; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=VvnYtqd0myYRNK/90yLn0GAD8hhlBrrwU4M1ju3ptmQ=;
 b=wCR4TJCZEG1EFZ9sAHD+M9t7myv55BOEKz3ojLI5zZT8kNCNQ69VpEl5WgAyAaIuXU8JYV
 TnAtkjlIUsZjY6BsgZwBu46it15MdA0pkZHV4IBB0BeO6gblx+LFTsXwpwzO7lCu8zmpQq
 RdpdBnGZQSwwdJhHENya2deNsUErubWClvCA2GbjT6k7eQEyxhhReE+7zwrqz8kPJTui1i
 DpntxKdFxNSdU7USbUVpNAWiJ5nEf44lNvBk+ViXRvWUCSS1L4gvH2FFFn0QXCCPoEmxfg
 ZbHJpu0Rfil2TPXIB8Jwt3ffw6lEsxzPhoMzACTwb1pHGMIbjpdV2DjJpYy0HA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 0/7] drm: remove deprecated *_of_get_bridge() from non-OF
 drivers (fixes build regression)
Date: Tue, 29 Sep 2026 12:36:32 +0200
Message-Id: <20260929-drm-fix-of_get_bridge-build-regression-v1-0-ccb7e602daad@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWN0QqDMAxFf0XyvID2Ydj9yhhim7RmbDpSlYH47
 4vz8cC5525QWIUL3KoNlFcpMo0GzaWCOPRjZhQyBle7a+2dR9I3JvnilLrMcxdUyKSwyItQOSu
 XI4G+Tc6ltm8oRrDYR9lW/6P74+SyhCfH+ajDvv8APlv53IoAAAA=
X-Change-ID: 20260929-drm-fix-of_get_bridge-build-regression-98f22f8a1dcc
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Icenowy Zheng <zhengxingda@iscas.ac.cn>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Arnd Bergmann <arnd@kernel.org>, Doug Anderson <dianders@chromium.org>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.16.0
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

After commit Fixes: aa8a8c7e4641 ("drm/bridge: panel: move all code to
drm_panel.c") some drivers fail building:

  error: implicit declaration of function 'devm_drm_of_get_bridge'

This is because devm_drm_of_get_bridge() (and drmm_of_get_bridge()) have
been moved to drm-panel.h.

The affected drivers are those which:

 * can be built without CONFIG_OF, and
 * don't include drm_panel.h

The affected drivers are 3, fix them (patches 1-3) by replacing the
deprecated *_of_get_bridge() calls with of_drm_get_bridge_by_endpoint().

While there, do the same for all drivers which be built without CONFIG_OF,
even if they don't fail (patches 4-7).

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Luca Ceresoli (7):
      drm/imx/lcdc: stop using deprecated devm_drm_of_get_bridge()
      drm: verisilicon: stop using deprecated devm_drm_of_get_bridge()
      drm/bridge: dw-mipi-dsi: stop using deprecated devm_drm_of_get_bridge()
      drm/bridge: dw-mipi-dsi2: stop using deprecated devm_drm_of_get_bridge()
      drm/vc4: dpi: stop using deprecated drmm_of_get_bridge()
      drm/vc4: dsi: stop using deprecated drmm_of_get_bridge()
      drm: renesas: shmobile: stop using deprecated devm_drm_of_get_bridge()

 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c     |  9 +++------
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c    |  9 +++------
 drivers/gpu/drm/imx/lcdc/imx-lcdc.c               |  4 ++--
 drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c |  5 ++---
 drivers/gpu/drm/vc4/vc4_dpi.c                     |  9 ++-------
 drivers/gpu/drm/vc4/vc4_dsi.c                     | 10 ++++------
 drivers/gpu/drm/verisilicon/vs_bridge.c           |  7 +++----
 drivers/gpu/drm/verisilicon/vs_bridge.h           |  1 -
 8 files changed, 19 insertions(+), 35 deletions(-)
---
base-commit: 91ceac83e599c9d48da4c4d2d91410c588a215f7
change-id: 20260929-drm-fix-of_get_bridge-build-regression-98f22f8a1dcc

Best regards,
--  
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

