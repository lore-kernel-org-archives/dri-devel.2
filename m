Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A617CD6E7B
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 13:53:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F58D11A0CF;
	Thu,  4 Jun 2026 13:53:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E5+Vd+p2";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48BC311A0D2
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 13:53:05 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-45ef616daf6so717361f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 06:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780581184; x=1781185984; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Y0cyJs3YzhZbMhMCeS+YcB/ZC7ibeA7FwgxaOl6j4E=;
 b=E5+Vd+p2uv9oUJA39HPi5zB/WeMmfx4YRz2uBLpJgekadi3bOgfSy8ERJq0UaKK4ah
 OVJea0sRZ+rVrkpoS1WuBaQIUAOX5mDVz02HXCcDXgkF0ww3mhx8u3OmS8gsLSpnlL7l
 49VCnyh/hQwSgUIyeEHVdHzPBPbjjY/UWRSiycdUA/XekZ8iNCdtipkssIXi9SkO0UkQ
 2zjF2jNtb2JRgQH0JJXJ+LpiqB1Wflkwtmb98NniR3aDcpkWS1rJ8AjA8gCGb4UF+cfq
 ct1ryGS1ljOd/0Kfzx2feAy/q4P2XO/cfc/buIK3Qh/N4GquM58w0DU3BjOqhOoaKdmg
 +9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780581184; x=1781185984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6Y0cyJs3YzhZbMhMCeS+YcB/ZC7ibeA7FwgxaOl6j4E=;
 b=KOUAtpgEnY/Du0sqsLTLUvcRfUzxacJntKzs+Q9+yNdTjBrzFrUYS/k/npz8VKa7UG
 HVWBuX4WgB4A9vEy4j/mv8dRBbnIWagxizDA2ytP7alsJb7jJSJBj8/tGefeezlGq8S9
 kDv+M5Ev62vroSlp1XlDFbbfjEzvIQ0yfwxMWxbH/B7Av+5uSbigdtqaIVPubuuTf8vv
 SmhYRzXMr+2ZCAL7wZOalpFJUnQPZIeu/R24cWvd8fqeGbxNuWL09GKAC4clbghe7tsu
 DH5r5fI2fH4RgWFQ6ggrlzKAbfWlZxin9a/teww0k7cE4YLu/Il4jJmnHzDDKBAh3ddr
 btEA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9wtqzAKv728E0+Io2V7XO/Z2SroZXcnQpMIPC0J30AaoVKO3tzmpFv9ARdvkKG8Efj9Oc+9hsHvc8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxnMeVhKwN90qeyakEStkrMVK1l99dW+GOzzdYm5the3Vh38tTk
 rJoJOn7D1w5BKqaqN1KJ7QVe7VtWyYD7QoCOh8WRWOXMUHQNOy4fXwazTxRwyrjxOva/XA==
X-Gm-Gg: Acq92OHQjHyxdN6wJE8TlD1DMn4LoMN2U6vxXo+LirjdRO9SUUBA2/WnMdiPwE95q9n
 7G6/80OLExSj+Om5gaXggz8fgrhXQNzO+fVKqz6STl4zKPegGHXCApjuKEZ1Ho6NnPNTS8PnSXv
 x0+he/vBAIL9yIPb6sRGkAXGyWuG4FzcfFrAk5SQGbWKDT9y7LHmSwtG2EWheNZAp9el8qVktMj
 UwkG+xZT6EQ4w/A8K282hBStDOgBWxJ3Arf0uSgTp41UUKEFFhNIOqi9Ph70z8W72Bk0kJFiIxh
 SkdoMC0UoJKr2PHZO8OYbarrbFmHQiha4clvWvQZeXaSKhfQvIIHk31Fmrkmsuj57XkK46Uq+6S
 KgdLXglsTvwvsCURbk+hPRwKqgfxCQ/2N20FZKIT0m0MAr4YHdzwgd9ayeC7n2C/Xo80s1+oLop
 rpgIDYxvQfsZBPtyCbEB1hTKpJFpHxC1aMaMk719jNnnGoeMMKYpku65t8zI5BhDk=
X-Received: by 2002:adf:fc48:0:b0:446:96b1:f53 with SMTP id
 ffacd0b85a97d-46021844e6emr9463717f8f.26.1780581183713; 
 Thu, 04 Jun 2026 06:53:03 -0700 (PDT)
Received: from compiler-rock3b.tailb81abf.ts.net
 ([2a01:e0a:104a:4d80:be24:11ff:fe12:2776])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f0a43e9sm16661068f8f.0.2026.06.04.06.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 06:53:03 -0700 (PDT)
From: Midgy BALON <midgy971@gmail.com>
To: tomeu@tomeuvizoso.net, ogabbay@kernel.org, heiko@sntech.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org,
 will@kernel.org
Cc: robin.murphy@arm.com, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 8/9] arm64: dts: rockchip: rk356x: Add the NPU and its
 IOMMU
Date: Thu,  4 Jun 2026 13:52:54 +0000
Message-Id: <20260604135255.62682-9-midgy971@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260604135255.62682-1-midgy971@gmail.com>
References: <20260604135255.62682-1-midgy971@gmail.com>
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

The RK3568 has an NVDLA-derived NPU at fde40000 with its own IOMMU at
fde4b000. Add both nodes (disabled by default) and the NPU power-domain
child under the PMU power-controller, and point rockchip,pmu at the PMU
syscon that controls the NPU NoC bus-idle.

The power-domain deliberately carries no pm_qos: qos_npu sits behind the
NPU NoC, which is gated until the NPU is brought up, so a genpd power-off
QoS save would fault reading it.

Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
index 64bdd8b7754b5..50ce5a5e4fc24 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
@@ -512,6 +512,13 @@ power-domain@RK3568_PD_GPU {
 				#power-domain-cells = <0>;
 			};
 
+			pd_npu: power-domain@RK3568_PD_NPU {
+				reg = <RK3568_PD_NPU>;
+				clocks = <&cru ACLK_NPU_PRE>,
+					 <&cru HCLK_NPU_PRE>;
+				#power-domain-cells = <0>;
+			};
+
 			/* These power domains are grouped by VD_LOGIC */
 			power-domain@RK3568_PD_VI {
 				reg = <RK3568_PD_VI>;
@@ -948,6 +955,37 @@ qos_rga_wr: qos@fe158300 {
 		reg = <0x0 0xfe158300 0x0 0x20>;
 	};
 
+	rknn_core_0: npu@fde40000 {
+		compatible = "rockchip,rk3568-rknn-core";
+		reg = <0x0 0xfde40000 0x0 0x1000>,
+		      <0x0 0xfde41000 0x0 0x1000>,
+		      <0x0 0xfde43000 0x0 0x1000>;
+		reg-names = "pc", "cna", "core";
+		interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_NPU>, <&cru HCLK_NPU>,
+			 <&scmi_clk SCMI_CLK_NPU>, <&cru PCLK_NPU_PRE>;
+		clock-names = "aclk", "hclk", "npu", "pclk";
+		assigned-clocks = <&scmi_clk SCMI_CLK_NPU>;
+		assigned-clock-rates = <200000000>;
+		resets = <&cru SRST_A_NPU>, <&cru SRST_H_NPU>;
+		reset-names = "srst_a", "srst_h";
+		power-domains = <&power RK3568_PD_NPU>;
+		rockchip,pmu = <&pmu>;
+		iommus = <&rknn_mmu_0>;
+		status = "disabled";
+	};
+
+	rknn_mmu_0: iommu@fde4b000 {
+		compatible = "rockchip,iommu";
+		reg = <0x0 0xfde4b000 0x0 0x40>;
+		interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
+		clock-names = "aclk", "iface";
+		clocks = <&cru ACLK_NPU>, <&cru HCLK_NPU>;
+		power-domains = <&power RK3568_PD_NPU>;
+		#iommu-cells = <0>;
+		status = "disabled";
+	};
+
 	qos_npu: qos@fe180000 {
 		compatible = "rockchip,rk3568-qos", "syscon";
 		reg = <0x0 0xfe180000 0x0 0x20>;
-- 
2.39.5

