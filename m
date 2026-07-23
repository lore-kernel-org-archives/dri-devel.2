Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4E6C531D0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 09:38:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54B5610E56B;
	Thu, 23 Jul 2026 09:38:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="KmZioJc9";
	dkim-atps=neutral
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBB4C10E396
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 09:38:24 +0000 (UTC)
Received: from francesco-nb.. (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 583621FB1B;
 Thu, 23 Jul 2026 11:38:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1784799502;
 bh=JJLBjhTwK9Uo53TmNSc/cJ9oL3cSqYdaSEVBlK9j7mw=; h=From:To:Subject;
 b=KmZioJc9sYaepD7gYtFjjcIDXj72DQt0fCOxDqITgrd6g54GW5QKCMnSvFzi84PDi
 1R47KYfSgyI46cU3MvkLhIR+b3Inj9CYnkCPaJ9ep6d1YnoHHkILF8kYy0s435I2gT
 ClzG4DWgzGY6gY1GAgcw6JSG0aWWZ0zi/fOjCnxbo5+9NmoPFQeRSZsTXHSMLv8kCI
 +2B80fYvR2pfu+CnFN0/VaFjEPhynDnK7HLoE7HaGBsiRn96wpafF/OU/4zHZiq4Re
 21TFqmkVaHDyDwqTBdz4v0+esdjq7GsbMVxk5UVLxQxO/D1qZCRkMcOE1Ce4LID/1V
 u5yPp/5ZHaRug==
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
 Fabio Estevam <festevam@gmail.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/4] drm: mxsfb: Support LCDIF interface bus width
Date: Thu, 23 Jul 2026 11:38:07 +0200
Message-ID: <20260723093813.180089-1-francesco@dolcini.it>
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

The width of the physical LCDIF output bus can differ from the input bus
format advertised by the downstream panel or bridge.

Such a distinction is required when the LCDIF bus width does not match the
width of the downstream display interface. For example, an 18-bit or
16-bit LCDIF bus can drive a 24-bit display by wiring the available color
bits to the appropriate display inputs. Configuring LCDIF solely from the
display's 24-bit format in this case selects the wrong LCD_DATABUS_WIDTH
mode, changing the color-bit assignment on the LCD_DATA pins and resulting
in incorrect colors.

Use the common OF graph endpoint bus-width property to describe the width
of the physical LCDIF output bus. Make the mxsfb driver derive the
corresponding media bus format from this property and use it in preference
to the format reported by the downstream display. When the property is
absent, the existing behavior is preserved.

Set the endpoint bus width for the Colibri iMX6ULL and Colibri iMX7 boards,
which route an 18-bit LCD interface.

v2: use the common bus-width property instead of the legacy interface-pix-fmt
v1: https://lore.kernel.org/all/20260717121847.488148-1-francesco@dolcini.it/

Francesco Dolcini (4):
  dt-bindings: lcdif: Add endpoint bus-width property
  drm: mxsfb: Add optional DPI output bus-width configuration
  ARM: dts: imx6ull-colibri: Set LCDIF bus-width
  ARM: dts: imx7-colibri: Set LCDIF bus-width

 .../bindings/display/fsl,lcdif.yaml           |  9 +++++++
 .../arm/boot/dts/nxp/imx/imx6ull-colibri.dtsi |  1 +
 arch/arm/boot/dts/nxp/imx/imx7-colibri.dtsi   |  1 +
 drivers/gpu/drm/mxsfb/mxsfb_drv.c             | 24 +++++++++++++++++++
 drivers/gpu/drm/mxsfb/mxsfb_drv.h             |  2 ++
 drivers/gpu/drm/mxsfb/mxsfb_kms.c             | 12 ++++++++++
 6 files changed, 49 insertions(+)

-- 
2.47.3

