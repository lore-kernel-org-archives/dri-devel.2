Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA241C4451C
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 12:19:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7D6F10F539;
	Fri, 17 Jul 2026 12:19:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="KLuku6X9";
	dkim-atps=neutral
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D40CD10F534
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 12:19:00 +0000 (UTC)
Received: from francesco-nb.. (unknown [178.82.120.96])
 by mail11.truemail.it (Postfix) with ESMTPA id A4E592272A;
 Fri, 17 Jul 2026 14:18:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1784290738;
 bh=EFuCLGYMCnbLRMYIZ0CTwCE+ic9FazVUGAB/i7iYseA=; h=From:To:Subject;
 b=KLuku6X91PrAs0AOGADuKz5arzfCbtAJqY5ng9vV0eawIWYzYGb3JlG482A5xiNMq
 b6dq/rqrNa0J0i60ifq1FN/uk50KAQ0mK5tL3/5kQxfpFqmCtkfFVa7XeZ4rrY3clH
 GR4+CaOY2p4OKugbynGzNcgEYbQClsWRoUcbxvMlV/faqkVEbBWgpgPc9IWq2baY9C
 IEJbL8elGkMNbCyRLJROMUC6UMdY47othoDhkUWLOB/mBU4uTPwFwibjplp2/vxOrN
 oki7t6a9U2w/renqrbI4QRBsd2zFD+u/JO9mR+n9E9VEpfHsrVw5RUZWg01gbDdS83
 UawJFAodslSVA==
From: Francesco Dolcini <francesco@dolcini.it>
To: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
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
Subject: [PATCH v1 0/4] drm: mxsfb: Support LCDIF interface pixel format
Date: Fri, 17 Jul 2026 14:18:42 +0200
Message-ID: <20260717121847.488148-1-francesco@dolcini.it>
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

The LCDIF data bus format describes how color component bits are assigned
to the physical LCD_DATA pins. This is a property of the LCDIF-to-display
wiring and can differ from the input format advertised by the downstream
panel or bridge.

Such a distinction is required when a narrower LCDIF bus is connected to
a wider display interface. For example, an 18-bit or 16-bit LCDIF bus can
drive a 24-bit display by wiring the available color bits to the
appropriate display inputs. Configuring LCDIF from the display's 24-bit
format in this case selects the wrong LCD_DATABUS_WIDTH mode, changing the
color-bit assignment on the LCD_DATA pins and resulting in incorrect
colors.

Add the optional interface-pix-fmt property to the LCDIF binding and make
the mxsfb driver use it in preference to the format reported by the
downstream display. When the property is absent, the existing behavior is
preserved.

This follows the approach already used by the i.MX IPUv3 parallel display
driver in drivers/gpu/drm/imx/ipuv3/parallel-display.c.

Set the interface format for the Colibri iMX6ULL and Colibri iMX7 boards,
which route an 18-bit LCD interface.

Francesco Dolcini (4):
  dt-bindings: lcdif: Add interface pixel format
  drm: mxsfb: Allow optional LCDIF interface format override
  ARM: dts: imx6ull-colibri: Set LCDIF format
  ARM: dts: imx7-colibri: Set LCDIF format

 .../devicetree/bindings/display/fsl,lcdif.yaml   |  7 +++++++
 arch/arm/boot/dts/nxp/imx/imx6ull-colibri.dtsi   |  1 +
 arch/arm/boot/dts/nxp/imx/imx7-colibri.dtsi      |  1 +
 drivers/gpu/drm/mxsfb/mxsfb_drv.c                | 16 ++++++++++++++++
 drivers/gpu/drm/mxsfb/mxsfb_drv.h                |  2 ++
 drivers/gpu/drm/mxsfb/mxsfb_kms.c                |  8 ++++++++
 6 files changed, 35 insertions(+)

-- 
2.47.3

