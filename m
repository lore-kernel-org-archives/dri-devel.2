Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF420C531D0
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 07:17:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B0FD10E2FA;
	Mon, 27 Jul 2026 07:17:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pDeiK3St";
	dkim-atps=neutral
Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CD2D10E0E8
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 03:19:26 +0000 (UTC)
Received: by mail-pz2-f1.google.com with SMTP id
 41be03b00d2f7-cbb818e57c9so551865a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 20:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784949566; x=1785554366; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VnOgmyFyaaGmxr13glRiK2+qIyg9Qu4CO8mOwq+CLUM=;
 b=pDeiK3StGdG5zO0kBDDGxwCYVWF4X9Cd5Uan0o1jaC8qSJv0HbCkMElJtBfPfFt/CU
 YsHOZ+TiB1cJMEz1D1CFylsp3J9pyWHPJbwq87OM/kQls9Lz9Ezop8/SZgDn2TjGvuS6
 17OpV3A9VMSj46Bt+kXwA7y16C/qrIpIlU5a95jbT+B+edWDV5cTC1r13150bQiEj5f8
 1EyHXCA5ArGRD/kyDnlXGgEr7s1mV2QxDzvOplB/3AUPFpW29uiKDNiqcCd6oAAbbpeg
 tIpuacz632uIvjVOqyNV14sF8I/ZfFuIHQMr36FovmjSAJmELh8mY34ir374RS6Dkcoi
 vS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784949566; x=1785554366;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VnOgmyFyaaGmxr13glRiK2+qIyg9Qu4CO8mOwq+CLUM=;
 b=A3eiljlzBApdKdTe53ZtfizQ7CyLZDbLC/b5YsqqQdo6nFtfnu9u9sCU5ScvsGfcX6
 hRkZqCSNj+jnIWvF2BiRQ0q77fKc0T7/EzVZ+0FcYn2pQNcJNLgIQ9oa+mFRfp4PUrtR
 qyWviC+G9B2b0c/9ed3JmXX5BMCz69/Cj0HgS2WS/UKncwyazp9anGcfLAXCGUSePGGb
 p4eU0DVompaZCc6CrsaM7rDMTvDCMlx59URLSht5EmVZ+h/fpmoyF/MDJvokLs6O3hYa
 sCmO64Kz07WIY1p09jRgczyV3JkNLww1YTUTSjBzYDlypWGkUNG2gDdXkQj3yBffhcd5
 xt7g==
X-Gm-Message-State: AOJu0YxJETWcm8+bzWESNfz4wh7SnZHwv4MS9HlMYGwBWlCd/jlbqQiK
 n2veAnA59sQSW8Eo30UQ3AbPP9fAKwjfK3dR4XFOnwj9gtoB3wwNUe9i
X-Gm-Gg: AR+sD132zkMoIpZYI3/qBCsMjJfP1DHI9xDXG+hf5hlDD2vYI2h2JzCVTmj54OK85EG
 8Dw+ia+88DzrGwtzFC184stJMvz/noECvXeQORLzX3zruKIZMAtIqhYPJd3B9XjKKXcPurCX70H
 UpWL4c3QNMJGOwclMiPSKS//FOY8m6mc8LqSqE0sHLO77/Wu5PM925C82q++rgQOhGdd2BtPHT5
 MzAzKygBpAr6HtIVK3Q519GpjeVNp955GMnhbKxVxZKquDhEv1fTSrG3eJWcpKn9l3vu3+QoQMj
 S+CSW/aZhXMV/pskVtjAKRI5pEidjzhfPF3OiCxTu6IhbACwDg7ruwOxrOd35gLvzg8wJvoPHwB
 YY8QSHu0haksqM8otSSpxHaaJv2ryIFu6KM9RAk2xww17sJXm3OEDzkI=
X-Received: by 2002:a05:6a00:2d9b:b0:848:2a71:a48a with SMTP id
 d2e1a72fcca58-84e593ff0ccmr648871b3a.13.1784949566154; 
 Fri, 24 Jul 2026 20:19:26 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::403c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e53432834sm640542b3a.50.2026.07.24.20.19.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 20:19:24 -0700 (PDT)
From: Cody Kang <codykang.hk@gmail.com>
Date: Fri, 24 Jul 2026 23:16:47 -0400
Subject: [PATCH 15/17] riscv: dts: spacemit: k3-pico-itx: enable the
 DisplayPort output
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-k3-display-v1-15-f22a10a52867@gmail.com>
References: <20260724-k3-display-v1-0-f22a10a52867@gmail.com>
In-Reply-To: <20260724-k3-display-v1-0-f22a10a52867@gmail.com>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Haylen Chu <heylenay@4d2.org>, Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-clk@vger.kernel.org, Cody Kang <codykang.hk@gmail.com>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Mon, 27 Jul 2026 07:16:35 +0000
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

Pico-ITX brings the second DPU's output to an external DisplayPort
connector. Enable that DPU and the DisplayPort controller it feeds.

Signed-off-by: Cody Kang <codykang.hk@gmail.com>
---
 arch/riscv/boot/dts/spacemit/k3-pico-itx.dts | 11 +++++++++++
 arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi | 11 +++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
index b89c1521e664..6c31460990a7 100644
--- a/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
+++ b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
@@ -6,6 +6,7 @@
 #include <dt-bindings/gpio/gpio.h>
 
 #include "k3.dtsi"
+#include "k3-display.dtsi"
 #include "k3-pinctrl.dtsi"
 
 / {
@@ -221,3 +222,13 @@ hub@1 {
 &usb2_phy {
 	status = "okay";
 };
+
+&dpu1_crtc0 {
+	status = "okay";
+};
+
+&dp1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&dp1_1_cfg>;
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi
index 3ee1471f3798..2f36eba20f1e 100644
--- a/arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi
@@ -11,6 +11,17 @@
 #define K3_GPIO(x)	(x / 32) (x % 32)
 
 &pinctrl {
+	/omit-if-no-ref/
+	dp1_1_cfg: dp1-1-cfg {
+		dp1-pins {
+			pinmux = <K3_PADCONF(24, 6)>;	/* dp1 hpd */
+
+			bias-disable;
+			drive-strength = <25>;
+			power-source = <3300>;
+		};
+	};
+
 	gmac0_rgmii_0_cfg: gmac0-rgmii-0-cfg {
 		gmac0-rgmii-0-pins {
 			pinmux = <K3_PADCONF(0, 1)>,	/* gmac0_rxdv */

-- 
2.43.0

