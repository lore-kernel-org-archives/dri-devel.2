Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65832C531D0
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 07:17:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A3BE10E2FE;
	Mon, 27 Jul 2026 07:17:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jVdjCg4w";
	dkim-atps=neutral
Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 496D810E0E8
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 03:19:35 +0000 (UTC)
Received: by mail-pz2-f1.google.com with SMTP id
 41be03b00d2f7-ca034c989e2so560502a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 20:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784949575; x=1785554375; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TSv4z6+j0ETigrrBAdkCkvY/jDNAOWHrT+gEbT1n1Mw=;
 b=jVdjCg4wYK0S95Uy3N7LKUQ64HwAjSqeGH59YuHwWZyDdq8sgz3ksNhnPRAmpo7o1r
 INJ1buItoCYYrzsJ+I4/BekDvh+LTN3y5JF/7/YI0F0BiYc/2Cfy3gXZZg5SVToFbECW
 kYsGG2KpfEoV2InKerGIo2ih/WYFYuvc19Q4XK+ORAlEaMCcWWWcrY1gH7vD3R2+tQ4B
 3rPzz+HbVYqCADxX9hGDDYMV5P3hNbf2d+0Ibx7SbOzX8gWCLXJJ4PzoCx7sJTavmgEv
 4+BfvLZ5aln6cshDpl9b/ObX6HxR6ZNWUN7Pz1BFJc/SCFh6KOhUgSd27dHXqvAb3xUq
 iPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784949575; x=1785554375;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TSv4z6+j0ETigrrBAdkCkvY/jDNAOWHrT+gEbT1n1Mw=;
 b=O1QEDK0qOI6RkqyuRzeOlExzl/pDtiISV+Z7SB2WzBlng8beubTt0GQmDWDGlGziFJ
 OYYdfVcXTOJwyUNS/qCaRl1J+BQ/E+LGlNJdzEWRItcXCMpTuM2FtsWMPYZqp2qVzxz3
 o5AfuiU513wMwq+FuQZlEUxLwUC8j77v1TIOvBwnB2V42hWCnHwPrIkHfrYc8zKKF2T8
 jsJJvfYAbsba7llUZLrG+SPVJV7CKJY7ARTkBdP0u2/sMmi3J0GrQw7IKii1XtLL6p5f
 DzCVPIQjKfCBOOK2sj4xSBrbjTufR/YgLMIdOlySOGNGdNRoe/UHMWqOWXqbb5bl9o/1
 IPBg==
X-Gm-Message-State: AOJu0YxgibBSTFVP8QSlCty8V5KMz+9hY/A7jGVtU7SUMxIkD5D5LluW
 63jDKFWSWel5wLnZy5H6h51U0rE90COrnKVb2LlxuJGeQwj/N+yEZA1C
X-Gm-Gg: AR+sD10d1bGagZvHJNga97NYS3UADv0UA33E90TP/e8XugtowsEJhzZu6+gNcFoSoyf
 5JYRk31VSGJ7PF/bWK/ZTlCpV7C2U/ovRVr51V67fd5DesWxpXKzBjqVtuucjTyeqat4t15UWqf
 vQRnvHqGoHYN0nb6/KKxZH5v+PRYbpx94UdOo0r7AsfYch0CwcTU+TDfTfIhgDV61w0vLxTk5Ti
 sKktAh6BKSLhX6JmxMhN/AmgkF3ANNnwR1m5FzbIwS+S3TgPUMAgTj9GDoTuehEsC1TDT8lOfXt
 aB74zH/KSA95LuDFxg1cX+cIh5x0aADAk1S4vaMkUmXo8q3qcwUlrTru0oVqfr00jBZnASvEGMR
 GAXZzhWdIC4+yGXmCQ+EN0NmihyWxndGhmOlojO68bwv0zmduvSXDPfY=
X-Received: by 2002:a05:6a00:298a:b0:845:c906:5ff5 with SMTP id
 d2e1a72fcca58-84e5944d694mr613698b3a.30.1784949574747; 
 Fri, 24 Jul 2026 20:19:34 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::403c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e53432834sm640542b3a.50.2026.07.24.20.19.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 20:19:33 -0700 (PDT)
From: Cody Kang <codykang.hk@gmail.com>
Date: Fri, 24 Jul 2026 23:16:48 -0400
Subject: [PATCH 16/17] riscv: dts: spacemit: k3-com260-ifx: enable the
 DisplayPort output
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-k3-display-v1-16-f22a10a52867@gmail.com>
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

CoM260-IFX carries a single DisplayPort output, so the second DPU and
the DisplayPort controller it feeds are enabled.

Signed-off-by: Cody Kang <codykang.hk@gmail.com>
---
 arch/riscv/boot/dts/spacemit/k3-com260-ifx.dts | 11 +++++++++++
 arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi   | 11 +++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k3-com260-ifx.dts b/arch/riscv/boot/dts/spacemit/k3-com260-ifx.dts
index 238bb03d0e9e..114d0e02fed9 100644
--- a/arch/riscv/boot/dts/spacemit/k3-com260-ifx.dts
+++ b/arch/riscv/boot/dts/spacemit/k3-com260-ifx.dts
@@ -5,6 +5,7 @@
  */
 
 #include "k3-com260.dtsi"
+#include "k3-display.dtsi"
 
 / {
 	model = "SpacemiT K3 CoM260 IFX";
@@ -19,3 +20,13 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 };
+
+&dpu1_crtc0 {
+	status = "okay";
+};
+
+&dp1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&dp1_3_cfg>;
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi
index 2f36eba20f1e..dbe8db4a8b76 100644
--- a/arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k3-pinctrl.dtsi
@@ -22,6 +22,17 @@ dp1-pins {
 		};
 	};
 
+	/omit-if-no-ref/
+	dp1_3_cfg: dp1-3-cfg {
+		dp1-pins {
+			pinmux = <K3_PADCONF(72, 4)>;	/* dp1 hpd */
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

