Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555E7C5516D
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:55:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D06610F178;
	Fri, 31 Jul 2026 06:55:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="YbRJQx46";
	dkim=permerror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nLbIKb1E";
	dkim-atps=neutral
Received: from flow-a8-smtp.messagingengine.com
 (flow-a8-smtp.messagingengine.com [103.168.172.143])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBED210E164
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 04:36:04 +0000 (UTC)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailflow.phl.internal (Postfix) with ESMTP id 639FB1380308;
 Fri, 31 Jul 2026 00:36:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Fri, 31 Jul 2026 00:36:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1785472564; x=
 1785476164; bh=rU/iiqj1yZpMF4hepdKdfzRcPTdeuKeK8FfjQz+3zm0=; b=Y
 bRJQx46papGhlR97wZvzwcVLQ3C86+K/5wFJyX0aYrqg92atvOXIEr1glQjvOsZR
 jilwQLXzHnuSkKh1eSMzW7MtDFWD4Me69oCY2+E80H3Mw3YftMtGf3+OM+VOVElc
 vT1h6IxoHBJksmGkH2oZckuvc5nQ2TqT0DgLPzpd0enpG7LFrPIeTLBvf16h69Bx
 4U2Es/XrcKQ7VVNEI/s2VarhupAHSI8E9xVOT/r3SzOKWWETsPAL2vIunPFTrBLl
 dWaqaXnlMmMEYuE13L1hLJAegg4eNE9H+wMP0MADC2dleIQ+zTKh/EIYQEH5ZF4R
 teZorG+jXO57m9Exvv9+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1785472564; x=1785476164; bh=r
 U/iiqj1yZpMF4hepdKdfzRcPTdeuKeK8FfjQz+3zm0=; b=nLbIKb1EvQuFhk8oO
 PzPnf8Gfin2EiK+CU7j36Oy1OHWlnvEwh5OuqH0nbRGIMLJvd5ENXGTJ7/06N50U
 xP+gYfEO9OTOBffO69cY9llWYrJv7856b6UyyVQOoFE8dBh9nbSSh1VCIXRPV3Eh
 yxY9kx4YLtRY412GkjMCH8Ifw+HgwPayAhYXu40Bto8s7NUZdeY1rOnh5xDD3Jr0
 oVQXNoShLfqy91rXGoh/xZUDcSZBtqWk//1EHEz0WoTgR++fa0oTV7wpGlMhMIUe
 yVTPoZWKEk1/4mRjn2S3Jl0htv3te0VwKNTAtd029+MuifPJNbqzlFY8HjgvnB6H
 apK3Q==
X-ME-Sender: <xms:NCZsanTtmqXRg8TLhykTSCQSiBKPqrSVLJOMFJPt0qjgPNHumgt0LQ>
 <xme:NCZsavVb40iYNTt_-foXwPDtDhWco42ZbQVDYr0x-ALKRwtvnOOBmgArQbU-neCIo
 NUgGZem0JMxxn7---ApWYnVyIgctjAW-F9BG6xjGxn6euGPnlmtMGQ>
X-ME-Received: <xmr:NCZsauiiK55vw5NgkwiX9z3rDyym_25ZVHaO1r2IvXsTogMMGfuK6A8dksCodIm-IcfV5TGZfA>
X-ME-Proxy-Cause: dmFkZTGvOKNO9zBdHkgYlF796lTt1g6XhHLwmREClOCu9o9rkxmgV8hTnMScLLO2GDOQ8J
 r0CGO8ZJUneVHtCq7+dnMIm3qpNwOne25S6y+nf8Qdu2wy6dFmZ65cN6L/zJGBGzwZh6qm
 Wyu3epeadLOxa+zYzYvJk+kW5lq4IpFJw9WGOL4ZvDEQZlTUiza5ARf616dz3THdtIoWiN
 c43PlVzZwGonGEEnTWbmkj5hQwCP9V6qOpOqoFK007M45URj5BUap6bF1x5FNVYRizLOGt
 R0M9nrZam8Fm1iy39qcV45G7pKDxJ8SNQGstN46NIeUIIJqPAT3ZGFI9q5F1oDm6qm3xuF
 WWTiNTSJqw1sm4AeJiXAJvYJTHnPIzfdLqXRaQb/irMzNXCAU2uQ6c+7L9EcUlfV62wcpg
 q7P1MmfoXZAqAPSYgEgMD1sKVJWjGv0lh4TFdOWH/PVYkc88MNP0g7CSnzwutxll+/X73x
 9116DFw/58jVReJ3K/aeQ3Y/MSr7cjqlBqacJBFaXPfxVfbKQqGb1ktl+uasx08GNHi2ZB
 WDCkTCKOm9ctSeKUhXVL+21Ftv+8iUsmxLTUCucLK+YkVaTT/ZZo9IiJ92Q1dUaVtpkBui
 PB4bhKCwlC0zMO4xlxXGggM9nrjocXsA+g/q3cacflEkEnXWU03D3ISPiVmA
X-ME-Proxy: <xmx:NCZsagcfwJz-7IpD-JjBZ3PZD5Z4gPW51vt_G-pworPNMAEJCB2VbA>
 <xmx:NCZsahe41yrGs840NeOd2hatHOkOkKGOdGIs6EwyGbAUzqxDLh5NJQ>
 <xmx:NCZsakUA0c6FxG1hDuAo3Ih0JvNgU1OXMqU3gixjNpsj5lpwByTFFA>
 <xmx:NCZsatfyqGeRcLNumMHM8kencj6XlNVGG8fIEJUvzozj4avZCQoMsw>
 <xmx:NCZsavUrEDlHwE4Ss0AiJwPWLJCZ3lDh9-gPyXT3P0LjfM5KaUteRO7Z>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 00:35:59 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, ulfh@kernel.org,
 p.zabel@pengutronix.de, ogabbay@kernel.org
Cc: chaoyi.chen@rock-chips.com, alchark@flipper.net, royalnet026@gmail.com,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jiaxing Hu <gahing@gahingwoo.com>
Subject: [RFC PATCH v3 6/6] arm64: dts: rockchip: rk3576-rock-4d: enable NPU
Date: Fri, 31 Jul 2026 16:35:07 +1200
Message-ID: <20260731043507.1832277-7-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731043507.1832277-1-gahing@gahingwoo.com>
References: <20260731043507.1832277-1-gahing@gahingwoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 31 Jul 2026 06:54:16 +0000
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

Enable rknn_core_0 and its IOMMU on the Radxa ROCK 4D and supply the
core from vdd_npu_s0. The core is listed on both NPU power domains, as
the vendor does from its single NPU node.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
index 272af1012..09d2fc98b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
@@ -442,6 +442,7 @@ regulator-state-mem {
 			};
 
 			vdd_npu_s0: dcdc-reg2 {
+				regulator-always-on;
 				regulator-boot-on;
 				regulator-enable-ramp-delay = <400>;
 				regulator-min-microvolt = <550000>;
@@ -869,3 +870,18 @@ vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
 		remote-endpoint = <&hdmi_in_vp0>;
 	};
 };
+
+&rknn_core_0 {
+	npu-supply = <&vdd_npu_s0>;
+	/*
+	 * Power BOTH NPU domains (NPU0 + NPU1) like the vendor's single NPU node,
+	 * even though rocket computes only on core 0: the CBUF->CMAC read path is
+	 * only fully powered with NPU1 up. rocket attaches the multi-PD list.
+	 */
+	power-domains = <&power RK3576_PD_NPU0>, <&power RK3576_PD_NPU1>;
+	status = "okay";
+};
+
+&rknn_mmu_0 {
+	status = "okay";
+};
-- 
2.43.0

