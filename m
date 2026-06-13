Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B01BCD98D8
	for <dri-devel@archiver.kernel.org>; Sat, 13 Jun 2026 06:58:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE7EB10ECAF;
	Sat, 13 Jun 2026 06:58:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Boj/9WR3";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F242510EC74
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 06:58:43 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-490b211ee6aso12149805e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 23:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781333922; x=1781938722; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6JonI5tVCKFVj4EE3HntNYMlqngF+zGzezn1FD6cSzY=;
 b=Boj/9WR3zVRLinscXUdeuhGIMxTFbxUJ44CwOufpXzcgpyfzzuOdhzKv6Er0zqMg5B
 mupz5NpjanmjdUwi6/5cw7cSxwYx27BiY1qPUghVxCcaWAyUXjCSjxOJu0rtwfnu+6Ix
 IJifLNSRRhS/NuG/nDAQ1PgvpcoDRIhMvIwg2dh2DW3Sz10YAECJ5PgcZiotuibk3yP0
 ZyXlOFmV9bPYd+BlsiIF97Nmm4nqkxfSyb1gh36PZXMWRjVZoW7pPBftPQameHZafxgL
 UwDKEyUD6J33x18ieC0YJKJu/m2SrnDc5iPxj+0DbtmWagbe1Py6z2/OKKKzsNS8+cV9
 jn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781333922; x=1781938722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6JonI5tVCKFVj4EE3HntNYMlqngF+zGzezn1FD6cSzY=;
 b=P10aXg3HUGu750g4vZU/AiJDaBeprgGrlzYxesOEduTaRnzK1M880kRRze9zpNdeuc
 tjjvHOTNNlaV12hxS6g8hzRQYoec3FhKox4hqnCG6oU4m5BNvG6B65SX8CHEVVyK+Fx3
 DdukiApYyyrybBQK9gLNzasgspvFEOfZqC+HMHNZ1Pdbs53om2FHD+eVZkloUa0RPelF
 UWA+8nIGflM0zPZzopVOkU42OUPtHrzUE658WrIDLpE04bXJQycrtIXGtng2oLXxPIAu
 Seeaz5JpqWUHef0OofeAjkPEZEqe1gA2AljfkntWuH+rpoJQHUZmzmaCh2ZZ7hDE1DAy
 /GCg==
X-Gm-Message-State: AOJu0Yxw8liPEJedIkTAwbVY2BDu3i66kTSrwRHRfgbZAhds5S4E92kM
 6Qh0tyUbkOTywgsQwa+TRIVesN2dpS39wAjy+yPrKIUrX/qHVdry/gh1
X-Gm-Gg: Acq92OFDvA8d3DluQD6ih83h5529tuHssqvD2RLof873k8EBlXDEpJC/MVzw030TX/W
 rxha8AxB592cwr9S8NhpAlGJDQJJ6ZNNptP1P+lz3CCGSRg2TkCfCws6hfcjDMmXRjBlHOxWROt
 gvAcBuoRA2sLi0onT7YOuNJRIgayybyur0NIOk07sabGOtygeORyFtZtvsVfRU7q12GeAomG9B/
 zgYJ2R4nPJfelii0OMmP5/naMCMmBu8cWwo8kTBi4U9iRS8UmLHXHb4sdOJU5z99r4JvV4yjfhr
 Kc8cSpRnJyNe9RHrzwmmrcMOepW5nVqUh1to7NEcpBEh86/iG80bkL+Osd4ATPfLOapFa/htJXR
 ZGGATVh9Xyvwn5iWJX4T4v1vvcV8HFW3x5Iai4VMF/STxfuFfKo5plLZNKsq3z3q6qMIWaEXd00
 rFpylsWGF2MHzfqLu+F4fkTgjHiDqvxMFXgRSB4SYh4Q==
X-Received: by 2002:a05:600c:83c8:b0:492:1e36:d16e with SMTP id
 5b1f17b1804b1-4921e36d1a9mr40797495e9.36.1781333922475; 
 Fri, 12 Jun 2026 23:58:42 -0700 (PDT)
Received: from debian.tailb81abf.ts.net
 ([2a01:e0a:104a:4d80:14c0:9448:1c38:77df])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492202e5cbasm42917705e9.2.2026.06.12.23.58.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 23:58:42 -0700 (PDT)
From: MidG971 <midgy971@gmail.com>
To: tomeu@tomeuvizoso.net, ogabbay@kernel.org, heiko@sntech.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ulf.hansson@linaro.org
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, xxm@rock-chips.com,
 chaoyi.chen@rock-chips.com, finley.xiao@rock-chips.com,
 diederik@cknow-tech.com, jonas@kwiboo.se, Midgy BALON <midgy971@gmail.com>
Subject: [RFC PATCH v4 8/9] arm64: dts: rockchip: rk3568-rock-3b: Enable the
 NPU
Date: Sat, 13 Jun 2026 09:01:15 +0200
Message-Id: <20260613070116.438906-9-midgy971@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260613070116.438906-1-midgy971@gmail.com>
References: <20260613070116.438906-1-midgy971@gmail.com>
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

From: Midgy BALON <midgy971@gmail.com>

Enable the NPU and its IOMMU on ROCK 3B and wire vdd_npu as the NPU
power domain's domain-supply, so genpd brings the rail up and down with
the domain (the domain is marked need_regulator). The PVTPLL compute
clock is brought up later by the driver.

The rail is no longer kept always-on, so pin it to 1000 mV (the NPU's
1 GHz operating voltage; the driver runs a fixed compute rate with no
devfreq voltage scaling) and mark it boot-on, so it is up before the
power domain de-idles the NPU NoC at power-on.

Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 .../arm64/boot/dts/rockchip/rk3568-rock-3b.dts | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
index 69001e453732e..d3f9776c2bdc3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
@@ -330,9 +330,10 @@ regulator-state-mem {
 
 			vdd_npu: DCDC_REG4 {
 				regulator-name = "vdd_npu";
+				regulator-boot-on;
 				regulator-initial-mode = <0x2>;
-				regulator-min-microvolt = <500000>;
-				regulator-max-microvolt = <1350000>;
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
 				regulator-ramp-delay = <6001>;
 
 				regulator-state-mem {
@@ -787,3 +788,16 @@ vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
 		remote-endpoint = <&hdmi_in_vp0>;
 	};
 };
+
+&pd_npu {
+	domain-supply = <&vdd_npu>;
+};
+
+&rknn_core_0 {
+	npu-supply = <&vdd_npu>;
+	status = "okay";
+};
+
+&rknn_mmu_0 {
+	status = "okay";
+};
-- 
2.39.5

