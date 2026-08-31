Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3244C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:22:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3068510E758;
	Mon, 31 Aug 2026 08:22:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="P5vqeOw3";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="VZ1NMvm9";
	dkim-atps=neutral
Received: from flow-a4-smtp.messagingengine.com
 (flow-a4-smtp.messagingengine.com [103.168.172.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E0F110E758
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:22:27 +0000 (UTC)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailflow.phl.internal (Postfix) with ESMTP id 7AC0E1380045;
 Mon, 31 Aug 2026 04:22:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Mon, 31 Aug 2026 04:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1788164546; x=
 1788171746; bh=yyAlnjllRJoc8EnuoheqRfmGGLiMMzIInITnv3UMbRQ=; b=P
 5vqeOw3ShNwcVBCo0k+wdZQceJK5uqFU/EnL4qZRbrjVznhH5r/SdRUCKEqhIDpP
 y1h3ZY4Sm1jwrGe7p3Lsabi+MnMnhQ73tiQcRNC3FmJoJCrdADhfikvkLq5gYpZy
 HG87BJPuMPrHUEPOALX0FOjWhS14GrDssJp6xZPrNuiwA/obU966sk1+zMk08ulF
 YM7g50Ptv39ILyEs9AREsWIxRlung84TzctmEhAYEi3FGewxS+csk39JRVHdbzaW
 6M+kj45fhtsDMZ8IBWZam8TvwLMuqE9c/VPSKoItahq630nSb100GJ+TvjxDI10e
 E/yopNWFLbk+NkYhfdHVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1788164546; x=1788171746; bh=y
 yAlnjllRJoc8EnuoheqRfmGGLiMMzIInITnv3UMbRQ=; b=VZ1NMvm9ufm+ap+8t
 SuJlH6aAjIyhx4gM+mcBuqtMaHkNbpB2nYr+BrYV56iwqCpFB1VUwS3rBezMP3hP
 1hjUSZEj8B6uqdfdG+TcpgPIzp8RTUp/U+5SBe7QrZDeILnzn6uZteItf2vaZSCH
 EYG5OxRla/e8bb+AnqDA4yMYHqSxRNm+d6AXbqxgnOb5oG+7aE6Kkkpq+QDAS6c3
 mP5+2S3h9IYhy2ohBwHQxzsA66zmUyTusjdjzjtPV652oCr22bL25HKVL8w/4myI
 t4hary/SDcsS2Jcv7bavfTe2BNUJ3CTuStrRAbVnTPfX1Ns3CtJekefeC8mSeqo4
 4+Hdg==
X-ME-Sender: <xms:wjmVat0bqC9i3Gc4GDM9cMyiIiw1mRJRyP4ucpYpYZt-lZE_pfm7hA>
 <xme:wjmVavlxMABW87ynYLKCF9HzH90_l0JdTvD8SrFCMSepAraK1Gggnu8b9lFyqegd2
 gOevkZ3opUYXpVLMaQk89if2OPw5eifrmB59bDfSXJP1RY6qpeRXYkH>
X-ME-Received: <xmr:wjmVaj70QoKrX8_AkeGr-LVL5dS68i4zPWrhSlK-xRxjUKikZ4Xu7sCEPMsi2ZgVr63YgKmCaQ>
X-ME-Proxy-Cause: dmFkZTGO980Yn8uMbt0j2BdcD4QX/iOl9tUTFXCQ903aZIrMv7Tc6fuat3dY7duyg1xULb
 yz10ob59tw/e4mxHxusC7Au1N4yhmt1yaDLIz0vcL8AJV9F7KQx+2+AsVtAkp8ss8MY4Kn
 JM/nREETieohMZYv4RIh7Ygrpu4ZhAjUJQvWYoB8T1YSEXSwyUcny6aAbDZsJTqMdR5hRt
 YbkWmcbdFOkc3c+lkICatwo6JMUCVpLlTOLedKImNWzhQDajBwqfhQjyXd8NbiMRLpQrNO
 vpYClpYhFWPE/Y0sKG5xjf/eaGk7Zjv8nlP0Vq5z/Uo/jONQQ3T8oIPx3LprFSjLy2zQIk
 hDBNgVO1mJx4GPGpisLvnD+Rzrr663mMdvMu22MeP6cfBXkMxCEJZNAHoQ/XlY0/PPOs1S
 JDmj/dMRdpjl/TpDdpzwRbCTSdz8Vq16CRR2y1PCRdCNo20v24Kt9rdjDzTdINn2cB/0dg
 OxQhrJEJtwez/a31NOTkjaKktqc4zh9EOj1uY0cHFxXLel43FBPKheMPj0xHWxa2nCfkRH
 TExXjedslOHuXQKdJj0MTUHSw78E5y7IzQdV+VYcO0gqF74uxkEmE8vxl+/DlHyOhlT+EX
 miAYGYwV+EjxcFrWe1AWjjplN6NrfjBzfiLI6yt/gjvzy1X66z1qKJpW2JYA
X-ME-Proxy: <xmx:wjmVaomHocHTofk4WSBKAtZXW_qWOCe4y1jDdl2tNHRBmQ1v83YG8Q>
 <xmx:wjmValQRsqTKowvptCS_erMnfJti375Byf39Og1a-w6BWubEAnb_nA>
 <xmx:wjmVammUIwsRCv287vwzNlzce58Wg9tAHOixMKwAGGGZMMCOWu1ewA>
 <xmx:wjmVamMfjf4re-Bgv4zaaoy_gmrlhVwLJo7ejzIgHDrUot5qW-gE4Q>
 <xmx:wjmVapjs23DSJ9eGdOqiwgdw25xCWfQtfslQzI6LoFvcbMP9P9chJj3_>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 04:22:19 -0400 (EDT)
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
Subject: [PATCH v11 14/14] arm64: dts: rockchip: rk3576-rock-4d: enable NPU
Date: Mon, 31 Aug 2026 20:19:56 +1200
Message-ID: <20260831081956.84871-15-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831081956.84871-1-gahing@gahingwoo.com>
References: <20260831081956.84871-1-gahing@gahingwoo.com>
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

