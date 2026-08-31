Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04E0C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 04:10:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F389D10E5CA;
	Mon, 31 Aug 2026 04:10:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="ptqF2cjx";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="HUtxA3Ix";
	dkim-atps=neutral
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D906310E5CA
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 04:10:32 +0000 (UTC)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfout.stl.internal (Postfix) with ESMTP id C1A191D000E2;
 Mon, 31 Aug 2026 00:10:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Mon, 31 Aug 2026 00:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1788149431; x=
 1788235831; bh=yyAlnjllRJoc8EnuoheqRfmGGLiMMzIInITnv3UMbRQ=; b=p
 tqF2cjx8J2Yp8MYjYCU6uG9FBoYI5tYG85Z8C/LzvXlE3s7TBg40D2GczawCBWbi
 xq1daNUDthJ6jybl/nrxF0RvSPPi1ruDApZD1KDc7BWzoSQQ2vS/b8UO/cQtuImX
 JxLlLD134P95Muo96itFE+eB2Yf8FHxdMNskL7Mv8LXN8qlvDswM3QJF21MzDQB7
 n0/+IGrIv01kMvG68DL/RAnHI+mH4K/7SDbynuDgr8Uru0z4VxZH8OVtRw5dw994
 JEBCLvXFRZ1zBY3s8tjJwnkpSUi0OS34dakdHoQCHfcBUC61rChLqCSsFUjRgNSZ
 9UJQ+f1uL8G8wHJTC/klg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1788149431; x=1788235831; bh=y
 yAlnjllRJoc8EnuoheqRfmGGLiMMzIInITnv3UMbRQ=; b=HUtxA3IxCZ57NdmV9
 apaggqOkpQL9I/IkEu5k1GLdjGR1eNwqH8ZwEtlGNY2P/DNjnSfEXZNygovq7a2O
 DxgLqbF0Ctm0BEbKUVMIZBH961nsHdzYHNlCs1O2RBvGCenOKiNxDeRVW3WkQkiP
 3kGb74NcMDY9AhPz0R1ll8z1xtlHLrcd9CU18If1i9FN7Yo7U1WXSeLDq1eO1B0X
 Hf4H2vZmhNioMc70j9Ql3FBdbTT/VpJKzegsdD94rVurfiPhqReo2zgeXEQNE5pn
 1jGVLxGOHKLxk50kuu/uPRVwS+fRm3yzdxwj2jOZo/1ppyJ50RX3976FtWhkvB54
 vK+hw==
X-ME-Sender: <xms:t_6UanlXnad4NTpuOfwYbwhposK5fj_P0g2A59RrE5KBI9A2PjOwSw>
 <xme:t_6UamX7-KIRuF1I9rdWmlr0tU4NvcVF9Mx9Yu9O88cX3UR1vHmCIKK3xvvqTRwor
 jxhF_AbNMUpcNQbKVaVyegWtMEUBEqbABcQGxTA-WPcTwu_9jF6QHA>
X-ME-Received: <xmr:t_6Uajp_rFTsMslCdmg7Bhgv6q6jLzoVcm1ZNJCNuw0KzATnp1ZWxpsUOsGrFYlkdsEJkAM_ug>
X-ME-Proxy-Cause: dmFkZTGgZgR+VcPfe+PhAzOLd0oIFeQYFsXhiZHiqFEfJLX+Zh5ZMdMCmp7DSb14qyqV39
 jp/P4WoX1+fWMg7xKNkg19erm52kJxQUcTYbC3fhf7J3kTCWp177f4eiTLGImcgm9FlW/K
 919HsGQiniAe1IB7e9jl0y2Y9dxEodpqsZNpi/Wh8/Y0aGqz1kZ0NysbtBSq+wCn4J8DOp
 NMVeqNR7AEscaSespCcNi1Tsf5l8QtvZS5D7uic9GEJ8sDuUqjUvTw65giXWj5Lizkd8mk
 k6Wvf2Wg5sOErrVa3i9eyoCaEv0ghglB6LbcQ07PYZ4WQgjzQYOd+k7ebFmJtNV5tyGOc8
 Q/+P0HR1tJLaI3SBZbzhAoTOvs9DTifvbmyzmZx1tJ4++5+zaT1c3uIPPgxmp5ytgjnFHT
 +f4CW97b8/8yJ5fBwI+tcd1jhH6vdqo3E236BxiJAf9zmbXaGOda7BivbvdcQdohxE5QFR
 R8yu2LGvJ2AUnPvVP0LU2UFszFa5jWeoZR0VmQM6jaMNlwqI5LiH/6nD5T4yzqJmcZJet/
 SNvBkSlb9A5eTNfehnYPWlp52+vtYC1PBA6in/+0UhBfmK3lhnS4zVOhD3hFrckJTLWvFO
 9YcPPPZkdIESfF2zPGtzxGcQlabFsm2VIiH2VPMaw7Z3gn22IJ4l0yh9mIiQ
X-ME-Proxy: <xmx:t_6UatUcwNPJCVKMjTqa3jbt8MYGN9q4dOqGYWk6PB3YO6aT77lAzQ>
 <xmx:t_6UarDq6V-AnZyeceAA6M9BTa4V5puiUI5ttupfNbdg_0hm_ZDu_Q>
 <xmx:t_6UapXIAxhkfUqTkrmsJow2REbRm4qHZnfJZaqs9gZ7Tt6E1_Z1yQ>
 <xmx:t_6Uah_ecikTMIZze-7yUXtmlsGDp_X6sXX0hKMg9EjZPO_7291a_A>
 <xmx:t_6UaquAE4pD4eKqbiiCbP5qhUWqxbQr8FXXgtdRI0lmMVUvsxN_G0v1>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 00:10:24 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
 ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, u.kleine-koenig@baylibre.com,
 chaoyi.chen@rock-chips.com, diederik@cknow-tech.com, alchark@flipper.net,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v10 13/13] arm64: dts: rockchip: rk3576-rock-4d: enable NPU
Date: Mon, 31 Aug 2026 16:08:04 +1200
Message-ID: <20260831040804.24111-14-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831040804.24111-1-gahing@gahingwoo.com>
References: <20260831040804.24111-1-gahing@gahingwoo.com>
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

Enable rknn_core_0 and its IOMMU on the Radxa ROCK 4D, and hand
vdd_npu_s0 to the NPU power domain as its domain-supply, so the rail is
switched by the domain that gates the block.

Measured on a ROCK 4D with this in place. The rail's regulator debugfs
reports open_count 1, so the domain is the consumer that took it. A
sampler running beside an inference caught use_count at 1, and three
reads at rest report use_count 0 with the rail disabled, so it follows
the domain rather than staying on. Over the same run the genpd
active_time of all four NPU domains rises by roughly 60ms per inference,
and the inferences either side of that are 128 of 128 channels against
the CPU reference.

rknn_core_0 keeps npu-supply on the same rail, which the binding
requires. Only rknn_core_0 is enabled: the driver binds one core per
node and the second core is left to whoever can test it.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
index 272af1012..79e039bee 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
@@ -722,6 +722,10 @@ &pcie0 {
 	status = "okay";
 };
 
+&pd_npu {
+	domain-supply = <&vdd_npu_s0>;
+};
+
 &pinctrl {
 	hdmi {
 		hdmi_tx_on_h: hdmi-tx-on-h {
@@ -779,6 +783,15 @@ wifi_en_h: wifi-en-h {
 	};
 };
 
+&rknn_core_0 {
+	npu-supply = <&vdd_npu_s0>;
+	status = "okay";
+};
+
+&rknn_mmu_0 {
+	status = "okay";
+};
+
 &sai6 {
 	status = "okay";
 };
-- 
2.43.0

