Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14D6CD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 13:20:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5985210E042;
	Fri, 22 May 2026 13:20:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YUxW1xld";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63CE310E042
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 13:20:37 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso64292455e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 06:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779456036; x=1780060836; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1qLGD+d59NtgQVVpwJfCXZu6HhFLlAFnjmTwdInD0HI=;
 b=YUxW1xldV/ikIle+gLjnlBHOCJZ6Ge8Q8kHphYzaK0sYtue3JcIMHeVlp2mvqU8Akm
 owb4KR5fc9BvMdx0x7XIGt/HxJh+CnKoHN9TRzeQtk5FhgFH67GNAuWFv/zwPLjw0CVR
 aUSkwE256m7VdFmc+eL3KhSS7aXbRnJrsx9j0k7yKumqhcaJFYXKQibNnY+aPDcIMH0k
 8WQEhHUIUKuwHqiXNCgYEhcgpbKY0DTnnaOpEr/qYDia9+gUXc7ntx2AANS2tK4u7yxv
 mh0PKgu9k0ljODPTJYQtRtwWekhxkVQoWeoIRN2mpXWOZa9cP8f9H3iDIyWTzEfMoWks
 RBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779456036; x=1780060836;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1qLGD+d59NtgQVVpwJfCXZu6HhFLlAFnjmTwdInD0HI=;
 b=m8p0eY6CqELVfnA9OXUjFUVil4x4cdt5MiSecXUiWt/AuPy5le6+UPHfvw/S2smvGV
 PO+WUkLmXdvhCHFMx3AbGi+amjiGAbv2vUSCGORi1zTSLYB+mZJKyf2ApGFiuyrSHuHM
 7LnS8EE1zwxJXZ5pjUJE0ENh3ibON/qw5+Rlb/ykJJbuvVerL48/Lp4o76CBeB9AyOQ6
 BGtIeiHoLgcdm8K2Ee5Ae9uM2G3AqVEfc1uneZ8s/PfXUi8smY52HrIWmh+RA4G7r+zX
 sAKzQshixXBRss0Rp9v5zx1vL9LQgITwL9ji7FUE5h7AU5di9jO66oQ7mZj3ELIP4pPC
 CpEA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Ln8fU6fvm3SiG29ZBnKPTKyu6rOVonYfa8zrg74lrzsiTswO+0RCuQaEuecYwTMALZbDVQB3ZmP0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzsynOWYXA/enkZSse6Q83iwOGFbS2MNGvQy2U3UwnfTi32lH1X
 6wqiRihHaIlTwmMUjHhjPkxNWystvr3B95nlIxxcH3FAVYC7Mr3G0k3b
X-Gm-Gg: Acq92OGZxKKdVFzeSLyJTkfNpbXo4Hn/XPAmVn39DIBmoyoD1Hskzsftl808RnUOl/1
 0bHE92F2R1FCNFknXFn4pDRxcvjw7NGW9OGw9aTtxUgRqd3hZL/NbrRZXiA4W5/na/PnPw9AF9l
 S7stKD20k3MvxrQ9N/JFmpABQA0skAySFEkCr7fyI6wYG2hIvJI8iB5FKbTwIrmbWvm5gFukbkX
 8FKypJ6TDoMcTW4eMo4IiMOtNVZzqUFcXF/p+FKQVJpvRJ3iy+rc6Vm9xCP6EU2DmJ4WT9SrHtj
 hNnsesyBHs356ChLV7UQUVaHLE7MAWWkRKSNMrKKd1p6RAHv2MwCcM0nBlSXRUn1LhbXUVTTAbA
 caWOnPfpRMdtxnQtuDiJgXcIOr8sb32NsreQOqFzwk2P9KzAUps8dGdu4Kkrdfx1o6dYBAkznTM
 bD5K14wmhWigfcdCli8av9VaoYb4QiSlZt4OkdG8eovS5jjdGDLkI2
X-Received: by 2002:a05:600d:8494:20b0:48f:d1b8:9aaa with SMTP id
 5b1f17b1804b1-490424a1628mr37558685e9.6.1779456035429; 
 Fri, 22 May 2026 06:20:35 -0700 (PDT)
Received: from vitor-nb (dsl-113-208.bl27.telepac.pt. [176.79.113.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454a0cd5sm52220755e9.10.2026.05.22.06.20.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 06:20:34 -0700 (PDT)
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
Subject: [PATCH v2 00/11] arm64: dts: ti: k3-am62-verdin: Add display and
 peripheral overlays
Date: Fri, 22 May 2026 14:20:13 +0100
Message-ID: <20260522132014.226721-13-ivitro@gmail.com>
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
Development Board, MCU_MCAN1 on the Verdin AM62 Mezzanine board,
and MCU_UART0 reservation for the Cortex-M4F debug UART.

TI maintainers: patches adding the Riverdi vendor prefix and panel-lvds
bindings are required by the DTS patches.
Are you fine picking up the full series once those patches are acked by
the DT/display maintainers?

Thanks,
Vitor Soares
---
Changes in v2:
- Add Acked-by tags
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
 ...mezzanine-panel-cap-touch-10inch-lvds.dtso |  97 +++++++++++++
 .../ti/k3-am625-verdin-dev-nau8822-btl.dtso   |  14 ++
 ...in-dsi-to-lvds-panel-cap-touch-10inch.dtso | 123 ++++++++++++++++
 .../dts/ti/k3-am625-verdin-ov5640-24mhz.dtso  |  17 +++
 .../boot/dts/ti/k3-am625-verdin-ov5640.dtsi   |  71 ++++++++++
 .../boot/dts/ti/k3-am625-verdin-ov5640.dtso   |  18 +++
 ...625-verdin-panel-cap-touch-10inch-dsi.dtso | 132 ++++++++++++++++++
 ...25-verdin-panel-cap-touch-10inch-lvds.dtso | 119 ++++++++++++++++
 ...m625-verdin-panel-cap-touch-7inch-dsi.dtso | 132 ++++++++++++++++++
 .../dts/ti/k3-am625-verdin-uart4-mcu.dtso     |  13 ++
 14 files changed, 819 insertions(+)
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

