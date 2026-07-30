Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42141C55167
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 21:52:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AAC210F0B4;
	Thu, 30 Jul 2026 21:52:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="o7WxiUr3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A37DD10F0B5
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 21:52:17 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 78372440B2;
 Thu, 30 Jul 2026 21:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3864FC2BD00;
 Thu, 30 Jul 2026 21:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1785448337;
 bh=1jMEmScgW7TseA/29UBdakYVRRuiPedDQP+bOxQIhjE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=o7WxiUr3RX/LKRMx12qeMKMf9XyQ98/8nLswif5ZRh9ffjAPu6I6RMNT6OQbJonr8
 IURDSrrhTYnjaPep2LHSFeumJYhFjU9sqM0NvxTUpI8fktdh6/NspOcNMQnmu55lEQ
 7PN2Yqx0iuo+72KpS3UeRLkVaPxyPGNksIJqAuJ2Sc04EMKmhcWlSegFhQJ9+EwhQ3
 G11GC0koERDZMEPOkv6R1R32dr0vys6pqFpLtMxFqAFCPyODv5VcVWThq178ZrqIOc
 vsDhvUJ5dx1wkpHvKJpyo+f0j9iOG4jAFCmDEdxsBhlCEpYNi1MnZYwgDSvZgbLwct
 FNa69SZsVzJCQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 22188C55173;
 Thu, 30 Jul 2026 21:52:17 +0000 (UTC)
From: =?utf-8?q?Dawid_Wr=C3=B3bel_via_B4_Relay?=
 <devnull+me.dawidwrobel.com@kernel.org>
Date: Thu, 30 Jul 2026 23:52:03 +0200
Subject: [PATCH 4/4] arm64: dts: qcom: sm8250: add device tree for the
 Xiaomi Mi Pad 5 Pro 5G
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260730-sm8250-xiaomi-enuma-v1-4-ed6d8fb99668@dawidwrobel.com>
References: <20260730-sm8250-xiaomi-enuma-v1-0-ed6d8fb99668@dawidwrobel.com>
In-Reply-To: <20260730-sm8250-xiaomi-enuma-v1-0-ed6d8fb99668@dawidwrobel.com>
To: Jianhua Lu <lujianhua000@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 =?utf-8?q?Dawid_Wr=C3=B3bel?= <me@dawidwrobel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2171; i=me@dawidwrobel.com;
 h=from:subject:message-id;
 bh=hi9FyJr3l3tmFrwy+xRGM7nOfpqAmtQXqm/PedUBYog=;
 b=owGbwMvMwCV2qrTGfeXVd28ZT6slMWRlH+8vLYqMaV9n9Epyx7p7BWlBrTta1+WentByMbKTe
 dOXk4H+HaUsDGJcDLJiiix6aUF7rIJffn/34nc4zBxWJpAhDFycAjARkZ2MDNc/CWh7Wev/9VAt
 +SZqu37a67/Zzh8Y0sIKzZ6tevv1RC3DP63EI9/Orpz9+Yp0Ugxn6+sUp2jxCdX3Vl259UR2/tL
 b1bwA
X-Developer-Key: i=me@dawidwrobel.com; a=openpgp;
 fpr=B64A778E0E64049A70C831C8B7B81FA12B282A92
X-Endpoint-Received: by B4 Relay for me@dawidwrobel.com/default with
 auth_id=901
X-Original-From: =?utf-8?q?Dawid_Wr=C3=B3bel?= <me@dawidwrobel.com>
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
Reply-To: me@dawidwrobel.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Dawid Wróbel <me@dawidwrobel.com>

The Mi Pad 5 Pro 5G (enuma, 2021) is the modem-equipped variant of the
Mi Pad 5 Pro. The board is otherwise the elish design, so describe it as
the common device tree plus its own board ID, panel compatible and WiFi
board data variant.

Unlike elish, this model shipped with a single display variant, so there
is one device tree rather than a per-panel pair.

Signed-off-by: Dawid Wróbel <me@dawidwrobel.com>
---
 arch/arm64/boot/dts/qcom/Makefile                |  1 +
 arch/arm64/boot/dts/qcom/sm8250-xiaomi-enuma.dts | 26 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index e05414290d8e..529e29ffb25a 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -369,6 +369,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-sony-xperia-edo-pdx203.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-sony-xperia-edo-pdx206.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-xiaomi-elish-boe.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-xiaomi-elish-csot.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-xiaomi-enuma.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-xiaomi-pipa.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-hdk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-microsoft-surface-duo2.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-enuma.dts b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-enuma.dts
new file mode 100644
index 000000000000..7cc9ed7d12b2
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-enuma.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2025 Dawid Wróbel <me@dawidwrobel.com>
+ */
+
+/dts-v1/;
+
+#include "sm8250-xiaomi-elish-common.dtsi"
+
+/ {
+	model = "Xiaomi Mi Pad 5 Pro 5G";
+	compatible = "xiaomi,enuma", "xiaomi,elish", "qcom,sm8250";
+
+	/* Platform type differs from elish; msm-id is inherited unchanged. */
+	qcom,board-id = <0x2e 0>;
+};
+
+&display_panel {
+	compatible = "xiaomi,enuma-csot-nt36523", "xiaomi,elish-csot-nt36523",
+		     "novatek,nt36523";
+	status = "okay";
+};
+
+&wifi_0 {
+	qcom,calibration-variant = "Xiaomi_Pad_5Pro_5G";
+};

-- 
2.55.0


