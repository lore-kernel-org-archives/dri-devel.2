Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 768F8CD5BAF
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 15:01:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95ADB10F38C;
	Thu, 21 May 2026 15:01:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TWjIzm6f";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4314710F393
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 15:01:18 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-44e1ebb3122so3839300f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779375677; x=1779980477; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sEzEUIi3oWaa4bkqOIR8hzCtlujzV1XyxBwf8XTkUg4=;
 b=TWjIzm6fbJqTC/L9IZNIg/LszxApEinEBN6tCadmNeZOLbheYrFx6Nnza4PY2CZe6l
 cmjLPwmgsN1FxWKrvsSO6Tful22L733vxTjxQiFfbupHWeX9A7Z4pTYSi6HrYSW63HGL
 0qXf0wIxJIFLUfVwsvpxKs3qIlswZm2bo1pcW7AXlWHGt9I1tIDuF44NY7FY+tC/i17h
 bfLSZCj5vtdWqUmQhjBgJQTLeL2MJUT8BWs869L/KzG55xKWCGXzriymit2dVbQ/IUP3
 +qpiCWhQ1zW3SkW7Fs00SeuaYzE7Xxc0BFGcIftQDZyvgsHeHlJl7repXelwaXnWg2g8
 8jQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779375677; x=1779980477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sEzEUIi3oWaa4bkqOIR8hzCtlujzV1XyxBwf8XTkUg4=;
 b=UqxiI4C+rhuNGNFUyJH9dcwq4h+96huj7EHZOmix1i7Q8aSkqT4GJT5QuQo57+XZpw
 1M+CaSj3zLQnXt2aF+saiRlf5W3/wJ4EG1tvGe3ZP5ySWXQKAafUoDjwhkCckd5KdLcQ
 OUu2KI78IGGiNV/3fDmU5n6nIwMBmu1lccT4i49VxdIWy8M5mZHQuJo9dLbki6fH08Yc
 2ck7RrmbVtWUrs5/wQ9tlZupF9kPNkvXXqdbIoelKaSRR8JSHWdZZ0zt0wXaLof/qeSP
 xmahf6P7k1vo3TF4QmdSmzk0lXa1Kqkx/zk52ZbjUP5J905CXQBNTpASEpx8gIP4BtMr
 2UTw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/DPifhwBg46Oh7m24wW/o1mRwy9INyVPpAnTiBMVlLfIItHesKsl2ibL07NcLVzzhSoB5uXFwDkt4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzL3/2r+i7vKrH1dRZW3YoJ1nRLonIZNCRS9Lft/fiReEBa2/Yv
 wgNd0q7At25hALayHtVVvXe+JFsZKv+BTniPOLIYlOQ9zKI+En1MYpKi
X-Gm-Gg: Acq92OHFTDTJsZtJrIoMLXSUBlNqL02uDtdsEuLo4BEY7SMxsz2YVnwvFN7HAy9fvtC
 QJ9cD67P3FXYyKrmzSN3GbLAyKlAvwRGzIWb+HU+nT5D9urpM6FivfKEZpKFOp/9Ig6EmXbEXFA
 ijBb042vmabQHAw3qp30E27VnoXYYW3KdOr77tP1iAaTxOW7pUKk5D+uC63pKX4Xm21K1gdHqhf
 yiH2bX0/6PFOR9z7mhy/RUgsaq691QzTGdFieLtH+WxXrczcADe6Y02nN+V9H9xLmnEk2tOnl6c
 en0WP4R5fW1MzEP+bMwubkyBVH2pGI54HCjM08USg6bOIXcZb/x/lJIOHvBAsrJ+FDtDQx3IdnB
 RWSwlej90PPnANpdQuGvXIzi1A004p3T+sxaCOIcBNUixxZKgcTvVsIR15z7dtdgoa1VFSgaJhh
 YVPffx1Ur/hZi6tRNkvOxzExNNFdqu3ZJsBEZYBMzKue2RLFcuqUyR
X-Received: by 2002:a05:600c:524d:b0:490:3893:c4f with SMTP id
 5b1f17b1804b1-49038931006mr39445515e9.3.1779375676464; 
 Thu, 21 May 2026 08:01:16 -0700 (PDT)
Received: from vitor-nb (dsl-113-208.bl27.telepac.pt. [176.79.113.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4903caede9fsm34056745e9.14.2026.05.21.08.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 08:01:15 -0700 (PDT)
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
Subject: [PATCH v1 08/15] arm64: dts: ti: k3-am62-verdin: Add NAU8822 Bridge
 Tied Load
Date: Thu, 21 May 2026 16:00:44 +0100
Message-ID: <20260521150038.103538-25-ivitro@gmail.com>
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

