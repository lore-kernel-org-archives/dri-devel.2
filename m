Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640A6EA71A1
	for <dri-devel@archiver.kernel.org>; Sun, 19 Apr 2026 19:38:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6E6B10E3ED;
	Sun, 19 Apr 2026 19:38:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="KQ9fDMwn";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DrFzN0Ub";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 455A310E3ED
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 19:38:12 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fzJnG6DpXz9t1S;
 Sun, 19 Apr 2026 21:38:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776627490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SlkbA/p29nZ5RMxQfG/SqbkLGXx2vuQDTDqohpkxhuc=;
 b=KQ9fDMwn87mZrtCH2owLwwFRE4/DRT44Sg8Cwc3XgeuKRho69ajCNv7nfyE5dCcmyvKbjX
 c8FTdPguIAiz2EtSd8f3wVVEWirpzalch+8cqiuL0W/phglJnQ38i00Na0E4uleXn4oWx1
 dVE1aA6cWmNuLb7gD0hZ+vPLNHfZB+XaROFU4yo6icJydGlyvbspw4lymbE7YNQG1pEyTk
 0zDFF9fyN+Dnqo276SJR5/br3vLOJ6bnvNusQfgfmGvZ2vMFbWYaKKNW6HEZO58AU0KVyZ
 q1vtQ9NXW2fzmSzHZSZ/D9AENI+MrXf77z7OhRvMpZg47rtiTcxJnOOs3/ue8w==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=DrFzN0Ub;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776627489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SlkbA/p29nZ5RMxQfG/SqbkLGXx2vuQDTDqohpkxhuc=;
 b=DrFzN0UbDIbvZbZ/s1JoNU4vr7regCxqrCxZMy0qTsZ0ifCBQa2sZ7Q43kTBk60C40eM+G
 81WO/ya6y7uEfPweeHYI41vpW3ONPE7SjYnptfbNiNktI1XzVi9cUC+C7xUjBnOun6lAEH
 shX2+J0T0Q/FwbJFI/z6mnbDqD5URkksiKfWT3+1s+olaNRYu6ytIRuZsYtStQJSSUr47/
 HdAa7iDTjNTY+oAP0oqLq8romWH+zQ4SCSrZd9GPqZnICikbV6makDRGXEcJLgMHJUolCr
 m7HoCmHGVBLd/+5RXbrLFKZctYhgC/lbeFhVjkkgbx2sFATCKv1MkB7KfZxuUQ==
To: linux-arm-kernel@lists.infradead.org
Cc: Nguyen Tran <nguyen.tran.pz@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Magnus Damm <magnus.damm@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Stephen Boyd <sboyd@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
Subject: [PATCH 6/7] arm64: dts: renesas: r8a779md: Add Renesas R-Car R8A779MD
 M3Le DTs
Date: Sun, 19 Apr 2026 21:35:37 +0200
Message-ID: <20260419193718.133174-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260419193718.133174-1-marek.vasut+renesas@mailbox.org>
References: <20260419193718.133174-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 58c89db21b2313176f4
X-MBO-RS-META: ogkhnyf5obinb8orhfmce4uwkrwsfqd9
X-Rspamd-Queue-Id: 4fzJnG6DpXz9t1S
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

From: Nguyen Tran <nguyen.tran.pz@bp.renesas.com>

Add support for the Renesas R-Car M3Le (R8A779MD) SoC, a variant of the
R-Car M3-N (R8A77965) SoC. The Renesas M3Le SoC is a register-compatible
variant of the R8A77965 (M3-N) with reduced set of peripherals.

Signed-off-by: Nguyen Tran <nguyen.tran.pz@bp.renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: David Airlie <airlied@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Cc: devicetree@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
 arch/arm64/boot/dts/renesas/r8a779md.dtsi | 48 +++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a779md.dtsi

diff --git a/arch/arm64/boot/dts/renesas/r8a779md.dtsi b/arch/arm64/boot/dts/renesas/r8a779md.dtsi
new file mode 100644
index 0000000000000..7e0f5fe4cd439
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a779md.dtsi
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the R-Car M3Le (R8A779MD) SoC
+ *
+ * Copyright (C) 2025-2026 Renesas Electronics Corp.
+ */
+
+#include "r8a77965.dtsi"
+
+/ {
+	compatible = "renesas,r8a779md", "renesas,r8a77965";
+};
+
+/delete-node/ &csi20;
+/delete-node/ &drif00;
+/delete-node/ &drif01;
+/delete-node/ &drif10;
+/delete-node/ &drif11;
+/delete-node/ &drif20;
+/delete-node/ &drif21;
+/delete-node/ &drif30;
+/delete-node/ &drif31;
+/delete-node/ &hdmi0;
+/delete-node/ &mlp;
+/delete-node/ &pciec1;
+/delete-node/ &sata;
+/delete-node/ &sdhi3;
+/delete-node/ &usb3_peri0;
+/delete-node/ &usb3_phy0;
+/delete-node/ &vin0csi20;
+/delete-node/ &vin1csi20;
+/delete-node/ &vin2csi20;
+/delete-node/ &vin3csi20;
+/delete-node/ &vin4csi20;
+/delete-node/ &vin5csi20;
+/delete-node/ &vin6csi20;
+/delete-node/ &vin7csi20;
+/delete-node/ &xhci0;
+
+&du {
+	compatible = "renesas,du-r8a779md";
+	renesas,cmms = <&cmm0>, <&cmm3>;
+	renesas,vsps = <&vspd0 0>, <&vspd1 0>;
+
+	ports {
+		/delete-node/ port@1;
+	};
+};
-- 
2.53.0

