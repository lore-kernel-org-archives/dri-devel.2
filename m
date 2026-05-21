Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9C0CD4F3D
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 15:01:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D45810F393;
	Thu, 21 May 2026 15:01:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KfqN//xp";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C26B10F389
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 15:01:20 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4903997fcb5so8202695e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779375679; x=1779980479; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RP+CltVi6jUCZJal0Anzdw8j6V9ipqNLat7Pdw8ZHRU=;
 b=KfqN//xpOGvwe05xj9IMf2FZ8b6mATIOdRHX8ZXG9owc+E30f+BDe18JYYAbb93hlJ
 Xaoza+5+UQ1wJXvX9rwB1RQdscUHZK8anYNg5syYZDlVOzd9qTkDNbadwzOoU1/njcDf
 2m2JfZrOhJ4Yunz04Lo3ErG/vzqsUpPtL8Ncms6xFVBU3t7IWj8TGO6Rn/nosmJSRmjj
 ChGRqZlYMaWrWf8n165JXOgyR7k7zf0Iy7V8JeuNZy+kGcvYVxVAEEpStaWAe7YzHLNy
 zWAdYXECMSDKHYNWPF/uL2f9Zf5XPmllfPKcs+CvEPPmYn1PhFPfl3gVpDPKpCT8Uwab
 /dmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779375679; x=1779980479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RP+CltVi6jUCZJal0Anzdw8j6V9ipqNLat7Pdw8ZHRU=;
 b=BxWbTzhAN6PzCAfVJBd7qWc89KkgelX39lo0nBURRIl3reuWj3MH5OGs2lVzIpXvV5
 jUo9Nc07xj3sLErzgb/dqvKjOIGWhKCPO8+G4Ttmss3oLPlZj1e4GyX15ykcPTxUbQD9
 SxT9pLkeXPb1FY3lLEoVvDPlhZtUEhLGlRBR32FPD+7kh+wvBKcXyixuNvH+Pt7dUlwC
 sUYIWvNThR2HtIEyqg+zE9Bz93JB2DMzrkOz2t+XCPa1TW6rMaiP0FEWmxKIw/EWQ2Jz
 Qsq1s047pdYLumWvuMPky5Gs1I0TkfL0J82yuKK4i4G/WYdy7uJdMukBYeUlQZXHcvch
 9S9Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/yuIW1ereIw2hd2FwGpOQ7x+JzDltOCT9wFRzn+XP87jUxjFtZZfcvoVq9pi0EeP43qvbjE+WaeOk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzf1eQp42SGCDoq2HEUzJT03nt7QunBet+0QVMaZ+H3H9t8Zgb+
 c6s23oL06VIKbEa3h4WUzzvaL80HkLozDb45fvFM9wqeiJ+g1U6R6I7Z
X-Gm-Gg: Acq92OEm7IG+CHQFucAGI4s//S62TbICfSToIWG6rUroziKOm9pMw0psgu1V6Z5zKfP
 7D7zXTHvIkm4gYZSo0hVj97LZkWZ4XWxFqGRaTWzqLrsJKTfHvi4F93AkbDo3Sdriy8HUhMoaXA
 k0wg5iKxxWDQUYr0AAZ7fuIQdKc4lBUPLbDV8IeQ3q5BxzBqsO3CZizCZJBnNkAHTQbA7Smohr6
 R0wiXSATb+ErIMKidsrpSj6Q7XJmuVEtRJZj6hwuW/I1Q7lSCqJT0Ew2dEUsAIuRqJToFmoaulj
 XQie5zhuqvGIbdapT2yfEKGDZCQVZshARvqpLANZDG1q7Ciqf1MJDvKv5/gDlJiXkXD1qNZJvaW
 Gcgya21UEUIX3A6vN5LNEkZpHkNfbOTpcMratAaafor6yJ5+TqpDb2XjXaY48UQ4AXEPy+U1lQP
 7mJpMYFAmFEb95YdeW8EEM++573fCOozGkqDGJkS5rY69kMBQgjSJO
X-Received: by 2002:a05:600c:8b05:b0:48f:e230:c3f8 with SMTP id
 5b1f17b1804b1-490360cc5d7mr64212735e9.30.1779375678650; 
 Thu, 21 May 2026 08:01:18 -0700 (PDT)
Received: from vitor-nb (dsl-113-208.bl27.telepac.pt. [176.79.113.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4903caede9fsm34056745e9.14.2026.05.21.08.01.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 08:01:17 -0700 (PDT)
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
Subject: [PATCH v1 09/15] arm64: dts: ti: k3-am62-verdin: Reserve UART_4 for
 Cortex-M4F
Date: Thu, 21 May 2026 16:00:45 +0100
Message-ID: <20260521150038.103538-26-ivitro@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521150038.103538-17-ivitro@gmail.com>
References: <20260521150038.103538-17-ivitro@gmail.com>
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

Add a device tree overlay reserving AM62 MCU_UART0 (Verdin UART_4) for
use by the Cortex-M4F co-processor as its debug UART.

Assisted-by: Claude:claude-sonnet-4.6
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 arch/arm64/boot/dts/ti/Makefile                     |  4 ++++
 .../boot/dts/ti/k3-am625-verdin-uart4-mcu.dtso      | 13 +++++++++++++
 2 files changed, 17 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-uart4-mcu.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index a1083c0b2502..31c9bc1d48b1 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -44,6 +44,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-nonwifi-zinnia.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-panel-cap-touch-10inch-dsi.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-panel-cap-touch-10inch-lvds.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-panel-cap-touch-7inch-dsi.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-uart4-mcu.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-dahlia-dsi-to-hdmi.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-dahlia-panel-cap-touch-10inch-dsi.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-dahlia.dtb
@@ -230,6 +231,8 @@ k3-am625-verdin-wifi-dev-nau8822-btl-dtbs := k3-am625-verdin-wifi-dev.dtb \
 k3-am625-verdin-wifi-dev-panel-cap-touch-7inch-dsi-dtbs := \
 	k3-am625-verdin-wifi-dev.dtb \
 	k3-am625-verdin-panel-cap-touch-7inch-dsi.dtbo
+k3-am625-verdin-wifi-dev-uart4-mcu-dtbs := k3-am625-verdin-wifi-dev.dtb \
+	k3-am625-verdin-uart4-mcu.dtbo
 k3-am625-verdin-wifi-mallow-panel-cap-touch-10inch-lvds-dtbs := \
 	k3-am625-verdin-wifi-mallow.dtb \
 	k3-am625-verdin-panel-cap-touch-10inch-lvds.dtbo
@@ -337,6 +340,7 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-am625-verdin-wifi-dev-dsi-to-lvds-panel-cap-touch-10inch.dtb \
 	k3-am625-verdin-wifi-dev-nau8822-btl.dtb \
 	k3-am625-verdin-wifi-dev-panel-cap-touch-7inch-dsi.dtb \
+	k3-am625-verdin-wifi-dev-uart4-mcu.dtb \
 	k3-am625-verdin-wifi-mallow-panel-cap-touch-10inch-lvds.dtb \
 	k3-am62-lp-sk-hdmi-audio.dtb \
 	k3-am62-lp-sk-nand.dtb \
diff --git a/arch/arm64/boot/dts/ti/k3-am625-verdin-uart4-mcu.dtso b/arch/arm64/boot/dts/ti/k3-am625-verdin-uart4-mcu.dtso
new file mode 100644
index 000000000000..e263809cdf74
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am625-verdin-uart4-mcu.dtso
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) Toradex
+ *
+ * Verdin AM62 Cortex-M4F debug UART
+ */
+
+/dts-v1/;
+/plugin/;
+
+&mcu_uart0 {
+	status = "reserved";
+};
-- 
2.54.0

