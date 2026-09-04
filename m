Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3057C624D3
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:09:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B75210E1B5;
	Fri,  4 Sep 2026 13:09:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T2Emfjg3";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58A7310F925
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 13:09:29 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4956d1d9fb2so929835e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 06:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788527368; x=1789132168; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kbG5tkNoyC999CbeFUHbHjzpSs9HHc0dLmddOFM6uZc=;
 b=T2Emfjg3830430B23TDQsfhG09tfV2pmez5PFioyG/b0AZlPUle+89muwcDc5gw1rB
 Z5Y9wU6flkc6uCnWHUvpJrS4Gek2T8vP7TA4lGbYQguiXtK9NgQeAR/efCFL/jJvB6Ak
 mrZNo/fDFFXYNGF+6mqFfMB4GWYz+0BSBTCDWMDoDhQy0iegMTwwntSIZFyB780bEja1
 KZ85suqEqkxj4EYsWhCO5jx+hyI1/i5Eim4YIK4SAwiyuVm+pYuhGw9eqFuINaJNQu9y
 7A/DY8w4dSpPTC3SZ3Xo79fGACFh23v5NJd4l1MfqDLFemKE/G97jN4nIrjMCXu5kgp9
 zO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788527368; x=1789132168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kbG5tkNoyC999CbeFUHbHjzpSs9HHc0dLmddOFM6uZc=;
 b=hG3mhQ08CM9jyv0svs0KDMFMDmUpdE7NlMxN6OfQ2ZY2OSmCv8CQ15MyRuLI39u1bO
 nkd3xVAt6rPY5WKXDwjUTITS4Vc/2DfPfP4M+z7LFf+l8IzHsEGYo0CwE7mfVDvVPDO7
 eZLA0/sF+j31/m2sS7zZU454Bng13VyvfVHrwVc7nymqQyhz1cl5Mv+L6Le5rwFN2zfw
 38qUAoN+whzLdeguQpqFprM9lalhgl2YgHXh1P4dqu1IUMBYxw4lEvUKsYj+Hr+S4eTR
 MYG1ifPEDjdUhUx7TRLdx2J33OdZfMg1LL7PzC1STSCIRZfGN8f36gyQjhJIM4Fedm8h
 cqjw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwXgLx1ndSGWccSC8u9qiojOuAbTrC7cGwy9NFXdazsIT4O9A988pI4xXnPgGMbdHd5rRMifBIVX3U=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nwI2brUYudDQBQUiLvCuY06F1Yc5S3oVIRHEqD2TzZyjTlSR8B
 ShhEFYzBiW76fHKSRpem/CkwBg3iUB3IYAp1aVfzcBUkjkjZaSDYK2JK
X-Gm-Gg: AYBFou15AnGeVaW68Bo+jwbCtOYFYjMhLI/OWpFitE93IuNZkqOD/qmj28GO3V/2Nkf
 gs4ntbZtkG6hzvaP68TQ8sx3Exbi/exEEwPLVAgc0UYsJnj9yiMrwyK3MEgIiquOo5IxyYmtq6E
 DTvH6lQhtDtGcwOid9XtGDpecNhR1auVqCstSQgpIyobfLgTb8FBZ7tZDsjEAwnp25wKttQyhY6
 AteMjYJ619gmi72E3TaXGj5eUUCgGps52DGXvKsAMXDnpNQEuaZToRK7kZuOYuyE4Ijq1pKsqai
 wmTdfiIkcvmOn6QOXixmZ4kJ+4i7uVfTyuP4fhwiPTvNO7ezDaeG9X9nYyBn1iYdxNCWvWdlMqI
 aRmw7Ow/zSuG2HMboX/bRfiXrsYaEn/UhPE+qcveEaW7r4fStCvvJfMJegXVZ8JBJY89Rt7tfwX
 6cLv58r2oy6Z2+WB+qcFTgw8CxZo9E/WM48QrnJbNKwZy0HxqH2VO4cseuSnf4fJlnP1fD7vDij
 70kdGnOab6tEA2/8ElqDrThKf/Qey+xLda6uXZ6mu4QnbV36V5vYb1U0ix05L5Fgibr
X-Received: by 2002:a05:600c:a00d:b0:499:d95a:41f with SMTP id
 5b1f17b1804b1-49cf7f51dcbmr42170965e9.0.1788527367548; 
 Fri, 04 Sep 2026 06:09:27 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B871500CB6EF488A18F9C42.dsl.pool.telekom.hu.
 [2001:4c4e:1b87:1500:cb6e:f488:a18f:9c42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce554d52esm135575435e9.3.2026.09.04.06.09.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:09:27 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sidong Yang <sidong.yang@furiosa.ai>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Jiaxing Hu <gahing@gahingwoo.com>, Nicolas Dufresne <nicolas@ndufresne.ca>,
 Jonas Karlman <jonas@kwiboo.se>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Igor Paunovic <royalnet026@gmail.com>
Subject: [PATCH 3/7] arm64: dts: rockchip: rk3588: add an OPP table for the NPU
Date: Fri,  4 Sep 2026 15:08:54 +0200
Message-ID: <20260904130858.27803-4-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904130858.27803-1-royalnet026@gmail.com>
References: <20260904130858.27803-1-royalnet026@gmail.com>
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

The NPU compute clock is driven by the firmware, which only accepts one of
the rates in its own PVTPLL table: 300, 400, 500, 600, 700, 800, 900 and
1000 MHz through the PVTPLL, plus 200 MHz off GPLL. Anything else comes
back as SCMI_INVALID_PARAMETERS, so the table has to name those rates
exactly rather than describe a range.

200 MHz is included even though the vendor table stops at 300, because
mainline pins the cores there with assigned-clock-rates and that is the
rate the NPU boots and idles at. Leaving it out would put the boot state
outside the table and give a driver nowhere to return to. Its voltage is
the same 700 mV the vendor uses for 300 MHz, so it is conservative.

The voltages are the vendor's, and the upper half of the table matches the
GPU table in this file step for step: 700 MHz at 700 mV, 800 at 750, 900 at
800, 1000 at 850. There is no PVTM or binning here, for the same reason the
GPU table has none: mainline uses conservative worst-case voltages instead
of per-chip nvmem data.

The table is attached to rknn_core_0 alone. All three cores share one clock
and one supply and cannot be scaled independently, and the driver hangs its
devfreq device off the core that carries the table.

The full SoC range is described rather than a per-board subset, so that a
board which cannot cool the upper rates drops them in its own .dts with a
/delete-node/ on the OPP it does not want. A board may only delete OPPs
that way, never invent intermediate ones: a rate that is not in the
firmware's table is rejected outright.

There is deliberately no opp-suspend property. The driver has to resume
every core before it may touch the shared clock, so letting the devfreq
core drive a suspend OPP from inside a runtime-suspend callback would
deadlock against the driver's own governor worker. The driver records the
boot rate and restores it itself instead.

The consumer is the devfreq support added later in this series; until then
the table is inert and the NPU keeps the fixed rate that
assigned-clock-rates gives it today.

rk3588j.dtsi does not include this file; it carries its own derated tables
for the CPU clusters and the GPU, and it gets no NPU table here. That is
deliberate. The J part is rated lower than the rates in this table and none
of it can be measured on the hardware this was written on, so inventing a
derated NPU table would be guessing. Its NPU node stays disabled, so
nothing binds and the cooling map added later in this series is simply
never resolved.

The same rates and voltages were arrived at independently by Nicolas
Dufresne in a proof of concept that was never posted to the list; his
version differs in that it marks 200 MHz as opp-suspend, shares one table
across all three cores and drops the assigned-clock-rates pins.
Link: https://gitlab.collabora.com/nicolas/linux/-/commits/rock5b-npu-poc-4

Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
Assisted-by: LLM checkpatch dtbs_check
---
 arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi | 45 ++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi
index b5d630d2c879f..3711727020ed1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi
@@ -151,6 +151,47 @@ opp-1000000000 {
 			opp-microvolt = <850000 850000 850000>;
 		};
 	};
+
+	npu_opp_table: opp-table-npu {
+		compatible = "operating-points-v2";
+
+		opp-200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <700000 700000 850000>;
+		};
+		opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-microvolt = <700000 700000 850000>;
+		};
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <700000 700000 850000>;
+		};
+		opp-500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <700000 700000 850000>;
+		};
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <700000 700000 850000>;
+		};
+		opp-700000000 {
+			opp-hz = /bits/ 64 <700000000>;
+			opp-microvolt = <700000 700000 850000>;
+		};
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <750000 750000 850000>;
+		};
+		opp-900000000 {
+			opp-hz = /bits/ 64 <900000000>;
+			opp-microvolt = <800000 800000 850000>;
+		};
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <850000 850000 850000>;
+		};
+	};
 };
 
 &cpu_b0 {
@@ -188,3 +229,7 @@ &cpu_l3 {
 &gpu {
 	operating-points-v2 = <&gpu_opp_table>;
 };
+
+&rknn_core_0 {
+	operating-points-v2 = <&npu_opp_table>;
+};
-- 
2.43.0

