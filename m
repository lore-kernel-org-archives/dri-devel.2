Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4B2606A332
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W22762lv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14B0E10E2E2;
	Thu,  5 Nov 2026 13:30:31 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B360F10E94B;
 Thu,  5 Nov 2026 13:30:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 776E043F9F;
 Thu,  5 Nov 2026 13:30:25 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793885425;
 b=cvGgGCXW5IFygaSP/dyulRicjXnwMHTBP1w8OByElEF5tdTwPa7BwCcfF3SVq4eNFg6i
 gRMwXQGAHArJ4buwtnAT8o8O4/apQRcRDJWXWmlUbSDs5OpjBCuNzFpDPG1LC/IYrZ+Lu
 0oQT5h0hrJHZ/E+U6ep9cBl9O1Xmo/j3nHUXooDb20VuFPoSSxOOAlz9+NoLVuLb5HedT
 bIpjzWXRBp5ffgDyrSkivOs6v5LGeJhIBcjBpFjsH7+ELyIZLFaXipD/1SnIku8SN4Zli
 1AHBq9YSlN6RQgmggBk2H53R1goPy3eB0IqeI3aJfT5o42gmIhEdOdtj3XltVsS+36w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793885425;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=noWbOBqyGXZHg9mlOzTz3nMj1re9nbXum97ku+iklZs=;
 b=d2/SwIkKc2lmDwAwRUgknp4dyO6fwHA5Va/7Ydlyg/gWuytQa9xAz3rzUh/+bZWeKFft
 XJ9C2La4tmVGOynTr/BKMS8kuYzLzy6degFteb/3URBpE1kWHeAwS7MzS/MD0Q6AqfvWZ
 YX185S6iLgvzimB+sWG+1j3xoshRblt+Lpqsp25uvKN+OpLpPigRKbMul0GgHMFixsuVE
 qgBBReeFr0WPIayvT84jmaBPHIYflPwAHx5bYD1jzX64QHqodbKj6fT83Tu8DDuHsxT+R
 7TlR2YrF7m/c0H367mhP2P8tIuXlyWk9njF4auvPpbnO3essT1WMQyKMhydbgl1HEDA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 80DB41F00A1D;
 Thu,  5 Nov 2026 13:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793885425;
 bh=noWbOBqyGXZHg9mlOzTz3nMj1re9nbXum97ku+iklZs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=W22762lvbUuUoL9XRay2jjeJ2nbMYBsn3Lzp+Fussarv2Ga/Ynr5OoXgLQnxbZg2p
 Pdh+YKkDitAlFdVbzYh3+35gKcqXC7uhXVm/TwZ3wggcHeXy1wNbeaZnsHplrCu4KA
 j+dfcbePZkQiQToELLwTNU7+UW2mg6FxHQhZ0c25+y4GmDD7s2/WInx/TFczusBJqU
 GlOAHTgsaS1UkJdIR5l3rkye5EcLfTHqVVKwgBr/iwtbg8vPN6x66vvOslFoTse7K0
 rxSVxmFYmaK+UXKTnp2lvNtPmeoiljzoY62dMN+UJtX65AgTKCgJBWT3SusvQf/MRx
 td+LgqR88zIOA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id F356847297;
 Thu,  5 Nov 2026 13:30:22 +0000 (UTC)
From: Demeter Barna via B4 Relay <devnull+me.fromdisposition.org@kernel.org>
Date: Thu, 05 Nov 2026 13:30:04 +0000
Subject: [PATCH 5/5] arm64: dts: qcom: sm8350: Add the GPU speed bins
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261105-b4-sm8350-gpu-v1-5-a7175cdd6512@fromdisposition.org>
References: <20261105-b4-sm8350-gpu-v1-0-a7175cdd6512@fromdisposition.org>
In-Reply-To: <20261105-b4-sm8350-gpu-v1-0-a7175cdd6512@fromdisposition.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, Demeter Barna <me@fromdisposition.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793885419; l=4165;
 i=me@fromdisposition.org; s=20261012; h=from:subject:message-id;
 bh=Go4TFFoOKKLlrDXSMdwVz23UmppnG+cEaIIyTAUOMts=;
 b=gvMWWyHdYqIcfg4Bi9gJX8QdzZV6k9PsAiPTXeSbClueRJU9sTngpnC2INWztvFHcEOht2Urt
 woh7pBiCoX1DPEBa0KUdekh9/Nd9aBtGj640nasUrxAvuZKLV6YwK+I
X-Developer-Key: i=me@fromdisposition.org; a=ed25519;
 pk=S0QFlGq1BQEaAtPPdAH8YKEOXMeRuSkTgctXuvtU+1Y=
X-Endpoint-Received: by B4 Relay for me@fromdisposition.org/20261012 with
 auth_id=1163
X-Original-From: Demeter Barna <me@fromdisposition.org>
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: me@fromdisposition.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Demeter Barna <me@fromdisposition.org>

Today every SM8350 runs its GPU up to 840 MHz, including the parts that
are validated only up to 738 MHz, and no part gets the 900 MHz level the
best bin supports.

Describe the QFPROM with the GPU speed bin cell, as sm8250.dtsi does,
let the GPU read it and mark each OPP with the bins that support it:

  900 MHz            bin 1 (new OPP, same bandwidth as 840 MHz)
  840, 778 MHz       bins 0 and 1
  738 MHz and below  all bins

Drop the note about downstream binning above the OPP table, which this
replaces.

Reading the whole nvmem file needs the SM8350 keepout regions in the
qfprom driver; without them it resets the SoC.

Signed-off-by: Demeter Barna <me@fromdisposition.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 903b2968c..d488c9d64 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -710,6 +710,18 @@ ipcc: mailbox@408000 {
 			#mbox-cells = <2>;
 		};
 
+		qfprom: efuse@784000 {
+			compatible = "qcom,sm8350-qfprom", "qcom,qfprom";
+			reg = <0 0x00784000 0 0x3000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			gpu_speed_bin: gpu-speed-bin@17b {
+				reg = <0x17b 0x1>;
+				bits = <5 3>;
+			};
+		};
+
 		gpi_dma2: dma-controller@800000 {
 			compatible = "qcom,sm8350-gpi-dma", "qcom,sm6350-gpi-dma";
 			reg = <0 0x00800000 0 0x60000>;
@@ -2057,6 +2069,9 @@ gpu: gpu@3d00000 {
 			operating-points-v2 = <&gpu_opp_table>;
 
 			qcom,gmu = <&gmu>;
+
+			nvmem-cells = <&gpu_speed_bin>;
+			nvmem-cell-names = "speed_bin";
 			#cooling-cells = <2>;
 
 			status = "disabled";
@@ -2065,68 +2080,84 @@ gpu_zap_shader: zap-shader {
 				memory-region = <&pil_gpu_mem>;
 			};
 
-			/* note: downstream checks gpu binning for 670 Mhz */
 			gpu_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
+				opp-900000000 {
+					opp-hz = /bits/ 64 <900000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L2>;
+					opp-peak-kBps = <12484375>;
+					opp-supported-hw = <0x2>;
+				};
+
 				opp-840000000 {
 					opp-hz = /bits/ 64 <840000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
 					opp-peak-kBps = <12484375>;
+					opp-supported-hw = <0x3>;
 				};
 
 				opp-778000000 {
 					opp-hz = /bits/ 64 <778000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
 					opp-peak-kBps = <12484375>;
+					opp-supported-hw = <0x3>;
 				};
 
 				opp-738000000 {
 					opp-hz = /bits/ 64 <738000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
 					opp-peak-kBps = <12484375>;
+					opp-supported-hw = <0x7>;
 				};
 
 				opp-676000000 {
 					opp-hz = /bits/ 64 <676000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
 					opp-peak-kBps = <10687500>;
+					opp-supported-hw = <0x7>;
 				};
 
 				opp-608000000 {
 					opp-hz = /bits/ 64 <608000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L2>;
 					opp-peak-kBps = <6074218>;
+					opp-supported-hw = <0x7>;
 				};
 
 				opp-540000000 {
 					opp-hz = /bits/ 64 <540000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
 					opp-peak-kBps = <6074218>;
+					opp-supported-hw = <0x7>;
 				};
 
 				opp-491000000 {
 					opp-hz = /bits/ 64 <491000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L0>;
 					opp-peak-kBps = <6074218>;
+					opp-supported-hw = <0x7>;
 				};
 
 				opp-443000000 {
 					opp-hz = /bits/ 64 <443000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
 					opp-peak-kBps = <6074218>;
+					opp-supported-hw = <0x7>;
 				};
 
 				opp-379000000 {
 					opp-hz = /bits/ 64 <379000000>;
 					opp-level = <80 /* RPMH_REGULATOR_LEVEL_LOW_SVS_L1 */>;
 					opp-peak-kBps = <3972656>;
+					opp-supported-hw = <0x7>;
 				};
 
 				opp-315000000 {
 					opp-hz = /bits/ 64 <315000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
 					opp-peak-kBps = <1761718>;
+					opp-supported-hw = <0x7>;
 				};
 			};
 		};

-- 
2.53.0


