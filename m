Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E5BCD5BB1
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 13:20:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FB1A10F5B1;
	Fri, 22 May 2026 13:20:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Shuj1o84";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93F6B10F587
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 13:20:48 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-49039a8851fso19150225e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 06:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779456047; x=1780060847; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sEzEUIi3oWaa4bkqOIR8hzCtlujzV1XyxBwf8XTkUg4=;
 b=Shuj1o84ca9WFG9s+fbO+uVWSeKQ5mx4sN1yjfNfSr0RFb0/LvhWe88lFfU7ZNCbNE
 JWheBRjSUGq6EPz7+o2PSFvG+xJx+toOdFemyUFNlmpucKJ/Iq62/7vMSdWfh6ONqN1r
 8evqcIZHZLjXNS8U7+6YLjSrFrzPm55CpPMnIaRAn9EFILRhxfYcEm5ZBYQauHkz6Gnd
 0RWux4gdDSnqHTk771SDAOdc3a7QnrZtiOngcpyp37LXVlSV9Er0+OtTIw9IHQWlB2Ro
 GsnB7VLVFtJ/S+DOzZV+9ey2Y9cy0kERjS8dEciyfaReri7TTgND/jlAiFOyJh4HvyVd
 pwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779456047; x=1780060847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sEzEUIi3oWaa4bkqOIR8hzCtlujzV1XyxBwf8XTkUg4=;
 b=UM4pAZX2ATSRddDGYdYNMsLkIDssDBMP7U+1THlPq0a2vSXWwv9ptBay4slUDGehVy
 REcpS0Qt9uQMqy7kQaUrTpFxn5nnxdJ47cj2p9P53aETEQxpNZ63lH19/DXc9euBZdIX
 J2uTTdQW+l8WLTqn/44b9kkxLYgw6vDevvU9vGZ+A91l4pup2ily/yiaJPWIPDz2zGEW
 gjq1DlZZUJB4Io9wnrIGhygwRVxNdDKZJUA3pN8BrascWLPrF+Ekr9HZfTdaSKD6rK2Z
 ZJj4GI/v1Q7LG6TWAJzXsW86E4ve+nIY1I0VaTSwNIJqsU9gmBWDVRzT1u0FZhFTPo1b
 OEcw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/SCjygNbbXbgEhV916DBq/FKP/ki/t6ODD9vEt6abBoWeLxUYd4KiEVyhcCIb5ClfDaB394Uki+xg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw//eay9BGcb8b3XKPRz7fiwwWHNryNx3/Mz1fJO//ZXprfukcH
 vB72XqG3x5MJfyrzDCNxteg6PDOctO88qhhRdH/d25bbQFrwQXDwAUtu
X-Gm-Gg: Acq92OH45wAEX2zmdb8kxawku244Nlz/z39CtE5avtZRqfCHON5EpWmmxbF8qG7BqLE
 0qolbYs4ovSX5HUhVjTN63oolsBM4TlhReYs86qJc9Xu7mmkwYK4wGDrhUVqd/d4ukfXVbKpqdT
 WpNgAxB+KJHx6CXthMjCuj6TTKn8OsC8sV6BNxUDXkfwkuNoSoPdBD1tYR1qbfuHAOkFlYiZvne
 4Krp4Fi6KTLwe3RtmalKwliUvHAuxI6p2SKCAp/CnaaBrdtMHSZZelb80bLCley9NhgM4ZM8Eb8
 xwZBUQm+gC5k5K1KSj90jClnBubl6Y2lDW1u1yh6R1ZDclyaC8PACWmL6s3/M86X6nsRW++YJ/s
 6FqwE8zAsqUYirwsBvyMIIOlvt9Rv9KrzW7qQBlktxi9FgwBPVxg+04D507Ok7os/0rFMjABsvr
 LsylvUcljnsWGoE98c642UXuR8tdXO72GeEeOayx1t6g==
X-Received: by 2002:a05:600c:470e:b0:489:1cd2:610a with SMTP id
 5b1f17b1804b1-490426aa413mr49128005e9.9.1779456046963; 
 Fri, 22 May 2026 06:20:46 -0700 (PDT)
Received: from vitor-nb (dsl-113-208.bl27.telepac.pt. [176.79.113.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454a0cd5sm52220755e9.10.2026.05.22.06.20.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 06:20:46 -0700 (PDT)
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
Subject: [PATCH v2 07/11] arm64: dts: ti: k3-am62-verdin: Add NAU8822 Bridge
 Tied Load
Date: Fri, 22 May 2026 14:20:20 +0100
Message-ID: <20260522132014.226721-20-ivitro@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522132014.226721-13-ivitro@gmail.com>
References: <20260522132014.226721-13-ivitro@gmail.com>
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

