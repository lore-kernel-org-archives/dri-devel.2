Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF0DC79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:19:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8197410F370;
	Thu, 10 Sep 2026 08:19:29 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D968C10F36F;
 Thu, 10 Sep 2026 08:19:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C153A43D25;
 Thu, 10 Sep 2026 08:19:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DED1F00893;
 Thu, 10 Sep 2026 08:19:23 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Anh Nguyen <anh.nguyen.pv@renesas.com>
Cc: imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 2/3] arm64: dts: renesas: r8a779g0: Add GPU node
Date: Thu, 10 Sep 2026 10:19:10 +0200
Message-ID: <2399b2755ee8f825c22ab12242d718d64745b239.1789028076.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789028076.git.geert+renesas@glider.be>
References: <cover.1789028076.git.geert+renesas@glider.be>
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

Add a device node for the Imagination Technologies IMG AXM-8-256 GPU.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Fails to load firmware:

    powervr fd000000.gpu: Direct firmware load for powervr/rogue_30.3.408.101_v1.fw failed with error -2
    powervr fd000000.gpu: [drm] *ERROR* failed to load firmware powervr/rogue_30.3.408.101_v1.fw (err=-2)

Firmware not available in upstream linux-firmware or
https://gitlab.freedesktop.org/imagination/linux-firmware.
---
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
index ee3fd0df4fca6020..c2e97d679d35be6d 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
@@ -2168,6 +2168,27 @@ its: msi-controller@40000 {
 			};
 		};
 
+		gsx: gpu@fd000000 {
+			compatible = "renesas,r8a779g0-gpu",
+				     "img,img-axm-8-256", "img,img-rogue";
+			reg = <0 0xfd000000 0 0x800000>;
+			interrupts = <GIC_SPI 464 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 470 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 471 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 0>;
+			clock-names = "core";
+			power-domains = <&sysc R8A779G0_PD_A33DGA>,
+					<&sysc R8A779G0_PD_A23DGB>;
+			power-domain-names = "a", "b";
+			resets = <&cpg 0>;
+			status = "disabled";
+		};
+
 		csi40: csi2@fe500000 {
 			compatible = "renesas,r8a779g0-csi2";
 			reg = <0 0xfe500000 0 0x40000>;
-- 
2.43.0

