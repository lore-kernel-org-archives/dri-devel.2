Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64F3CD4851
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 09:10:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E23F10F4A5;
	Fri, 15 May 2026 09:10:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="QxpDTze9";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E506D10F4A5
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 09:10:05 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id BDE3F1337;
 Fri, 15 May 2026 11:09:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778836195;
 bh=Q0KK8Vnmn0OKEEcWFrpokO4RWx/VC1ho0JpGmPQEI5Q=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=QxpDTze9IPXVXHJyWDbbaXDTI2JoVnhsZgvSYrEwX8mzwMitYEeRIlO3sdUMWhhAB
 WkkNfRFlDM/IoH/NBXxeukRwzqujQgVVNrEQdbZzn3gPztkWHCjrfUdp4sqb6mUuDB
 T/QDwgIlSrf7HFWkzuaKNHsFPLJmUVnVZl0B3kCU=
From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Date: Fri, 15 May 2026 12:09:30 +0300
Subject: [PATCH v3 5/7] arm64: dts: renesas: r8a779g0: Add DSC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-rcar-du-dsc-v3-5-164157820498@ideasonboard.com>
References: <20260515-rcar-du-dsc-v3-0-164157820498@ideasonboard.com>
In-Reply-To: <20260515-rcar-du-dsc-v3-0-164157820498@ideasonboard.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1848;
 i=tomi.valkeinen+renesas@ideasonboard.com; h=from:subject:message-id;
 bh=LB0h2hc6Sj2kvghRC2Rip9B8urRMXGeEfCaq9x9z/6Q=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqBuLiI9h3bVKCgisUxUZwYF14YJcg2kBLL3u2X
 Bluo9pkMTyJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCagbi4gAKCRD6PaqMvJYe
 9egAD/4q54Y9c6EsRHM/rWayxcTqLqCxyZYt8tosp+hQvuZmKiYBwojjQUPk8u/o9QniHV6Nolb
 zKP1JR5Ww/X9OglYMOejbwPtoKwPDVRoM9Y3Crs4e5Dafqm0KV3g9IRUVxCPwfpm0IBs8QiGkx1
 nFd4Dm3OQWq9JmHXzLt3n2MILpu3tCe+SYGxoJvuDqBZhSbALqztFEyAry6/RDKQPcO2EGUXEwL
 iy4nFUGFPD131rdxQCpyRmwrp+KLC/XJJ5+w5UiHr6mhioc6Al6anhC3PlZYCIXE8TiG7Lx4lxf
 DM5cnaarIguh80XubmHbR0+egF5uZYQCihEaWseTVIqsl6SLlfPAOo9M8f/WJmvGyWhubJln8Xu
 3qfe8U/Z/96xZXzb1/CNAtbePAo6AHYT5E3KHVYVMG/BWO01JB7giSySsPNXsOrLejLk6FRhseo
 C8A0XWCcLdiJIY+efL6q1esDzQjjjda8eOfo23eCAn5ob/Rey8Z69joW0WGvyiJPtIm0if3V2nl
 CQk2s0EjVxU9AZfoniWNR4uNwxQLU3mbTQhaBWYyYMoU7Vsf+X3ZMC62bK6zZHBvkfsxiB53tCU
 wc3vioEaUqze14rlToLcyz7DrrBLi/meYrO5YrYh8GsanVIjHTlsUHhdqj1IveI8r7soQfR4fxQ
 7HDMGyWBJvjIkQg==
X-Developer-Key: i=tomi.valkeinen+renesas@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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

From: Marek Vasut <marek.vasut+renesas@mailbox.org>

The Renesas DSC Display Stream Compression is a bridge embedded in the
Renesas R-Car V4H SoC. The bridge is placed between DU and DSI1 units.

The current dtsi file does not represent the DSC at all, and thus the
pipeline for DSI1 has not been functional.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
[tomi.valkeinen: separated the sparrowhawk changes]
Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
---
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
index 82a7278836e5..52a6176f9fd0 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
@@ -2298,6 +2298,35 @@ du_out_dsi0: endpoint {
 				port@1 {
 					reg = <1>;
 					du_out_dsi1: endpoint {
+						remote-endpoint = <&dsc_in_dsi1>;
+					};
+				};
+			};
+		};
+
+		dsc: dsc@feb8d000 {
+			compatible = "renesas,r8a779g0-dsc";
+			reg = <0 0xfeb8d000 0 0x400>;
+			interrupts = <GIC_SPI 559 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 2819>;
+			power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+			resets = <&cpg 2819>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					dsc_in_dsi1: endpoint {
+						remote-endpoint = <&du_out_dsi1>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					dsc_out_dsi1: endpoint {
 						remote-endpoint = <&dsi1_in>;
 					};
 				};
@@ -2534,7 +2563,7 @@ ports {
 				port@0 {
 					reg = <0>;
 					dsi1_in: endpoint {
-						remote-endpoint = <&du_out_dsi1>;
+						remote-endpoint = <&dsc_out_dsi1>;
 					};
 				};
 

-- 
2.43.0

