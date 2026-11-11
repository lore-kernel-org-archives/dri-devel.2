Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB22E606A330
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytesatwork-ch.20260707.gappssmtp.com header.i=@bytesatwork-ch.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=cZv7r/QW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B8A210F942;
	Wed, 11 Nov 2026 08:22:53 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F67F10E2AB
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:13:08 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a215e64962so32690755e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 00:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytesatwork-ch.20260707.gappssmtp.com; s=20260707; t=1794384786; x=1794989586;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6d9NY4/sGebTASwnIbgSwLkcj0rsBaL9wxhXAF9kunQ=;
 b=cZv7r/QWqnTDjnNuuhpTQ9a4ztsuY5qykaKZKZQceT4s2TZykMQFY+/QsbEtQvj4BN
 GZzvvZl6oLtwHENmPR8TWaWb/XxegF90cbwSgsKhwgI0wO+5sQcivFsxcKnOv8cZc2s+
 I2bDYH4fFQUMEQjxc+GEKoRFl+SYOevDGsjqumvEBKWGDd9I5bhf04HUk8ZxORNZl7lv
 v2G1SdXyXHK0oe72zw8D0UpovrPf7/aKc4GTXm3Ht+lsMDyRQJcJQNVVQ1fufAYHmZIq
 ZyMG1PWpRJhjxpoaSvQWyTww7a4bcSMkjxumwm4yN9vyeqw5XpNxbABRKzj35cGLMNuo
 GsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794384786; x=1794989586;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6d9NY4/sGebTASwnIbgSwLkcj0rsBaL9wxhXAF9kunQ=;
 b=Lz+Bz/K7frBk8hEE9Q6Q1kzkLlqIgxvKuh9LdOaVqGjJoPA9v2IIMNfY8apJ7p46hx
 HBB9byeFB8epgzzwfNgq7Crw/UH0VayGnnI6orjJOJE14Vwh3zsS7DmmRSpLiiAA4jWi
 oj2p81iHoYveZeRsmeyCPVnRkpi/GA6yjKGJ8l5YdBupSIRN9q2jcINmsuApcforuTgw
 oQkda4avOcj2Xt6v1Cic9gmXuJXmgWG4agQiQf8J+TdPdoRM1ZsVPL6wiZVlOopFFLJO
 MOmWs/xQoGmY8W3cS3BUB2Gdp1bYgPk6L69bkhxl9SJ8rdgw/4XUI8UMh/bxGYfAzvK9
 4t5Q==
X-Forwarded-Encrypted: i=1;
 AL+hErFf7dvH3dfRXpZF6z6NZGicYb0ff+pJftUO55ibImv+Y7EMV1dsJGBa4xhtPbGFdoBKRkbHSdfLH6c=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z89teJmZgLCVWGXYxMu1eBQMUSHlzWs/5Jww5tSA7D88Vi1XFlN
 rWHfmsAoVtkO9lRlVOIj/SbAadIvE4J8L0joDCnYfQbYi4DKm8UkNTvAlPH9+jehZpo=
X-Gm-Gg: AYBFou0HqSjgMYA/nHx2rNqsDDd9a+aLFAEXmFTkD3EqcCJoBVxHHExy+NIEv+FpxrD
 tOMa0E1sSjqjhEs9jFY0ERReEZogYjKdPpkHEpKRGm0+hvsXH9okisBuAjmDXewNoBQG/MsFCS2
 0lDMVauB/BF09JdaAeKZMLVYTk5ENfK45RUjOnE3pFxkx0XPuZ/hmOUwGIA8lFDIIRXnYtrRYya
 3ftQ/x7AfwPFe/i/zK5SIrgQ2e4CQKp47QMuiUAIqY4JQBuA/Od5lPiVutRUcCjhO7HzuMreB9Y
 NX7LfYVTiDQbR4mjpPgGPi3UxAQW/kvVu362BVzIu8lbMU7LPvSlhRkaQ2udAVnxKi+gIC1TeXn
 t+MpkTAtwtpw+yWExEsSsF1Il0P74zuaX82v7Dq/Ntk2m8aHcSETxNvN9RUwdqDLgpoxJUB0R+S
 8sazg9Q8bxt+zxkGJ55rNgseFm80vO6RULvwdw/Xiz+TyX0dhb9R/PPX2S7ZHYWCulq+eqbIVlL
 RaR7/KW8Kx0G/MqHRwICRm75G29/Anv8KwGv+2trwlhYW5WjesaacxOFX2fqKhEbh+f3qbNbWHA
 m+gE0pt68KnNUK+eVzqpuem1aO9S5ZoUNTcON1MoT2Nmq70OHE26f0QxXONy0LW9zyeu1ZHwgLL
 boUX6ZYUqUQ==
X-Received: by 2002:a05:600c:6214:b0:4b5:d95c:2378 with SMTP id
 5b1f17b1804b1-4ba0939815cmr24681275e9.34.1794384786446; 
 Wed, 11 Nov 2026 00:13:06 -0800 (PST)
Received: from frobdeb.bytesatwork.ch (162.40.150.83.ftth.as8758.net.
 [83.150.40.162]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba02242bd9sm113233815e9.15.2026.11.11.00.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 00:13:05 -0800 (PST)
From: Frank Obergfell <frank.obergfell@bytesatwork.ch>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Frank Li <Frank.Li@nxp.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Walle <mwalle@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Alexander Forsch <alexander.forsch@bytesatwork.ch>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] arm64: dts: freescale: Add support for bytesatwork
 byteDEVKIT i.MX93
Date: Wed, 11 Nov 2026 09:11:45 +0100
Message-ID: <20261111081150.950272-1-frank.obergfell@bytesatwork.ch>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 11 Nov 2026 08:22:47 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series introduces support for the bytesatwork byteENGINE i.MX93
System on Module (SoM) and the carrier board byteDEVKIT.
It also adds display support for the integrated Youritech et050fw01-kt
MIPI-DSI panel by extending the existing ILI9806E panel driver.

Changes in v2:
- Patch 1:
  - Use specific panel part number (youritech,et050fw01-kt) instead of generic controller name.
  - Elaborate commit message with vendor description, panel resolution and dimensions.
- Patch 2:
  - Update compatible string and function names to match youritech,et050fw01-kt.
  - Fix commit subject formatting and commit message.
- Patch 3:
  - No changes.
- Patch 4:
  - Drop standalone SoM compatible entry from fsl.yaml (only bootable board combinations allowed).
  - Fix typo in commit message ("byteDEVKIT carrier board").
- Patch 5:
  - Update panel compatible string to youritech,et050fw01-kt.
  - Invert GT911 GPIO polarity to GPIO_ACTIVE_HIGH to fix address strapping and reset.
  - Assign pinctrl_usb2 to reg_usb2_vbus and add vbus-supply to usbotg2.
  - Add disable-over-current to usbotg1 and usbotg2.
  - Move panel reset GPIO into dedicated pinctrl_panel_reset group on panel@0.
  - Standardize Ethernet PHY node names to ethernet-phy@... and use tx-fifo-depth.
  - Replace underscores in pinctrl node names with hyphens.
  - Rename tca6418e node to generic gpio@34.
  - Consolidate devkit devicetrees into single imx93-bytedevkit.dts.

Frank Obergfell (5):
  dt-bindings: display: panel: ilitek,ili9806e: Add Youritech et050fw01-kt
  drm/panel: ilitek-ili9806e: Add support for Youritech et050fw01-kt panel
  arm64: dts: freescale: imx93: Add MIPI DSI controller node
  dt-bindings: arm: fsl: Add byteENGINE i.MX93 platforms
  arm64: dts: freescale: Add support for bytesatwork i.MX93

 Documentation/devicetree/bindings/arm/fsl.yaml                |   7 +
 .../devicetree/bindings/display/panel/ilitek,ili9806e.yaml    |   1 +
 Documentation/devicetree/bindings/vendor-prefixes.yaml        |   4 +
 MAINTAINERS                                                   |   7 +
 arch/arm64/boot/dts/freescale/Makefile                        |   1 +
 arch/arm64/boot/dts/freescale/imx93-bytedevkit.dts            | 449 ++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx93-byteengine.dtsi           | 199 ++++++++
 arch/arm64/boot/dts/freescale/imx93.dtsi                      |  34 ++
 drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.c            |   4 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c             | 158 ++++++
 10 files changed, 863 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-bytedevkit.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-byteengine.dtsi
