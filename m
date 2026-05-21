Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA96CD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 15:01:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E03A510F398;
	Thu, 21 May 2026 15:01:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MRrEqIfw";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAACD10F37D
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 15:01:33 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4903fd19957so1384475e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779375692; x=1779980492; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HWDvvZpW/sE15P0paVY2aruhyEKLAjYbjEimD4YPxkE=;
 b=MRrEqIfwO/vVFv2U9Fa0+JeSpzKWmzDdDDVnR+XqRELB+vQXriYOC2PXHii1ub7gp9
 6pO0OVgWJDU1pO5KtlMkvcOcHvLRhU2WKZq37xe4lkEJTVWqc9OE5MGwDrWXZv1D4nTa
 M/7QFDACY1UnwVjN0pj4yt8+rYfMDrVl3iu0ZceiJIEK1k/AtL0tX8KmRah0gYg0/DvR
 6qSbsey6qRM3YmxZFWjjv8++9378yQ9V5CTaxy+g2/bYOf7WLaWgplwbIt868YEZ8sdM
 t9SekSTvlXc5S4KXDJ7HDElDp/OAc4V7YZT+71kjY6I4q266S2ZaVvfK1O5dkxTVL+DS
 wPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779375692; x=1779980492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HWDvvZpW/sE15P0paVY2aruhyEKLAjYbjEimD4YPxkE=;
 b=VHQORHVX9ovfolT9wlKDb9MADvDGLIRz4/pP6qnOctvmITWQUUUfvY7/vbviUd0gA5
 OKQimwtXC26dYA5boTYSuxYO3eZrT9flrK01i+RJ30UjEUv4X71REYRD4fgcC6i6M/rG
 SHXQiLWQTZGvVm6c+mHiWy7MgLLhavVDcM0iaOHF/1STUduPxguomzI0zTpSZHGkRjzw
 8Xr8ouSqf65G8Vv8ta3MCuT7yNcdFNFP25HXYU8ZW9vGl+BqrJ0mMY2CyjOGW7MvkDWP
 RN7btnA/X1hWx+2+9kC8LoB9lrfOXVXr+gkYZ4Q6MQZYKRankd7jML9TTTTJaqi09Ter
 coew==
X-Forwarded-Encrypted: i=1;
 AFNElJ9eiR0iyIZq1gz+DFC7Odda4IjQI82MFFyCzUUWWpbARs+1rTf1SmO+vl9iKddvi53kmDMJV0ZBiAk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw65hu/QjExYLKgmIhwbGqQYXFXXK2WL0gDgI7wvUmcAxeLxItZ
 pKYs9IIBVCKqOBF5kypWybiRKeSoThPPWpaJYmvTQC6A5nHPEulG/wf9
X-Gm-Gg: Acq92OE+ich3xQtRrfGsAADBLVmAtrLbYKJJsVRukL17QK3wuz1WBHYvfZ2exGkCnp/
 3wT6U1ki/C5Sz4LUXbfPPFNtKUbtHQXG3MmiW9T2H7i5tR14eLMQq9MUyKA1y8iCNZuS5ebQZ6Q
 oHcTNU9IN1xvSr3oZjcDpP+HGIwUSFrt2jWNoXbCa/OTXWIcCu3r5MXlbkEZBsmCigtabsSkAmd
 UrrqhNu9/sS0aa49mhHuOEAj18Zd/wyErBgcB6o4H2/X9eBB/Hmfkz1ZekdBCQxvXmlqNt9VFX8
 9vRVsqTPwq/YPVVJ5g4oUbMKmEFyki/Nt3XkpF4llYRTz+0NnNJZDerS2Of0FIsRcOa0hYy8+uo
 HaYRGCiww2dLjLG+SyvFvLA2YynT84wGVxQ5uhxVPLjyajSZ7EMD2B+6UwhMuvZuFubvxwbnhYp
 rM+yF9Et/HCJlPfWO4KzGpCb7KVHce+DhVwCQdjn4ddg==
X-Received: by 2002:a05:600d:10:b0:48e:526e:101a with SMTP id
 5b1f17b1804b1-4903606b81emr41807905e9.12.1779375691986; 
 Thu, 21 May 2026 08:01:31 -0700 (PDT)
Received: from vitor-nb (dsl-113-208.bl27.telepac.pt. [176.79.113.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4903caede9fsm34056745e9.14.2026.05.21.08.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 08:01:31 -0700 (PDT)
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
Subject: [PATCH v1 15/15] arm64: dts: ti: k3-am62-verdin: Add Mezzanine with
 LG LP156WF1 LVDS panel
Date: Thu, 21 May 2026 16:00:51 +0100
Message-ID: <20260521150038.103538-32-ivitro@gmail.com>
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

Add a device tree overlay enabling the LG LP156WF1 15.6" FHD (1920x1080)
dual-channel LVDS panel on the Verdin Development Board with Verdin AM62
Mezzanine expansion board. The panel connects via the AM62 OLDI0 and
OLDI1 in dual-channel mode on the Mezzanine LVDS interface (J10).

Assisted-by: Claude:claude-sonnet-4.6
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 arch/arm64/boot/dts/ti/Makefile               |   5 +
 ...verdin-dev-mezzanine-lvds-lg-lp156wf1.dtso | 129 ++++++++++++++++++
 2 files changed, 134 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-dev-mezzanine-lvds-lg-lp156wf1.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 371f9a043fe5..e9951b5d2e0b 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -30,6 +30,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am625-phyboard-lyra-rdk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-tqma62xx-mba62xx.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-dev-mezzanine-can.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-dev-mezzanine-lvds-lg-lp156wf1.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-dev-mezzanine-panel-cap-touch-10inch-lvds.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-dev-nau8822-btl.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-dsi-to-hdmi.dtbo
@@ -232,6 +233,9 @@ k3-am625-verdin-wifi-dev-dsi-to-lvds-panel-cap-touch-10inch-dtbs := \
 	k3-am625-verdin-dsi-to-lvds-panel-cap-touch-10inch.dtbo
 k3-am625-verdin-wifi-dev-mezzanine-can-dtbs := k3-am625-verdin-wifi-dev.dtb \
 	k3-am625-verdin-dev-mezzanine-can.dtbo
+k3-am625-verdin-wifi-dev-mezzanine-lvds-lg-lp156wf1-dtbs := \
+	k3-am625-verdin-wifi-dev.dtb \
+	k3-am625-verdin-dev-mezzanine-lvds-lg-lp156wf1.dtbo
 k3-am625-verdin-wifi-dev-mezzanine-panel-cap-touch-10inch-lvds-dtbs := \
 	k3-am625-verdin-wifi-dev.dtb \
 	k3-am625-verdin-dev-mezzanine-panel-cap-touch-10inch-lvds.dtbo
@@ -352,6 +356,7 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-am625-sk-hdmi-audio.dtb \
 	k3-am625-verdin-wifi-dev-dsi-to-lvds-panel-cap-touch-10inch.dtb \
 	k3-am625-verdin-wifi-dev-mezzanine-can.dtb \
+	k3-am625-verdin-wifi-dev-mezzanine-lvds-lg-lp156wf1.dtb \
 	k3-am625-verdin-wifi-dev-mezzanine-panel-cap-touch-10inch-lvds.dtb \
 	k3-am625-verdin-wifi-dev-nau8822-btl.dtb \
 	k3-am625-verdin-wifi-dev-ov5640-24mhz.dtb \
diff --git a/arch/arm64/boot/dts/ti/k3-am625-verdin-dev-mezzanine-lvds-lg-lp156wf1.dtso b/arch/arm64/boot/dts/ti/k3-am625-verdin-dev-mezzanine-lvds-lg-lp156wf1.dtso
new file mode 100644
index 000000000000..a4d6cbe9ff3b
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am625-verdin-dev-mezzanine-lvds-lg-lp156wf1.dtso
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) Toradex
+ *
+ * LG LP156WF1 dual-channel LVDS panel on Verdin AM62 Mezzanine
+ * LVDS interface (J10), used with the Verdin Development Board.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pwm/pwm.h>
+
+&{/} {
+	backlight_pwm2: backlight-pwm2 {
+		compatible = "pwm-backlight";
+		brightness-levels = <0 45 63 88 119 158 203 255>;
+		default-brightness-level = <4>;
+		/* Verdin GPIO_4 (SODIMM 212) - LVDS_BKL_EN */
+		enable-gpios = <&mcu_gpio0 4 GPIO_ACTIVE_HIGH>;
+		/* Verdin PWM_2 (SODIMM 16) - LVDS_PWM */
+		pwms = <&epwm0 1 6666667 PWM_POLARITY_INVERTED>;
+	};
+
+	panel-lvds-native {
+		compatible = "lg,lp156wf1", "panel-lvds";
+		backlight = <&backlight_pwm2>;
+		data-mapping = "jeida-24";
+		height-mm = <194>;
+		width-mm = <345>;
+
+		panel-timing {
+			clock-frequency = <138500000>;
+			hactive = <1920>;
+			hback-porch = <40>;
+			hfront-porch = <24>;
+			hsync-len = <16>;
+			pixelclk-active = <0>;
+			vactive = <1080>;
+			vback-porch = <23>;
+			vfront-porch = <3>;
+			vsync-len = <5>;
+		};
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				dual-lvds-odd-pixels;
+
+				panel_lvds_native_in0: endpoint {
+					remote-endpoint = <&oldi0_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				dual-lvds-even-pixels;
+
+				panel_lvds_native_in1: endpoint {
+					remote-endpoint = <&oldi1_out>;
+				};
+			};
+		};
+	};
+};
+
+&dss {
+	status = "okay";
+};
+
+&dss_ports {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* DSS VP1: internal DPI output to OLDIx */
+	port@0 {
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		dss0_out0: endpoint@0 {
+			reg = <0>;
+			remote-endpoint = <&oldi0_in>;
+		};
+
+		dss0_out1: endpoint@1 {
+			reg = <1>;
+			remote-endpoint = <&oldi1_in>;
+		};
+	};
+};
+
+&oldi0 {
+	ti,companion-oldi = <&oldi1>;
+	status = "okay";
+};
+
+&oldi0_port0 {
+	oldi0_in: endpoint {
+		remote-endpoint = <&dss0_out0>;
+	};
+};
+
+&oldi0_port1 {
+	oldi0_out: endpoint {
+		remote-endpoint = <&panel_lvds_native_in0>;
+	};
+};
+
+&oldi1 {
+	ti,secondary-oldi;
+	status = "okay";
+};
+
+&oldi1_port0 {
+	oldi1_in: endpoint {
+		remote-endpoint = <&dss0_out1>;
+	};
+};
+
+&oldi1_port1 {
+	oldi1_out: endpoint {
+		remote-endpoint = <&panel_lvds_native_in1>;
+	};
+};
-- 
2.54.0

