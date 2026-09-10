Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6486AC88E41
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:19:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F61310F373;
	Thu, 10 Sep 2026 08:19:32 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD4B010F371;
 Thu, 10 Sep 2026 08:19:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BE78443F9A;
 Thu, 10 Sep 2026 08:19:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB201F000FF;
 Thu, 10 Sep 2026 08:19:27 +0000 (UTC)
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
Subject: [PATCH/RFC 3/3] arm64: dts: renesas: r8a779h0: Add GPU node
Date: Thu, 10 Sep 2026 10:19:11 +0200
Message-ID: <2eb9d054023049e1aa282c141981a39de4d4abe6.1789028076.git.geert+renesas@glider.be>
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

Add a device node for the Imagination Technologies IMG BXS-4-64 GPU.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
TI K3 J721s2 uses the same GPU, and firmware is available in upstream
linux-firmware.  The firmware is loaded, but fails to boot:

    powervr fd000000.gpu: [drm] loaded firmware powervr/rogue_36.53.104.796_v1.fw
    powervr fd000000.gpu: [drm] FW version v1.1 (build 6976702 OS)
    powervr fd000000.gpu: [drm] *ERROR* Firmware failed to boot
---
 arch/arm64/boot/dts/renesas/r8a779h0.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a779h0.dtsi b/arch/arm64/boot/dts/renesas/r8a779h0.dtsi
index 0c9ca0f90badc096..ac6665568bd83a12 100644
--- a/arch/arm64/boot/dts/renesas/r8a779h0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779h0.dtsi
@@ -1873,6 +1873,27 @@ its: msi-controller@40000 {
 			};
 		};
 
+		gsx: gpu@fd000000 {
+			compatible = "renesas,r8a779h0-gpu",
+				     "img,img-bxs-4-64", "img,img-rogue";
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
+			power-domains = <&sysc R8A779H0_PD_A33DGA>,
+					<&sysc R8A779H0_PD_A23DGB>;
+			power-domain-names = "a", "b";
+			resets = <&cpg 0>;
+			status = "disabled";
+		};
+
 		csi40: csi2@fe500000 {
 			compatible = "renesas,r8a779h0-csi2";
 			reg = <0 0xfe500000 0 0x40000>;
-- 
2.43.0

