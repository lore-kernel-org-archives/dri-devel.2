Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407F6CD5BB4
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 16:12:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 825D810F61A;
	Fri, 22 May 2026 16:12:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ibit3h5Q";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0519510F61A
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 16:11:53 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-48fe26a177cso56977305e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 09:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779466311; x=1780071111; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sEzEUIi3oWaa4bkqOIR8hzCtlujzV1XyxBwf8XTkUg4=;
 b=Ibit3h5QaQIsN7uWnmTEQLX1OakCfStTRojBmvlMRaRiYxnuGPB1SBtA10HvlgARTn
 Ye4uDOuzFpaNyRajNTjK1fBUZNyg3fsEta11Mb7CQeKMZ7B8i//PUaGjBPRKmmLHAiI2
 y+NHVqU44TU3896jdwlClsxcuEsY/IBYzDmo06+bsefRclaCMmJTd11HhEb4YGLpet7E
 ghD3l0nhK9k7GMcpVbpWRS8FJk9bnni66x4xej/ps1MXnAF7PD3j0ivdUTDZddcRuNyQ
 uzPwwBuv5lBOqzPdRfZR1kK6SdDUMmLHeuNpSEjA+SNTjbQiVdRGSuDS8D/GK2zcBDG3
 ao5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779466311; x=1780071111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sEzEUIi3oWaa4bkqOIR8hzCtlujzV1XyxBwf8XTkUg4=;
 b=C4rzczFgOsyA8BkrITKDV2FB0U5nmxQi4lXPV/xime1r8uMPfZh2gnOASHGK4JXr+6
 LuYScjYNi5ZoTcIjGt6SgoBMDxALUBqgWjlFavwuXJjJKQ7j1C8b3YJHvFoaFLnXVZqU
 HaNualfk5tWVUYcdm69x/X6UnrZ2x1NMfHLwj01NZcgBGt6SWNNHkjqmQ/IlJWK6FVj6
 6biAYEErISX81v36goo9VTTPUSAHRbYmv/u2PhxwNhsPj4pcJtZcDTjaG4L7KRLl3aPx
 6BdIJ/6E1E0bALoA+5hNC61vLidROw2OPz0h9uJ12zBBKkO3HhhL5L8liNTGEv5oBt8A
 puOQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+4yERGt6ur36tt+guWYj5UL2aFC4kBVGxHVZUGJtaDjz/H48vzAK4hbrYHJ/Se2/0b78PEctlR+D8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzIq2VCGDbEC0ibikanuAbZ6dvaGAPzLbsHWIwQlq7XIlfRFaok
 Ha2k5/YCcMx5IZ2ZZfZGgAfJVK5k0MaOva9e2LEIMgW1McXQJLrtaCFC
X-Gm-Gg: Acq92OEd4bjR2obE4iDyPAfqNrunQcsoGm1LNWzb/Emsp/E4KypKRCaTYpZKr26TQU1
 rIJKmPZzUrSelBpOLF2ZwhfPbcjdj/cIBV+Hf5rpvcwDRQRs9K7Mv/sWy23zms3K7IZkSaiKmLY
 q0N5BQfzhsOGQUKz0aO0+eLAbMeXd3JD7ZiPRmZiiTXFG/ESChrCjW01dwUXTdIACvcoP0wFFgE
 WMrlKtSALgMaqEc4UG12LaQdWG9FNa4jJEOlQQD1p52B88hSBUumx2RydZatlS4b5cpWK15ZAPN
 F4+dPgqCzoiYNjxw8rLpxn8JHatnr2s/o9bttq1ShsXhcm9rCh6P5A6/GqJjSkyKPNxGxEJL+lZ
 IR7j94lO4GS6znb6LWGpoDfkazwzhNx64vX2oL7Etqdpo53OT7jk4u0Dhz5CY6Pj2p67Cqj7MTp
 wvYHNrDwkiSVyhw1O9L+e5w1cSdHsacDzBi935sUB3Mg==
X-Received: by 2002:a05:600c:4fc9:b0:490:3893:c71 with SMTP id
 5b1f17b1804b1-4904248839emr59095215e9.5.1779466311391; 
 Fri, 22 May 2026 09:11:51 -0700 (PDT)
Received: from vitor-nb (dsl-113-208.bl27.telepac.pt. [176.79.113.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454a0b9asm51042755e9.11.2026.05.22.09.11.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 09:11:50 -0700 (PDT)
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
Subject: [PATCH v3 07/11] arm64: dts: ti: k3-am62-verdin: Add NAU8822 Bridge
 Tied Load
Date: Fri, 22 May 2026 17:11:11 +0100
Message-ID: <20260522161105.277519-20-ivitro@gmail.com>
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

Add a device tree overlay enabling Bridge Tied Load (BTL) mode on the
Nuvoton NAU8822 audio codec present on the Verdin Development Board.
In BTL mode, the two loudspeaker outputs are bridged to deliver higher
output power on the X28 speaker connector.

Assisted-by: Claude:claude-sonnet-4.6
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 arch/arm64/boot/dts/ti/Makefile                    |  4 ++++
 .../dts/ti/k3-am625-verdin-dev-nau8822-btl.dtso    | 14 ++++++++++++++
 2 files changed, 18 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-dev-nau8822-btl.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 14898f8ab0e2..a1083c0b2502 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -29,6 +29,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am625-beagleplay-csi2-tevi-ov5640.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-phyboard-lyra-rdk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-tqma62xx-mba62xx.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-dev-nau8822-btl.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-dsi-to-hdmi.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-dsi-to-lvds-panel-cap-touch-10inch.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-nonwifi-dahlia-dsi-to-hdmi.dtb
@@ -224,6 +225,8 @@ k3-am625-sk-hdmi-audio-dtbs := k3-am625-sk.dtb k3-am62x-sk-hdmi-audio.dtbo
 k3-am625-verdin-wifi-dev-dsi-to-lvds-panel-cap-touch-10inch-dtbs := \
 	k3-am625-verdin-wifi-dev.dtb \
 	k3-am625-verdin-dsi-to-lvds-panel-cap-touch-10inch.dtbo
+k3-am625-verdin-wifi-dev-nau8822-btl-dtbs := k3-am625-verdin-wifi-dev.dtb \
+	k3-am625-verdin-dev-nau8822-btl.dtbo
 k3-am625-verdin-wifi-dev-panel-cap-touch-7inch-dsi-dtbs := \
 	k3-am625-verdin-wifi-dev.dtb \
 	k3-am625-verdin-panel-cap-touch-7inch-dsi.dtbo
@@ -332,6 +335,7 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-am625-sk-csi2-tevi-ov5640.dtb \
 	k3-am625-sk-hdmi-audio.dtb \
 	k3-am625-verdin-wifi-dev-dsi-to-lvds-panel-cap-touch-10inch.dtb \
+	k3-am625-verdin-wifi-dev-nau8822-btl.dtb \
 	k3-am625-verdin-wifi-dev-panel-cap-touch-7inch-dsi.dtb \
 	k3-am625-verdin-wifi-mallow-panel-cap-touch-10inch-lvds.dtb \
 	k3-am62-lp-sk-hdmi-audio.dtb \
diff --git a/arch/arm64/boot/dts/ti/k3-am625-verdin-dev-nau8822-btl.dtso b/arch/arm64/boot/dts/ti/k3-am625-verdin-dev-nau8822-btl.dtso
new file mode 100644
index 000000000000..e4b662519a6b
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am625-verdin-dev-nau8822-btl.dtso
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) Toradex
+ *
+ * Enable Bridge Tied Load (BTL) speaker mode on the Verdin Development Board,
+ * combining the two loudspeaker outputs for higher output power.
+ */
+
+/dts-v1/;
+/plugin/;
+
+&nau8822_1a {
+	nuvoton,spk-btl;
+};
-- 
2.54.0

