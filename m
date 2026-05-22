Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF1D9CD5BB3
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 16:11:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0511610E292;
	Fri, 22 May 2026 16:11:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FWa+GJpI";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC5E810E292
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 16:11:41 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4891b0786beso51626095e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 09:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779466300; x=1780071100; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QPGVYKqn3FQ80LKzOq7xEivdqWu7ECBxaeXMtXQgpig=;
 b=FWa+GJpID3G47Ct5p78T2/4ivpeT3BwxgUQwL1jtL6roprMIevO/TpBWcVAdkjNz9t
 TYy0JLp+WGUITZxHcafSm7xL7ThZlMNfGOzpJvDENnFBZDZ6JD+80hve6cNjXAmif5Js
 btZ3vCtA1yiTfj7H908NJbCyGaToGRoB7Qxpzet689LJyYPfWZAk6ZFkw5j66lLsnNV9
 R3LJnorTtnPQ3uby9jHTqZaSIEWrpvqTIhdnMIVliD128ii9rGBh/L6Nql7C+ySsT210
 bffZ3pMQmHSNCdAvhN0sjOHSCBW/D1tjo2XUpKTU4SlvE2wr5V/VpfSxXOOJQxInwZUk
 7ODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779466300; x=1780071100;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QPGVYKqn3FQ80LKzOq7xEivdqWu7ECBxaeXMtXQgpig=;
 b=eDqmXCNbi38rco3VbGcP686TrAJSF7kDRsqsOoDwtsfqLy4azxbmUWPa6a/EIcvfWx
 XD595jWZebiJK3OVfTKVm8BZ+Mx5o+FUw8ck1hd0BnBAbiPHspKFs7+r64+GpFeMROH6
 WwgAVPIrElkL3b0v7lv2+Q4COQOvkLMEigB4O9+p++3wiNuaw5aoGpCtRIeLUyOIP/X/
 Ene1PCJxN1KZNd8/EkVTrqyaWb8a1K2uNDfqW8Otgdy/8rcNp9kUIad2u+YM6lZUP2H4
 vkXJFhGZ2MnZAZthYJ/ooYEFKxJ23msclZ6Z/khUnMdeCKiAXxuy4opU9NuypK5rjjzf
 2yHA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/OM+SNJRAAcUtAH0j2mzUSL7cUU611QMCo3aeZGBWoMZrTAjuM8GqxtW561IrMOAVt5pWmfz+o2eo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzUgAvf5Xp5oBB7TvelTd1hAco618EyouVVG9ZUyENnTySUqVtz
 L0X5iTptOvOPfTejhzIrHiLuxANx1h21kHJ560PoN9doo/sFNbbtmDx3
X-Gm-Gg: Acq92OHxD7zPUWMbxmZsbGkoRsf7KYAF2CCZQHDmFBAkxTt6ZFLnFzKRHrC3umyF0rY
 h4jpDOGIeRwzbbCZ2lwaYQ7mO6WgMWk9mOXeYtK+DHp+WOTPeBmvgncasS0Y4z8CJqruiZMtYWe
 IlEAemz8GwCiOaWmpOQdrOqcdrgc/bdrlQWYWyaRlUcogXYfIqSBncLpu4G/mosfRfwHt+Vv3BX
 0bgsCDsbTB0uJV+mcF/J7Ow2dIAlR2Crl371UJ5ErUknIboeTy/MdDy719Hf2dUeY/Y3S50L7CN
 Qlb995S8y3TwuiHgS/179Tpdhv/AK9ZSWGbsW0ddRuMp8yIj8vqnn/obMTUF5H5AR+p4YJYC2dI
 b+Tgxt12KyUYfOhyS7Nx7lg+fBlVJQjYb4QBn2UN2XFArT1U+Fpg27G8yRsvfOo0VIjdq6scb9D
 HynEVJqPpgZ/jGyvRowcQ6cftVFO0JZTQrcCxXmFW8og==
X-Received: by 2002:a05:600c:1c0a:b0:490:402f:324d with SMTP id
 5b1f17b1804b1-490428e03admr60430125e9.29.1779466299935; 
 Fri, 22 May 2026 09:11:39 -0700 (PDT)
Received: from vitor-nb (dsl-113-208.bl27.telepac.pt. [176.79.113.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454a0b9asm51042755e9.11.2026.05.22.09.11.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 09:11:39 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thierry Reding <thierry.reding@gmail.com>
Cc: Vitor Soares <vitor.soares@toradex.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 00/11] arm64: dts: ti: k3-am62-verdin: Add display and
 peripheral overlays
Date: Fri, 22 May 2026 17:11:04 +0100
Message-ID: <20260522161105.277519-13-ivitro@gmail.com>
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
- native OLDI (LVDS) with Toradex Capacitive Touch Display 10.1" LVDS
- DSI-to-LVDS adapter based on the SN65DSI84 with Toradex Capacitive Touch
  Display 10.1" LVDS
- DSI driving Toradex Capacitive Touch Display 7" and 10.1" DSI.

The Riverdi vendor prefix and panel bindings required by the DSI overlay
patches are also added.

Non-display additions include OV5640 CSI camera support in 24 MHz and
27 MHz oscillator variants, NAU8822 Bridge Tied Load mode on the
Development Board, MCU_MCAN1 on the Mezzanine board low-speed header,
and MCU_UART0 reservation for the Cortex-M4F debug UART.

TI maintainers: patches adding the Riverdi vendor prefix and panel-lvds
bindings are required by the DTS patches.
Are you fine picking up the full series once those patches are acked by
the DT/display maintainers?

---
Changes in v3:
- Add missing regulator-name property on fixed regulators
- Simplify regulator labels (reg_3v3_lvds_native -> reg_3v3_lvds,
  reg_3v3_lvds_bridge -> reg_3v3_dsi)
- Rename touch@ nodes to touchscreen@
- Link v2: https://lore.kernel.org/all/20260522132014.226721-13-ivitro@gmail.com/

Changes in v2:
- Add Ab tags
- Drop introduction of the LG LP156WF1 15.6" FHD dual-channel LVDS panel
- Drop migration of "logictechno,lt170410-2whc" to panel-lvds.yaml
- Link v1: https://lore.kernel.org/all/20260521150038.103538-17-ivitro@gmail.com/
---

Vitor Soares (11):
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

 .../bindings/display/panel/panel-lvds.yaml    |   4 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/ti/Makefile               |  49 +++++++
 .../ti/k3-am625-verdin-dev-mezzanine-can.dtso |  28 ++++
 ...mezzanine-panel-cap-touch-10inch-lvds.dtso |  98 +++++++++++++
 .../ti/k3-am625-verdin-dev-nau8822-btl.dtso   |  14 ++
 ...in-dsi-to-lvds-panel-cap-touch-10inch.dtso | 124 ++++++++++++++++
 .../dts/ti/k3-am625-verdin-ov5640-24mhz.dtso  |  17 +++
 .../boot/dts/ti/k3-am625-verdin-ov5640.dtsi   |  71 ++++++++++
 .../boot/dts/ti/k3-am625-verdin-ov5640.dtso   |  18 +++
 ...625-verdin-panel-cap-touch-10inch-dsi.dtso | 132 ++++++++++++++++++
 ...25-verdin-panel-cap-touch-10inch-lvds.dtso | 120 ++++++++++++++++
 ...m625-verdin-panel-cap-touch-7inch-dsi.dtso | 132 ++++++++++++++++++
 .../dts/ti/k3-am625-verdin-uart4-mcu.dtso     |  13 ++
 14 files changed, 822 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-dev-mezzanine-can.dtso
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

