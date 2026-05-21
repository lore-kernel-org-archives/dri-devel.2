Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD944CD5BB7
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 15:01:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA91910F395;
	Thu, 21 May 2026 15:01:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="huVENtrx";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 338A310F395
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 15:01:25 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-48896199cbaso48766965e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779375684; x=1779980484; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CF3gRsfbMMzbZIz4+Gb+p1TqqTyY+cXpLaVD2dZQxls=;
 b=huVENtrxRwvPQuo1ekZXDEFYw9x0Oq62vWbmK9m2r4rseeMJYchLcRGwfu/ADzOcsR
 Euh7/uyvegKLmDk/dxv8GXjXDe5qQx2b+XwGBvCt7zTX/UItBWYTbV3v61Fn3zT8TJbi
 pwUfH3lvgzygdpGkAT/k4Ysade1GXepGLUuJTk/SAIyj3q/7YR1Y0Uk3BO4NhQZI9pG6
 hbyCIu8X6+YOqc8yscxQw8iiCPjAp8YFy2/ZIBe07rxqJVc9P5t0cv//+jqP3+fxpAzc
 C8Btf7y3Hxy5yShZxHpaK24apG/ItB1JXhMLaiztoKQIe/9pJ9rRMb3y3lAoFk72KxB2
 rHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779375684; x=1779980484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CF3gRsfbMMzbZIz4+Gb+p1TqqTyY+cXpLaVD2dZQxls=;
 b=lgKzeBGMkQgaUf8SkyncO1x4k796t8CjK2mUIFXtRGf6uWhmDcqRUmZodJ6laUQVhk
 ZiE63kx4dnsFjJMeZNfK20Ojg2YsTE2imK8rTpmC87/0wqxEi+ZfL5r6OwTMAHT45c46
 SAPOkXMkz3f4liMzkpSZBVWqCR1mFUAc6IiwrX4sKbRGDQ/ldikkP9TNby1XoRWzy8Sj
 8daAAgrJSQgk0FG+LfdONj8ourBaNN/U1XQj7+MDiMZBPxtkSvxH9SB1fhVfCu2F6VYI
 V3xm5EIbeoORwp8GipsWoNw5bdB1upPuq2H3LwyD8ZF0jM/D1rkED0R1W4ZkfaZ5V3Dj
 ovVg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+VQsnnDwHEZkxwHk/X5sRdrMmTWLyOigUbf/ZwDYTWdI8Zszj+IEwJ0E6gtCnHLD27YzY4JR8XgC4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YylH5xVN8fTBY7LChOSTDsRBH1cPnacv5OOvClLPDMHBcCp02G3
 x0YnRFoE9adZA2a1LlT8Baqh5qT+nMSZsAYkQEEAaM9gNQpjtFqwX9di
X-Gm-Gg: Acq92OEtr+tmVG2oTNF3Dvp1F3N51GRDjE8F7N5raTBHXLyr3ySJ9LqiVzjfH2rSSxj
 ZCFcRBZaaJdHrGSXd7o4ItqQdq1zxGtz2wSasTEEVcDpMQCeN8JmSSf3cygh2/SMhA/NVLH/Zy3
 M0cTvYhoS5vLMsd28av/vghk1kNzkLfT+Yfakn0A9/dMghaQnGHdyQPhjWI1srb7UsgJwbpa78E
 E51iVNIJMmpZ7/VecsFdtKtJ7pTCEAHEbQIOIX6XFRyYMrSFooDpurRiA2TGToDFp4RArmiTYaH
 NYJA53zWFGfv4t0kc9fu6p4AO12x5EtbgisQV3TJ5AfTofKaatuAK0iHVFEjDGqjcVRUB1KWRcv
 UQTDDqk24YaYwt5uHSMNZ6G3aL4omlsns5AJbz3XI6a6KVtSE8bmY8VVWdpPwkyH3ObFs/609i9
 cO0KEDvtENFKJDZL8WPAUg9AEFCuZYnA8TG5BsyQV4Lg==
X-Received: by 2002:a05:600c:c0c1:b0:48a:f18:ece4 with SMTP id
 5b1f17b1804b1-490360c495bmr39484555e9.24.1779375683441; 
 Thu, 21 May 2026 08:01:23 -0700 (PDT)
Received: from vitor-nb (dsl-113-208.bl27.telepac.pt. [176.79.113.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4903caede9fsm34056745e9.14.2026.05.21.08.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 08:01:22 -0700 (PDT)
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
Subject: [PATCH v1 11/15] arm64: dts: ti: k3-am62-verdin: Add Toradex Verdin
 Mezzanine CAN
Date: Thu, 21 May 2026 16:00:47 +0100
Message-ID: <20260521150038.103538-28-ivitro@gmail.com>
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

Add a device tree overlay enabling AM62 MCU_MCAN1 on the Toradex Verdin
Development Board with Verdin AM62 Mezzanine expansion board. MCU_MCAN1
is exposed on the Mezzanine CAN Header (J13), Pin 3 (CAN1_CONN_N) and
Pin 4 (CAN1_CONN_P).

Assisted-by: Claude:claude-sonnet-4.6
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 arch/arm64/boot/dts/ti/Makefile               |  4 +++
 .../ti/k3-am625-verdin-dev-mezzanine-can.dtso | 28 +++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-dev-mezzanine-can.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 60844951c9ce..90bb3b0522d3 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -29,6 +29,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am625-beagleplay-csi2-tevi-ov5640.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-phyboard-lyra-rdk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-tqma62xx-mba62xx.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-dev-mezzanine-can.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-dev-nau8822-btl.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-dsi-to-hdmi.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-dsi-to-lvds-panel-cap-touch-10inch.dtbo
@@ -228,6 +229,8 @@ k3-am625-sk-hdmi-audio-dtbs := k3-am625-sk.dtb k3-am62x-sk-hdmi-audio.dtbo
 k3-am625-verdin-wifi-dev-dsi-to-lvds-panel-cap-touch-10inch-dtbs := \
 	k3-am625-verdin-wifi-dev.dtb \
 	k3-am625-verdin-dsi-to-lvds-panel-cap-touch-10inch.dtbo
+k3-am625-verdin-wifi-dev-mezzanine-can-dtbs := k3-am625-verdin-wifi-dev.dtb \
+	k3-am625-verdin-dev-mezzanine-can.dtbo
 k3-am625-verdin-wifi-dev-nau8822-btl-dtbs := k3-am625-verdin-wifi-dev.dtb \
 	k3-am625-verdin-dev-nau8822-btl.dtbo
 k3-am625-verdin-wifi-dev-ov5640-24mhz-dtbs := k3-am625-verdin-wifi-dev.dtb \
@@ -344,6 +347,7 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-am625-sk-csi2-tevi-ov5640.dtb \
 	k3-am625-sk-hdmi-audio.dtb \
 	k3-am625-verdin-wifi-dev-dsi-to-lvds-panel-cap-touch-10inch.dtb \
+	k3-am625-verdin-wifi-dev-mezzanine-can.dtb \
 	k3-am625-verdin-wifi-dev-nau8822-btl.dtb \
 	k3-am625-verdin-wifi-dev-ov5640-24mhz.dtb \
 	k3-am625-verdin-wifi-dev-ov5640.dtb \
diff --git a/arch/arm64/boot/dts/ti/k3-am625-verdin-dev-mezzanine-can.dtso b/arch/arm64/boot/dts/ti/k3-am625-verdin-dev-mezzanine-can.dtso
new file mode 100644
index 000000000000..7ebf60d27c3c
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am625-verdin-dev-mezzanine-can.dtso
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) Toradex
+ *
+ * Enable AM62 MCU_MCAN1 exposed on Toradex Verdin Development Board with
+ * Verdin AM62 Mezzanine expansion board on CAN Header (J13),
+ * Pin 3 (CAN1_CONN_N) and Pin 4 (CAN1_CONN_P).
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include "k3-pinctrl.h"
+
+&mcu_pmx0 {
+	pinctrl_mcu_mcan1: mcu-mcan1-default-pins {
+		pinctrl-single,pins = <
+			AM62X_MCU_IOPAD(0x0040, PIN_INPUT,  0) /* (D4) MCU_MCAN1_RX (SODIMM 116) */
+			AM62X_MCU_IOPAD(0x003c, PIN_OUTPUT, 0) /* (E5) MCU_MCAN1_TX (SODIMM 128) */
+		>;
+	};
+};
+
+&mcu_mcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mcu_mcan1>;
+	status = "okay";
+};
-- 
2.54.0

