Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11891CD4F3D
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 15:01:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AC0C10F37F;
	Thu, 21 May 2026 15:01:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JUmA1F0P";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D34010F37A
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 15:01:01 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so69123435e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779375660; x=1779980460; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OH7BCjjdxq2DLB6fo/wyUar0j55aA2dc57uz4YwkDi4=;
 b=JUmA1F0P6nRW1a+Aqmyc7aWTybpdvR+ytqK+44lIdqQlnHnBKsC/IK2MVeb6f4aIRY
 ERpdvkIM+FfZgeJkHSF95p9Izm13AX8M7F12rfVCiwueFFzgFVSPuf5KUHahrhSgTrx+
 wJv3ABInRhrXyVhZL34CbH1ZBtD2ce6k0n8u3pJxLKxfkwkccgxxqlCvJjw1OZrPRj6e
 YTrzdvng1MXgAU3UUaqLzAcLPID48R1WdSA1IdssdOmKsBNtIw+UceJaqHR9PyTEgNp7
 WcOWxsNM9CTlhx4DGNNT2RXZet0vUOK0mXAE9ADCgK8rx8hCgHD2MCDFOyFPfgan8go2
 C+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779375660; x=1779980460;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OH7BCjjdxq2DLB6fo/wyUar0j55aA2dc57uz4YwkDi4=;
 b=eRfhTY33M1XTcSAbgY6Yg+MlP716ReLyI2JCMjOYfjECehWJ//VacWJHqmuiIEDlsE
 iNPQXmMvzbSt6prutCtnW2PTZ16+rto2SptAaUKNcTTALQNLWTNHSflNOSpahTEnP2L+
 2jIevDkh2H7uW3AyTngKDc2AYoLQ4UoRVP5OfJTFpy8tEVL4+3BYz9DDf9I7s7PKgma5
 nfTmW7KS0EPNlw/Fn/da01+ntcfTiMT4rPC/7znR6Wj/H9cR9lOoCcgw80WZH8M+FW+J
 FSDkS4XvH3IiXsPA8qqA0a5jxq/3IPbOuJ2QSsOvzgy4ytMMollbqqpm93AeZNGOtlra
 eQwg==
X-Forwarded-Encrypted: i=1;
 AFNElJ88QrNPbj2OBjp+HcmVtusZ9aV6+P5ZLsly4PPIqWHn+23FoRHc6ecYZxfNNeXG3Ld8tkVPuu4DrNk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz3+Hbi1Ajp0nJDfE29Qoy8YB3/0PVYUWoqzuvUElkLywakMRJ/
 H5DPZxHRd0OjcNgPJ7Qx178SB/SQW6xc/W/19aux1ROp87EuwFvNWeVy
X-Gm-Gg: Acq92OG/9Jg4tUWVmL2W+FzmiKVAAaNB24o72vJOkgWgA9VOJh+CGtyUKcSlSD6eIR9
 sAYv7NQEQhuBbc/O6yVAHzRadck0ppa36Ss+oPhxFb0p31hd5gLwdy70Fqw2FBq9wQgYZZBmAha
 SNnfbwRvTke+HX6llbVi8NDIGBjmzHD2PUfrGOi2a45mBAs0HFGXAnig4Z2ce9+fRmTYKqYNg7O
 rcw40YjBxnDGPmbFTq5a5U253JYvyTmKmclhOr+kE1OnMvVNZjxtA4F0vG4ZT+eks0rHhGxhAhX
 tRC7LHEOAICexoraT3mErsJf9izXqk23MyWR1N6t489Ry0KPKIy7ZoTbVkrgklkYQ+00cqhRZzZ
 z84Tal2rOSvtL87ltKFYWLOuMM6cwTveBhdIrVTT1QBvjgKZdOKnNhwO/iWAqMz/0TwGalLsU/d
 im848VL65Gk9wdEZRXQYbMJoEgH0kyywViOln1/Cu7GQ==
X-Received: by 2002:a05:600c:32af:b0:488:9ed3:1492 with SMTP id
 5b1f17b1804b1-4903605e3damr32117115e9.10.1779375659006; 
 Thu, 21 May 2026 08:00:59 -0700 (PDT)
Received: from vitor-nb (dsl-113-208.bl27.telepac.pt. [176.79.113.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4903caede9fsm34056745e9.14.2026.05.21.08.00.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 08:00:58 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: Vitor Soares <vitor.soares@toradex.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 00/15] arm64: dts: ti: k3-am62-verdin: Add display and
 peripheral overlays
Date: Thu, 21 May 2026 16:00:36 +0100
Message-ID: <20260521150038.103538-17-ivitro@gmail.com>
X-Mailer: git-send-email 2.54.0
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

From: Vitor Soares <vitor.soares@toradex.com>

This series adds device tree overlays, expanding the hardware support for
the Toradex Verdin AM62 SoM. The overlays target displays, cameras, audio,
and peripherals available through Toradex carrier boards and the accessory
ecosystem.

Display additions cover three interface types:
- native OLDI (LVDS) with Toradex Capacitive Touch Display 10.1" LVDS and
  LG LP156WF1 15.6" FHD dual-channel panels
- DSI-to-LVDS adapter based on the SN65DSI84 with Toradex Capacitive Touch
  Display 10.1" LVDS
- DSI driving Toradex Capacitive Touch Display 7" and 10.1" DSI.

The Riverdi vendor prefix and panel bindings required by the DSI overlay
patches are also added, along with an extension to the panel-lvds binding
to support lvds-dual-ports for dual-channel LVDS.

Non-display additions include OV5640 CSI camera support in 24 MHz and
27 MHz oscillator variants, NAU8822 Bridge Tied Load mode on the
Development Board, MCU_MCAN1 on the Mezzanine board low-speed header,
and MCU_UART0 reservation for the Cortex-M4F debug UART.

TI maintainers: patches adding the Riverdi vendor prefix, panel-lvds
bindings, and dual-channel LVDS support are required by the DTS patches.
Are you fine picking up the full series once those patches are acked by
the DT/display maintainers?

Vitor Soares (15):
  dt-bindings: display: panel: Move Logic Technologies LT170410-2WHC to
    LVDS
  arm64: dts: ti: k3-am62-verdin: Add Toradex DSI to LVDS adapter with
    10.1" display
  arm64: dts: ti: k3-am62-verdin: Add Toradex Capacitive Touch Display
    10.1" LVDS
  dt-bindings: vendor-prefixes: Add Riverdi
  dt-bindings: display: panel-lvds: Add Riverdi RVT70HSLNWCA0 and
    RVT101HVLNWC00
  arm64: dts: ti: k3-am62-verdin: Add Toradex Capacitive Touch Display
    10.1" DSI
  arm64: dts: ti: k3-am62-verdin: Add Toradex Capacitive Touch Display
    7" DSI
  arm64: dts: ti: k3-am62-verdin: Add NAU8822 Bridge Tied Load
  arm64: dts: ti: k3-am62-verdin: Reserve UART_4 for Cortex-M4F
  arm64: dts: ti: k3-am62-verdin: Add Toradex OV5640 CSI Cameras
  arm64: dts: ti: k3-am62-verdin: Add Toradex Verdin Mezzanine CAN
  arm64: dts: ti: k3-am62-verdin: Add Mezzanine with Toradex Display
    10.1" LVDS
  dt-bindings: display: panel-lvds: Add dual-channel LVDS support
  dt-bindings: display: panel-lvds: Add LG LP156WF1
  arm64: dts: ti: k3-am62-verdin: Add Mezzanine with LG LP156WF1 LVDS
    panel

 .../bindings/display/panel/panel-lvds.yaml    |  21 ++-
 .../bindings/display/panel/panel-simple.yaml  |   2 -
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/ti/Makefile               |  54 +++++++
 .../ti/k3-am625-verdin-dev-mezzanine-can.dtso |  28 ++++
 ...verdin-dev-mezzanine-lvds-lg-lp156wf1.dtso | 129 +++++++++++++++++
 ...mezzanine-panel-cap-touch-10inch-lvds.dtso | 109 ++++++++++++++
 .../ti/k3-am625-verdin-dev-nau8822-btl.dtso   |  14 ++
 ...in-dsi-to-lvds-panel-cap-touch-10inch.dtso | 135 ++++++++++++++++++
 .../dts/ti/k3-am625-verdin-ov5640-24mhz.dtso  |  17 +++
 .../boot/dts/ti/k3-am625-verdin-ov5640.dtsi   |  71 +++++++++
 .../boot/dts/ti/k3-am625-verdin-ov5640.dtso   |  18 +++
 ...625-verdin-panel-cap-touch-10inch-dsi.dtso | 132 +++++++++++++++++
 ...25-verdin-panel-cap-touch-10inch-lvds.dtso | 131 +++++++++++++++++
 ...m625-verdin-panel-cap-touch-7inch-dsi.dtso | 132 +++++++++++++++++
 .../dts/ti/k3-am625-verdin-uart4-mcu.dtso     |  13 ++
 16 files changed, 1005 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-dev-mezzanine-can.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-dev-mezzanine-lvds-lg-lp156wf1.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-dev-mezzanine-panel-cap-touch-10inch-lvds.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-dev-nau8822-btl.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-dsi-to-lvds-panel-cap-touch-10inch.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-ov5640-24mhz.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-ov5640.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-ov5640.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-panel-cap-touch-10inch-dsi.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-panel-cap-touch-10inch-lvds.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-panel-cap-touch-7inch-dsi.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-uart4-mcu.dtso

-- 
2.54.0

