Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1636CD5BB6
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 16:11:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D3D310F6AE;
	Fri, 22 May 2026 16:11:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KSuPBBuC";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 970BE10F61A
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 16:11:54 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-490388fd0dbso20099755e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 09:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779466313; x=1780071113; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RP+CltVi6jUCZJal0Anzdw8j6V9ipqNLat7Pdw8ZHRU=;
 b=KSuPBBuC9pENqW8zwLpFnNcg8pZn6gnUePTRq0kca5eMIrc8qoAsm+ewuqVfrO4xeR
 VqrdwtTZ/Df5UX77bokjoi3cHrTdhBeoMDlj4DnB3SDmqmFbeRT+4HoGxwXAkmIszboT
 Miv5wtw8LChGU57ui+diozu31eKIuoH+MGchw0rZgTsrKGWswHgVJgvMa16fW43MiJiV
 1gcAzo0GpAiKsVUawHt7UHoQM57wKmEou4jbTKKjlyeJ1WIzTTBt6ehc+mC9Owcoo63/
 6pYJCiV1atHxUhWtjIcVvKnBk3W0Rq8mVtq+ys8IHQS1NbVzsS0rX8gCVEySZdMErL0U
 DN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779466313; x=1780071113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RP+CltVi6jUCZJal0Anzdw8j6V9ipqNLat7Pdw8ZHRU=;
 b=P0RujI3UYfxn0mfwqNZt9lpP0cO1klEKAT/fBrsAiuYmEc3zr4z8cP4IrdUjI8Zsp4
 xerkZ6SLGsoMt0vDPzb8rS85Od3hMkE0Nln72aSnuVJ9jYvABwa/2Jxw48VqfGhUhDl2
 0hC+tkrHAI3fiIuDD4+Vcnupc0dv2KlhNGZFIOx2wubHTo+TW+F2TCdfaC0hZm+110FR
 MoUO91Hruzmf6RoHXaKOlzz0NwaCUU674XnzTViyTAPgWFVgccU+//zApjybMqXPkj0L
 32ugLdaJGtzxCHd5nbRUB631rgAwgt5ncGDBdvzxGG4blG1VCr/V9sxxdRNPyRPfZk42
 Azeg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/4T5v5vIIztsaE8JqwP4kALpzF1/C2l3adda7WURpqQc8anWrfJi/sjJ6IBb8RNn41GRKO+C2aoAc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy5VlHwmEyFZtyzf/2PwB6iRsFAqssWcRospwCAT6gvao9Zl3Lh
 /fzBqyxSJus6XZe7IIlbKae15zBdpSlma1b/wEAso4cb0kG4/k1g1sF3
X-Gm-Gg: Acq92OF3kv32PGxHM8p+jcY+toglV4HI2WBYFKXFtkB0xOK/jT6FN3PziXBS1uiAiWW
 A5uRu+8Mjl41f+uBDUPmuQko72V47HdqLdgEt928kR12lJSTehNwuDVZpek4e7L5IZ/RiOBYAD4
 rYy+XTDSRmKzwaOvQX0u3poCHl8up+LmBI6Y+i9RV2pxT/VqE5atgHf3eHvxmfwu+yWztpP8MD7
 baGsgOUGVHlYOJvb8Yze/dsGGocJaAAlqvilHxQ1VTFyFd+b5tL7Y0vf6t150k00KmnNsKWuCBm
 WNK2nRWEDdyRYmCqEkyFQmhunhlMw5QCexf4X9FQer+N5TRiYmMt55jxz5//xvZ+5luiD1lmHC+
 u05oCSxQ9UbDO6os69WfTMp8/3ENLnWTRDBK2QIXlta7zaHoB43srK8DUqtY9WFtlLEiMMq89jR
 dHNYMLek5/D51mfWcy9JlfRWWqm/FFCBuCVTjHHzs3FQ==
X-Received: by 2002:a05:600c:3e0c:b0:488:ac01:72de with SMTP id
 5b1f17b1804b1-49042489c30mr69866695e9.5.1779466313046; 
 Fri, 22 May 2026 09:11:53 -0700 (PDT)
Received: from vitor-nb (dsl-113-208.bl27.telepac.pt. [176.79.113.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454a0b9asm51042755e9.11.2026.05.22.09.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 09:11:52 -0700 (PDT)
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
Subject: [PATCH v3 08/11] arm64: dts: ti: k3-am62-verdin: Reserve UART_4 for
 Cortex-M4F
Date: Fri, 22 May 2026 17:11:12 +0100
Message-ID: <20260522161105.277519-21-ivitro@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522161105.277519-13-ivitro@gmail.com>
References: <20260522161105.277519-13-ivitro@gmail.com>
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

