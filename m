Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A450606A321
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytesatwork-ch.20260707.gappssmtp.com header.i=@bytesatwork-ch.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=V6JfpqpF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F0A91120EE;
	Thu, 12 Nov 2026 12:55:53 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7203B10EA10
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 13:31:40 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a215e64962so35706145e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 05:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytesatwork-ch.20260707.gappssmtp.com; s=20260707; t=1794403899; x=1795008699;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=H0L8NY5KvCN7Y6Y0k6z0RIGpvtUytxSeGPbkleqES2c=;
 b=V6JfpqpFel+BpG1ohjtbUKGR2mdOXL+3npsBiDYNiO2RM88ncEYlP9zk7JfTmeMZHZ
 Qpg+4GV1SjhOum2E4bOGGJQiaFx5JMtDqz6iDawlNZMz8vpIEZG1VUCoWURAAAlRYmk4
 7IHZn3AmdJt1fswktGWZYhdxy5ElX1KTeayiosKrNb/Wrty/wmXKxkRvFuEAn0UF7yLg
 Is99nU7/2Nt14PbGP6jzDzIi18ZZ6xMYaGNOBRBkyPl+xnWv9Xgs+ezndZqtPGfWrsNw
 tg55x7oITILtUA8PwhS2/LCLUdF6I8WmmqFgbX0cmtKVaiDv9KwWkCNYRZNZk+o5M13+
 W5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794403899; x=1795008699;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H0L8NY5KvCN7Y6Y0k6z0RIGpvtUytxSeGPbkleqES2c=;
 b=y/gtv+MmAYfNocCRdO+gAnrgWu+8iOaRZ/nl4yFVUUb2oNy+23EbttjOrGGm91Dmtf
 s15bxFaJ85y7Kah7ihL1dno11BrJAW743vzcwJjpE1A6pG6bfqd5OSpNJE5h+P62BMTv
 AsvnhYkUCKJlGciwO2KUKU1nCQmY7cKnRXGdj06TH04yhP/M3X8vwi45L4WkjKO+7AnT
 0KUuGJjuFLzzQ37HSq9LphxqhEZmTRrHUslUK3XYUpgjre/dwVd+ZEYeN29Pe18LtncY
 O3Xbd4obY8lkHj1EJz2yJQbhDxMs8nrhhCb+K4COzJpRZlT0u0333y0HO6UpoMZW4OIC
 nL8A==
X-Forwarded-Encrypted: i=1;
 AL+hErFlTDMvLcuDw2lMOaR3hHaMnP3AYZOOjsSnc5rvb0Nl+HzZ9bfGyKRTwu5C5/f/7ut6mhjvY3v5n58=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/CecX8B6+EHTLTSWOmB1p32GA6fGfdq+el4oTIG+1CHYYibsM/
 HoZi38slkYWN1hnA/g5ZdAWuZzm7xw9A8wnLnq4bLB0KmSt4wafhsSCXeTCWfG7dYsU=
X-Gm-Gg: AYBFou1XBH/zKM0zC1J0Es6BTsiMEX4MT7YS1GTdyWe1ZdkNENwUDkwm7dIH+b0drJx
 As7SeqJFdJH9/UOgk0VSLbSp5fVtL69aD8US7KPX86zmpcGcoYY8yS1rgIsVxA3wkJaU4WFC0p/
 TUNZ2ukL0XtO7enuZhAA/+LGntrPCRhGm/Rc21rWnPyZmlOEICBCoFENwSYVZI5tfz/MFXbUJhZ
 ScVOu6dsj2SRBuPfk1ZsHwJlEo/BNcnU5lt6ERJ7Xn2J2NtUKmDG6XACEqjn6MjFsCU2zhVKBkM
 aEF2l9CzLh37xNScAF+ePB2CLkqiWqbQ99xw7r5Q+bVdi1Riax8bLfpZSoTsucmcqOdZDE2cwUX
 /asIJvsXr49+PuQsFb4aeYYnNRSQmXq264Wdj5MWFTNMAhTweyjVfhRsKcKaRh9xQVotZJj7FYp
 K6yV5FxIsi9BN/2tMTid4MT1dI4cozCehyzpvm/nx0qZj3PqfHER0HFLPPjGqHZHPj3EczL5Uy0
 U6awvesre73vjR7NRUKJhBlFuK7vC3A/2ru0mavX6XLHIb2Z+aklwU5+VKNA5YtA/G4yUdosAai
 LKnc6iUQ+WyEoRW+xkneNTgPyjyKnVivr+aPCObl5c6oNeoKU/t/qc/zlJd4KQ+YT9h1GXVVvv4
 +WTKvg0Xu0w==
X-Received: by 2002:a05:600c:6214:b0:4b5:d95c:2378 with SMTP id
 5b1f17b1804b1-4ba0939815cmr42149525e9.34.1794403898734; 
 Wed, 11 Nov 2026 05:31:38 -0800 (PST)
Received: from frobdeb.bytesatwork.ch (162.40.150.83.ftth.as8758.net.
 [83.150.40.162]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498363df7a5sm11089358f8f.37.2026.11.11.05.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 05:31:37 -0800 (PST)
From: Frank Obergfell <frank.obergfell@bytesatwork.ch>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Frank Li <Frank.Li@nxp.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Walle <mwalle@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Daniel Baluta <daniel.baluta@nxp.com>,
 Jessica Zhang <jesszhan0024@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Alexander Forsch <alexander.forsch@bytesatwork.ch>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] arm64: dts: freescale: Add support for bytesatwork
 byteDEVKIT i.MX93
Date: Wed, 11 Nov 2026 14:31:14 +0100
Message-ID: <20261111133119.1063210-1-frank.obergfell@bytesatwork.ch>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 12 Nov 2026 12:55:13 +0000
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

Changes in v3:
- Patches 1 & 4:
  - Added Reviewed-by tag from Daniel Baluta.
- Patch 5:
  - Added imx mailing list (imx@lists.linux.dev) to MAINTAINERS entry.
  - Moved controller activation (&lpi2c2, &mu1, &mu2, &usdhc1, &wdog3) from
    imx93-byteengine.dtsi to imx93-bytedevkit.dts.
  - Removed unused LVDS backlight (lcd_bl), disabled lpi2c1 node, and unused
    LVDS pinctrl groups.
- Patches 2 & 3:
  - No changes.

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
 MAINTAINERS                                                   |   8 +
 arch/arm64/boot/dts/freescale/Makefile                        |   1 +
 arch/arm64/boot/dts/freescale/imx93-bytedevkit.dts            | 415 ++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx93-byteengine.dtsi           | 185 +++++++++
 arch/arm64/boot/dts/freescale/imx93.dtsi                      |  34 ++
 drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.c            |   4 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c             | 158 ++++++
 10 files changed, 816 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-bytedevkit.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-byteengine.dtsi
